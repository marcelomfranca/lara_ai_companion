import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../../../core/application/extensions/theme_build_context_extension.dart';

class FluidText extends StatefulWidget {
  const FluidText({
    super.key,
    required this.text,
    required this.isStreaming,
    this.style,
    this.scrollController,
    this.onComplete,
    this.onRetry,
  });

  final String text;
  final bool isStreaming;
  final TextStyle? style;
  final ScrollController? scrollController;
  final void Function(bool)? onComplete;
  final void Function()? onRetry;

  @override
  State<FluidText> createState() => _FluidTextState();
}

class _FluidTextState extends State<FluidText> {
  late final _scrollController = widget.scrollController;
  String _displayedText = "";
  Timer? _timer;
  int _currentIndex = 0;
  bool _completed = false;

  @override
  void didUpdateWidget(FluidText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text.length > _displayedText.length) {
      _startTyping();
    }
  }

  void _startTyping() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _currentIndex++;
          _displayedText = widget.text.substring(0, _currentIndex);
        });

        _scrollToBottom();
      } else {
        timer.cancel();

        setState(() => _completed = true);

        widget.onComplete?.call(true);
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController?.hasClients ?? false) {
        _scrollController!.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MarkdownBody(data: _displayedText, selectable: true, shrinkWrap: true),
        if (_completed && widget.onRetry != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.refresh, color: context.colors.electricCyan),
              onPressed: widget.onRetry,
            ),
          ),
        ],
      ],
    );
  }
}
