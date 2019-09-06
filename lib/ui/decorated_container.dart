import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;

  const DecoratedContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.1),
            BlendMode.dstATop,
          ),
          image: AssetImage('assets/ball.jpg'),
        ),
      ),
      child: child,
    );
  }
}
