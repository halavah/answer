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
