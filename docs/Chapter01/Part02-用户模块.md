## 2. 用户模块
```text

```

### 1.1 用户模块：数据库设计
- `answer/users/models.py` ：自定义用户模型
```python
from django.utils.encoding import python_2_unicode_compatible
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.urls import reverse

"""自定义用户模型"""
@python_2_unicode_compatible
class User(AbstractUser):
    # 属性
    nickname = models.CharField(null=True, blank=True, max_length=255, verbose_name='昵称')
    job_title = models.CharField(max_length=50, null=True, blank=True, verbose_name='职称')
    introduction = models.TextField(blank=True, null=True, verbose_name='简介')
    picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True, verbose_name='头像')
    location = models.CharField(max_length=50, null=True, blank=True, verbose_name='城市')
    personal_url = models.URLField(max_length=255, null=True, blank=True, verbose_name='个人链接')
    weibo = models.URLField(max_length=255, null=True, blank=True, verbose_name='微博链接')
    zhihu = models.URLField(max_length=255, null=True, blank=True, verbose_name='知乎链接')
    github = models.URLField(max_length=255, null=True, blank=True, verbose_name='GitHub链接')
    linkedin = models.URLField(max_length=255, null=True, blank=True, verbose_name='LinkedIn链接')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    # 元信息
    class Meta:
        verbose_name = '用户'
        verbose_name_plural = verbose_name

    # __str__：相当于toString
    def __str__(self):
        return self.username

    # 返回：用户详情页中url的路径
    def get_absolute_url(self):
        return reverse("users:detail", kwargs={"username": self.username})

    def get_profile_name(self):
        return self.nickname if self.nickname else self.username
```

### 1.2 用户模块：使用 django-allauth 用户登录、用户注册、用户注销、找回密码
- `cookiecutter-django-2.0.13` ：默认集成了 django-allauth，具体配置内容，参考网址：https://django-allauth.readthedocs.io/en/latest/installation.html
- `install package`：操作步骤，来自 django-allauth 官方文档
```text
pip install django-allauth
```  
- `base.py` ：操作步骤，来自 django-allauth 官方文档
```python
# 模板
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',   # django-allauth 上下文处理器
            ],
        },
    },
]

# 认证_后台
AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',            # django默认的认证
    'allauth.account.auth_backends.AuthenticationBackend',  # django-allauth的认证
]

# APPS：应用
DJANGO_APPS = [
    
]
THIRD_PARTY_APPS = [
    'allauth.account',         # allauth.account 生成的数据表（2张）：account_emailaddress、account_emailconfirmation
    'allauth.socialaccount',   # allauth.socialaccount 生成的数据表（4张）：socialaccount_socialaccount、socialaccount_socialapp、socialaccount_socialapp_sites、socialaccount_socialtoken   
]
LOCAL_APPS = [

]
INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

# 站点_ID
SITE_ID = 1
```
- `urls.py` ：操作步骤，来自 django-allauth 官方文档
```python
urlpatterns = [
    ...
    path('accounts/', include('allauth.urls')),
    ...
]
```
- `database migrate` ：操作步骤，来自 django-allauth 官方文档
```text
python manage.py migrate
```

### 1.3 用户模块：使用 django-allauth 实现 Github 第三方登录
- `cookiecutter-django-2.0.13` ：默认集成了 django-allauth，具体配置内容，参考网址：https://django-allauth.readthedocs.io/en/latest/installation.html
- `base.py` ：操作步骤，来自 django-allauth 官方文档
```python
THIRD_PARTY_APPS = [
    'allauth.socialaccount.providers.github',   # 实现 Github 第三方登录
]
```
- `OAuth Apps`：https://github.com/settings/developers
```text
Application name：answer
Homepage URL：http://192.168.2.128:8000/
Application description：django-allauth 实现 Github 第三方登录
Authorization callback URL：http://192.168.2.128:8000/

Client ID：89186fcbd8c3af3edaca
Client secrets：6c6960b7e9d292ddce4c11c9b63a58bde7d28658 
```

- `socialaccount_socialapp` ：数据库，手动添加数据
```text
id  provider  name      client_id               secret                                      key
1   Github    Github	89186fcbd8c3af3edaca	6c6960b7e9d292ddce4c11c9b63a58bde7d28658 	1
```
- `socialaccount_socialapp_sites` ：数据库，手动添加数据
```text
id  socialapp_id  site_id
1	1	          1
```



