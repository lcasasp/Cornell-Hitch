import json

import os
from db import db
from flask import Flask
from flask import request
from db import User
from db import Request


app = Flask(__name__)
db_filename = "cms.db"

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



# -- request ROUTES ---------------------------------------------------

@app.route("/api/users/<int:user_id>/request/", methods=["POST"])
def create_request(user_id):
    """
    Endpoint for creating an request
    for a task by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("user not found!")
    body = json.loads(request.data)
    date = body.get("date")
    destination = body.get("destination")
    if date is None or destination is None:
        return failure_response("Did not provide request data!", 400)
    new_request = Request(
        date = date,
        destination = destination,
        user_id = user_id
    )
    db.session.add(new_request)
    db.session.commit()
    return success_response(new_request.serialize())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
