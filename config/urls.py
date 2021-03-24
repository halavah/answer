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
