import 'package:flutter/material.dart';

class TooltipText extends StatelessWidget {
  const TooltipText({
    super.key,
    required this.message,
    required this.style,
    this.text,
    this.maxLines = 1,
  });

  final String message;
  final String? text;
  final TextStyle? style;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final visibleText = text ?? message;

    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedWidth = constraints.maxWidth;
        final textWidget = Text(
          visibleText,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: style,
        );

        if (!constrainedWidth.isFinite) {
          return textWidget;
        }

        final textPainter = TextPainter(
          text: TextSpan(text: visibleText, style: style),
          maxLines: maxLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constrainedWidth);

        if (!textPainter.didExceedMaxLines) {
          return textWidget;
        }

        return Tooltip(
          message: visibleText,
          constraints: const BoxConstraints(maxWidth: 320),
          child: textWidget,
        );
      },
    );
  }
}
