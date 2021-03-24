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
