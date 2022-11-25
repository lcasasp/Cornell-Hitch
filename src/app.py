import json
import os
os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

from db import db
from flask import Flask, request, redirect, url_for
from db import User, Ride, Message
from flask_login import (
    LoginManager,
    current_user,
    login_required,
    login_user,
    logout_user,
)
from oauthlib.oauth2 import WebApplicationClient
import requests

GOOGLE_CLIENT_ID = os.environ.get("GOOGLE_CLIENT_ID", None)
GOOGLE_CLIENT_SECRET = os.environ.get("GOOGLE_CLIENT_SECRET", None)
GOOGLE_DISCOVERY_URL = (
    "https://accounts.google.com/.well-known/openid-configuration"
)

app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY") or os.urandom(24)

login_manager = LoginManager()
login_manager.init_app(app)

client = WebApplicationClient(GOOGLE_CLIENT_ID)

@login_manager.user_loader
def load_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return None
    return user

db_filename = "ridesharing.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = False

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps(data), code

def failure_response(message, code=404):
    return json.dumps({"error": message}), code

#----------  LOGIN REQUESTS ------------------------------------------------------------
@app.route("/")
def index():
    if current_user.is_authenticated:
        return (
            "<p>Hello, {}! You're logged in! Email: {}</p>"
            '<a class="button" href="/logout">Logout</a>'.format(
                current_user.name, current_user.email
            )
        )
    else:
        return '<a class="button" href="/login">Google Login</a>'

@app.route("/login/")
def login():
    google_provider_cfg = get_google_provider_cfg()
    authorization_endpoint = google_provider_cfg["authorization_endpoint"]

    request_uri = client.prepare_request_uri(
        authorization_endpoint,
        redirect_uri=request.base_url + "callback",
        scope=["openid", "email", "profile"],
    )
    return redirect(request_uri)

@app.route("/login/callback")
def callback():
    code = request.args.get("code")

    google_provider_cfg = get_google_provider_cfg()
    token_endpoint = google_provider_cfg["token_endpoint"]
    
    token_url, headers, body = client.prepare_token_request(
        token_endpoint,
        authorization_response=request.url,
        redirect_url=request.base_url,
        code=code
    )
    token_response = requests.post(
        token_url,
        headers=headers,
        data=body,
        auth=(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET),
    )
    client.parse_request_body_response(json.dumps(token_response.json()))

    userinfo_endpoint = google_provider_cfg["userinfo_endpoint"]
    uri, headers, body = client.add_token(userinfo_endpoint)
    userinfo_response = requests.get(uri, headers=headers, data=body)

#if statement can be removed if emails dont have to be verified, however it's best to keep it.
    if userinfo_response.json().get("email_verified"):
        unique_id = userinfo_response.json()["sub"]
        users_email = userinfo_response.json()["email"]
        picture = userinfo_response.json()["picture"]
        users_name = userinfo_response.json()["given_name"]
    else:
        return failure_response("User email not available or not verified by Google.")
    
    user = User.query.filter_by(email=users_email).first()
    if user is not None:
        return redirect(url_for("index"))
    new_user = User(id=unique_id, email=users_email, name=users_name)

    db.session.add(new_user)
    db.session.commit()       

    login_user(new_user)
    return redirect(url_for("index"))

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("index"))

def get_google_provider_cfg():
    try:
        return requests.get(GOOGLE_DISCOVERY_URL).json()
    except:
        return failure_response("Could not get Google API")

#------------------ APP REQUESTS -------------------------------------------------

@app.route("/api/users/")
def get_users():
    """
    Endpoint for getting all users
    """
    return success_response({"users": [c.serialize() for c in User.query.all()]})

@app.route("/api/users/", methods=["POST"])
def create_user():
    """
    Endpoint for creating a new user
    """
    body = json.loads(request.data)
    new_user = User(netid=body.get("netid"), name=body.get("name"))
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(),201)


@app.route("/api/users/<int:user_id>/")
def get_user(user_id):
    """
    Endpoint for getting a user by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("user not found!")
    return success_response(user.serialize())

@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Endpoint for deleting a user by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("user not found!")
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

# -- ride ROUTES ---------------------------------------------------

@app.route("/api/users/<int:host_id>/ride/", methods=["POST"])
def create_ride(host_id):
    """
    Endpoint for creating an ride
    for a task by id
    """
    user = User.query.filter_by(id=host_id).first()
    if user is None:
        return failure_response("user not found!")
    body = json.loads(request.data)
    date = body.get("date")
    destination = body.get("destination")
    if date is None or destination is None:
        return failure_response("Did not provide ride data!", 400)
    new_ride = Ride(
        date = date,
        destination = destination,
    )
    new_ride.host.append(user)
    db.session.add(new_ride)
    db.session.commit()
    return success_response(new_ride.serialize())

@app.route("/api/users/<int:rider_id>/add/", methods=["POST"])
def assign_ride(rider_id):
    """
    Endpoint for assigning a ride request
    to a ride by id
    """
    user = User.query.filter_by(id=rider_id).first()
    if user is None:
        return failure_response("user not found!")
    body = json.loads(request.data)
    ride_id = body.get("ride_id")
    ride = Ride.query.filter_by(id=ride_id).first()
    if ride in user.hosts:
        return failure_response("Cannot add the host to the ride!")
    if ride is None:
        return failure_response("ride not found!")
    ride.riding.append(user)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/api/rides/<int:ride_id>/")
def get_ride(ride_id):
    """
    Gets a ride by Id which includes serialized users they are part of
    """
    ride = Ride.query.filter_by(id=ride_id).first()
    if ride is None:
        return failure_response("ride not found!")
    return success_response(ride.serialize())

#--- Message routes-----------------------------------------------------------------------------------

@app.route("/api/users/<int:sender_id>/messages/<int:recipient_id>/", methods=["POST"])
def create_message(sender_id, recipient_id):
    """
    Creates a new message based on user id that sent it, also appends the
    recipient as a user of the message. Messages limited to 2 users.
    """
    sender = User.query.filter_by(id=sender_id).first()
    if sender is None:
        return failure_response("sender not found!")
    recipient = User.query.filter_by(id=recipient_id).first()
    if recipient is None:
        return failure_response("Recipient not found!")

    body = json.loads(request.data)
    time = body.get("time")
    text = body.get("text")
    if time is None or text is None:
        return failure_response("Did not provide message data!", 400)
    new_message = Message(
        time = time,
        text = text
    )
    new_message.sender.append(sender)
    new_message.recipient.append(recipient)
    db.session.add(new_message)
    db.session.commit()
    return success_response(new_message.serialize())

@app.route("/api/messages/<int:message_id>/")
def get_message(message_id):
    """
    Endpoint for getting a message by message id
    """
    message = Message.query.filter_by(id=message_id).first()
    if message is None:
        return failure_response("message not found!")
    return success_response(message.serialize())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
