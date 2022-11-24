from flask_sqlalchemy import SQLAlchemy
from flask import Flask

db = SQLAlchemy()

association_table = db.Table(
    "association", db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("ride_id", db.Integer, db.ForeignKey("rides.id")),
)
sender_assoc = db.Table(
    "sender_assoc",
    db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("message_id", db.Integer, db.ForeignKey("messages.id")),
)

recipient_assoc = db.Table(
    "recipient_assoc",
    db.Model.metadata,
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
    senders = db.relationship("Message", secondary=sender_assoc, back_populates="sender")
    recipients = db.relationship("Message", secondary=recipient_assoc, back_populates="recipient")

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid", "")
        self.name = kwargs.get("name", "")
        self.rides = []
        self.senders = []
        self.recipients = []
    
    def serialize(self):
        senders = []
        for i in self.senders:
            user = {"id": i.serialize()["id"], "time": i.serialize()["time"], "text": i.serialize()["text"]}
            senders.append(user)

        recipients = []
        for i in self.recipients:
            user = {"id": i.serialize()["id"], "time": i.serialize()["time"], "text": i.serialize()["text"]}
            recipients.append(user)

        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
            "rides": [a.simple_serialize() for a in self.rides],
            "messages": {
                "sender": senders,
                "recipient": recipients
            },
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
    sender = db.relationship("User", secondary=sender_assoc, back_populates="senders")
    recipient = db.relationship("User", secondary=recipient_assoc, back_populates="recipients")

    def __init__(self, **kwargs):
        self.time = kwargs.get("time", "")
        self.text = kwargs.get("text", "") 
        self.sender = []
        self.recipient = []

    def serialize(self):
        return {
            "id": self.id,
            "time": self.time,
            "text": self.text,
            "sender": self.sender[0].simple_serialize(),
            "recipient": self.recipient[0].simple_serialize()
        }

    def simple_serialize(self):
        return {
            "id": self.id,
            "time": self.time,
            "text": self.text
        }
