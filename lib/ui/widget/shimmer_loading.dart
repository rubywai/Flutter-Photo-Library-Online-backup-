import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
       itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 60.0,
            width: 60.0,
            color: Colors.grey[300],
          ),
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(height: 16.0, color: Colors.grey[300]),
        ),
        subtitle: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(height: 16.0, color: Colors.grey[300]),
        ),
        trailing: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 24.0,
            width: 24.0,
            color: Colors.grey[300],
          ),
        ),
      );
    },
    );
  }
}
