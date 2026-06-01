#!/bin/bash

echo "-- Updating Packages..."
sudo pacman -Syu -y &
echo "[O] Updates Complete"

echo "-- Creating VENV"
mkdir venv
python -m venv venv

touch pyrightconfig.json

cat <<'EOF' >pyrightconfig.json
{
  "venvPath": ".",
  "venv": "venv",

  "include": ["."],

  "typeCheckingMode": "standard",

  "reportMissingImports": true,
  "reportMissingTypeStubs": true,

  "pythonVersion": "3.12",
  "pythonPlatform": "Linux",

  "exclude": [
    "venv",
    "__pycache__"
  ]
}
EOF

echo "[O] Venv Creation Comllete"
