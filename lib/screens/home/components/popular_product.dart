import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pim/components/global_repos.dart';
import 'package:pim/components/product_card.dart';
import 'package:pim/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder<UnmodifiableListView<Product>>(
            stream: apiData.Products,
            initialData: UnmodifiableListView([]),
            builder: (context, snapshot) {
              return Row(
                children: [
                  ...List.generate(
                    snapshot.data!.length,
                    (index) {
                      if (snapshot.data![index].isPopular == false) {
                        return ProductCard(product: snapshot.data![index]);
                      }

                      return const SizedBox
                          .shrink(); // here by default width and height is 0
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
