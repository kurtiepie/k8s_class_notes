FROM alpine:latest 
COPY ./entrypoint.sh / 
RUN apk --no-cache add netcat-openbsd curl
RUN chmod +x /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]
