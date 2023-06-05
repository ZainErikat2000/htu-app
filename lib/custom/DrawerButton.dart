import 'package:flutter/material.dart';

class DrawerButtonSim extends StatelessWidget {
  DrawerButtonSim({required this.onTap, this.icon, required this.text, Key? key})
      : super(key: key);
  final VoidCallback onTap;
  Widget? icon = null;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(height: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(.25),width: 2),
          borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox(),
            Container(width: MediaQuery.of(context).size.width*.5,
              child: Text(textAlign: TextAlign.center,
                text,
                style: TextStyle(fontSize: 18, color: Colors.grey[850],fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
