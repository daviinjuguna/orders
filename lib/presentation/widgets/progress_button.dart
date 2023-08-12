import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({
    Key? key,
    required this.isLoading,
    required this.child,
    this.borderRadius,
    this.foregroundColor,
    this.backgroundColor,
    this.onPressed,
  }) : super(key: key);
  final bool isLoading;
  final Widget child;
  final BorderRadius? borderRadius;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _actionOnLoading();
  }

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _actionOnLoading();
  }

  void _actionOnLoading() {
    //if controller is forwadd and loading return
    if (_controller.status == AnimationStatus.forward && widget.isLoading) {
      return;
    }

    //if controller is reverse and not loading return
    if (_controller.status == AnimationStatus.reverse && !widget.isLoading) {
      return;
    }

    //if loading start animation
    if (widget.isLoading) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _child() {
    if (_controller.isAnimating) {
      return Container();
    }
    if (_controller.isCompleted && !widget.isLoading) {
      return widget.child;
    }
    if (_controller.isDismissed && widget.isLoading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(widget.foregroundColor),
      );
    }
    return widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonHeight = (constraints.maxHeight != double.infinity)
            ? constraints.maxHeight
            : 45.0;

        final widthAnimation = Tween<double>(
          begin: constraints.maxWidth,
          end: 10,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );

        final borderRadiusAnimation = Tween<BorderRadius>(
          begin: widget.borderRadius,
          end: BorderRadius.all(Radius.circular(buttonHeight / 2.0)),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ));

        return AnimatedBuilder(
          animation: _controller,
          child: _child(),
          builder: (context, child) => SizedBox(
            height: buttonHeight,
            width: widthAnimation.value,
            child: FilledButton(
              onPressed: widget.onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.foregroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadiusAnimation.value,
                ),
                maximumSize: Size(widthAnimation.value, 45),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
