FROM alpine:3.5

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates curl
RUN apk add bash

#ADD configure.sh.ss+v2ray-plugin /configure.sh
ADD configure.sh.ws /configure.sh

RUN chmod +x /configure.sh
CMD /configure.sh
