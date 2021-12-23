FROM flyway/flyway:7.11.4

USER root

RUN apt-get update -y && apt-get install -y postgresql-client libgdal-dev build-essential python3-pip python3-venv wget

RUN wget https://s3.amazonaws.com/redshift-downloads/drivers/jdbc/2.1.0.1/redshift-jdbc42-2.1.0.1.jar

RUN mv redshift-jdbc42-2.1.0.1.jar /flyway/drivers/

COPY entrypoint.sh /entrypoint.sh
COPY pre-migration.sh /pre-migration.sh

# Remove destructive packages.
RUN  apt-get remove -y wget

ENTRYPOINT ["/entrypoint.sh"]
