FROM alpine:3.20.2

# install dependencies
RUN apk update && apk add --no-cache \
  iwd

# Copy configs and scripts
RUN mkdir /conf /app /run/dhcp
ADD conf/* /conf
ADD app/* /app
RUN chmod +x /app/start.sh

# Start iwd service on every boot
RUN rc-service iwd start
RUN rc-update add iwd default

CMD [ "/app/start.sh" ]
