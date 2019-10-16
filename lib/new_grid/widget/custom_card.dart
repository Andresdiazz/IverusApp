import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  CustomCard({
  this.documentData,
    this.bloc
  });
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Stack(
        children: <Widget>[
          Container(
            child: (widget.documentData.image != null)
                ? CachedNetworkImage(
                      imageUrl: widget.documentData.image,
                      fit: BoxFit.cover,
                  ) : null,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }

  BoxDecoration _whiteGradientDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.black, const Color(0x10000000)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    );
  }
}
