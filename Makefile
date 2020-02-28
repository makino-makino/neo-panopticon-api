PROGRAM=docker-compose
CONTAINER=api

up:
	rm ./tmp/pids/server.pid \
	; $(PROGRAM) up 

build:
	$(PROGRAM) build

down:
	$(PROGRAM) down

logs:
	$(PROGRAM) logs

mysql:
	$(PROGRAM) run $(CONTAINER) \
		bash -c 'rails db'

console:
	$(PROGRAM) run $(CONTAINER) \
		bash -c 'rails console'

bash:
	$(PROGRAM) run $(CONTAINER) bash
