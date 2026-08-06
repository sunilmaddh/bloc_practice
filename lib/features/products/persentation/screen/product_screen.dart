import 'dart:developer';

import 'package:bloc_practice/features/products/persentation/bloc/product_bloc.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    "Data loaded ${state.productModel.first.title}",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoadedState) {
              return ListView.builder(
                itemCount: state.productModel.length,
                itemBuilder: (context, index) {
                  var data = state.productModel[index];
                  return ListTile(
                    leading: SizedBox(
                      height: 45,
                      width: 45,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: data.image,
                          placeholder: (context, url) => ClipRRect(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(data.title),
                  );
                },
              );
            } else {
              return Center(child: Text("Error occured"));
            }
          },
        ),
      ),
    );
  }
}
