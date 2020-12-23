# Vagrant Docker Clusters

A single Ubuntu 18.04 vagrant instance that will spin up clustered products using docker and docker-compose.

Currently, supported clusters are `redis`, `rabbitmq` and `mysql`. The default cluster type is `redis`, the other clusters
can be specified via environment variables.

### Requirements
 - vagrant
 - virtualbox

### Environment Variables
  - `BOOTSTRAP_TARGET` This can be one of the following values `REDIS`, `MYSQL`, `RABBITMQ`, if unset it defaults to `REDIS`
  - `RABBITMQ_CLUSTER_COOKIE` The name of the erlang cluster cookie(optional)
  - `RABBITMQ_ADMIN_USER` The name of the admin user for rabbitmq(optional default admin)
  - `RABBITMQ_ADMIN_PASSWORD` the password for rabbitmq admin(optional, default admin)
  - `MYSQL_ROOT_PASSWORD`  the password for mysql root user(optional, default password)
  - `MYSQL_REPLICATION_GROUP_NAME` the UID for the replication group(optional)

### Getting started

- ##### Rabbitmq
  - `$ BOOTSTRAP_TARGET=RABBITMQ <RABBITMQ_ADMIN_USER=xxx> <RABBITMQ_ADMIN_PASSWORD=yyy> vagrant up`: This will bootstrap the vagrant image with a cluster of 3
    rabbitmq disc nodes. The admin interface is available on http://localhost:15672
  - Rabbitmq data is persisted on the vagrant host under /data/rabbitmq-< nodenumber >

- ##### MySQL
  - `$ BOOTSTRAP_TARGET=MYSQL <MYSQL_ROOT_PASSWORD=xxx> <MYSQL_REPLICATION_GROUP_NAME=yyy> vagrant up`: This will bootstrap the vagrant image with a cluster of 3
    mysql nodes set up in master/slave replication
  - Mysql data is persisted on the vagrant host under /data/rabbitmq-< nodenumber >
