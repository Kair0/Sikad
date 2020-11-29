import 'package:Sikad/colours.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/itemsIndex.dart';

import 'package:provider/provider.dart';

Widget navigationBar(context, IconData icon, int index, int type) {
  final selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
  return GestureDetector(
    onTap: () {
      selectedItemIndex.equate(index);
      print(selectedItemIndex.ind);
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 90,
      child: icon != null
          ? Stack(children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: MediaQuery.of(context).size.width / 10 - 25),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: type == 0 ? Color(0xFFFFFFFF) : Color(OGRed),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: MediaQuery.of(context).size.width / 10 - 25),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: index == selectedItemIndex.ind
                      ? RadialGradient(
                          colors: [Color(0xFF000000), Color(0x66000000)])
                      : RadialGradient(
                          colors: [Color(0x00000000), Color(0x00000000)]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 25,
                  color: index == selectedItemIndex.ind
                      ? Colors.white
                      : Color(OGBlue),
                ),
              ),
            ])
          : Container(),
    ),
  );
}
