import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductTile extends StatelessWidget {
  const ShimmerProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile( 
      leading: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(width: 50, height: 50, color: Colors.white),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 16,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 14,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 2),
        ),
      ),
    );
  }
}