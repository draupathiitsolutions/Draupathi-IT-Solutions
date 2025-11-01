import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceking/widget/text.dart';

import '../function/appFunction.dart';

class ButtonWithText extends StatefulWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;

  const ButtonWithText({
    super.key,
    required this.title,
    required this.onPressed, required this.width, this.height = 50,
  });

  @override
  State<ButtonWithText> createState() => _ButtonWithTextState();
}

class _ButtonWithTextState extends State<ButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: OpenSansText(title: widget.title, size: 14)),
      ),
    );
  }
}

class TextAsButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final double size;

  const TextAsButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    required this.size,
  });

  @override
  State<TextAsButton> createState() => _TextAsButtonState();
}

class _TextAsButtonState extends State<TextAsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.openSans(
              fontSize: widget.size,
              fontWeight: FontWeight.w600,
              color: widget.color,
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.open_in_new_rounded,
            color: widget.color,
            size: widget.size,
          ),
        ],
      ),
    );
  }
}

class IconAsButton extends StatefulWidget {
  final IconData icon;
  final Function() onPressed;
  final double size;

  const IconAsButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.size,
  });

  @override
  State<IconAsButton> createState() => _IconAsButtonState();
}

class _IconAsButtonState extends State<IconAsButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Icon(
        widget.icon,
        color: Theme.of(context).colorScheme.tertiary,
        size: widget.size,
      ),
    );
  }
}
