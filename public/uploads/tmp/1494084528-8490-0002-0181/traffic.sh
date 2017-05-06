#!/bin/bash

# Reset dummynet to default config
dnctl -f flush

# Compose an addendum to the default config: creates a new anchor
(cat /etc/pf.conf &&
  echo 'dummynet-anchor "my_anchor"' &&
  echo 'anchor "my_anchor"') | pfctl -q -f -

# Configure the new anchor
cat <<EOF | pfctl -q -a my_anchor -f -
no dummynet quick on lo0 all
dummynet in proto tcp from any to any port 1:65535 pipe 1
EOF

# Create the dummynet queue
dnctl pipe 1 config bw 200000byte/s

# Activate PF
pfctl -E

# to check that dnctl is properly configured: sudo dnctl list

