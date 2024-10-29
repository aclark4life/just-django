from django.apps import AppConfig


class PollsConfig(AppConfig):
    default_auto_field = "django_mongodb.fields.ObjectIdAutoField"
    name = "polls"
