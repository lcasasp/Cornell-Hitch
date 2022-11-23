from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table = db.Table(
    "association", db.Model.metadata,
    db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
    db.Column("ride_id", db.Integer, db.ForeignKey("rides.id")),
)
# implement database model classes
class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    netid = db.Column(db.String, nullable = False)
    name = db.Column(db.String, nullable = False)
    rides = db.relationship("Ride", secondary=association_table, back_populates="users")

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid", "")
        self.name = kwargs.get("name", "")
    
    def serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
            "rides": [a.simple_serialize() for a in self.rides],
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
        }   

class Ride(db.Model):
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