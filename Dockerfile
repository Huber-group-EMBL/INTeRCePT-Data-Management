FROM quay.io/oauth2-proxy/oauth2-proxy

# Copy configuration files
COPY email_list.txt /site_config/
COPY _site /app/

# Ensure the environment variable OAUTH2_PROXY_HTTP_ADDRESS is used in the command properly
ENTRYPOINT ["/bin/sh", "-c", "/bin/oauth2-proxy --provider google --upstream file:///app/#/ --authenticated-emails-file /site_config/email_list.txt --scope=openid profile email --cookie-expire=0h0m30s --skip-provider-button=true --http-address=$(echo $OAUTH2_PROXY_HTTP_ADDRESS)"]
