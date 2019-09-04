.PHONY: build-vault clean shit run-mysql run-vault unseal

build-vault:
	docker build -t boris/vault-meetup:latest -f vault/Dockerfile ./vault

clean:
	docker stop vault-meetup
	docker stop vault-mysql

shit:
	docker stop vault-meetup
	docker stop vault-mysql
	rm init.txt
	rm -rf vault/data

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

unseal:
	vault operator unseal zlKIfVvrGnP+30Iyr7dC027zM6EPLPE+rv164dfQAQ5I
	vault operator unseal 4YXdPUYfdKbMQhEdItwCbsBah99PmpVJOocq0DL1SItH
	vault operator unseal 1Sh3Scfouu1ZpDcERTRIB15qFlS1QKSnqjnY6I2jAreb
	clear
	vault status
	vault login 
