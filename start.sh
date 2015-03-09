#!/usr/bin/env bash
set -o errexit

# Remove lock file (for restarts)
rm -f /data/.jira-home.lock

# Configure database driver
cat > /data/dbconfig.xml <<END
<?xml version="1.0" encoding="UTF-8"?>
<jira-database-config>
<name>defaultDS</name>
<delegator-name>default</delegator-name>
<database-type>postgres72</database-type>
<jdbc-datasource>
  <url>jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/${DB_DATABASE:-jira}</url>
  <driver-class>org.postgresql.Driver</driver-class>
  <username>${DB_USER:-postgres}</username>
  <password>${DB_PASSWORD:-}</password>
  <pool-min-size>20</pool-min-size>
  <pool-max-size>20</pool-max-size>
  <pool-max-wait>30000</pool-max-wait>
  <pool-max-idle>20</pool-max-idle>
  <pool-remove-abandoned>true</pool-remove-abandoned>
  <pool-remove-abandoned-timeout>300</pool-remove-abandoned-timeout>
</jdbc-datasource>
</jira-database-config>
END

# Start
/opt/jira/bin/start-jira.sh -fg
