import 'package:flutter/material.dart';


class NotificationMenuButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const NotificationMenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  NotificationMenuButtonState createState() => NotificationMenuButtonState();
}

class NotificationMenuButtonState extends State<NotificationMenuButton> {
  bool _showDevelopmentMessage = false;

  void handleTap() {
    setState(() {
      _showDevelopmentMessage = !_showDevelopmentMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              leading: Icon(widget.icon, color: widget.iconColor),
              title: Text(
                widget.label,
                style: const TextStyle(color: Colors.black87),
              ),
              onTap: handleTap,
            ),
          ),
          if (_showDevelopmentMessage)
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 4.0),
              child: Text(
                'Still under development',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
