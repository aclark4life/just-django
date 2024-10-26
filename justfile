# list all available recipes
default: just-list

# ---------------------------------------- django ----------------------------------------

startapp_template := "./startapp_template"
startproject_template := "./startproject_template"

# django-dbshell
[group('django')]
django-dbshell:
    python manage.py dbshell

alias dbshell := django-dbshell

# django-clean
[group('django')]
django-clean:
    #!/bin/bash
    if [ ! -f .gitignore ]; then
      echo ".gitignore file not found!"
      exit 1
    fi
    while IFS= read -r entry; do
      if [[ -z "$entry" || "$entry" == \#* ]]; then
        continue
      fi
      echo "Removing $entry"
      rm -rvf "$entry"
    done < .gitignore

alias clean := django-clean
alias c := django-clean

# django-dumpdata
[group('django')]
django-dumpdata:
    python manage.py dumpdata | python -m json.tool

alias dump := django-dumpdata

# django-init
[group('django')]
django-init: check-venv django-install django-project

alias django := django-init
alias d := django-init

# django-install
[group('django')]
django-install:
    export PIP_SRC=src && pip install -r requirements.txt

# django-test
[group('django')]
django-test:
    CFLAGS="-I/opt/homebrew/Cellar/libmemcached/1.0.18_2/include" \
    LDFLAGS="-L/opt/homebrew/Cellar/libmemcached/1.0.18_2/lib" pip install pylibmc
    pip install -r django/tests/requirements/py3.txt

alias test := django-test
alias t := django-test

# django-su
[group('django')]
django-su:
    DJANGO_SUPERUSER_PASSWORD=admin python manage.py createsuperuser --noinput \
        --username=admin --email=`git config user.mail`

alias su := django-su

# django-migrations
[group('django')]
django-migrations:
    python manage.py makemigrations

alias migrations := django-migrations

# django-migrate
[group('django')]
django-migrate:
    python manage.py migrate

alias migrate := django-migrate
alias m := django-migrate

# open django
[group('django')]
django-open:
    open http://0.0.0.0:8000

alias o := django-open

# django-serve
[group('django')]
django-serve:
    npm run watch &
    python manage.py runserver

alias s := django-serve

# django-shell
[group('django')]
django-shell:
    python manage.py shell

alias shell := django-shell

# django-startapp
[group('django')]
django-startapp app_label:
    python manage.py startapp {{ app_label }} --template "{{ startapp_template }}"

alias startapp := django-startapp

# django-sqlmigrate
[group('django')]
django-sqlmigrate app_label migration_name:
    python manage.py sqlmigrate {{ app_label }} {{ migration_name }}

alias sqlmigrate := django-sqlmigrate

# django-project
[group('django')]
django-project:
    django-admin startproject backend . --template "{{ startproject_template }}"

# ---------------------------------------- git ----------------------------------------

[group('git')]
git-commit-last:
    git log -1 --pretty=%B | git commit -a -F -
    git push

alias last := git-commit-last

[group('git')]
git-commit-push:
    git commit -a -m "Add/update just-django recipes."
    git push

alias cp := git-commit-push

[group('git')]
git-commit-edit-push:
    git commit -a
    git push

alias ce := git-commit-edit-push

# ---------------------------------------- jira ----------------------------------------

[group('jira')]
INTPYTHON-348:
    python manage.py shell -c "from polls.models import Question; q = Question(); q.save(); \
        qs = Question.objects.raw_mql('{}'); [i for i in qs]"

# ---------------------------------------- just ----------------------------------------

# list all available recipes
[group('just')]
just-list:
    @just -l | less

alias l := just-list

# edit the justfile
[group('just')]
just-edit:
    @just -e

alias e := just-edit

# ---------------------------------------- mongodb-------------------------------------

[group('mongodb')]
mongo-launch:
    mongo-launch single

alias ml := mongo-launch

# ---------------------------------------- npm ----------------------------------------

[group('npm')]
npm-build:
    npm run build

[group('npm')]
npm-init: npm-install npm-build

alias n := npm-init

[group('npm')]
npm-install:
    npm install

# ---------------------------------------- python ----------------------------------------

[group('python')]
pip-freeze:
    pip freeze > requirements.txt

alias freeze := pip-freeze

[group('python')]
check-venv:
    @if [ -z "${VIRTUAL_ENV:-}" ]; then \
    	echo "Please activate virtual environment"; \
    	exit 1; \
    fi
