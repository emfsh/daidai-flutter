const defaultPanelBaseUrl = 'http://127.0.0.1:5700';

String normalizeServerUrl(String url) {
  var normalized = url.trim();
  if (normalized.isEmpty) return defaultPanelBaseUrl;
  if (!normalized.startsWith('http://') && !normalized.startsWith('https://')) {
    normalized = 'http://$normalized';
  }
  while (normalized.endsWith('/')) {
    normalized = normalized.substring(0, normalized.length - 1);
  }
  return normalized;
}

String friendlyLoginError(Object error) {
  final message = error.toString().trim();
  if (message.contains('403')) {
    return '登录请求被服务器拒绝（403）。如果面板部署在 NAS、Nginx Proxy Manager 或公网域名反代后，请升级面板到 v2.3.0 及以上，并检查反代/CORS 配置。';
  }
  if (message.isEmpty) return '登录失败';
  return message;
}

String apiPath(String path) {
  final normalized = path.startsWith('/') ? path : '/$path';
  if (normalized.startsWith('/api/')) return normalized;
  if (_requiresV1Api(normalized)) return '/api/v1$normalized';
  return '/api$normalized';
}

bool _requiresV1Api(String path) {
  return path == '/health' ||
      path == '/version' ||
      path.contains('/stream') ||
      path.contains('/log-stream');
}

bool shouldAttemptAutoLogin({
  required bool autoLoginEnabled,
  required bool manualLogoutInSession,
  required String username,
  required String password,
}) {
  return autoLoginEnabled &&
      !manualLogoutInSession &&
      username.trim().isNotEmpty &&
      password.isNotEmpty;
}
