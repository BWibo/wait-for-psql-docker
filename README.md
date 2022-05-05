# Wait for `psql`

`wait-for-psql` is a simple script packed in a `Dockerfile` to wait for a
postgres database to become available. For instance, this is handy when
automatically testing a database schema, that takes some time to setup.

The Docker image is available at `bwibo/wait-for-psql` from
[DockerHub](https://hub.docker.com/repository/docker/bwibo/wait-for-psql/tags).

```text
Usage:
    docker run --rm -t bwibo/wait-for-psql \
      TIMEOUT HOST PORT USERNAME PASSWORD [COMMAND] [ARGUMENTS...]

    TIMEOUT         Timeout in seconds
    HOST            Host or IP of the postgres server
    PORT            Postgres server port
    USERNAME        Postgres db user
    PASSWORD        Postgres db password
    COMMAND ARGS    Execute command with args after the test finishes

Exit codes: 0 = Postgres available, 1 = timeout.
```
