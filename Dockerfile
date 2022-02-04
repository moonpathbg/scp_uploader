FROM alpine
RUN apk update && apk add git openssh
COPY . /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
