FROM alpine
MAINTAINER kost - https://github.com/kost

RUN apk --update add php5-apache2 curl php5-cli php5-json php5-phar php5-openssl && rm -f /var/cache/apk/* && \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
mkdir /app && chown -R apache:apache /app && \
sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g' /etc/apache2/httpd.conf && \
sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
echo "Success"

ADD scripts/run.sh /scripts/run.sh
RUN mkdir /scripts/pre-exec.d && \
mkdir /scripts/pre-init.d && \
chmod -R 755 /scripts

EXPOSE 80

# VOLUME /app
WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]

