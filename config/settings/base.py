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
    'django.contrib.humanize',
    'django.forms',             # 表单
]
THIRD_PARTY_APPS = [
    'crispy_forms',             # crispy_forms_tags 标签
    'sorl.thumbnail',           # thumbnail 处理图片
    'allauth',                  # allauth 用户权限
    'allauth.account',          # allauth.account 生成的数据表（2张）：account_emailaddress、account_emailconfirmation
    'allauth.socialaccount',    # allauth.socialaccount 生成的数据表（4张）：socialaccount_socialaccount、socialaccount_socialapp、socialaccount_socialapp_sites、socialaccount_socialtoken
    'allauth.socialaccount.providers.github'  # 实现 Github 第三方登录
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
    'django.contrib.auth.backends.ModelBackend',  # django默认的认证
    'allauth.account.auth_backends.AuthenticationBackend',  # django-allauth的认证
]
AUTH_USER_MODEL = 'users.User'
LOGIN_REDIRECT_URL = 'account_logout'  # 登录跳转配置
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
STATIC_URL = '/static/'  # 指定静态目录的URL
STATICFILES_DIRS = [
    str(APPS_DIR.path('static')),  # 引用位于STATIC_ROOT中的静态文件时使用的网址
]
STATICFILES_FINDERS = [
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
]

# MEDIA：媒体
MEDIA_ROOT = str(APPS_DIR('media'))  # 在Windows开发环境下加上.replace("\\", "/")
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
ACCOUNT_EMAIL_VERIFICATION = 'none'  # 可选，【mandatory】邮箱验证、【none】不开启邮箱验证、【optional】可选验证
ACCOUNT_ADAPTER = 'answer.users.adapters.AccountAdapter'
SOCIALACCOUNT_ADAPTER = 'answer.users.adapters.SocialAccountAdapter'

# django-compressor：压缩
INSTALLED_APPS += ['compressor']
STATICFILES_FINDERS += ['compressor.finders.CompressorFinder']

