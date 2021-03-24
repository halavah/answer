## 2. 用户模块-环境集成 django-allauth 实现 Github 第三方登录
```text
│  │      
│  ├─templates
│  │  ├─account
│  │  │      login.html
│              
├─config
│  │  
│  └─settings
│          base.py
```

### 2.1 用户模块：环境集成 django-allauth，实现用户登录、用户注册、用户注销、找回密码
- `cookiecutter-django-2.0.13` ：默认集成了 django-allauth，具体配置内容，参考该网址：https://django-allauth.readthedocs.io/en/latest/installation.html
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
    'allauth',
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
- `database migrate` ：添加用户，【命令如下，创建用户名：halavah、密码：QETU1234】
```text
pipenv run python manage.py createsuperuser	
```

### 2.2 用户模块：模板引擎，实现用户登录、用户注册、用户注销、找回密码
- `answer/templates/account/login.html` ：模板引擎，【实现用户登录、用户注册、用户注销、找回密码】
```html
<!-- 继承【account/base.html】 -->
{% extends "account/base.html" %}

<!-- 加载：国际化i18n、权限allauth、表单form-->
{% load i18n %}
{% load account socialaccount %}
{% load crispy_forms_tags %}

<!-- 宏：标题【填充内容】 -->
{% block head_title %}{% trans "Sign In" %}{% endblock %}

<!-- 宏：主体信息【填充内容】 -->
{% block inner %}
  <h1>{% trans "Sign In" %}</h1>
  <form class="login" method="POST" action="{% url 'account_login' %}">
    {% csrf_token %}
    {{ form|crispy }}
    {% if redirect_field_value %}
      <input type="hidden" name="{{ redirect_field_name }}" value="{{ redirect_field_value }}"/>
    {% endif %}
    <a class="button secondaryAction" href="{% url 'account_reset_password' %}">{% trans "Forgot Password?" %}</a>
    <button class="primaryAction btn btn-primary" type="submit">{% trans "Sign In" %}</button>
    <!-- 第三方登录：GitHub -->
    <div class="float-right">
      {% get_providers as socialaccount_providers %}
      {% if socialaccount_providers %}
        <div class="socialaccount_ballot">
          <ul class="socialaccount_providers">
            {% include "socialaccount/snippets/provider_list.html" with process="login" %}
          </ul>
        </div>
        {% include "socialaccount/snippets/login_extra.html" %}
      {% else %}
        <p>{% blocktrans %} 如果还没有账号，请先
          <a href="{{ signup_url }}">注册</a>{% endblocktrans %}</p>
      {% endif %}
    </div>
  </form>
{% endblock %}
```

### 2.3 用户模块：开通 OAuth Apps，使用 django-allauth 实现 Github 第三方登录
- `cookiecutter-django-2.0.13` ：默认集成了 django-allauth，具体配置内容，参考网址：https://django-allauth.readthedocs.io/en/latest/installation.html
- `base.py` ：操作步骤，来自 django-allauth 官方文档
```python
THIRD_PARTY_APPS = [
    'allauth.socialaccount.providers.github',   # 实现 Github 第三方登录
]
```
- `OAuth Apps` ：开通 OAuth Apps，【https://github.com/settings/developers】
```text
Application name：answer
Homepage URL：http://192.168.2.128:8000/
Application description：django-allauth 实现 Github 第三方登录
Authorization callback URL：http://192.168.2.128:8000/

Client ID：89186fcbd8c3af3edaca
Client secrets：6c6960b7e9d292ddce4c11c9b63a58bde7d28658 
```
- `socialaccount_socialapp` ：数据库，【手动添加数据】
```text
id  provider  name      client_id               secret                                      key
1   GitHub    GitHub	89186fcbd8c3af3edaca	08c09e17d0fcfa396b303d70e55c29b1a8b94894 	 
```
- `socialaccount_socialapp_sites` ：数据库，【手动添加数据】
```text
id  socialapp_id  site_id
1	1	          1
```