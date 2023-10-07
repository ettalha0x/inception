FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache nginx openssl 

RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nettalha.key \
    -out /etc/nginx/ssl/nettalha.crt  \
    -subj "/C=MA/L=Tetouan/O=42/OU=1337 MED/CN=nettalha.42.fr"

RUN mkdir -p /var/www/html/wordpress && chmod 777 /var/www/html

COPY ./conf/nginx.conf /etc/nginx/http.d/nginx.conf
 

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]