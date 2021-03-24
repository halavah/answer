## 1. 项目初始化模板
```text
│  .coveragerc
│  .editorconfig
│  .gitattributes
│  .gitignore
│  .pylintrc
│  manage.py
│  Pipfile
│  pytest.ini
│  README.rst
│  setup.cfg
│  tree.txt
│  
├─answer
│  │  conftest.py
│  │  __init__.py
│  │  
│  ├─contrib
│  │  │  __init__.py
│  │  │  
│  │  └─sites
│  │      │  __init__.py
│  │      │  
│  │      └─migrations
│  │              0001_initial.py
│  │              0002_alter_domain_unique.py
│  │              0003_set_site_domain_and_name.py
│  │              __init__.py
│  │              
│  ├─static
│  │  ├─css
│  │  │      project.css
│  │  │      
│  │  ├─fonts
│  │  │      .gitkeep
│  │  │      
│  │  ├─images
│  │  │  └─favicons
│  │  │          favicon.ico
│  │  │          
│  │  ├─js
│  │  │      project.js
│  │  │      
│  │  └─sass
│  │          custom_bootstrap_vars.scss
│  │          project.scss
│  │          
│  ├─taskapp
│  │      celery.py
│  │      __init__.py
│  │      
│  ├─templates
│  │  │  403_csrf.html
│  │  │  404.html
│  │  │  500.html
│  │  │  base.html
│  │  │  
│  │  ├─account
│  │  │      account_inactive.html
│  │  │      base.html
│  │  │      email.html
│  │  │      email_confirm.html
│  │  │      login.html
│  │  │      logout.html
│  │  │      password_change.html
│  │  │      password_reset.html
│  │  │      password_reset_done.html
│  │  │      password_reset_from_key.html
│  │  │      password_reset_from_key_done.html
│  │  │      password_set.html
│  │  │      signup.html
│  │  │      signup_closed.html
│  │  │      verification_sent.html
│  │  │      verified_email_required.html
│  │  │      
│  │  ├─pages
│  │  │      about.html
│  │  │      home.html
│  │  │      
│  │  └─users
│  │          user_detail.html
│  │          user_form.html
│  │          user_list.html
│  │          
│  └─users
│      │  adapters.py
│      │  admin.py
│      │  apps.py
│      │  forms.py
│      │  models.py
│      │  urls.py
│      │  views.py
│      │  __init__.py
│      │  
│      ├─migrations
│      │      0001_initial.py
│      │      __init__.py
│      │      
│      └─tests
│              factories.py
│              test_forms.py
│              test_models.py
│              test_urls.py
│              test_views.py
│              __init__.py
│              
├─config
│  │  urls.py
│  │  wsgi.py
│  │  __init__.py
│  │  
│  └─settings
│          base.py
│          local.py
│          production.py
│          test.py
│          __init__.py
│          
├─locale
│      README.rst
│      
├─requirements
│      base.txt
│      local.txt
│      production.txt
│      
└─utility
```

### 1.1 删除一些项目不需要的文件
- `docs/...` ：删除项
- `utility/...` ：删除项
- `locale/...` ：删除项

### 1.2 更改 base.txt 文件
- `base.txt` ：项目依赖，【修改 Django 版本号为 2.1.7、新增 mysqlclient==1.4.2.post1】
```text
pytz==2018.9  # https://github.com/stub42/pytz
python-slugify==2.0.1  # https://github.com/un33k/python-slugify
Pillow==5.4.1  # https://github.com/python-pillow/Pillow
rcssmin==1.0.6  # https://github.com/ndparker/rcssmin
argon2-cffi==19.1.0  # https://github.com/hynek/argon2_cffi
redis>=2.10.6, < 3  # pyup: < 3 # https://github.com/antirez/redis
celery==4.2.1  # pyup: < 5.0  # https://github.com/celery/celery
mysqlclient==1.4.2.post1

# Django
# ------------------------------------------------------------------------------
django==2.1.7  # pyup: < 2.1  # https://www.djangoproject.com/
django-environ==0.4.5  # https://github.com/joke2k/django-environ
django-model-utils==3.1.2  # https://github.com/jazzband/django-model-utils
django-allauth==0.38.0  # https://github.com/pennersr/django-allauth
django-crispy-forms==1.7.2  # https://github.com/django-crispy-forms/django-crispy-forms
django-compressor==2.2  # https://github.com/django-compressor/django-compressor
django-redis==4.10.0  # https://github.com/niwinz/django-redis

# Django REST Framework
djangorestframework==3.9.1  # https://github.com/encode/django-rest-framework
coreapi==2.3.3  # https://github.com/core-api/python-client
```

### 1.3 修改 base.py、local.py、production.py 配置文件
- `config/settings/base.py` ：基本环境，【修改如下】
```python
"""
Base settings to build other settings files upon.
"""

import environ

ROOT_DIR = environ.Path(__file__) - 3  # (answer/config/settings/base.py - 3 = answer/)
APPS_DIR = ROOT_DIR.path('answer')

env = environ.Env()

# 配置文件：使用.env自定义配置文件，【将 default=False 变为 default=True】
READ_DOT_ENV_FILE = env.bool('DJANGO_READ_DOT_ENV_FILE', default=True)
if READ_DOT_ENV_FILE:
    # OS environment variables take precedence over variables from .env
    env.read_env(str(ROOT_DIR.path('.env')))

# GENERAL：常规设置
DEBUG = env.bool('DJANGO_DEBUG', False)
TIME_ZONE = 'Asia/Shanghai'
LANGUAGE_CODE = 'zh-Hans'
SITE_ID = 1
USE_I18N = True
USE_L10N = True
USE_TZ = True

# DATABASES：数据库
DATABASES = {
    'default': env.db('DATABASE_URL', default='mysql:///answer'),  # 修改为mysql
}
DATABASES['default']['ATOMIC_REQUESTS'] = True  # 将 HTTP请求中，对数据库的操作封装成事务

# URLS ：网址
ROOT_URLCONF = 'config.urls'
WSGI_APPLICATION = 'config.wsgi.application'

# APPS：应用
DJANGO_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',  # Handy template tags
    # 'django.contrib.admin',
]
THIRD_PARTY_APPS = [
    'crispy_forms',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
]
LOCAL_APPS = [
    'answer.users.apps.UsersAppConfig',
]
INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

# MIGRATIONS：迁移
MIGRATION_MODULES = {
    'sites': 'answer.contrib.sites.migrations'
}

# AUTHENTICATION：验证
AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',            # django默认的认证
    'allauth.account.auth_backends.AuthenticationBackend',  # django-allauth的认证
]
AUTH_USER_MODEL = 'users.User'
LOGIN_REDIRECT_URL = 'users:redirect'                       # 登录跳转配置
LOGIN_URL = 'account_login'

# PASSWORDS：密码加密
PASSWORD_HASHERS = [
    'django.contrib.auth.hashers.Argon2PasswordHasher',
    'django.contrib.auth.hashers.PBKDF2PasswordHasher',
    'django.contrib.auth.hashers.PBKDF2SHA1PasswordHasher',
    'django.contrib.auth.hashers.BCryptSHA256PasswordHasher',
    'django.contrib.auth.hashers.BCryptPasswordHasher',
]
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# MIDDLEWARE：中间件
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# STATIC：静态文件
STATIC_ROOT = str(ROOT_DIR('staticfiles'))
STATIC_URL = '/static/'                         # 指定静态目录的URL
STATICFILES_DIRS = [
    str(APPS_DIR.path('static')),               # 引用位于STATIC_ROOT中的静态文件时使用的网址
]
STATICFILES_FINDERS = [
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
]

# MEDIA：媒体
MEDIA_ROOT = str(APPS_DIR('media'))             # 在Windows开发环境下加上.replace("\\", "/")
MEDIA_URL = '/media/'

# TEMPLATES：模板引擎
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            str(APPS_DIR.path('templates')),
        ],
        'OPTIONS': {
            'debug': DEBUG,
            'loaders': [
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ],
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.template.context_processors.media',
                'django.template.context_processors.static',
                'django.template.context_processors.tz',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
CRISPY_TEMPLATE_PACK = 'bootstrap4'

# FIXTURES：固定装置
FIXTURE_DIRS = (
    str(APPS_DIR.path('fixtures')),
)

# SECURITY：安全
SESSION_COOKIE_HTTPONLY = True
CSRF_COOKIE_HTTPONLY = False  # 默认为False, 如果设置为True, JS将不能获取到CSRF cookie
SECURE_BROWSER_XSS_FILTER = True
X_FRAME_OPTIONS = 'DENY'

# EMAIL：邮件
EMAIL_BACKEND = env('DJANGO_EMAIL_BACKEND', default='django.core.mail.backends.smtp.EmailBackend')
EMAIL_HOST = env('DJANGO_EMAIL_HOST')
EMAIL_USE_SSL = env('DJANGO_EMAIL_USE_SSL', default=True)
EMAIL_PORT = env('DJANGO_EMAIL_PORT', default=465)
EMAIL_HOST_USER = env('DJANGO_EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = env('DJANGO_EMAIL_HOST_PASSWORD')
DEFAULT_FROM_EMAIL = env('DJANGO_DEFAULT_FROM_EMAIL')

# # ADMIN：后台管理
# ADMIN_URL = 'admin/'
# ADMINS = [
#     ("""halavah""", 'halavah@126.com'),
# ]
# MANAGERS = ADMINS

# Celery：异步任务队列
INSTALLED_APPS += ['answer.taskapp.celery.CeleryAppConfig']
if USE_TZ:
    CELERY_TIMEZONE = TIME_ZONE
CELERY_BROKER_URL = env('CELERY_BROKER_URL')
CELERY_RESULT_BACKEND = env('CELERY_RESULT_BACKEND')
CELERY_ACCEPT_CONTENT = ['json', 'msgpack']  # 指定接受的内容类型
CELERY_TASK_SERIALIZER = 'msgpack'  # 任务序列化和反序列化使用msgpack，msgpack是一个二进制的json序列化方案，比json数据结构更小，更快
CELERY_RESULT_SERIALIZER = 'json'  # 读取任务结果一般性能要求不高，所以使用了可读性更好的json
CELERYD_TASK_TIME_LIMIT = 5 * 60  # 单个任务的最大运行时间5分钟
CELERYD_TASK_SOFT_TIME_LIMIT = 60  # 任务的软时间限制，超时候SoftTimeLimitExceeded异常将会被抛出

# django-allauth：第三方认证
ACCOUNT_ALLOW_REGISTRATION = env.bool('DJANGO_ACCOUNT_ALLOW_REGISTRATION', True)
ACCOUNT_AUTHENTICATION_METHOD = 'username'
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_EMAIL_VERIFICATION = 'mandatory'
ACCOUNT_ADAPTER = 'answer.users.adapters.AccountAdapter'
SOCIALACCOUNT_ADAPTER = 'answer.users.adapters.SocialAccountAdapter'

# django-compressor：压缩
INSTALLED_APPS += ['compressor']
STATICFILES_FINDERS += ['compressor.finders.CompressorFinder']
```
- `config/settings/local.py` ：开发环境，【修改如下】
```python
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
```
- `config/settings/production.py` ：生产环境，【修改如下】
```text
from .base import *  # noqa
from .base import env

# GENERAL：常规配置
SECRET_KEY = env('DJANGO_SECRET_KEY')
ALLOWED_HOSTS = env.list('DJANGO_ALLOWED_HOSTS', default=['halavah.buzz'])

# DATABASES：数据库
DATABASES['default'] = env.db('DATABASE_URL')  # noqa F405
DATABASES['default']['ATOMIC_REQUESTS'] = True  # noqa F405
DATABASES['default']['CONN_MAX_AGE'] = env.int('CONN_MAX_AGE', default=60)  # noqa F405

# CACHES：缓存
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': env('REDIS_URL'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
            'IGNORE_EXCEPTIONS': True,
        }
    }
}

# SECURITY：安全
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_SSL_REDIRECT = env.bool('DJANGO_SECURE_SSL_REDIRECT', default=True)
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 60
SECURE_HSTS_INCLUDE_SUBDOMAINS = env.bool('DJANGO_SECURE_HSTS_INCLUDE_SUBDOMAINS', default=True)
SECURE_HSTS_PRELOAD = env.bool('DJANGO_SECURE_HSTS_PRELOAD', default=True)
SECURE_CONTENT_TYPE_NOSNIFF = env.bool('DJANGO_SECURE_CONTENT_TYPE_NOSNIFF', default=True)

# TEMPLATES：模板引擎
TEMPLATES[0]['OPTIONS']['loaders'] = [  # noqa F405
    (
        'django.template.loaders.cached.Loader',
        [
            'django.template.loaders.filesystem.Loader',
            'django.template.loaders.app_directories.Loader',
        ]
    ),
]

# django-compressor：压缩
COMPRESS_ENABLED = env.bool('COMPRESS_ENABLED', default=True)
COMPRESS_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
COMPRESS_URL = STATIC_URL

# LOGGING：登录
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s '
                      '%(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True
        },
        'django.security.DisallowedHost': {
            'level': 'ERROR',
            'handlers': ['console', 'mail_admins'],
            'propagate': True
        }
    }
}
```
- `config/wsgi.py` ：当前环境，【将 config.settings.production 修改为 config.settings.local】
```python
"""
WSGI config for answer project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

"""
import os
import sys

from django.core.wsgi import get_wsgi_application

# This allows easy placement of apps within the interior
# answer directory.
app_path = os.path.abspath(os.path.join(
    os.path.dirname(os.path.abspath(__file__)), os.pardir))
sys.path.append(os.path.join(app_path, 'answer'))

# We defer to a DJANGO_SETTINGS_MODULE already in the environment. This breaks
# if running multiple sites in the same mod_wsgi process. To fix this, use
# mod_wsgi daemon mode with each site in its own daemon process, or use
# os.environ["DJANGO_SETTINGS_MODULE"] = "config.settings.production"

# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.production")   # 开发环境
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings.local")   # 本地环境

# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
application = get_wsgi_application()

# Apply WSGI middleware here.
# from helloworld.wsgi import HelloWorldApplication
# application = HelloWorldApplication(application)
```

### 1.4 编写 env.py 配置文件
- `env.py` ：外部配置文件，【主要包含以下六类配置】
```text
# MySQL 连接配置
DATABASE_URL=mysql://answer:kBeZGFXBEz244mAp@127.0.0.1:3306/answer

# Redis连接配置
REDIS_URL=redis://127.0.0.1:6379

# Django基本配置
# 开启调试功能
DJANGO_DEBUG=True
# 是否允许用户注册
DJANGO_ACCOUNT_ALLOW_REGISTRATION=True
DJANGO_SECRET_KEY=Tb8iqRxXPbube2qD9nJBxMtkCYAEK0jqzLtXEczynjjHuV2h7duQk5Qox4lYoPDC

# Django生产环境配置
DJANGO_SECURE_SSL_REDIRECT=False
DJANGO_ALLOWED_HOSTS=*
DJANGO_SECURE_HSTS_INCLUDE_SUBDOMAINS=False
DJANGO_SECURE_HSTS_PRELOAD=False
DJANGO_SECURE_CONTENT_TYPE_NOSNIFF=True

# 邮箱配置
DJANGO_EMAIL_BACKEND=djcelery_email.backends.CeleryEmailBackend
DJANGO_EMAIL_HOST=smtpdm.aliyun.com
DJANGO_EMAIL_USE_SSL=True
DJANGO_EMAIL_PORT=465
DJANGO_EMAIL_HOST_USER=imooc@socialmail.liaogx.com
DJANGO_EMAIL_HOST_PASSWORD=im0OCs0cia1
DJANGO_DEFAULT_FROM_EMAIL=imooc@socialmail.liaogx.com

# Celery配置
# 消息代理：使用Redis 1
CELERY_BROKER_URL=redis://localhost:6379/1
# 任务结果：使用Redis 2
CELERY_RESULT_BACKEND=redis://localhost:6379/2
```
- `.gitignore` ：配置文件，【忽略 .env 文件】
```text
.env
```

### 1.5 项目第一次运行
- `/root/answer` ：Pipenv，【项目依赖，命令如下】
```text
cd /root/answer
pipenv install -r requirements/local.txt
```
- `/root/answer` ：Pipenv，【生成数据库，命令如下】
```text
cd /root/answer
pipenv run python manage.py migrate
```
- `/root/answer` ：Pipenv，【运行项目，命令如下】
```text
cd /root/answer
pipenv run python manage.py runserver 0.0.0.0:8000
```
