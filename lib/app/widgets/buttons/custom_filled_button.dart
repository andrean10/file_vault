import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isFilledTonal;
  final Icon? icon;
  final Widget child;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final bool state;
  final bool isActive;

  const CustomFilledButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    required this.isFilledTonal,
    this.icon,
    required this.child,
    this.style,
    this.state = false,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height ?? size.height * 0.055,
      child: (isFilledTonal)
          ? (icon != null)
              ? FilledButton.tonalIcon(
                  onPressed: isActive ? onPressed : null,
                  icon: icon!,
                  label: child,
                  style: style,
                )
              : FilledButton.tonal(
                  onPressed: isActive ? onPressed : null,
                  style: style,
                  child: (state)
                      ? SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: colors.onSecondaryContainer,
                          ),
                        )
                      : child,
                )
          : (icon != null)
              ? FilledButton.icon(
                  onPressed: isActive ? onPressed : null,
                  icon: icon!,
                  label: child,
                  style: style,
                )
              : FilledButton(
                  onPressed: isActive ? onPressed : null,
                  style: style,
                  child: (state)
                      ? SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            color: colors.onPrimary,
                          ),
                        )
                      : child,
                ),
    );
  }
}
