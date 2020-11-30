FROM flyway/flyway:6.4.0

COPY entrypoint.sh /entrypoint.sh
COPY pre-migration.sh /pre-migration.sh
COPY post-migration.sh /post-migration.sh

RUN chmod +x pre-migration post-migration

ENTRYPOINT ["/entrypoint.sh"]

