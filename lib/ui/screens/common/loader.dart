import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? color;

  const Loader({
    this.width,
    this.height,
    this.color,
  });

  const Loader.sm({
    this.width = 16,
    this.height = 16,
    this.color,
  });

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool run = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.height,
        width: widget.width,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.color ?? Colors.white),
        ),
      ),
    );
  }
}
