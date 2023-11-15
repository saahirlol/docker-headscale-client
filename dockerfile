# Use the official Tailscale image
FROM tailscale/tailscale

# Set default environment variables for the Tailscale server URL and the auth key
ENV HEADSCALE_SERVER_URL="https://controlplane.tailscale.com:443"
ENV LOGIN_KEY=""

# Copy the start script into the container
COPY start-tailscale.sh /start-tailscale.sh

# Make the script executable
RUN chmod +x /start-tailscale.sh

# Set the entrypoint to the script
ENTRYPOINT ["/start-tailscale.sh"]
