// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products_provider.dart';
import '../Providers/products.dart';

class addProductScreen extends StatefulWidget {
  static String routeName = "/add-product";

  @override
  State<addProductScreen> createState() => _addProductScreenState();
}

class _addProductScreenState extends State<addProductScreen> {
  var _addProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  final _urlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) return;
    _form.currentState?.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Products>(context, listen: false).addItem(_addProduct);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("An Error Occured !!"),
                content: Text("Something Went Wrong ."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(label: Text("Titile")),
                        validator: (value) {
                          if (value!.isEmpty) return "Please Provide A Title";
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _addProduct = Product(
                              id: _addProduct.id,
                              title: value!,
                              description: _addProduct.description,
                              price: _addProduct.price,
                              imageUrl: _addProduct.imageUrl);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(label: Text("Pice")),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) return "Please Provide A Price";
                          if (double.tryParse(value) == null)
                            return "Please Provide a Valid Price";
                          if (double.parse(value) <= 0)
                            return "Please Provide A Price Greater Than 0";
                          return null;
                        },
                        onSaved: (value) {
                          _addProduct = Product(
                              id: _addProduct.id,
                              title: _addProduct.title,
                              description: _addProduct.description,
                              price: double.parse(value!),
                              imageUrl: _addProduct.imageUrl);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(label: Text("Decription")),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please Provide A Description";
                          if (value.length < 10)
                            return "Description Should be of Atleast 10 words";
                          return null;
                        },
                        onSaved: (value) {
                          _addProduct = Product(
                              id: _addProduct.id,
                              title: _addProduct.title,
                              description: value!,
                              price: _addProduct.price,
                              imageUrl: _addProduct.imageUrl);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.all(5),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1,
                            )),
                            child: FittedBox(
                                child: _urlController.text.isEmpty
                                    ? Text(
                                        "Enter A Url",
                                      )
                                    : Image.network(
                                        _urlController.text,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Text(
                                            "Enter Correct Url",
                                          );
                                        },
                                      )),
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(label: Text("Image Url")),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _urlController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Please Provide A Url";
                                return null;
                              },
                              onChanged: (_) {
                                setState(() {});
                              },
                              onSaved: (value) {
                                _addProduct = Product(
                                    id: _addProduct.id,
                                    title: _addProduct.title,
                                    description: _addProduct.description,
                                    price: _addProduct.price,
                                    imageUrl: value!);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
