#!/bin/bash

set -e

ROOT_DIR="python-coding-agency"
SRC_DIR="$ROOT_DIR/src/agency"

echo "📁 Creating new src/agency layout..."
mkdir -p $SRC_DIR/{agents,tasks,tools,workflows}

# Move source files into new structure
mv $ROOT_DIR/agents/*.py $SRC_DIR/agents/
mv $ROOT_DIR/tasks/*.py $SRC_DIR/tasks/
mv $ROOT_DIR/tools/*.py $SRC_DIR/tools/
mv $ROOT_DIR/workflows/*.py $SRC_DIR/workflows/

# Create __init__.py files
touch $SRC_DIR/__init__.py
touch $SRC_DIR/agents/__init__.py
touch $SRC_DIR/tasks/__init__.py
touch $SRC_DIR/tools/__init__.py
touch $SRC_DIR/workflows/__init__.py

echo "✅ Directory structure updated under src/agency"

# Update import paths in Python files
echo "🔄 Updating import statements to use agency package paths..."

find $SRC_DIR -name "*.py" -exec sed -i '' -E \
  -e 's/from agents\./from agency.agents./g' \
  -e 's/from tasks\./from agency.tasks./g' \
  -e 's/from tools\./from agency.tools./g' \
  -e 's/from workflows\./from agency.workflows./g' \
  {} +

# Also update main.py at root
sed -i '' -E \
  -e 's/from workflows\./from agency.workflows./g' \
  $ROOT_DIR/main.py

echo "✅ Import paths updated."

# Optional: move tests under tests/ if not already
if [ -f "$ROOT_DIR/tests/test_dummy.py" ]; then
  echo "📁 tests/ already exists."
else
  echo "📁 Creating tests/ directory with basic test..."
  mkdir -p $ROOT_DIR/tests
  echo -e "def test_sanity():\n    assert 2 + 2 == 4" > $ROOT_DIR/tests/test_dummy.py
fi

echo "🎉 Refactor complete!"
