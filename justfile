# list all available recipes
default: just-list

startapp_template := "https://github.com/aclark4life/django-mongodb-app/archive/refs/heads/main.zip"
startproject_template := "https://github.com/aclark4life/just-django-project/archive/refs/heads/main.zip"

# ---------------------------------------- asv ----------------------------------------

# asv-clean
[group('asv')]
asv-clean:
    pushd .venv/src/django-asv && rm -rvf ./results && popd

# asv-preview
[group('asv')]
asv-preview:
    pushd .venv/src/django-asv && asv preview && popd

# asv-publish
[group('asv')]
asv-publish:
    pushd .venv/src/django-asv && asv publish && popd

# asv-run
[group('asv')]
asv-run:
    pushd .venv/src/django-asv && asv run && popd

# ---------------------------------------- django ----------------------------------------

# django-dbshell
[group('django')]
django-dbshell:
    python manage.py dbshell

alias dbshell := django-dbshell

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
    export PIP_SRC=./src ; pip install \
    -e git+https://github.com/aclark4life/django-asv#egg=django-asv \
    -e git+https://github.com/aclark4life/django-mongodb@PYTHON-4856#egg=django-mongodb \
    -e git+https://github.com/aclark4life/mongo-python-driver#egg=pymongo \
    -e git+https://github.com/mongodb-forks/django@mongodb-5.0.x#egg=django \
    asv \
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
PYTHON-4856:
    python manage.py shell -c "from polls.models import Question; q = Question(); q.save(); Question.objects.raw_mql('db.polls_question.find()')"

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
