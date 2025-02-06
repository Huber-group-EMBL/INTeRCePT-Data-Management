# Use the OAuth2 Proxy image
FROM quay.io/oauth2-proxy/oauth2-proxy

# Copy required files into the container
COPY email_list.txt /site_config/
COPY _site /app/

# Set up the OAuth2 Proxy to use Google authentication
ENTRYPOINT ["/bin/oauth2-proxy", \
            "--provider", "google", \
            "--upstream", "file:///app/#/", \
            "--authenticated-emails-file", "/site_config/email_list.txt", \
            "--scope=openid profile email", \
            "--cookie-expire=0h0m30s", \
            "--skip-provider-button=true", \
            "--http-address=0.0.0.0:${PORT}", \
            "--redirect-url=${OAUTH2_PROXY_REDIRECT_URL}", \
            "--cookie-secure=false", \
            "--cookie-csrf-per-request=true", \
            "--cookie-csrf-expire=5m"]
