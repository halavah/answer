from .base import *  # noqa
from .base import env

# GENERAL
DEBUG = True
SECRET_KEY = env('DJANGO_SECRET_KEY', default='bLFtv82CohGnmVl52eKuFGkh1H4W9dex0WMG1hSn9QO0YgM6bgLECtuEzMVCpNi9')
ALLOWED_HOSTS = ['*']   # 允许全部地址访问

# CACHES
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': ''
    }
}

# TEMPLATES
TEMPLATES[0]['OPTIONS']['debug'] = DEBUG  # noqa F405

# # EMAIL
# EMAIL_BACKEND = env('DJANGO_EMAIL_BACKEND', default='django.core.mail.backends.console.EmailBackend')
# EMAIL_HOST = 'localhost'
# EMAIL_PORT = 1025

# django-debug-toolbar
INSTALLED_APPS += ['debug_toolbar']  # noqa F405
MIDDLEWARE += ['debug_toolbar.middleware.DebugToolbarMiddleware']  # noqa F405
DEBUG_TOOLBAR_CONFIG = {
    'DISABLE_PANELS': [
        'debug_toolbar.panels.redirects.RedirectsPanel',
    ],
    'SHOW_TEMPLATE_CONTEXT': True,
}
INTERNAL_IPS = ['127.0.0.1', '10.0.2.2']


# django-extensions
INSTALLED_APPS += ['django_extensions']  # noqa F405

# Celery
CELERY_TASK_ALWAYS_EAGER = True
CELERY_TASK_EAGER_PROPAGATES = True
