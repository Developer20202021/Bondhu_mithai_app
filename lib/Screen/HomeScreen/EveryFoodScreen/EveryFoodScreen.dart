import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dotted_line/dotted_line.dart';

class EveryFoodScreen extends StatefulWidget {
  const EveryFoodScreen({super.key});

  @override
  State<EveryFoodScreen> createState() => _EveryFoodScreenState();
}

class _EveryFoodScreenState extends State<EveryFoodScreen> {
  var UserReview = [
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 3,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 2,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 4,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 3,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      "userName": "Mahadi Hasan",
      "UserRating": 5,
      "UserReviewTime": "01/01/2022 12:13",
      "UserMessage":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    },
  ];


  int UserAddToCartNumber = 0;

    void plusOne() {
      setState(() {
      UserAddToCartNumber =  UserAddToCartNumber + 1;
      });
    }

    void minusOne() {
      if (UserAddToCartNumber == 0) {
        setState(() {
         UserAddToCartNumber = 0;
        });
      }
      else{
         setState(() {
       UserAddToCartNumber = UserAddToCartNumber - 1;
      });
      }

     
    }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
        ],
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Show food Image

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(158), // Image radius
                      child: Image.network(
                        'https://img.freepik.com/premium-photo/hamburger-with-flying-ingredients-white-background_787273-480.jpg?w=2000',
                        width: 400,
                        height: 350,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Center(
                  child: Text(
                    "This Food is Very good. You can purchase this food.",
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.line_weight,
                            size: 40,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "320gm",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                            rating: 2.5,
                            itemCount: 5,
                            itemSize: 24.0,
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                )),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rating",
                          style: TextStyle(
                              color: Color.fromARGB(255, 48, 2, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                Container(
                    child: DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashGradient: [Colors.grey, Colors.purple],
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapGradient: [Colors.grey, Colors.purple],
                  dashGapRadius: 0.0,
                )),

                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Ingredients",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Potato, Biscuits, Tomato, Meat, Egg, Mutton",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Meat",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.purple),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Breakfast",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.purple),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Hot Meals",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                    child: DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashGradient: [Colors.grey, Colors.purple],
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapGradient: [Colors.grey, Colors.purple],
                  dashGapRadius: 0.0,
                )),

                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Reviews",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 48, 2, 56),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

                for (var item in UserReview)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RatingBarIndicator(
                                  rating: double.parse(
                                      item["UserRating"].toString()),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.purple,
                                      )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${item["userName"]}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 48, 2, 56),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          Text(
                            "${item["UserReviewTime"]}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "${item["UserMessage"]}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
              ],
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromARGB(255, 203, 103, 221),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "50",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  minusOne();
                                },
                                icon: Icon(Icons.exposure_minus_1)),
                            Text(
                              "${UserAddToCartNumber}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  // var NewValue = UserAddToCartNumber + 1;
                                  plusOne();
                                },
                                icon: Icon(Icons.plus_one)),
                          ]),
                    ),
                  ],
                ),
                Container(
                    width: 90,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart, 
                        
                        color: Colors.purple,
                        
                        ),
                        Text(
                          "${UserAddToCartNumber}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
