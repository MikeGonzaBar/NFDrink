import 'package:flutter/material.dart';
import 'package:nfdrink/pages/admin/one_product_info.dart';

class ProductSelectionItem extends StatelessWidget {
  final dynamic productData;
  const ProductSelectionItem({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OneProductInfo(productData: productData),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(0xff494949),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    productInfo(productData["product_name"]),
                    productInfo("${productData["content"].toString()} ml"),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.network(
                  productData["image_url"],
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding productInfo(String info) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        info,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}
