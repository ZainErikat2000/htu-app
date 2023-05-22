import 'package:flutter/material.dart';

class ItemInfoPiece extends StatelessWidget {
  const ItemInfoPiece({required this.infoName, required this.info, Key? key})
      : super(key: key);
  final String infoName;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2),
        ),
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: MediaQuery.of(context).size.width * .8,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
