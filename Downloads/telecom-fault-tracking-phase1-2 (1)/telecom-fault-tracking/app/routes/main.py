"""
main.py (routes)
-----------------
Enti chestundi? -> Idi TEMPORARY test route. "/" open chesthe, setup correct ga
                   work avtunda ledaa ani chudataniki matrame.
Phase 6 (Authentication) tarwatha, ee route ni login page ki redirect chesi
replace chestam.
"""

from flask import Blueprint, render_template

main_bp = Blueprint("main", __name__)


@main_bp.route("/")
def index():
    return render_template("setup_check.html")
