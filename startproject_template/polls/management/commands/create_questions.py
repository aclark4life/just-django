from django.core.management.base import BaseCommand
from polls.factories import create_questions_with_choices


class Command(BaseCommand):
    help = "Generate X number of Questions with Choices"

    def add_arguments(self, parser):
        # Add X as a positional argument
        parser.add_argument("X", type=int, help="Number of questions to create")

        # Optional argument for the number of choices per question
        parser.add_argument(
            "--choices", type=int, default=3, help="Number of choices per question"
        )

    def handle(self, *args, **options):
        num_questions = options["X"]
        num_choices = options["choices"]

        questions = create_questions_with_choices(
            num_questions=num_questions, num_choices_per_question=num_choices
        )

        self.stdout.write(
            self.style.SUCCESS(
                f"Successfully created {len(questions)} questions with {num_choices} choices each."
            )
        )
