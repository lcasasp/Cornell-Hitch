import json

import os
from db import db
from flask import Flask
from flask import request
from db import User
from db import Ride


app = Flask(__name__)
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

@app.route("/")
def greet_user():
    """
    Exclaimes user with env variable netid
    """
    return os.environ.get("NETID") + " was here!"
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

@app.route("/api/users/<int:user_id>/ride/", methods=["POST"])
def create_ride(user_id):
    """
    Endpoint for creating an ride
    for a task by id
    """
    user = User.query.filter_by(id=user_id).first()
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
        # users = user
    )
    db.session.add(new_ride)
    user.rides.append(new_ride)
    db.session.commit()
    return success_response(new_ride.serialize())

@app.route("/api/users/<int:user_id>/add/", methods=["POST"])
def assign_ride(user_id):
    """
    Endpoint for assigning a ride request
    to a ride by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("user not found!")
    # process request body if user IS found
    body = json.loads(request.data)
    ride_id = body.get("ride_id")
    # create new rides object if it doesnt exist,
    # otherwise assign user to existing rides
    ride = Ride.query.filter_by(id=ride_id).first()
    if ride is None:
        failure_response("ride not found!")
    user.rides.append(ride)
    db.session.commit()
    return success_response(user.serialize())


@app.route("/api/rides/<int:ride_id>/")
def get_ride(ride_id):
    """
    Gets a ride by Id which includes serialized courses they are part of
    """
    ride = Ride.query.filter_by(id=ride_id).first()
    if ride is None:
        return failure_response("ride not found!")
    return success_response(ride.serialize())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
