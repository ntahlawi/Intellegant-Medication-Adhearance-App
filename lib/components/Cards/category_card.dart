import 'package:flutter/material.dart';
import 'package:medappfv/components/Themes/Sizing.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  const CategoryCard({super.key, required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // Responsive margin (Adjust the multiplier as needed)
    final cardMargin = EdgeInsets.only(left: SizeConfig.screenWidth * 0.06); 

    // Responsive padding (Adjust the multipliers as needed)
    final double responsivePadding = SizeConfig.screenWidth * 0.015 + SizeConfig.screenHeight * 0.015;

    return Padding(
      padding: cardMargin,
      child: Container(
        padding: EdgeInsets.all(responsivePadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12), // Consider relative BorderRadius too
        ),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              color: Theme.of(context).colorScheme.background,
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.02), // Responsive spacing
            Text(categoryName),
          ],
        ),
      ),
    );
  }
}
