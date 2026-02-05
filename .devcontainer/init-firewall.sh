#!/bin/bash
#
# init-firewall.sh - Optional iptables firewall hardening script
#
# WARNING: This is an opt-in security feature. Enable only if you understand
# the implications. May affect Codespaces networking and container connectivity.
#
# Usage:
#   1. Make this script executable: chmod +x .devcontainer/init-firewall.sh
#   2. Add to devcontainer.json postCreateCommand:
#      "postCreateCommand": ".devcontainer/post-create.sh && .devcontainer/init-firewall.sh"
#

set -euo pipefail

echo "🔒 Initializing iptables firewall hardening..."

# Check if running with sufficient privileges
if ! command -v iptables &> /dev/null; then
    echo "❌ ERROR: iptables not available. This script requires iptables."
    exit 1
fi

# Default policy: DROP all incoming, ACCEPT outgoing
echo "Setting default policies..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
echo "Allowing loopback traffic..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related connections
echo "Allowing established connections..."
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH (if needed for remote access)
echo "Allowing SSH (port 22)..."
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS for development servers (optional)
echo "Allowing HTTP/HTTPS (ports 80, 443, 8080, 3000)..."
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

# Allow Jupyter (port 8888)
echo "Allowing Jupyter (port 8888)..."
iptables -A INPUT -p tcp --dport 8888 -j ACCEPT

# Log dropped packets (optional, for debugging)
echo "Enabling packet logging..."
iptables -A INPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4

echo "✅ Firewall hardening complete."
echo ""
echo "Current iptables rules:"
iptables -L -v -n
