import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../function/appFunction.dart';

class OnlineImage extends StatefulWidget {
  final String url;
  final double border;
  final BoxFit fit;
  const OnlineImage({super.key, required this.url, this.border = 0, this.fit = BoxFit.fill});

  @override
  State<OnlineImage> createState() => _OnlineImageState();
}

class _OnlineImageState extends State<OnlineImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.border),
      child: Image.network(
        widget.url,
        height: 100,
        width: width(context),
        fit: widget.fit,
        errorBuilder: (context, e, tree) {
          return Image.asset(
            'assets/image_not_founded.jpg',
            fit: widget.fit,
            height: 120,
            width: 120,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: SpinKitFadingCircle(
                color: Theme.of(
                  context,
                ).colorScheme.tertiary.withOpacity(0.75),
                size: 25.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
