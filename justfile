alias clean := django-clean

default:
    @echo 'Just Django!'
    @git commit -a -m "Add/update just-django files."; git push
	
django: django-install django-project

template := "https://github.com/aclark4life/just-django-project/archive/refs/heads/main.zip"

[group('django')]
django-clean:
	rm -rvf .babelrc .eslintrc .stylelintrc.json backend frontend manage.py mongo_migrations package.json \
		postcss.config.js

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
    djangorestframework \
    python-webpack-boilerplate

[group('django')]
django-migrate:
	python manage.py migrate

[group('django')]
django-project:
	django-admin startproject backend . --template "{{template}}"
