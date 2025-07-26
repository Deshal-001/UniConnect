import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  final bool initialValue;
  const FavoriteIcon({super.key, this.initialValue = false});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    isFavorited = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
      child: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
        size: 20,
        color: isFavorited ? Colors.red : Colors.grey,
      ),
    );
  }
}
