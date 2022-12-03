from flask_sqlalchemy import SQLAlchemy
from flask import Flask

db = SQLAlchemy()

host_assoc = db.Table(
    "host_assoc", db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("ride_id", db.Integer, db.ForeignKey("rides.id")),
)
rider_assoc = db.Table(
    "rider_assoc", db.Model.metadata,
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
    email = db.Column(db.String, nullable = False)
    name = db.Column(db.String, nullable = False)
    hosts = db.relationship("Ride", secondary=host_assoc, back_populates="host")
    riders = db.relationship("Ride", secondary=rider_assoc, back_populates="riding")
    senders = db.relationship("Message", secondary=sender_assoc, back_populates="sender")
    recipients = db.relationship("Message", secondary=recipient_assoc, back_populates="recipient")

    def get_id(self):
        return str(self.id)

    def __init__(self, **kwargs):
        self.email = kwargs.get("email", "")
        self.name = kwargs.get("name", "")
        self.hosts = []
        self.riders = []
        self.senders = []
        self.recipients = []

    @property
    def is_active(self):
        return True

    @property
    def is_authenticated(self):
        return self.is_active

    @property
    def is_anonymous(self):
        return False

    def get_id(self):
        try:
            return str(self.id)
        except AttributeError:
            raise NotImplementedError("No `id` attribute - override `get_id`") from None
    
    def serialize(self):
        senders = []
        for i in self.senders:
            user = {"id": i.serialize()["id"], "time": i.serialize()["time"], "text": i.serialize()["text"]}
            senders.append(user)

        recipients = []
        for i in self.recipients:
            user = {"id": i.serialize()["id"], "time": i.serialize()["time"], "text": i.serialize()["text"]}
            recipients.append(user)

        hosts = []
        for i in self.hosts:
            user = {"id": i.serialize()["id"], "date": i.serialize()["date"], "destination": i.serialize()["destination"]}
            hosts.append(user)

        riders = []
        for i in self.riders:
            user = {"id": i.serialize()["id"], "date": i.serialize()["date"], "destination": i.serialize()["destination"]}
            riders.append(user)
        return {
            "id": self.id,
            "email": self.email,
            "name": self.name,
            "rides": {
                "hosting": hosts,
                "riding": riders
            },
            "messages": {
                "sender": senders,
                "recipient": recipients
            },
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "email": self.email,
            "name": self.name,
        }   

class Ride(db.Model): #Many to Many relationship with User
    __tablename__ = "rides"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    date = db.Column(db.String, nullable = False)
    destination = db.Column(db.String, nullable = False)
    distance = db.Column(db.Integer, nullable = False)
    host = db.relationship("User", secondary=host_assoc, back_populates="hosts")
    riding = db.relationship("User", secondary=rider_assoc, back_populates="riders")

    def __init__(self, **kwargs):
        self.date = kwargs.get("date", "")
        self.destination = kwargs.get("destination", "") 
        self.distance = kwargs.get("distance", 0)
        self.host = []
        self.riding = []

    def serialize(self):
        riders = []
        for i in self.riding:
            rider = i.simple_serialize()
            riders.append(rider)
        return {
            "id": self.id,
            "date": self.date,
            "destination": self.destination,
            "distance": self.distance,
            "host": self.host[0].simple_serialize(),
            "riders": riders
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
