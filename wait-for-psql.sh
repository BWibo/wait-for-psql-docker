#!/usr/bin/env bash
# wait-for-psql.sh ------------------------------------------------------------
#   Wait for Postgres to become available and execute a command with arguments
#   when the server is up.
#------------------------------------------------------------------------------
# config ----------------------------------------------------------------------
sleeptime=1

# functions -------------------------------------------------------------------
function usage()
{
    cat << USAGE >&2


Usage:
   wait-for-psql.sh TIMEOUT HOST PORT DBNAME USERNAME PASSWORD [COMMAND] [ARGUMENTS...]

    TIMEOUT         Timeout in seconds
    HOST            Host or IP of the postgres server
    PORT            Postgres server port
    DBNAME          Postgres database name
    USERNAME        Postgres db user
    PASSWORD        Postgres db password
    COMMAND ARGS    Execute command with args after the test finishes

Exit codes: 0 = Postgres available, 1 = timeout.

USAGE
}

# process arguments -----------------------------------------------------------
if [ "$#" -lt 6 ]; then
  printf '\nWrong number of arguments passed! At least 5 args are required.'
  usage
  exit 1
fi

timeout="$1"
host="$2"
port="$3"
dbname="$4"
user="$5"
export PGPASSWORD="$6"

# set command to execute, if psql server is online within timeout -------------
shift 6
cmd="$@"

# test postgres until timeout -------------------------------------------------
until psql -h "$host" -p "$port" -d "$dbname" -U "$user" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping for ${sleeptime}s..."
  sleep $sleeptime
  if [ "$SECONDS" -gt "$timeout" ]; then
    >&2 echo Timeout
    exit 1
  fi
done

# postgres is up
>&2 echo "Postgres is up - executing command: $cmd"
exec $cmd
