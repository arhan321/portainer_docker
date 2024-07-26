FROM httpd:2.4

# Install necessary packages and enable modules
RUN apt-get update && apt-get install -y \
    ssl-cert \
    && apt-get clean

# Copy custom configuration file
COPY ./apache-config.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY ./certs/ /usr/local/apache2/certs/

# Enable necessary modules by copying config
RUN echo "LoadModule ssl_module modules/mod_ssl.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "Include /usr/local/apache2/conf/extra/httpd-vhosts.conf" >> /usr/local/apache2/conf/httpd.conf