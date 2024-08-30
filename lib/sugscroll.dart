import 'package:flutter/material.dart';
import 'package:food_recipe/search.dart';
import 'RecipeView.dart';
import 'package:food_recipe/recipemodel.dart';

Widget sugscroll(reciptCatList) {
  return Container(
    height: 90,
    child: ListView.builder(
      itemCount: reciptCatList.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: ((context, index) {
        return Container(
            child: InkWell(
          onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>search(reciptCatList[index]["heading"])));
          },
          child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0.0,
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.network(
                        reciptCatList[index]["imgUrl"],
                        fit: BoxFit.cover,
                        width: 200,
                        height: 250,
                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(color: Colors.black26),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                reciptCatList[index]["heading"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                            ],
                          ))),
                ],
              )),
        ));
      }),
    ),
  );
}
