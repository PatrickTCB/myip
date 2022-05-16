start:
	docker run -d -p "[::1]:80:80" --network bridge --restart always --name myip myip:latest
stop:
	docker stop myip
	docker container rm myip
