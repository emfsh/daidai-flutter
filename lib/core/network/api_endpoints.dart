class ApiEndpoints {
  static const String baseApi = '/api';
  static const String baseApiV1 = '/api/v1';

  static const String health = '$baseApiV1/health';
  static const String version = '$baseApiV1/version';

  static const String login = '$baseApi/auth/login';
  static const String logout = '$baseApi/auth/logout';
  static const String refresh = '$baseApi/auth/refresh';
  static const String user = '$baseApi/auth/user';
  static const String password = '$baseApi/auth/password';
  static const String captchaConfig = '$baseApi/auth/captcha-config';

  static const String systemInfo = '$baseApi/system/info';
  static const String dashboard = '$baseApi/system/dashboard';
  static const String panelSettings = '$baseApi/system/panel-settings';
  static const String panelLog = '$baseApi/system/panel-log';
  static const String backup = '$baseApi/system/backup';
  static const String backups = '$baseApi/system/backups';

  static const String tasks = '$baseApi/tasks';
  static String taskById(int id) => '$baseApi/tasks/$id';
  static String taskRun(int id) => '$baseApi/tasks/$id/run';
  static String taskStop(int id) => '$baseApi/tasks/$id/stop';
  static String taskEnable(int id) => '$baseApi/tasks/$id/enable';
  static String taskDisable(int id) => '$baseApi/tasks/$id/disable';
  static String taskLiveLogs(int id) => '$baseApi/tasks/$id/live-logs';

  static const String logs = '$baseApi/logs';
  static String logById(int id) => '$baseApi/logs/$id';
  static String logStream(int id) => '$baseApiV1/logs/$id/stream';
  static const String logsClean = '$baseApi/logs/clean';

  static const String scripts = '$baseApi/scripts';
  static const String scriptsTree = '$baseApi/scripts/tree';
  static const String scriptsContent = '$baseApi/scripts/content';
  static const String scriptsUpload = '$baseApi/scripts/upload';

  static const String envs = '$baseApi/envs';
  static String envById(int id) => '$baseApi/envs/$id';
  static const String envsGroups = '$baseApi/envs/groups';

  static const String deps = '$baseApi/deps';
  static String depLogStream(int id) => '$baseApiV1/deps/$id/log-stream';

  static const String notifications = '$baseApi/notifications';
  static const String notificationTypes = '$baseApi/notifications/types';

  static const String subscriptions = '$baseApi/subscriptions';
  static String subscriptionPullStream(int id) =>
      '$baseApiV1/subscriptions/$id/pull-stream';

  static const String users = '$baseApi/users';
  static const String loginLogs = '$baseApi/security/login-logs';
  static const String sessions = '$baseApi/security/sessions';
  static const String ipWhitelist = '$baseApi/security/ip-whitelist';
  static const String twoFaStatus = '$baseApi/security/2fa/status';
  static const String openApiApps = '$baseApi/open-api/apps';
}
