#!/bin/sh
# Start Tailscale
tailscaled &

# Wait for Tailscale daemon to start
sleep 5

# Check if LOGIN_KEY is provided and use it if it is
if [ -n "$LOGIN_KEY" ]; then
    tailscale up --login-server=$HEADSCALE_SERVER_URL --authkey=$LOGIN_KEY
else
    tailscale up --login-server=$HEADSCALE_SERVER_URL
fi

# Keep the container running
tail -f /dev/null
