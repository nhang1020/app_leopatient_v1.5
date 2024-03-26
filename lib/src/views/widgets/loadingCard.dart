import 'package:app/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key});

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Container(
        width: isSmallScreen(context) ? null : 300,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: GreyContainer(height: 43, width: 43, radius: 45),
                    title: GreyContainer(),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        GreyContainer(),
                        SizedBox(height: 5),
                        GreyContainer(
                          width: 200,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GreyContainer(height: 30, width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
  });
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey.withOpacity(.4),
      highlightColor: Colors.grey,
      child: Container(
        height: height ?? 13,
        width: width ?? 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: color ?? Colors.grey.withOpacity(.4),
        ),
      ),
    );
  }
}
