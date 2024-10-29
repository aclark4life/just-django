import factory
from .models import Question, Choice


class QuestionFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Question

    question_text = factory.Faker("sentence")


class ChoiceFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Choice

    question = factory.SubFactory(QuestionFactory)
    choice_text = factory.Faker("word")
    votes = factory.Faker("random_int", min=0, max=100)


def create_questions_with_choices(num_questions=5, num_choices_per_question=3):
    questions = []
    for _ in range(num_questions):
        question = QuestionFactory()
        ChoiceFactory.create_batch(size=num_choices_per_question, question=question)
        questions.append(question)
    return questions
