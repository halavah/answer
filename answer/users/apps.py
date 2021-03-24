from django.apps import AppConfig


class UsersAppConfig(AppConfig):
    name = "answer.users"
    verbose_name = "用户"

    def ready(self):
        try:
            import users.signals  # noqa F401
        except ImportError:
            pass
