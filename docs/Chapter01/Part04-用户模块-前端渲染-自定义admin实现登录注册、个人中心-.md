## 4. 用户模块-前端渲染-自定义 admin 实现登录注册、个人中心
```text
│  ├─static   # 添加文件，省略提前准备的CSS、JS文件
│  │      
│  ├─templates
│  │  │  400.html
│  │  │  403.html
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
│  │  └─users
│  │          user_detail.html
│  │          user_form.html
│              
├─config
│  │  
│  └─settings
│          base.py
```

### 4.1 向项目添加准备好的 CSS、JS、HTML 文件
- `answer/static` ：添加文件，【省略提前准备的 CSS、JS 文件】
- `answer/templates` ：添加文件，【省略提前准备的 HTML 文件】

### 4.2 向项目添加 django.forms、sorl.thumbnail、crispy_forms、allauth 等支持
- `config/settings/base.py` ：基本环境，【添加 django.forms、sorl.thumbnail、crispy_forms、allauth 等支持】
```python
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
]
```

### 4.3 自定义 admin 实现登录注册：base.html
- `answer/templates/base.html`
```html
<!-- 加载：静态文件static、处理图片thumbnail、压缩文件compress-->
{% load static thumbnail compress %}<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- 宏：标题【填充内容】 -->
  <title>{% block title %}赞乎{% endblock title %}</title>
  <link rel="icon" type="image/png" href="{% static 'img/favicon.png' %}">
  <meta name="description" content="赞乎问答社区">
  <meta name="author" content="__Jack__">

  <!-- 浏览器版本小于IE9 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>

  <!-- CSS文件 -->
  {% compress css %}
    <link rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}">
    <link rel="stylesheet" href="{% static 'fonts/font-awesome-4.7.0/css/font-awesome.min.css' %}">
    <link rel="stylesheet" href="{% static 'css/zanhu.css' %}">
    <!-- 宏：CSS【填充内容】 -->
    {% block css %}{% endblock css %}
  {% endcompress %}
</head>

<body>
<nav class="navbar fixed-top navbar-expand-sm bg-light">
  <div class="container">
    <a class="navbar-brand" href="#">赞 乎</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainMenu" aria-controls="mainMenu" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="mainMenu">
      <!-- 1.消息通知 -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="btn-sm" href="#" id="notifications" data-toggle="popover" data-title="通知">
            <i class="fa fa-bell-o" aria-hidden="true"></i>
          </a>
        </li>
      </ul>

      <!-- 2.导航栏 -->
      <ul class="navbar-nav mr-auto">
        <li class="nav-item"><a class="nav-link" href="#">首页</a></li>
        <li class="nav-item"><a class="nav-link" href="#">文章</a></li>
        <li class="nav-item"><a class="nav-link" href="#">问答</a></li>
        <li class="nav-item"><a class="nav-link" href="#">私信</a></li>
      </ul>

      <!-- 3.搜索栏 -->
      <form role="search" action="#">
        <div class="input-group">
          <input name="q" type="search" id="searchInput" class="form-control" placeholder="搜索" aria-label="Search">
          <div class="input-group-append">
            <button class="input-group-text"><i class="fa fa-search" aria-hidden="true"></i></button>
          </div>
        </div>
      </form>

      <!-- 4.登录用户验证通过后，【显示的内容】 -->
      {% if request.user.is_authenticated %}
        <ul class="navbar-nav">
          <li class="nav-item dropdown">
            <!-- 4.1 用户验证通过后，【显示的内容：头像 + 名字】 -->
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              {% thumbnail request.user.picture "x40" as im %}
                <img src="{{ im.url }}" style="border-radius: 50%;" alt="用户头像" class="user-image">
              {% empty %}
                <img src="{% static 'img/01_0047.jpg' %}" height="40px" alt="没有头像"/>
              {% endthumbnail %}
              {{ request.user.username }}
            </a>
            <!-- 4.2 用户验证通过后，【下拉框：设置 + 退出】 -->
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="{% url 'users:detail' request.user.username %}"><i class="fa fa-cogs fa-fw" aria-hidden="true"></i> 设置</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="{% url 'account_logout' %}"><i class="fa fa-sign-out fa-fw" aria-hidden="true"></i> 退出</a>
            </div>
          </li>
        </ul>
      {% endif %}

    </div>
  </div>
</nav>

<div class="mb-3"></div>

<!-- 主体信息 -->
<div class="container">
  <!-- 消息提示 -->
  {% if messages %}
    {% for message in messages %}
      <div id="messages" class="alert {% if message.tags %}alert-{{ message.tags }}{% endif %}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        {{ message }}
      </div>
    {% endfor %}
  {% endif %}

  <!-- 宏：主体信息【填充内容】 -->
  {% block content %}{% endblock content %}
</div>

<!-- JS文件 -->
{% compress js %}
  <script src="{% static 'js/jquery.min.js' %}"></script>
  <script src="{% static 'js/popper.min.js' %}" type="text/javascript"></script>
  <script src="{% static 'js/bootstrap.min.js' %}" type="text/javascript"></script>
  <script src="{% static 'js/jquery-ui.min.js' %}" type="text/javascript"></script>
  <script type="text/javascript">
    const currentUser = "{{ request.user.username }}";
  </script>
  {% block js %}{% endblock js %}
{% endcompress %}

</body>
</html>
```

### 4.4 自定义 admin 实现登录注册：account/base.html
- `answer/templates/account/base.html`
```html
<!-- 继承【base.html】 -->
{% extends "base.html" %}

<!-- 宏：标题【填充内容】 -->
{% block title %}
  {% block head_title %}{% endblock head_title %}
{% endblock title %}

<!-- 宏：主体信息【填充内容】 -->
{% block content %}
  <div class="row">
    <div class="col-md-6 offset-md-3">
      {% block inner %}{% endblock %}
    </div>
  </div>
{% endblock %}
```

### 4.5 自定义 admin 实现登录注册：account/login.html
- `answer/templates/account/login.html`
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

### 4.6 自定义 admin 实现登录注册：account/logout.html
- `answer/templates/account/logout.html`
```html
<!-- 继承【account/base.html】 -->
{% extends "account/base.html" %}

<!-- 加载：国际化i18n-->
{% load i18n %}

<!-- 宏：标题【填充内容】 -->
{% block head_title %}{% trans "Sign Out" %}{% endblock %}

<!-- 宏：主体信息【填充内容】 -->
{% block inner %}
  <h1>{% trans "Sign Out" %}</h1>
  <p>{% trans 'Are you sure you want to sign out?' %}</p>
  <form method="post" action="{% url 'account_logout' %}">
    {% csrf_token %}
    {% if redirect_field_value %}
      <input type="hidden" name="{{ redirect_field_name }}" value="{{ redirect_field_value }}"/>
    {% endif %}
    <button class="btn btn-danger" type="submit">{% trans 'Sign Out' %}</button>
  </form>
{% endblock %}
```

### 4.7 自定义 admin 实现登录注册：account/logout.html
- `answer/templates/account/logout.html`
```html
<!-- 继承【account/base.html】 -->
{% extends "account/base.html" %}

<!-- 加载：国际化i18n-->
{% load i18n %}

<!-- 宏：标题【填充内容】 -->
{% block head_title %}{% trans "Sign Out" %}{% endblock %}

<!-- 宏：主体信息【填充内容】 -->
{% block inner %}
  <h1>{% trans "Sign Out" %}</h1>
  <p>{% trans 'Are you sure you want to sign out?' %}</p>
  <form method="post" action="{% url 'account_logout' %}">
    {% csrf_token %}
    {% if redirect_field_value %}
      <input type="hidden" name="{{ redirect_field_name }}" value="{{ redirect_field_value }}"/>
    {% endif %}
    <button class="btn btn-danger" type="submit">{% trans 'Sign Out' %}</button>
  </form>
{% endblock %}
```

### 4.8 自定义 admin 实现登录注册：account/signup.html
- `answer/templates/account/signup.html`
```html
<!-- 继承【account/base.html】 -->
{% extends "account/base.html" %}

<!-- 加载：国际化i18n、权限allauth-->
{% load i18n %}
{% load crispy_forms_tags %}

<!-- 宏：标题【填充内容】 -->
{% block head_title %}{% trans "Signup" %}{% endblock %}

<!-- 宏：主体信息【填充内容】 -->
{% block inner %}
  <h1>{% trans "Sign Up" %}</h1>
  <p>{% blocktrans %}Already have an account? Then please <a href="{{ login_url }}">sign in</a>.{% endblocktrans %}</p>
  <form class="signup" id="signup_form" method="post" action="{% url 'account_signup' %}">
    {% csrf_token %}
    {{ form|crispy }}
    {% if redirect_field_value %}
      <input type="hidden" name="{{ redirect_field_name }}" value="{{ redirect_field_value }}"/>
    {% endif %}
    <button class="btn btn-primary" type="submit">{% trans "Sign Up" %} &raquo;</button>
  </form>
{% endblock %}
```

### 4.9 自定义 admin 实现个人中心：users/user_detail.html
- `answer/templates/users/user_detail.html`：个人信息，【展示数据】
```html
<!-- 继承【base.html】 -->
{% extends "base.html" %}

<!-- 加载：静态文件static、处理图片thumbnail-->
{% load static thumbnail %}

<!-- 宏：标题【填充内容】 -->
{% block title %}{{ object.username }} - {{ block.super }}{% endblock %}

<!-- 宏：CSS【填充内容】 -->
{% block css %}
  <link href="{% static 'css/user_profile.css' %}" rel="stylesheet">
{% endblock css %}

<!-- 宏：主体信息【填充内容】 -->
{% block content %}
  <div class="row">
    <!-- 1.用户头像 -->
    <div class="col-md-2">
      {% thumbnail object.picture "x180" as im %}
        <img src="{{ im.url }}" alt="用户头像">
      {% empty %}
        <img src="{% static 'img/01_0047.jpg' %}" height="180px" alt="没有头像"/>
      {% endthumbnail %}
    </div>

    <!-- 2.个性签名 -->
    <div class="col-md-7">
      <div class="card card-body"><p>{{ object.introduction }}</p></div>
    </div>

    <!-- 3.更新资料 -->
    <div class="col-md-3">
      <i class="fa fa-user-circle-o" aria-hidden="true"></i>{{ object.get_profile_name }}<br/>
      <i class="fa fa-envelope" aria-hidden="true"></i><a class="email" href="mailto:{{ object.email }}">{{ object.email }}</a><br/>
      {% if object.job_title %}
        <i class="fa fa-briefcase" aria-hidden="true"></i>  {{ object.job_title }} <br/>
      {% endif %}
      {% if object.location %}
        <i class="fa fa-map-marker" aria-hidden="true"></i>  {{ object.location }} <br/>
      {% endif %}
      <div class="mb-2"></div>
      <!--【登录用户=当前用户】，【更新按钮】-->
      {% if request.user.username == object.username %}
        <a class="btn btn-primary" href="{% url 'users:update' %}">更新信息</a>
      {% endif %}
    </div>
  </div>

  <!-- 4.【用户存在社交链接时】，【显示社交链接】 -->
  <div class="clear mb-3"></div>
  {% if object.personal_url %}
    <a href="{{ object.personal_url }}" style="font-size: 2em" title="个人网站"><i class="fa fa-link"></i> </a>
  {% endif %}
  {% if object.weibo %}
    <a href="{{ object.weibo }}" style="font-size: 2em" title="微博"><i class="fa fa-weibo"></i> </a>
  {% endif %}
  {% if object.zhihu %}
    <a href="{{ object.zhihu }}" style="font-size: 2em" title="知乎"><i class="fa fa-quora"></i> </a>
  {% endif %}
  {% if object.github %}
    <a href="{{ object.github }}" style="font-size: 2em" title="Github"><i class="fa fa-github"></i> </a>
  {% endif %}
  {% if object.linkedin %}
    <a href="{{ object.linkedin }}" style="font-size: 2em" title="LinkedIn"><i class="fa fa-linkedin"></i> </a>
  {% endif %}

  <!--5.【登录用户=当前用户】，【动态、文章、评论、提问、回答、互动】-->
  {% if request.user.username == object.username %}
    <div class="row tile_count">
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-code"> 动态</p>
        <div class="count">{{ moments_num }}</div>
      </div>
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-key"> 文章</p>
        <div class="count">{{ article_num }}</div>
      </div>
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-comments"> 评论</p>
        <div class="count">{{ comment_num }}</div>
      </div>
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-question-circle"> 提问</p>
        <div class="count">{{ question_num }}</div>
      </div>
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-keyboard-o"> 回答</p>
        <div class="count">{{ answer_num }}</div>
      </div>
      <div class="col-md-2 col-sm-3 col-xs-4 tile_stats_count">
        <p class="fa fa-navicon"> 互动</p>
        <div class="count">{{ interaction_num }}</div>
      </div>
    </div>
  {% endif %}
{% endblock content %}
```

### 4.10 自定义 admin 实现个人中心：users/user_form.html
- `answer/templates/users/user_form.html`：个人信息，【更新数据】
```html
<!-- 继承【base.html】 -->
{% extends "base.html" %}

<!-- 加载：静态文件static、标签crispy_forms_tags、处理图片thumbnail-->
{% load static crispy_forms_tags thumbnail %}

{% block title %}用户信息 - {{ block.super }}{% endblock %}

{% block css %}
  <link href="{% static 'css/user_form.css' %}" rel="stylesheet">
{% endblock css %}

{% block content %}
  <div class="row profile">
    <div class="col-md-3">
      <h2>{{ user.username }}</h2>
      {% if user.picture %}
        {% thumbnail user.picture "x180" as im %}
          <img src="{{ im.url }}" alt="用户头像" id="pic">
        {% endthumbnail %}
      {% else %}
        <img src="{% static 'img/01_0047.jpg' %}" height="180px" alt="没有头像"/>
      {% endif %}
    </div>

    <div class="col-md-9">
      <form enctype="multipart/form-data" class="form-horizontal" method="post" action="{% url 'users:update' %}">
        {% csrf_token %}
        {{ form|crispy }}
        <div class="control-group">
          <div class="controls">
            <button type="submit" class="btn btn-primary">更新</button>
          </div>
        </div>
      </form>
    </div>
  </div>
{% endblock %}
```