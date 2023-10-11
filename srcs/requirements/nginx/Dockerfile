FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache nginx openssl && apk add --no-cache git

RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nettalha.key \
    -out /etc/nginx/ssl/nettalha.crt  \
    -subj "/C=MA/L=Tetouan/O=42/OU=1337 MED/CN=nettalha.42.fr"

RUN /bin/sh -c 'mkdir -p /var/www/html/{wordpress,portfolio}' && chmod 777 /var/www/html

RUN /bin/sh -c 'git clone https://github.com/ettalha0x/ettalha0x.github.io.git /var/www/html/portfolio'

COPY ./conf/nginx.conf /etc/nginx/http.d/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]