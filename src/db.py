from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# association_table = db.Table(
#     "association", db.Model.metadata,
#     db.Column("user_id", db.Integer, db.ForeignKey("users.id")),
#     db.Column("request_id", db.Integer, db.ForeignKey("requests.id")),
# )
# implement database model classes
class User(db.Model):
    __tablename__ = "Users"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    netid = db.Column(db.String, nullable = False)
    name = db.Column(db.String, nullable = False)
    requests = db.relationship("Request", cascade="delete")

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid", "")
        self.name = kwargs.get("name", "")
    
    def serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
            "requests": [a.serialize() for a in self.requests],
        }
    
    def simple_serialize(self):
        return {
            "id": self.id,
            "netid": self.netid,
            "name": self.name,
        }   

class Request(db.Model):
    __tablename__ = "requests"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    date = db.Column(db.String, nullable = False)
    destination = db.Column(db.Integer, nullable = False)
    user_id = db.Column(db.Integer, db.ForeignKey("Users.id"), nullable = False)
    user = db.relationship("User", back_populates="requests")


    def __init__(self, **kwargs):
        self.date = kwargs.get("date", "")
        self.destination = kwargs.get("destination", "") 
        self.user_id = kwargs.get("user_id")

    def serialize(self):
        return {
            "id": self.id,
            "date": self.date,
            "destination": self.destination,
            "user": self.user.simple_serialize()
        }