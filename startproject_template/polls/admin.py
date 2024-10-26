from django.contrib import admin
from .models import Choice, Question


@admin.register(Choice)
class ChoiceAdmin(admin.ModelAdmin):
    """Choice Admin"""


@admin.register(Question)
class QuestionAdmin(admin.ModelAdmin):
    """Question Admin"""
