import 'package:flutter/widgets.dart';

class Texticonbutton extends StatelessWidget {
  const Texticonbutton({
    super.key,
    required this.buttonasset1,
    required this.buttonasset2,
    this.onTap,
  });
  final Widget buttonasset1;
  final Widget buttonasset2;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(spacing: 2, children: [buttonasset1, buttonasset2]),
    );
  }
}
