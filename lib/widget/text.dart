import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riceking/function/appFunction.dart';

class RobotoText extends StatefulWidget {
  final String title;
  final double size;
  const RobotoText({super.key, required this.title, required this.size});

  @override
  State<RobotoText> createState() => _RobotoTextState();
}

class _RobotoTextState extends State<RobotoText> {
  String? title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    change(widget.title);
  }

  Future<void> change(String text) async {
    final data = await translateString(text);
    setState(() {
      title = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title??'',
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.robotoSerif(
        fontSize: widget.size,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class OpenSansText extends StatefulWidget {
  final String title;
  final double size;
  const OpenSansText({super.key, required this.title, required this.size});

  @override
  State<OpenSansText> createState() => _OpenSansTextState();
}

class _OpenSansTextState extends State<OpenSansText> {
  String? title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    change(widget.title);
  }

  Future<void> change(String text) async {
    final data = await translateString(text);
    setState(() {
      title = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.openSans(
        fontSize: widget.size,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class LatoText extends StatefulWidget {
  final String title;
  final double size;
  final int lineHeight;
  final bool showLine;
  final Color color;
  const LatoText({
    super.key,
    required this.title,
    required this.size,
    required this.lineHeight,
    this.showLine = false,
    this.color = const Color(0xff212121),
  });

  @override
  State<LatoText> createState() => _LatoTextState();
}

class _LatoTextState extends State<LatoText> {
  String? title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    change(widget.title);
  }

  Future<void> change(String text) async {
    final data = await translateString(text);
    setState(() {
      title = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: widget.showLine ? null : widget.lineHeight,
      style: GoogleFonts.poppins(
        fontSize: widget.size,
        fontWeight: FontWeight.w400,
        color: widget.color
      ),
    );
  }
}
