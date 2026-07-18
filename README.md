# 呆呆面板

呆呆面板是一个轻量级定时任务管理客户端，用于在移动端管理面板、任务、脚本、环境变量、订阅、依赖、通知、安全设置与备份恢复。

## 技术栈

- **UI 框架**: [Jetpack Compose](https://developer.android.com/jetpack/compose)
- **UI 组件库**: [Miuix](https://github.com/compose-miuix-ui/miuix) - A UI library for Compose Multiplatform
- **状态管理**: [ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel)
- **网络请求**: [Ktor Client](https://ktor.io/docs/client.html)
- **序列化**: [Kotlinx Serialization](https://github.com/Kotlin/kotlinx.serialization)
- **存储**: [DataStore](https://developer.android.com/topic/libraries/architecture/datastore)
- **导航**: [Navigation Compose](https://developer.android.com/jetpack/compose/navigation)

## 功能模块

- **仪表盘**: 查看系统概览、资源状态和最近执行记录
- **定时任务**: 任务列表、创建编辑、启停、执行、复制、置顶和批量操作
- **脚本管理**: 脚本浏览、编辑、上传、批量操作和运行辅助
- **执行日志**: 日志列表、详情、导出、清理和实时/流式日志入口
- **环境变量**: 变量增删改查、启停、排序和批量操作
- **依赖管理**: Python/Node.js 依赖查看、安装、重装、取消和删除
- **订阅管理**: 订阅列表、同步、启停和日志入口
- **通知渠道**: 渠道配置、启停、测试和发送
- **安全设置**: 2FA、登录日志、会话管理、IP 白名单和审计信息
- **开放 API**: 客户端凭据管理和开放接口访问配置
- **应用锁**: 密码、图案锁和生物识别
- **服务器配置**: 多面板管理

## 开发

### 环境要求

- Android Studio Hedgehog (2023.1.1) 或更高版本
- JDK 17 或更高版本
- Android SDK 35 或更高版本

### 构建

```bash
cd android-new
./gradlew assembleRelease
```

### 运行

```bash
cd android-new
./gradlew installDebug
```

## 项目结构

```text
android-new/
├── app/
│   └── src/
│       └── main/
│           └── kotlin/
│               └── com/daidai/panel/
│                   ├── DaidaiApp.kt          # 应用主入口
│                   ├── MainActivity.kt        # 主 Activity
│                   ├── data/                  # 数据层
│                   │   ├── api/               # API 客户端
│                   │   └── models/            # 数据模型
│                   ├── ui/                    # UI 层
│                   │   ├── screens/           # 页面
│                   │   ├── components/        # 组件
│                   │   └── theme/             # 主题
│                   └── viewmodel/             # ViewModel
├── build.gradle.kts
├── settings.gradle.kts
└── gradle/
```

## 引用

本项目使用了以下开源库：

- [Miuix](https://github.com/compose-miuix-ui/miuix) - A UI library for Compose Multiplatform
  - 提供了 Material Design 风格的 UI 组件
  - 支持 Android、iOS、Desktop、Web 等多平台
  - 使用 Apache 2.0 许可证

- [Ktor](https://ktor.io/) - Kotlin 异步 HTTP 客户端
  - 用于网络请求
  - 使用 Apache 2.0 许可证

- [Kotlinx Serialization](https://github.com/Kotlin/kotlinx.serialization) - Kotlin 序列化库
  - 用于 JSON 序列化/反序列化
  - 使用 Apache 2.0 许可证

- [Jetpack Compose](https://developer.android.com/jetpack/compose) - Android 现代 UI 工具包
  - 用于构建原生 UI
  - 使用 Apache 2.0 许可证

## 许可证

MIT License

## 相关项目

- 呆呆面板后端：[linzixuanzz/daidai-panel](https://github.com/linzixuanzz/daidai-panel)
- 原 Flutter 客户端：[linzixuanzz/Dumb-Panel-APP](https://github.com/linzixuanzz/Dumb-Panel-APP)
