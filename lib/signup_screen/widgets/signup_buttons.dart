import 'package:flutter/material.dart';

class DynamicColorButton extends StatefulWidget {
  const DynamicColorButton(
      {super.key,
      required this.text,
      this.icon,
      this.isIconLeft = false,
      this.backgroundColor = Colors.black,
      this.textColor = Colors.white,
      this.borderColor = Colors.black,
      required this.onTap});

  final String text;
  final Icon? icon;
  final bool isIconLeft;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  State<DynamicColorButton> createState() => _DynamicColorButtonState();
}

class _DynamicColorButtonState extends State<DynamicColorButton> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.textColor ?? Colors.white;

    return Expanded(
      child: InkWell(
        splashColor: widget.backgroundColor,
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.backgroundColor,
            border: Border.all(
              color: widget.borderColor!,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isIconLeft && widget.icon != null) ...[
                Icon(
                  widget.icon!.icon,
                  color: color,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (!widget.isIconLeft && widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon!.icon,
                  color: color,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
