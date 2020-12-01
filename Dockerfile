FROM flyway/flyway:6.4.0

USER root

RUN apt-get update -y && apt-get install -y postgresql-client

USER flyway

COPY entrypoint.sh /entrypoint.sh
COPY pre-migration.sh /pre-migration.sh
COPY post-migration.sh /post-migration.sh

# RUN chmod +x /pre-migration.sh /post-migration.sh

ENTRYPOINT ["/entrypoint.sh"]

