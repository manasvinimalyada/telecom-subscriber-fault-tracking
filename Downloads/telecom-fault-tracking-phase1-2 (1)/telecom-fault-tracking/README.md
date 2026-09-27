# Telecom Subscriber & Fault Tracking System

Flask + MySQL based telecom subscriber and fault management system.
Built progressively, phase by phase (see chat history for each phase's explanation).

## Current status: Phase 1 & 2 complete
- Project folder structure created
- Flask application factory wired up
- A "setup check" page confirms the skeleton runs
- `database/schema.sql` ready for Phase 3

## How to run (once dependencies are installed)
```bash
python -m venv venv
venv\Scripts\activate          # Windows
pip install -r requirements.txt
copy .env.example .env         # then edit .env with your MySQL password
python run.py
```
Open http://127.0.0.1:5000 in your browser.
