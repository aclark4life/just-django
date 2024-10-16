default: git-commit-push

alias c := django-clean
alias ce := git-commit-edit-push
alias clean := django-clean
alias d := django-init
alias django := django-init
alias freeze := pip-freeze
alias last := git-commit-last
alias migrate := django-migrate
alias s := django-serve
alias startapp := django-startapp
alias sqlmigrate := django-sqlmigrate

project_template := "https://github.com/aclark4life/just-django-project/archive/refs/heads/main.zip"
app_template := "https://github.com/aclark4life/django-mongodb-app/archive/refs/heads/main.zip"

# django

[group('django')]
django-init: django-install django-project polls-app

[group('django')]
django-clean:
    rm -rvf .babelrc .eslintrc .stylelintrc.json .venv/src backend frontend manage.py mongo_migrations \
    node_modules \
    package.json \
    package-lock.json \
    polls \
    postcss.config.js \
    requirements.txt

[group('django')]
django-install:
    pip install \
    -e git+https://github.com/aclark4life/django-mongodb#egg=django-mongodb \
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

[group('django')]
django-migrate:
	python manage.py migrate

[group('django')]
django-startapp app_label: 
	python manage.py startapp {{app_label}} --template "{{app_template}}"

[group('django')]
django-sqlmigrate app_label migration_name:
	python manage.py sqlmigrate {{app_label}} {{migration_name}}

[group('django')]
django-project:
	django-admin startproject backend . --template "{{project_template}}"

[group('django')]
django-serve:
	python manage.py runserver

[group('django')]
polls-app:
	just startapp polls

# git

[group('git')]
git-commit-last:
	git log -1 --pretty=%B | git -a -F -

[group('git')]
git-commit-push:
    git commit -a -m "Add/update just-django files."; git push

[group('git')]
git-commit-edit-push:
    git commit -a; git push

# pip

[group('pip')]
pip-freeze:
	pip freeze > requirements.txt
