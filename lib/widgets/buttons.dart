import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';

class LoadingButtonV1 extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const LoadingButtonV1({
    super.key,
    required this.onPressed,
    required this.text,
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ScaleTransition(
        scale: _animation,
        child: InkResponse(
          splashColor: Colors.blue,
          borderRadius:
              BorderRadius.circular(10), // Match the button border radius
          onTap: _handleTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: primaryGradience,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20), // Adjust padding if needed
              child: Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
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
