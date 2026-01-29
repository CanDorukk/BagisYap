import 'package:flutter/material.dart';

/// Bilgi metni gösteren widget.
class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
