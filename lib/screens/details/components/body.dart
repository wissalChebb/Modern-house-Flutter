import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pim/components/api_routes.dart';
import 'package:pim/components/default_button.dart';

import 'package:pim/components/global_repos.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Product.dart';
import 'package:pim/models/Rate.dart';
import 'package:pim/models/user.dart';
import 'package:pim/size_config.dart';

import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../../models/Product.dart';
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
                            SizedBox(height: getProportionateScreenWidth(20)),
                            // Similar(product.item),
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
                      builder: (context, snapshot) {
                        return Column(
                          //print(snapshost.data!);
                          children: snapshot.data!
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

class Similar extends StatefulWidget {
  final int? item ;

  Similar(this.item);

  @override
  _SimilarState createState() => _SimilarState();
}

class _SimilarState extends State<Similar> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.13:8000/similar_products/${widget.item}'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<Product> productList =
            jsonList.map((json) => Product.fromJson(json)).toList();
        setState(() {
          _products = productList;
        });
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ..._products.map((product) {
            if (!product.isPopular)
              return ProductCard(product: product);
            else
              return SizedBox.shrink(); // here by default width and height is 0
          }).toList(),
          SizedBox(width: getProportionateScreenWidth(20)),
        ],
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
  PostWidget({Key? key, required this.rate}) : super(key: key);
  Rate rate;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getUser();
  }

  Future<Null> getUser() async {
    user = await apiData.getUserInfo(userID: widget.rate.user!);
    print(user!.username);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//    SchedulerBinding.instance
    //      .addPostFrameCallback((_) => getUser());
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        color: Colors.deepOrangeAccent,
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
                    backgroundImage:
                        NetworkImage('${Api_Routes.base}img/${user!.image}'),
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
                child: Rating(
                  rate: widget.rate.rate!,
                )),
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
