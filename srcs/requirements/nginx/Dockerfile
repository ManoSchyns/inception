FROM debian:bookworm

RUN apt update && \
    apt install -y nginx && \
    apt install -y openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mschyns.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

COPY conf/default.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
