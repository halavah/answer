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