import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_recipe/recipemodel.dart';
import 'package:food_recipe/sugscroll.dart';
import 'package:http/http.dart';

import 'MyView.dart';

class search extends StatefulWidget {
  String query;
  search(this.query);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  bool isloading = true;
  List<RecipeModel> recipelist = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Veg"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Non Veg"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "South Indian"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];
  // eska esa pass nhi krna hai utf8 mai encode kr k krna chaiye
  getRecipe(String query) async {
    String encodedQuery = Uri.encodeComponent(query);
    String url =
        "https://api.edamam.com/search?q=$encodedQuery&app_id=4dce9b7a&app_key=6fd453298068eb3562a0f7996b488a76";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipelist.add(recipeModel);
      setState(() {
        isloading = false;
      });
      log(recipelist.toString());
    });
    recipelist.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 229, 221, 1),
      body: Container(
        padding: EdgeInsets.all(18.0),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 227, 220, 90),
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if ((searchController.text)
                                        .replaceAll(" ", "") ==
                                    "") {
                                  print("Blank search");
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              search(searchController.text)));
                                          
                                  
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Let's Cook Something!",
                                    fillColor: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // Logic to Show Loading circular bar ,
                      child: isloading == true
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recipelist.length,
                              itemBuilder: (context, index) {
                                return MyView(recipelist, index,context);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
