#!/bin/bash
# Simple test suite for HistoriX core and advanced modules

set -e

HISTORIX=bin/historiX.sh

# Test shell and history detection
bash $HISTORIX --help
bash $HISTORIX --features

# Test: version info
bash $HISTORIX --version | grep -q 'HistoriX version'

# Test: features list contains key features
bash $HISTORIX --features | grep -q 'Top Commands'

# Test: help output contains usage
bash $HISTORIX --help | grep -qi 'usage\|help'

# Test menu (non-interactive, just to check for errors)
echo 9 | bash $HISTORIX

# Test: menu advanced section (simulate input for advanced > security > back)
echo -e '9\nb\nd' | bash $HISTORIX | grep -q 'Security & Privacy'

# Test: real-time monitoring module loads (simulate input for advanced > monitoring > back)
echo -e '9\na\ni' | bash $HISTORIX | grep -q 'Real-Time Monitoring'

# Test: plugin manager (list plugins)
echo -e '9\ne\na\nc' | bash $HISTORIX | grep -q 'Available plugins'

# Test: workflow detection (advanced > workflow > detect > back)
echo -e '9\nd\na\nc' | bash $HISTORIX | grep -q 'Workflows: Most common command sequences'

# Test: CLI animations demo (spinner, then back)
echo -e '9\nh\na\nc' | bash $HISTORIX | grep -q 'CLI Animations Demo'

# Test: exit from menu
echo 9 | bash $HISTORIX | grep -q 'Goodbye'

# Edge case: invalid option in main menu
echo '99' | bash $HISTORIX | grep -qi 'invalid option'

# Edge case: invalid submenu option
echo -e '9\nz\ni' | bash $HISTORIX | grep -qi 'invalid advanced option'

# Edge case: missing config file (temporarily move it)
if [ -f data/historix.conf ]; then
  mv data/historix.conf data/historix.conf.bak
  bash $HISTORIX --features | grep -q 'Feature'
  mv data/historix.conf.bak data/historix.conf
fi

# Edge case: missing plugin directory (temporarily move it)
if [ -d plugins ]; then
  mv plugins plugins.bak
  echo -e '9\ne\na\nc' | bash $HISTORIX | grep -qi 'no plugins directory'
  mv plugins.bak plugins
fi

# Test: plugin loading and function listing
bash $HISTORIX --features > /dev/null # ensure env
bash $HISTORIX <<EOF
9
e
b
EOF
# Should load plugins
bash $HISTORIX <<EOF
9
e
a
EOF | grep -q 'example_plugin.sh'
# Test: run plugin by function name (greet_user)
bash $HISTORIX <<EOF
9
e
c
historiX_plugin_greet_user
EOF | grep -q 'Hello'
# Test: workflow export
bash $HISTORIX <<EOF
9
d
b
EOF | grep -q 'Workflow script exported'
# Test: schedule report (simulate input)
bash $HISTORIX <<EOF
9
c
b
0 8 * * *
EOF | grep -q 'Report scheduled'

echo "All advanced and edge case tests passed."
