import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_reciep_app/recipe_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<RecipeModel> recipeList = [];
  List recipeCatList = [{
    "imgUrl":"https://tse2.mm.bing.net/th?id=OIP.c6Tbz7IbCn9bVXzXQSOqhgHaFN&pid=Api&P=0&h=220",
    "heading": "Fruits"
  },
    {
      "imgUrl": "https://realfood.tesco.com/media/images/SpeckledEasterEggCake-Final-dc56b86a-6777-47b4-97d6-291cba4a1451-0-636x418.jpg",
      "heading": "Cake"
    },
    {
      "imgUrl":"https://tse2.mm.bing.net/th?id=OIP.c6Tbz7IbCn9bVXzXQSOqhgHaFN&pid=Api&P=0&h=220",
      "heading": "Fruits"
    },
    {
      "imgUrl": "https://realfood.tesco.com/media/images/SpeckledEasterEggCake-Final-dc56b86a-6777-47b4-97d6-291cba4a1451-0-636x418.jpg",
      "heading": "Cake"
    },
  ];

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=c10af810&app_key=bcfe58a15975a82a40dacee9eed4ae71";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    //print(data);
    log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("laddo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SafeArea(
              child: Column(
                children: [
                  //search bar
                  Container(
                    //height: 55,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white70.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*if((searchController.text).replaceAll("", "")){
                              print("Blank");
                            }*/
                            getRecipe(searchController.text);
                          },
                          child: Container(
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Recipe"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What do you want to cook today",
                          style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70),
                        ),
                        Text(
                          "Let's Cook Something New",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                 Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            //physics: NeverScrollableScrollPhysics(),
                            itemCount: recipeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          recipeList[index].appimgUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              color: Colors.black26,
                                              child: Text(
                                                recipeList[index].applabel,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ))),
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          //height: 60,
                                          //width: 150,
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.white70,
                                              ),
                                              margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.local_fire_department,
                                                    size: 20,
                                                    color: Colors.red,),
                                                    Text(
                                                      recipeList[index].appcalories.toString().substring(0,6),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            })),

                Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            //physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: recipeCatList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          recipeCatList[index]["imgUrl"],
                                          fit: BoxFit.cover,
                                          width: 180,
                                          height: 180,
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              color: Colors.black26,
                                              child: Text(
                                                recipeCatList[index]["heading"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ))),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
