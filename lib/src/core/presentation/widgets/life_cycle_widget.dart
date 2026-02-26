import 'dart:developer';

import 'package:flutter/material.dart';

class LifeCycleWidget extends StatefulWidget {
  const LifeCycleWidget({super.key, required this.child});

  final Widget child;

  @override
  State<LifeCycleWidget> createState() => _LifeCycleWidgetState();
}

class _LifeCycleWidgetState extends State<LifeCycleWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('Current App Life Cycle: $state');

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
