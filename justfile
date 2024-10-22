# list all available recipes
default: list

alias c := django-clean
alias d := django-init
alias e := edit
alias l := list
alias m := django-migrate
alias o := open
alias s := django-serve
alias su := django-su
alias ce := git-commit-edit-push
alias cp := git-commit-push
alias clean := django-clean
alias dump := django-dumpdata
alias dbshell := django-dbshell
alias django := django-init
alias freeze := pip-freeze
alias last := git-commit-last
alias migrate := django-migrate
alias migrations := django-migrations
alias shell := django-shell
alias sqlmigrate := django-sqlmigrate
alias startapp := django-startapp

startapp_template := "https://github.com/aclark4life/django-mongodb-app/archive/refs/heads/main.zip"
startproject_template := "https://github.com/aclark4life/just-django-project/archive/refs/heads/main.zip"

# django-dbshell
[group('django')]
django-dbshell:
    python manage.py dbshell

# django-clean
[group('django')]
django-clean:
    rm -rvf \
    .babelrc \
    .eslintrc \
    .stylelintrc.json \
    .venv/src \
    backend \
    frontend \
    manage.py \
    mongo_migrations \
    node_modules \
    package.json \
    package-lock.json \
    polls \
    postcss.config.js \
    requirements.txt

# django-dumpdata
[group('django')]
django-dumpdata:
    python manage.py dumpdata | python -m json.tool

# django-init
[group('django')]
django-init: check-venv django-install django-project npm-install npm-build

# django-install
[group('django')]
django-install:
    pip install \
    -e git+https://github.com/aclark4life/django-asv#egg=django-asv \
    -e git+https://github.com/aclark4life/django-mongodb@PYTHON-4856#egg=django-mongodb \
    -e git+https://github.com/aclark4life/mongo-python-driver#egg=pymongo \
    -e git+https://github.com/mongodb-forks/django@mongodb-5.0.x#egg=django \
    crispy-bootstrap5 \
    dj-database-url \
    django-crispy-forms \
    django-debug-toolbar \
    django-extensions \
    django-hijack \
    django-recaptcha \
    djangorestframework

# django-su
[group('django')]
django-su:
    DJANGO_SUPERUSER_PASSWORD=admin python manage.py createsuperuser --noinput --username=admin --email=`git config user.mail`

# django-migrations
[group('django')]
django-migrations:
    python manage.py makemigrations

# django-migrate
[group('django')]
django-migrate:
    python manage.py migrate

# django-serve
[group('django')]
django-serve:
    npm run watch &
    python manage.py runserver

# django-shell
[group('django')]
django-shell:
    python manage.py shell

# django-startapp
[group('django')]
django-startapp app_label:
    python manage.py startapp {{ app_label }} --template "{{ startapp_template }}"

# django-sqlmigrate
[group('django')]
django-sqlmigrate app_label migration_name:
    python manage.py sqlmigrate {{ app_label }} {{ migration_name }}

# django-project
[group('django')]
django-project:
    django-admin startproject backend . --template "{{ startproject_template }}"

[group('git')]
git-commit-last:
    git log -1 --pretty=%B | git commit -a -F -
    git push

[group('git')]
git-commit-push:
    git commit -a -m "Add/update just-django recipes."
    git push

[group('git')]
git-commit-edit-push:
    git commit -a
    git push

# list all available recipes
[group('just')]
list:
    @just -l

# edit the justfile
[group('just')]
edit:
    @just -e

# open django
[group('misc')]
open:
    open http://0.0.0.0:8000

[group('npm')]
npm-build:
    npm run build

[group('npm')]
npm-install:
    npm install

[group('pip')]
pip-freeze:
    pip freeze > requirements.txt

[group('python')]
check-venv:
    @if [ -z "${VIRTUAL_ENV:-}" ]; then \
    	echo "Please activate virtual environment"; \
    	exit 1; \
    fi
