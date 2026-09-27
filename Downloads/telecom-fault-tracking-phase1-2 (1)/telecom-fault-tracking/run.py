"""
run.py
------
Enti chestundi? -> Ee file ni run cheste, Flask development server start avtundi.
Ela run cheyyali? -> Terminal lo:  python run.py
Expected result -> Terminal lo "Running on http://127.0.0.1:5000" ani kanapadali.
                    Browser lo aa URL open cheste, setup check page kanapadali.
"""

from app import create_app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True)
