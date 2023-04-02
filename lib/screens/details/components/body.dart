import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pim/components/default_button.dart';

import 'package:pim/components/global_repos.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Rate.dart';
import 'package:pim/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    apiData.getProductRates(product.id);
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(10),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: Column(
                          children: [
                            DefaultButton(
                              text: "Add To Cart",
                              press: () {
                                cart_repo.addToCart(product, 1);
                              },
                            ),

                            // FeedBackCard()
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reviews",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    StreamBuilder<UnmodifiableListView<Rate>>(
                      stream: apiData.Rates,
                      initialData: UnmodifiableListView([]),
                      builder: (context, snapshost) {
                        return Column(
                          children: snapshost.data!
                              .map((e) => Reviews(
                                    rate: e,
                                  ))
                              .toList(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Reviews extends StatelessWidget {
  final Rate? rate;
  Reviews({super.key, this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image.asset(
                      "assets/images/download.jpg",
                      fit: BoxFit
                          .cover, // ajuster l'image pour remplir complètement le conteneur
                    ),
                  ),
                ),
                Text(
                  " ${rate!.user}",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Rating(
              rate: double.parse(rate!.rate!.toString()),
              rateValue: (_) {},
            ),
            Text("${rate!.feedback}"),
          ],
        ),
      ),
    );
  }
}

class Rating extends StatefulWidget {
  final double? rate;
  ValueChanged<double>? rateValue;
  Rating({super.key, this.rate, this.rateValue});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    // print(widget.rate!);
    return Padding(
      padding: EdgeInsets.all(10),
      child: RatingBar.builder(
        initialRating: double.parse(widget.rate.toString()),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          widget.rateValue!(rating);
          print(rating);
        },
      ),
    );
  }
}
