COMPOSER=docker-compose
RELEASER=heroku
CONTAINER=web
ENV_TOOL=./tools/env.ipy


up:
	$(COMPOSER) up --build 

build:
	$(COMPOSER) build

down:
	$(COMPOSER) down

logs:
	$(COMPOSER) logs

mysql:
	$(COMPOSER) run $(CONTAINER) \
		bash -c 'rails db'

console:
	$(COMPOSER) run $(CONTAINER) \
		bash -c 'rails console'

migrate:
	$(COMPOSER) run $(CONTAINER) \
		bash -c 'rails db:migrate'

reset:
	$(COMPOSER) run $(CONTAINER) \
		bash -c 'rails db:reset'

bash:
	$(COMPOSER) run $(CONTAINER) bash

release:
	$(COMPOSER) down \
	&& $(RELEASER) login \
	&& $(RELEASER) container:login \
	&& $(RELEASER) container:push $(CONTAINER) \
	&& $(RELEASER) container:release $(CONTAINER) \
	&& chmod +x $(ENV_TOOL) \
	&& $(ENV_TOOL) \
	&& $(RELEASER) logs --tail
