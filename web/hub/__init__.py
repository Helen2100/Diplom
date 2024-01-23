from flask import Flask
from flask_sqlalchemy import SQLAlchemy

import os

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)

    app.config['SECRET_KEY'] = os.environ['SECRET_KEY']
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///modules.sqlite'

    db.init_app(app)

    from . import models

    with app.app_context():
        db.create_all()

    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app
