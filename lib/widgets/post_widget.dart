import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sikad/pages/cause_page.dart';

//context, String _title, String category, String urlPost,
//  double currentMoney, double goal

Widget eachCard(BuildContext context, DocumentSnapshot document) {
  var _title = document['title'];
  var category = document['category'];
  var urlPost = document['downloadURL'];
  var causeID = document['causeID'];
  var currentMoney = document['total'];
  var goal = document['target'];
  var percentage = currentMoney <= goal ? (currentMoney / goal) : 1.0;
  return GestureDetector(
    onTap: () {
      if (true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CausePage(causeID)));
      } else {
        null;
      }
    },
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
          width: MediaQuery.of(context).size.width / 1.7,
          height: MediaQuery.of(context).size.width / 1.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPost),
              )),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
            width: MediaQuery.of(context).size.width / 1.7,
            height: MediaQuery.of(context).size.width / 1.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0x66000000),
            )
            /*gradient: LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: [Color(0xDD000000), Color(0x00000000)])),*/
            ),
        Positioned(
          top: 12,
          left: 27,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7 - 38,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '$_title',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '$category',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCCCCCC)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 63,
          right: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.7 - 38,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Php " +
                            currentMoney.toStringAsFixed(0) +
                            " out of Php " +
                            goal.toStringAsFixed(0),
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 23,
          bottom: 48,
          child: new LinearPercentIndicator(
            width: MediaQuery.of(context).size.width / 1.7 - 20,
            lineHeight: 8.0,
            percent: percentage,
            progressColor: Colors.red,
          ),
        ),
      ],
    ),
  );
}
