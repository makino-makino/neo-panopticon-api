COMPOSER=docker-compose
RELEASER=heroku
CONTAINER=web
ENV_TOOL=./tools/env.ipy


up:
	$(COMPOSER) up

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

deploy:
	$(COMPOSER) down \
	&& $(RELEASER) login \
	&& $(RELEASER) container:login \
	&& $(RELEASER) container:push $(CONTAINER) \
	&& $(RELEASER) addons:create heroku-postgresql:hobby-dev \
	&& $(RELEASER) container:release $(CONTAINER) \
	&& chmod +x $(ENV_TOOL) \
	&& $(ENV_TOOL) \
	&& $(RELEASER) logs --tail
