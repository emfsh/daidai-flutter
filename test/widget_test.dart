import 'package:flutter_test/flutter_test.dart';

import 'package:daidai_app/services/api_utils.dart';

void main() {
  group('normalizeServerUrl', () {
    test('adds http scheme and removes trailing slashes', () {
      expect(normalizeServerUrl('example.com///'), 'http://example.com');
    });

    test('keeps existing https scheme', () {
      expect(
        normalizeServerUrl('https://panel.example.com/'),
        'https://panel.example.com',
      );
    });

    test('uses default local panel url for blank input', () {
      expect(normalizeServerUrl('  '), 'http://127.0.0.1:5700');
    });
  });

  group('friendlyLoginError', () {
    test('explains 403 reverse proxy compatibility problem', () {
      final message = friendlyLoginError('网络错误: 403 Forbidden');

      expect(message, contains('403'));
      expect(message, contains('v2.3.0'));
      expect(message, contains('反代'));
    });

    test('uses backend message when it is already clear', () {
      expect(friendlyLoginError('用户名或密码错误'), '用户名或密码错误');
    });
  });

  group('apiPath', () {
    test('uses /api for regular panel endpoints', () {
      expect(apiPath('/tasks'), '/api/tasks');
      expect(apiPath('/system/info'), '/api/system/info');
    });

    test('keeps paths that already include /api prefix', () {
      expect(apiPath('/api/auth/login'), '/api/auth/login');
      expect(apiPath('/api/v1/health'), '/api/v1/health');
    });

    test('uses /api/v1 for streaming endpoints', () {
      expect(apiPath('/logs/42/stream'), '/api/v1/logs/42/stream');
      expect(apiPath('/deps/3/log-stream'), '/api/v1/deps/3/log-stream');
      expect(
        apiPath('/subscriptions/8/pull-stream'),
        '/api/v1/subscriptions/8/pull-stream',
      );
    });
  });
}
