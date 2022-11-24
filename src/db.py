from flask_sqlalchemy import SQLAlchemy
from flask import Flask

db = SQLAlchemy()

association_table = db.Table(
    "association", db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("ride_id", db.Integer, db.ForeignKey("rides.id")),
)
association_table2 = db.Table(
    "association2", db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("message_id", db.Integer, db.ForeignKey("messages.id")),
)
# implement database model classes
class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    netid = db.Column(db.String, nullable = False)
    name = db.Column(db.String, nullable = False)
    rides = db.relationship("Ride", secondary=association_table, back_populates="users")
    messages = db.relationship("Message", secondary=association_table2, back_populates="users")

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid", "")
        self.name = kwargs.get("name", "")
    
    def serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
            "messages": [a.simple_serialize() for a in self.messages],
            "rides": [a.simple_serialize() for a in self.rides],
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
        }   

class Ride(db.Model): #Many to Many relationship with User
    __tablename__ = "rides"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    date = db.Column(db.String, nullable = False)
    destination = db.Column(db.Integer, nullable = False)
    users = db.relationship("User", secondary=association_table, back_populates="rides")

    def __init__(self, **kwargs):
        self.date = kwargs.get("date", "")
        self.destination = kwargs.get("destination", "") 

    def serialize(self):
        return {
            "id": self.id,
            "date": self.date,
            "destination": self.destination,
            "users": [c.simple_serialize() for c in self.users]
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "date": self.date,
            "destination": self.destination
        }

class Message(db.Model): #Many to many relationship with User
    __tablename__ = "messages"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    time = db.Column(db.String, nullable = False)
    text = db.Column(db.String, nullable = False)
    users = db.relationship("User", secondary=association_table2, back_populates="messages")
    sender = db.Column(db.Integer, db.ForeignKey("users.id"), nullable = False)
    recipient = db.Column(db.Integer, db.ForeignKey("users.id"), nullable = False)

    def __init__(self, **kwargs):
        self.time = kwargs.get("time", "")
        self.text = kwargs.get("text", "") 
        self.sender = kwargs.get("sender", "")
        self.recipient = kwargs.get("recipient", "")

    def serialize(self):

        return {
            "id": self.id,
            "time": self.time,
            "text": self.text,
            # "users": [c.simple_serialize() for c in self.users]
            "sender": self.sender.simple_serialize(),
            "recipient": self.recipient.simple_serialize()
        }

    def simple_serialize(self):
        return {
            "id": self.id,
            "time": self.time,
            "text": self.text
        }
