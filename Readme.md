- levantar servicios:
```
make run-mysql
make run-vault
```

- conectar a la DB:
```
mysql -h 127.0.0.1 -P 3306 -u root -p
```
- crear una DB: 
```
CREATE DATABASE meetup
```
- crear un usuario admin en mysql:
```
GRANT ALL PRIVILEGES ON meetup.* TO 'vault'@'%' IDENTIFIED BY 'vault123' WITH GRANT OPTION;
```
- the process:
```
vault operator init > init.txt
vault secrets enable database
```

Create DB config:
```
vault write database/config/meetup \
plugin_name=mysql-database-plugin \
connection_url="{{username}}:{{password}}@tcp(172.17.0.1:)/" \
allowed_roles="ro,rw" \
username="vault" \
password="vault123"
```
Create roles:
```
vault write database/roles/ro \
db_name=meetup \
creation_statements="GRANT SELECT ON meetup.* TO '{{name}}'@'%' IDENTIFIED BY '{{password}}';" \
default_ttl="3m" \
max_ttl="1h"

vault write database/roles/rw \
db_name=meetup \
creation_statements="GRANT SELECT, INSERT, UPDATE, DELETE ON meetup.* TO '{{name}}'@'%' IDENTIFIED BY '{{password}}';" \
default_ttl="3m" \
max_ttl="1h"
```
- obtener creds desde roles:
```
vault read database/creds/{ro,rw}
```
