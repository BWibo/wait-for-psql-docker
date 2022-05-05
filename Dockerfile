FROM alpine:3.15
RUN apk --no-cache add postgresql-client bash
COPY wait-for-psql.sh /usr/bin/wait-for-psql
RUN \
  chmod u+x /usr/bin/wait-for-psql
ENTRYPOINT [ "wait-for-psql" ]
