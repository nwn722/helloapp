IMAGE=helloapp
CONTAINER=helloapp-container
PORT=80

build-container:
	echo "Initiating Docker build..."
	docker build  -t $(IMAGE) .

run: check-env
	docker run --rm --env ENV=${ENV} -p $(PORT):80 --name $(CONTAINER) -d $(IMAGE)

stop:

	docker stop $(CONTAINER) || true

ssh:
	docker exec -it $(IMAGE) bash

bash:
	docker run -it --rm  $(CONTAINER) /bin/bash

rebuild: build-container check-env restart

restart: stop run

check-env:
ifndef ENV
	$(error ENV is undefined.  Accepted Values: DEV, PROD or UAT.)
endif
