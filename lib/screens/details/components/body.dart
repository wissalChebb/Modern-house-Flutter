import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/components/default_button.dart';

import 'package:pim/components/global_repos.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Rate.dart';
import 'package:pim/models/user.dart';
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
                    //PostWidget(),
                    StreamBuilder<UnmodifiableListView<Rate>>(
                      stream: apiData.Rates,
                      initialData: UnmodifiableListView([]),
                      builder: (context, snapshost) {
                        return Column(
                          //print(snapshost.data!);
                          children: snapshost.data!
                              .map((e) => PostWidget(
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
/*
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
}*/


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
        itemSize: 22,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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


class PostWidget extends StatefulWidget {
  PostWidget({Key? key,required this.rate}) : super(key: key);
  Rate rate;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getUser();
  }
  Future<Null> getUser() async{
    user = await apiData.getUserInfo(userID: widget.rate.user!);
    print(user!.username);
setState(() {

});
  }
  @override
  Widget build(BuildContext context) {
//    SchedulerBinding.instance
  //      .addPostFrameCallback((_) => getUser());
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14.0, 14.0, 3.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 18.0,
                    backgroundImage: NetworkImage(
                        'http://172.16.2.241:9090/img/${user!.image}'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user!.username}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.more_horiz_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                child: Rating(rate: widget.rate.rate!,)),

            Text(
              "${widget.rate.feedback}",
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              textAlign: TextAlign.start,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_up),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_down),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "${widget.rate.createdAt}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class Rating extends StatefulWidget {

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
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 22,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ));
  }
}*/
