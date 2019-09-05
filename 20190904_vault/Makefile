.PHONY: build-vault clean shit run-mysql run-vault

build-vault:
	docker build -t boris/vault-meetup:latest -f vault/Dockerfile ./vault

clean:
	docker stop vault-meetup
	docker stop vault-mysql

shit:
	docker stop vault-meetup
	docker stop vault-mysql
	rm init.txt
	sudo rm -rf vault/data

run-mysql:
	docker run -P -d --rm \
	    -e MYSQL_ROOT_PASSWORD=supersecret \
	    -v /home/boris/Code/hashicorp/meetup/mysql/data:/var/lib/mysql \
	    --name vault-mysql \
	    mysql:5.7

run-vault:
	docker run -P -d --rm \
	    -v /home/boris/Code/hashicorp/meetup/vault/data:/vault/file \
	    --name vault-meetup \
	    boris/vault-meetup:latest
	@echo "Remember to check vault port and export VAULT_ADDR!!"

