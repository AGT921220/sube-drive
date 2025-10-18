include .env

 example:
	@echo ${SERVER_PASS};
up:
	@docker compose down;\
	docker-compose up -d
up-dev:
	@docker compose down;\
	docker compose -f docker-compose-dev.yml up -d;
down-dev:
	@docker compose -f docker-compose-dev.yml down;
install:
	echo "Docker Exec";\
	docker exec -it php-sube composer install
enter:
	docker exec -it php-sube /bin/bash;
nginx:
	docker exec -it nginx-sube /bin/sh;	
qa-code-metrics:
	@php artisan qa;	
test:
	@./vendor/bin/phpunit --stop-on-error --stop-on-failure

# restart-database-testing:
# 	@php artisan migrate:rollback --env=testing;\
# 	php artisan migrate --env=testing;\
# 	php artisan initial_setup_test --env=testing;\
# 	php artisan db:restore-config

	@php vendor/bin/phpunit --stop-on-error --stop-on-failure --no-coverage;
restart-database-testing:
	@docker exec -i mysql-sube mysql -u user -ppassword -e "DROP DATABASE IF EXISTS testing; CREATE DATABASE testing;"
	@docker exec -i mysql-sube mysql -u user -ppassword testing < testing_db.sql

restart-database-github-action:
	@docker exec -i mysql-sube mysql -u user -ppassword -e "DROP DATABASE IF EXISTS db; CREATE DATABASE db;"
	@docker exec -i mysql-sube mysql -u user -ppassword db < testing_db.sql

#Agregar migraciones a base de datos de Testing
migrate-testing:
	@php artisan migrate --env=testing

#Exporta la base de datos de Testing
create-testing-db:
	@docker exec -i mysql-sube mysqldump -u user -ppassword db > storage/app/testing_db.sql

# 	@if [ -f testing_db.sql ]; then \
# 		mkdir -p storage/testing; \
# 	fi
# 	@docker exec -i mysql-sube mysqldump -u user -ppassword db > testing_db.sql
db-export:
	@docker exec -i mysql-sube mysqldump -u user -ppassword db > storage/app/sube.sql

restart-testing-db:
	@docker exec -i mysql-sube mysql -u user -ppassword -e "CREATE DATABASE testing;"
	

clear:
	@docker exec -it php-sube /bin/bash -c \
"php artisan config:cache && php artisan config:clear && php artisan horizon:terminate && php artisan queue:restart && php artisan route:clear && php artisan route:cache"
#&& php artisan horizon:purge
#&& php artisan cache:clear
deploy:
	@docker exec -it php-sube /bin/bash -c "php artisan config:clear && php artisan config:cache"

qa/full-report:
	@mkdir -p build/phpmd && mkdir -p build/phpcs && mkdir -p build/coverage-report &&\
	php -d pcov.enabled=1 -dpcov.directory=./app vendor/bin/phpunit --coverage-html=./build/coverage-report && \
	vendor/bin/phpmd app html phpmd.xml --reportfile build/phpmd/phpmd.html --ignore-violations-on-exit && \
	vendor/bin/phpcs --report=summary --report-file=./build/phpcs/phpcs_summary.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app && \
	vendor/bin/phpcs --report=source --report-file=./build/phpcs/phpcs_source.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app && \
	vendor/bin/phpcs --report=full --report-file=./build/phpcs/phpcs_full.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app;

coverage:
	@php -d memory_limit=512M -d xdebug.mode=coverage vendor/bin/phpunit --coverage-clover='build/coverage-report/coverage.xml' --coverage-html='build/coverage-report'
	
old/qa-full-report:
# @mkdir -p build/phpmd && mkdir -p build/phpstan && mkdir -p build/phpcs && mkdir -p build/coverage-report &&\
# vendor/bin/phpunit --coverage-clover ./build/phpunit-sonarqube/coverage.xml --log-junit ./build/phpunit-sonarqube/logfile.xml \
# --coverage-html ./build/coverage-report && \
# phpdismod -s cli xdebug && \
# vendor/bin/phpmd app html phpmd.xml --reportfile build/phpmd/phpmd.html --ignore-violations-on-exit && \
# vendor/bin/phpcs --report=summary --report-file=./build/phpcs/phpcs_summary.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app && \
# vendor/bin/phpcs --report=source --report-file=./build/phpcs/phpcs_source.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app && \
# vendor/bin/phpcs --report=full --report-file=./build/phpcs/phpcs_full.txt --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1 app;

server-enter:
	@ssh root@${SERVER_IP}
#	@sshpass -p test ssh root@e73c1b9.online-server.cloud


coverage-report:
	@./vendor/bin/phpunit --coverage-html build/coverage-report
check-namespaces:
	@php artisan check_namespaces



configure-testing-database:
	@php artisan migrate --env="testing";
utils/paste-master:
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD); \
    git checkout master; \
    git pull origin master; \
    git checkout $$CURRENT_BRANCH; \
    git merge master;

install-xdebug:
	@apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.9.2 \
    && docker-php-ext-enable xdebug 
phpunit-config:
	@alias phpunit='./vendor/bin/phpunit';
ngrok:
	@ngrok http --host-header=rewrite http://localhost:8088;

create-valid-path:
	@mkdir -p storage/framework/cache \
	mkdir -p storage/framework/views

import-db:
	@docker exec -i ${DB_HOST} mysql -u user -ppassword -e "DROP DATABASE IF EXISTS ${DB_DATABASE}; CREATE DATABASE ${DB_DATABASE};"
	@docker exec -i ${DB_HOST} mysql -u user -ppassword ${DB_DATABASE} < storage/app/sube.sql

testing/import-db:
	@docker exec -i ${DB_HOST} mysql -u user -ppassword -e "DROP DATABASE IF EXISTS testing; CREATE DATABASE testing;"
	@docker exec -i ${DB_HOST} mysql -u user -ppassword testing < storage/app/sube.sql

restart-testing:
	@docker exec -i mysql-sube bash -c "\
		mysql -u root -p1234 -e 'DROP DATABASE IF EXISTS testing; CREATE DATABASE testing; GRANT ALL PRIVILEGES ON testing.* TO \"user\"@\"%\" IDENTIFIED BY \"password\" WITH GRANT OPTION; FLUSH PRIVILEGES;'"\

refresh-database-performance:
	# Ejecutar comandos en el contenedor MySQL
	@docker exec -i mysql-sube bash -c "\
		mysql -u root -p1234 -e 'DROP DATABASE IF EXISTS performance; CREATE DATABASE performance; GRANT ALL PRIVILEGES ON performance.* TO \"user\"@\"%\" IDENTIFIED BY \"password\" WITH GRANT OPTION; FLUSH PRIVILEGES;'"
	
	# Ejecutar comandos en el contenedor PHP
	@docker exec -it php-sube bash -c "php artisan migrate --env=performance"
	@docker exec -it php-sube bash -c "php artisan initial_setup_performance"

restart-database-performance:
	@docker exec -i mysql-sube mysql -u user -ppassword -e "DROP DATABASE IF EXISTS performance; CREATE DATABASE performance;"
	@docker exec -i mysql-sube mysql -u user -ppassword performance < ./storage/app/performance.sql


develop-server/copy-signs:
	rsync -avz ~/Alfredo/Personal/Proyectos/sube-drive/public/images/usuarios/firma_digital/ root@74.208.83.112:/home/sube-drive/public/images/usuarios/firma_digital/

update-bulk-passwords:
	@echo "Actualizando contraseñas de usuarios..."
	@docker exec php-sube php artisan update-bulk-passwords

UNUSED_PHP_FILES=unused_php_files.txt

check-unused-php:
	@echo "Buscando archivos .php no utilizados en el sistema Laravel..."
	@find app -type f -name "*.php" | sed 's|^\./||' > all_php_files.txt
	@grep -hr --include=\*.php -E "namespace|class" app | awk '/namespace/ {ns=$2} /class/ {print ns"\\"$2}' | sed 's/;//g' | sort | uniq > php_classes.txt
	@grep -r -E --include=\*.php "\\b($(awk '{printf "%s|", $0}' php_classes.txt | sed 's/|$//'))\\b" app \
		| awk -F: '{print $1}' | sort | uniq > referenced_php_files.txt
	# Filtra los archivos usados también por autoload y composiciones dinámicas
	@find app -type f -name "*.php" -exec grep -l "use " {} + | sort | uniq >> referenced_php_files.txt
	@sort all_php_files.txt > sorted_all_php_files.txt
	@sort referenced_php_files.txt | uniq > sorted_referenced_php_files.txt
	@comm -23 sorted_all_php_files.txt sorted_referenced_php_files.txt > $(UNUSED_PHP_FILES)
	@echo "Análisis completo. Archivos no utilizados guardados en $(UNUSED_PHP_FILES)."
	@rm -f all_php_files.txt referenced_php_files.txt php_classes.txt sorted_all_php_files.txt sorted_referenced_php_files.txt
push-database-server:
	@scp storage/app/sube.sql root@$(SERVER_IP):/home/sube-drive/storage/app/sube.sql
push-signs-images-server:
	@scp -r public/images/usuarios/firma_digital/ root@$(SERVER_IP):/home/sube-drive/public/images/usuarios/
	
staging/import-db:
	@docker exec -i mysql-staging mysql -u ${MYSQL_USER} -p${DB_PASSWORD} -e "DROP DATABASE IF EXISTS sube; CREATE DATABASE sube;"
	@docker exec -i mysql-staging mysql -u ${MYSQL_USER} -p${DB_PASSWORD} sube < storage/app/sube.sql