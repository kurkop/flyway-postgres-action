FROM flyway/flyway:6.4.0

USER root

RUN apt-get update -y && apt-get install -y postgresql-client libgdal-dev build-essential python3-pip python3-venv

COPY entrypoint.sh /entrypoint.sh
COPY pre-migration.sh /pre-migration.sh

ENTRYPOINT ["/entrypoint.sh"]

