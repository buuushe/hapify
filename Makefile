#################################
# Application workflow
#################################

SERVICES=laravel-app nginx redis mysql

# Run all containers
.PHONY: up
up:
	@docker-compose up -d ${SERVICES}

# Stop all containers
.PHONY: down
down:
	@docker-compose -f docker-compose.yml down

# Rebuild
.PHONY: rebuild
rebuild:
	@docker-compose -f docker-compose.yml up -d --build ${SERVICES}

# Test
.PHONY: test
test: up
	@docker-compose -f docker-compose.yml up test

# Restart
.PHONY: restart
restart: down up

# Reload all services
.PHONY: reload
reload: nginx-reload php-reload

# Nginx reload
.PHONY: nginx-reload
nginx-reload:
	@docker-compose exec nginx sh -c 'nginx -s reload'

# Php reload
.PHONY: php-reload
php-reload:
	@docker-compose exec laravel-app sh -c 'kill 1'

#################################
# Test & debug 
#################################

# Nginx reload
.PHONY: workspace
workspace:
	@docker-compose exec --user=laradock workspace zsh

# Healthcheck
.PHONY: nginx-healthcheck
nginx-healthcheck: up
	@docker-compose exec nginx sh -c 'curl -v http://localhost/healthcheck'