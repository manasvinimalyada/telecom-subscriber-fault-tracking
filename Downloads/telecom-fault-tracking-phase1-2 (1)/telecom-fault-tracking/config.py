"""
config.py
---------
Ee file lo app configuration untundi.
Enti chestundi?  -> .env file nunchi secret values (DB password, secret key) chadivi,
                    app ki avasaramaina settings ni build chestundi.
Enduku required?  -> Passwords/keys ni code lo direct ga rayakunda undataniki
                    (security best practice).
Ekkada undali?    -> Project root lo (telecom-fault-tracking/config.py)
"""

import os
from dotenv import load_dotenv

# .env file lo unna variables ni load chesi, os.environ lo pedutundi
load_dotenv()


class Config:
    # Flask secret key - sessions/cookies ni sign cheyyataniki use avtundi
    SECRET_KEY = os.environ.get("SECRET_KEY", "dev-key-change-me")

    # MySQL connection details
    MYSQL_HOST = os.environ.get("MYSQL_HOST", "localhost")
    MYSQL_PORT = os.environ.get("MYSQL_PORT", "3306")
    MYSQL_USER = os.environ.get("MYSQL_USER", "root")
    MYSQL_PASSWORD = os.environ.get("MYSQL_PASSWORD", "")
    MYSQL_DATABASE = os.environ.get("MYSQL_DATABASE", "telecom_fault_tracking")

    # SQLAlchemy ki full connection string (PyMySQL driver use chestunnam)
    SQLALCHEMY_DATABASE_URI = (
        f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}"
        f"@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Debug mode - development lo True, production lo False
    DEBUG = os.environ.get("FLASK_DEBUG", "1") == "1"
