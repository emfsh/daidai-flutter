class _TaskCardState extends State<_TaskCard> {
  static const double _actionWidth = 52;
  static const double _actionGap = 6;
  // ↓↓↓ 改动 1：宽度从 5 列改为 3 列
  static const double _actionsWidth = _actionWidth * 3 + _actionGap * 2 + 8;

  double _dragOffset = 0;
  bool _dragging = false;

  Task get task => widget.task;

  @override
  void didUpdateWidget(covariant _TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectionMode || oldWidget.task.id != widget.task.id) {
      _dragOffset = 0;
      _dragging = false;
    }
  }

  Color _dotColor() {
    if (task.isRunning) {
      return AppColors.primary;
    }
    if (task.isQueued) {
      return AppColors.amber500;
    }
    if (task.lastRunStatus == 1) {
      return AppColors.red500;
    }
    if (task.isEnabled) {
      return AppColors.primary;
    }
    return AppColors.slate300;
  }

  String _statusLabel() {
    if (task.isRunning) {
      return '运行中';
    }
    if (task.isQueued) {
      return '排队中';
    }
    if (task.isEnabled) {
      return '已启用';
    }
    return '已禁用';
  }

  Color _statusBg() {
    if (task.isRunning) {
      return widget.isLight
          ? AppColors.primaryLight
          : AppColors.primary.withAlpha(25);
    }
    if (task.isQueued) {
      return AppColors.amber500.withAlpha(widget.isLight ? 18 : 25);
    }
    if (task.isEnabled) {
      return widget.isLight
          ? AppColors.blue100
          : AppColors.blue500.withAlpha(25);
    }
    return widget.isLight ? AppColors.slate100 : AppColors.slate800;
  }

  Color _statusFg() {
    if (task.isRunning) {
      return widget.isLight ? const Color(0xFF047857) : AppColors.primary;
    }
    if (task.isQueued) {
      return AppColors.amber500;
    }
    if (task.isEnabled) {
      return widget.isLight ? AppColors.blue600 : AppColors.blue500;
    }
    return AppColors.slate500;
  }

  String _taskTypeLabel() {
    switch (task.taskType) {
      case 'manual':
        return '手动运行';
      case 'startup':
        return '开机运行';
      default:
        return '常规定时';
    }
  }

  List<String> _scheduleExpressions() {
    if (task.cronExpressions.isNotEmpty) {
      return task.cronExpressions;
    }
    if (task.cronExpression.trim().isNotEmpty) {
      return [task.cronExpression.trim()];
    }
    return const [];
  }

  String _bottomText() {
    if (task.isRunning) {
      return '点击查看实时日志';
    }
    if (task.lastRunStatus == 1 && task.lastRunAt != null) {
      return '上次失败：${formatTimeCn(task.lastRunAt, short: true)}';
    }
    if (task.nextRunAt != null) {
      return '下次运行：${formatTimeCn(task.nextRunAt, short: true)}';
    }
    if (task.taskType == 'manual') {
      return '手动触发';
    }
    if (task.taskType == 'startup') {
      return '面板启动时自动执行';
    }
    return '暂无计划';
  }

  void _closeActions() {
    if (_dragOffset == 0) {
      return;
    }
    setState(() => _dragOffset = 0);
  }

  void _runSwipeAction(VoidCallback action) {
    _closeActions();
    action();
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = _dotColor();
    final borderColor = widget.isLight
        ? AppColors.slate200
        : AppColors.slate800;
    final labels = task.userLabelsForDisplay;
    final hasFailure = task.lastRunStatus == 1;
    final primaryColor = task.isRunning ? AppColors.red500 : AppColors.primary;

    return PopScope(
      canPop: _dragOffset == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || _dragOffset == 0) {
          return;
        }
        // 侧滑按钮展开时，系统返回先收起按钮，避免用户回滑时误退出 APP。
        _closeActions();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ↓↓↓ 改动 2：侧滑按钮改为两行（上 3 下 2）
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TaskSwipeActionButton(
                            label: task.isDisabled ? '启用' : '禁用',
                            icon: task.isDisabled
                                ? Icons.play_circle_outline
                                : Icons.pause_circle_outline,
                            color: task.isDisabled
                                ? AppColors.primary
                                : AppColors.slate500,
                            onTap: () => _runSwipeAction(widget.onToggleEnabled),
                          ),
                          const SizedBox(width: _actionGap),
                          _TaskSwipeActionButton(
                            label: task.isPinned ? '取消' : '置顶',
                            icon: task.isPinned
                                ? Icons.push_pin_outlined
                                : Icons.push_pin,
                            color: AppColors.amber500,
                            onTap: () => _runSwipeAction(widget.onTogglePinned),
                          ),
                          const SizedBox(width: _actionGap),
                          _TaskSwipeActionButton(
                            label: '复制',
                            icon: Icons.copy_outlined,
                            color: AppColors.blue500,
                            onTap: () => _runSwipeAction(widget.onCopy),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: _actionGap),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _TaskSwipeActionButton(
                            label: '编辑',
                            icon: Icons.edit_outlined,
                            color: AppColors.slate500,
                            onTap: () => _runSwipeAction(widget.onEdit),
                          ),
                          const SizedBox(width: _actionGap),
                          _TaskSwipeActionButton(
                            label: '删除',
                            icon: Icons.delete_outline,
                            color: AppColors.red500,
                            onTap: () => _runSwipeAction(widget.onDelete),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_dragOffset != 0) {
                  _closeActions();
                  return;
                }
                widget.onTap();
              },
              onLongPress: widget.onLongPress,
              onHorizontalDragStart: widget.selectionMode
                  ? null
                  : (_) => setState(() => _dragging = true),
              onHorizontalDragUpdate: widget.selectionMode
                  ? null
                  : (details) {
                      // 左滑露出右侧次要操作；关闭时也限制在卡片内处理，避免和系统返回手势抢动作。
                      final nextOffset = (_dragOffset + details.delta.dx)
                          .clamp(-_actionsWidth, 0.0)
                          .toDouble();
                      if (nextOffset == _dragOffset) {
                        return;
                      }
                      setState(() => _dragOffset = nextOffset);
                    },
              onHorizontalDragCancel: widget.selectionMode
                  ? null
                  : () => setState(() => _dragging = false),
              onHorizontalDragEnd: widget.selectionMode
                  ? null
                  : (_) {
                      final nextOffset =
                          _dragOffset.abs() > _actionsWidth * 0.42
                          ? -_actionsWidth
                          : 0.0;
                      setState(() {
                        _dragging = false;
                        _dragOffset = nextOffset;
                      });
                      if (nextOffset == -_actionsWidth) {
                        HapticFeedback.selectionClick();
                      }
                    },
              child: AnimatedContainer(
                duration: _dragging
                    ? Duration.zero
                    : const Duration(milliseconds: 160),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(_dragOffset, 0, 0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: glassCardColor(glassMode: widget.glassMode, isLight: widget.isLight),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: widget.selected
                        ? AppColors.primary
                        : (hasFailure
                              ? AppColors.red500.withAlpha(60)
                              : borderColor),
                    width: widget.selected ? 1.4 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (widget.selectionMode) ...[
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: widget.selected,
                              onChanged: (_) => widget.onSelectedChanged(),
                              activeColor: AppColors.primary,
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                            boxShadow: task.isRunning || hasFailure
                                ? [
                                    BoxShadow(
                                      color: dotColor.withAlpha(140),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            task.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (task.isPinned)
                          const Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: Icon(
                              Icons.push_pin,
                              size: 14,
                              color: AppColors.amber500,
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _statusBg(),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            _statusLabel(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _statusFg(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _TaskScheduleSummary(
                      taskType: task.taskType,
                      taskTypeLabel: _taskTypeLabel(),
                      expressions: _scheduleExpressions(),
                      isLight: widget.isLight,
                    ),
                    if (labels.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _TaskSubscriptionSummary(
                        labels: labels,
                        isLight: widget.isLight,
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _bottomText(),
                            style: TextStyle(
                              fontSize: 11,
                              color: hasFailure
                                  ? AppColors.red500
                                  : (widget.isLight
                                        ? AppColors.slate400
                                        : AppColors.slate500),
                            ),
                          ),
                        ),
                        if (!widget.selectionMode) ...[
                          _TaskPrimaryActionButton(
                            label: task.isRunning ? '停止' : '运行',
                            icon: task.isRunning
                                ? Icons.stop_rounded
                                : Icons.play_arrow_rounded,
                            color: primaryColor,
                            onTap: task.isRunning
                                ? widget.onStop
                                : widget.onRun,
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.swipe_left_alt_rounded,
                            size: 18,
                            color: AppColors.slate400,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
