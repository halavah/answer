## 3. 用户模块-后端接口-自定义 admin 实现登录注册、个人中心
```text
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
├─config
│  │  urls.py
│  │  
│  └─settings
│          base.py
```

### 3.1 删除 Django 自带的 admin 后台管理
- `config/settings/base.py` ：基本环境，【删除有关于 admin 后台管理的内容】
```python
# APPS：应用
DJANGO_APPS = [
    # 'django.contrib.admin',
]

# # ADMIN：后台管理
# ADMIN_URL = 'admin/'
# ADMINS = [
#     ("""halavah""", 'halavah@126.com'),
# ]
# MANAGERS = ADMINS
```    
- `answer/users/admin.py` ：删除该文件，【删除有关于 admin 后台管理的内容】
```python
from django.contrib import admin
from django.contrib.auth import admin as auth_admin
from django.contrib.auth import get_user_model

from answer.users.forms import UserChangeForm, UserCreationForm

User = get_user_model()


@admin.register(User)
class UserAdmin(auth_admin.UserAdmin):

    form = UserChangeForm
    add_form = UserCreationForm
    fieldsets = (("User", {"fields": ("name",)}),) + auth_admin.UserAdmin.fieldsets
    list_display = ["username", "name", "is_superuser"]
    search_fields = ["name"]
```  
- `config/urls.py` ：修改该文件，【删除有关于 admin 后台管理的内容】
```python
from django.contrib import admin

# Django Admin, use {% url 'admin:index' %}
path(settings.ADMIN_URL, admin.site.urls),
```

### 3.2 自定义 admin 实现登录注册：adapters.py
- `answer/users/adapters.py` ：适配器，【将自定义的 user 模型，与默认的 Django allauth 进行转换，起到适配的效果】
```python
from typing import Any

from allauth.account.adapter import DefaultAccountAdapter
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter
from django.conf import settings
from django.http import HttpRequest


'''
适配器：将自定义的 user 模型，与默认的 Django allauth 进行转换，起到适配的效果
'''
class AccountAdapter(DefaultAccountAdapter):

    def is_open_for_signup(self, request: HttpRequest):
        return getattr(settings, "ACCOUNT_ALLOW_REGISTRATION", True)


class SocialAccountAdapter(DefaultSocialAccountAdapter):

    def is_open_for_signup(self, request: HttpRequest, sociallogin: Any):
        return getattr(settings, "ACCOUNT_ALLOW_REGISTRATION", True)
```

### 3.3 自定义 admin 实现个人中心：models.py
- `answer/users/models.py`
```python
from __future__ import unicode_literals
from django.utils.encoding import python_2_unicode_compatible
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.urls import reverse


@python_2_unicode_compatible
class User(AbstractUser):
    """自定义用户模型"""
    nickname = models.CharField(null=True, blank=True, max_length=255, verbose_name='昵称')
    job_title = models.CharField(max_length=50, null=True, blank=True, verbose_name='职称')
    introduction = models.TextField(blank=True, null=True, verbose_name='简介')
    picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True, verbose_name='头像')
    location = models.CharField(max_length=50, null=True, blank=True, verbose_name='城市')
    personal_url = models.URLField(max_length=555, blank=True, null=True, verbose_name='个人链接')
    weibo = models.URLField(max_length=255, blank=True, null=True, verbose_name='微博链接')
    zhihu = models.URLField(max_length=255, blank=True, null=True, verbose_name='知乎链接')
    github = models.URLField(max_length=255, blank=True, null=True, verbose_name='Github链接')
    linkedin = models.URLField(max_length=255, blank=True, null=True, verbose_name='LinkedIn链接')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse('users:detail', kwargs={'username': self.username})

    def get_profile_name(self):
        if self.nickname:
            return self.nickname
        return self.username
```

### 3.4 自定义 admin 实现个人中心：views.py
- `answer/users/views.py`
```python
from django.urls import reverse
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import DetailView, UpdateView
from answer.users.models import User


"""用户【详情】"""
class UserDetailView(LoginRequiredMixin, DetailView):
    model = User
    template_name = 'users/user_detail.html'
    slug_field = "username"
    slug_url_kwarg = "username"


"""用户【更新】"""
class UserUpdateView(LoginRequiredMixin, UpdateView):
    # 用户只能更新自己的信息
    model = User
    fields = ['nickname', 'email', 'picture', 'introduction', 'job_title', 'location',
              'personal_url', 'weibo', 'zhihu', 'github', 'linkedin']   # 允许用户更新的字段
    template_name = 'users/user_form.html'

    # 更新成功后，跳转页面 -> 用户自己的页面
    def get_success_url(self):
        return reverse("users:detail", kwargs={"username": self.request.user.username})

    # 返回的对象
    def get_object(self, queryset=None):
        return self.request.user
```

### 3.5 自定义 admin 实现个人中心：urls.py
- `answer/users/urls.py`
```python
from django.urls import path
from answer.users import views


app_name = "users"
urlpatterns = [
    path("update", views.UserUpdateView.as_view(), name="update"),
    path("<username>/", views.UserDetailView.as_view(), name="detail"),
]
```

### 3.6 自定义 admin 实现个人中心：apps.py
- `answer/users/apps.py`
```python
from django.apps import AppConfig


class UsersAppConfig(AppConfig):
    name = "answer.users"
    verbose_name = "用户"

    def ready(self):
        try:
            import users.signals  # noqa F401
        except ImportError:
            pass
```

### 3.7 项目 urls.py
- `config/urls.py`
```python
from django.conf import settings
from django.urls import include, path
from django.conf.urls.static import static
from django.views import defaults as default_views

urlpatterns = [
    # 首页

    # 用户管理
    path('users/', include('users.urls', namespace='users')),
    path("accounts/", include("allauth.urls")),

    # 第三方应用

    # 开发的应用

] + static(
    settings.MEDIA_URL, document_root=settings.MEDIA_ROOT
)

# DEBUG=True，网页可以显示【报错信息】
if settings.DEBUG:
    urlpatterns += [
        path("400/", default_views.bad_request, kwargs={"exception": Exception("Bad Request!")},),
        path("403/", default_views.permission_denied, kwargs={"exception": Exception("Permission Denied")}, ),
        path("404/", default_views.page_not_found, kwargs={"exception": Exception("Page not Found")},),
        path("500/", default_views.server_error),
    ]

    if "debug_toolbar" in settings.INSTALLED_APPS:
        import debug_toolbar
        urlpatterns = [path("__debug__/", include(debug_toolbar.urls))] + urlpatterns
```

### 3.8 数据测试
- `answer/users/tests/test_models.py` ：test_models.py
```python
from test_plus.test import TestCase


class TestUser(TestCase):

    # 每个测试类，需要新建一个user对象
    def setUp(self):
        self.user = self.make_user()

    def test__str__(self):
        self.assertEqual(self.user.__str__(), "testuser")

    def test_get_absolute_url(self):
        self.assertEqual(self.user.get_absolute_url(), "/users/testuser/")

    def test_get_profile_name(self):
        assert self.user.get_profile_name() == "testuser"
        self.user.nickname = "昵称"
        assert self.user.get_profile_name() == "昵称"
```
- `answer/users/tests/test_urls.py` ：test_urls.py
```python
from django.urls import reverse, resolve
from test_plus.test import TestCase


class TestUserURLs(TestCase):

    # 每个测试类，需要新建一个user对象
    def setUp(self):
        self.user = self.make_user()

    # reverse 正向解析（）
    def test_detail_reverse(self):
        self.assertEqual(reverse('users:detail', kwargs={'username': 'testuser'}), '/users/testuser/')

    # resolve 反向解析
    def test_detail_resolve(self):
        self.assertEqual(resolve('/users/testuser/').view_name, 'users:detail')

    # reverse 正向解析
    def test_update_reverse(self):
        self.assertEqual(reverse('users:update'), '/users/update/')

    # resolve 反向解析
    def test_update_resolve(self):
        self.assertEqual(resolve('/users/update/').view_name, 'users:update')
```
- `answer/users/tests/test_views.py` ：test_views.py
```python
from django.test import RequestFactory
from test_plus.test import TestCase
from answer.users.views import UserUpdateView

# 基类：利用 RequestFactory 来进行测试
class BaseUserTestCase(TestCase):

    def setUp(self):
        self.factory = RequestFactory()
        self.user = self.make_user()


class TestUserUpdateView(BaseUserTestCase):

    def setUp(self):
        super().setUp()
        # testuser用户 -> 发送自定义request请求 -> 给UserUpdateView视图，【相比于通过request请求经过中间件等数据处理，这种方式直接测试视图，显得更加方便】
        self.view = UserUpdateView()
        request = self.factory.get('/fake-url')
        request.user = self.user
        self.view.request = request

    def test_get_success_url(self):
        self.assertEqual(self.view.get_success_url(), '/users/testuser/')

    # 返回：request请求的用户
    def test_get_object(self):
        self.assertEqual(self.view.get_object(), self.user)
```