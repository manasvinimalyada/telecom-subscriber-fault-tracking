"""
app/__init__.py
----------------
Enti idi?        -> "Application Factory" pattern. Flask app ni build cheyyadaniki
                    ee file lo unna create_app() function ni use chestam.
Enduku factory?  -> Direct ga "app = Flask(__name__)" module level lo create chesthe,
                    testing/config-switching complicated avtundi. Factory pattern tho
                    "create_app()" ni pilిస్తే prathisari fresh app vastundi.
Ekkada run avtundi? -> run.py ee function ni call chestundi.
"""

from flask import Flask
from config import Config
from app.extensions import db, login_manager


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    # Extensions ni app tho bind cheyyadam
    db.init_app(app)
    login_manager.init_app(app)

    # Blueprints register cheyyadam (ippatiki main matrame; tarvatha phases lo
    # auth_bp, dashboard_bp, subscribers_bp, faults_bp... ila add chestam)
    from app.routes.main import main_bp
    app.register_blueprint(main_bp)

    return app
