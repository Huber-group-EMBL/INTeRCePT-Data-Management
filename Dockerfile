FROM quay.io/oauth2-proxy/oauth2-proxy

COPY email_list.txt /site_config/
COPY _site /app/

# Set environment variable for the port that Render provides
ENV PORT 10000

# Expose the port that Render expects
EXPOSE $PORT

ENTRYPOINT ["/bin/oauth2-proxy", \
            "--provider", "google", \
            "--upstream", "file:///app/#/", \
            "--authenticated-emails-file", "/site_config/email_list.txt", \
            "--scope=openid profile email", \
            "--cookie-expire=0h0m30s", \
            "--skip-provider-button=true", \
            "--http-address=0.0.0.0:$PORT"]