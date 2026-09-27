"""
extensions.py
-------------
Enti chestundi? -> SQLAlchemy (db) mariyu LoginManager objects ni ikkada create
                   chestam, kani app tho bind cheyyam (init_app() lo bind chestam).
Enduku ikkada?   -> models.py mariyu __init__.py rendu kuda "db" ni import
                   cheyyali. Direct ga __init__.py lo create chesthe,
                   circular import error vastundi. So separate file lo pettam.
"""

from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

db = SQLAlchemy()
login_manager = LoginManager()
login_manager.login_view = "auth.login"
login_manager.login_message = "Please log in to access this page."
login_manager.login_message_category = "warning"
