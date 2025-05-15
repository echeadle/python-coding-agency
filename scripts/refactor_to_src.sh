#!/bin/bash
#
# Script: refactor_to_src.sh
# Purpose: Restructure a flat Python project to use the recommended `src/` layout.
# Usage: Run from the project root. Will move agents/, tasks/, tools/, workflows/ → src/agency/.
# Adds __init__.py files and rewrites import paths accordingly.
# Author: [Your Name or Team]
# License: MIT

set -e

SRC_DIR="src/agency"

echo "📁 Creating new src/agency layout..."
mkdir -p $SRC_DIR/{agents,tasks,tools,workflows}

mv agents/*.py $SRC_DIR/agents/
mv tasks/*.py $SRC_DIR/tasks/
mv tools/*.py $SRC_DIR/tools/
mv workflows/*.py $SRC_DIR/workflows/

touch $SRC_DIR/__init__.py
touch $SRC_DIR/agents/__init__.py
touch $SRC_DIR/tasks/__init__.py
touch $SRC_DIR/tools/__init__.py
touch $SRC_DIR/workflows/__init__.py

echo "✅ Directory structure updated under src/agency"

echo "🔄 Updating import statements to use agency package paths..."

find $SRC_DIR -name "*.py" -exec sed -i '' -E \
  -e 's/from agents\./from agency.agents./g' \
  -e 's/from tasks\./from agency.tasks./g' \
  -e 's/from tools\./from agency.tools./g' \
  -e 's/from workflows\./from agency.workflows./g' \
  {} +

sed -i '' -E \
  -e 's/from workflows\./from agency.workflows./g' \
  main.py

if [ ! -d "tests" ]; then
  echo "📁 Creating tests/ directory with basic test..."
  mkdir -p tests
  echo -e "def test_sanity():\n    assert 2 + 2 == 4" > tests/test_dummy.py
fi

echo "🎉 Refactor complete!"
