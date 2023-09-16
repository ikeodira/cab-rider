import 'package:flutter/material.dart';

class ToastWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final TextStyle textStyle;

  ToastWidget({
    required this.message,
    this.duration = const Duration(seconds: 2),
    this.backgroundColor = Colors.black54,
    this.textStyle = const TextStyle(color: Colors.white),
  });

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget> {
  @override
  void initState() {
    super.initState();
    _showToast();
  }

  void _showToast() async {
    await Future.delayed(widget.duration);

    if (mounted) {
      setState(() {
        // Remove the toast widget from the widget tree
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(8.0),
        color: widget.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.message,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ToastWidget(message: message);
    },
  );
}
