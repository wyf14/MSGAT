import 'package:flutter/material.dart';

class CardsWidget extends StatelessWidget {
 final String id,image,title;
  const CardsWidget({ required this.image,required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),


              child:  Image.asset(image,
                  fit: BoxFit.fill,
                ),
              ),


          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(40),
            borderRadius: BorderRadius.circular(15)
            ),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(title,
            style: TextStyle(fontSize: 24,color: Colors.white
            ),
            ),
          )
        ],

    );

  }

}
Widget buildNavButton(IconData icon, String label, VoidCallback f) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    onPressed: f,
    child: Column(
      mainAxisSize: MainAxisSize.min, // مهم عشان يمنع التمدد الزائد
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 10),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

