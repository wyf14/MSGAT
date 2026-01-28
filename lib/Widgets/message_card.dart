import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageCard extends StatelessWidget {
  final String messageText;
  final bool isFav;
  final VoidCallback onShare;
  final VoidCallback onFavorite;

  const MessageCard({
    Key? key,
    required this.messageText,
    required this.isFav,
    required this.onShare,
    required this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageText,
              style: TextStyle(fontSize: MediaQuery.textScalerOf(context).scale(16)),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.share), onPressed: onShare),
                  IconButton(
                    icon: Icon(Icons.favorite, color: isFav ? Colors.red : Colors.grey),
                    onPressed: onFavorite,
                  ),

                  IconButton(onPressed: (){
                    Clipboard.setData(ClipboardData(text: messageText));
                  }, icon: Icon(Icons.copy))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
