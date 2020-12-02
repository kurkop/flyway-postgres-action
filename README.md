# Flyway Postgres Action

This action gets the config file from environment variables and run `flyway migrate` command.

It runs two scripts:

pre-migration: clean localfiles without migration
post-migration: grants access to tables and delete history

_Note: Please check the these scripts before using, I will be happy to help you if you have any issue_ 

## Inputs

### `flyway_conf_sha`

**Required** Content of flyway.conf in base64 file. Default `""`.

Uses `cat flyway.conf | base64` to create the flyway_conf_sha

### `flyway_sql`

**No Required** Path to migrations. Default `"./flyway/sql"`.

#### `pre_migration_bash_sha`

**No Required** Bash file in base64 to run before migration.

#### `post_migration_bash_sha`

**No Required** Bash file in base64 to run after migration.
## Example usage

```yaml
uses: kurkop/flyway-postgres-action@master
with:
  flyway_conf_sha: ${{ secrets.FLYWAY_CONF }}
```
