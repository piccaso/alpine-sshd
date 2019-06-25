FROM alpine:3.10
RUN apk add --no-cache dropbear
RUN mkdir /etc/dropbear
RUN touch /var/log/lastlog
COPY docker-entrypoint.sh /
EXPOSE 22
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["dropbear", "-RFEwg", "-p", "22"]
