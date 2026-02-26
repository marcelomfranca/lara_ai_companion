import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lara_ai/src/core/application/extensions/relative_time_extension.dart';
import 'package:lara_ai/src/core/application/extensions/theme_build_context_extension.dart';
import '../../../../domain/entities/chat.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.index,
    this.onTap,
    this.onLongPress,
    this.selected,
  });

  final Chat chat;
  final int index;
  final void Function()? onTap;
  final void Function(bool)? onLongPress;
  final bool? selected;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late var _isSelected = widget.selected ?? false;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.selected ?? false;

    return GestureDetector(
          onTap: widget.onTap,
          onLongPress: () {
            setState(() {
              _isSelected = !_isSelected;
              widget.onLongPress?.call(_isSelected);
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(minHeight: 105),
            decoration: BoxDecoration(
              color: _isSelected
                  ? context.colors.violet.withValues(alpha: 0.1)
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Theme.of(context).dividerColor),
              boxShadow: <BoxShadow>[
                if (!_isSelected)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF7C3AED)],
                    ),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Visibility(
                        visible: widget.chat.lastMessage.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.chat.lastMessage,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                            maxLines: 1, // 'line-clamp-1'
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        widget.chat.lastMessageDateTime.toRelativeTime(),
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fade(duration: 400.ms, delay: (widget.index * 50).ms)
        .slideY(
          begin: 0.2,
          end: 0,
          curve: Curves.easeOutQuad,
          duration: 400.ms,
          delay: (widget.index * 50).ms,
        );
  }
}
