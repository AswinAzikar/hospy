import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class LoadingButtonV1 extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Icon? icon;
  final bool iconLeft;

  const LoadingButtonV1({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.iconLeft = true,
  });

  @override
  State<LoadingButtonV1> createState() => _LoadingButtonV1State();
}

class _LoadingButtonV1State extends State<LoadingButtonV1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _handleTap() {
    _controller.forward().then((_) {
      widget.onPressed();
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasIcon = widget.icon != null;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ScaleTransition(
        scale: _animation,
        child: InkResponse(
          splashColor: const Color(0xffef7878),
          borderRadius: BorderRadius.circular(10),
          onTap: _handleTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: screenHeight * 0.06,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (widget.icon != null)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: widget.iconLeft ? 5 : null,
                        right: widget.iconLeft ? null : 5,
                        child: widget.icon!,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
