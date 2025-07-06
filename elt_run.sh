#!/bin/bash

echo "========== Start Orcestration Process =========="

# Virtual Environment Path
VENV_PATH="/home/laode/pacmann/dvd_rental_case/elt_pipeline.py/.venv/bin/activate"

# Activate Virtual Environment
source "$VENV_PATH"

# Set Python script
PYTHON_SCRIPT="/home/laode/pacmann/dvd_rental_case/elt_pipeline.py"

# Run Python Script 
python3 "$PYTHON_SCRIPT"


echo "========== End of Orcestration Process =========="