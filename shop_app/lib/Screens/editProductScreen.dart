import 'package:flutter/material.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:provider/provider.dart';
import '../Providers/products_provider.dart';

class editProductScreen extends StatefulWidget {
  static String routeName = "/edit-product";
  const editProductScreen({super.key});

  @override
  State<editProductScreen> createState() => _editProductScreenState();
}

class _editProductScreenState extends State<editProductScreen> {
  var _editProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  final _urlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var isLoading = false;
  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) return;
    setState(() {
      isLoading = true;
    });
    _form.currentState?.save();
    try {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final prodId = ModalRoute.of(context)?.settings.arguments.toString();
      _editProduct =
          Provider.of<Products>(context, listen: false).findProdById(prodId!);
      _urlController.text = _editProduct.imageUrl;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
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
                        initialValue: _editProduct.title,
                        decoration: InputDecoration(label: Text("Titile")),
                        validator: (value) {
                          if (value!.isEmpty) return "Please Provide A Title";
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: value!,
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavourite: _editProduct.isFavourite);
                        },
                      ),
                      TextFormField(
                        initialValue: _editProduct.price.toString(),
                        decoration: InputDecoration(label: Text("Price")),
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
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: double.parse(value!),
                              imageUrl: _editProduct.imageUrl,
                              isFavourite: _editProduct.isFavourite);
                        },
                      ),
                      TextFormField(
                        initialValue: _editProduct.description,
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
                          _editProduct = Product(
                              id: _editProduct.id,
                              title: _editProduct.title,
                              description: value!,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl,
                              isFavourite: _editProduct.isFavourite);
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
                              // initialValue: _editProduct.imageUrl,
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
                                _editProduct = Product(
                                    id: _editProduct.id,
                                    title: _editProduct.title,
                                    description: _editProduct.description,
                                    price: _editProduct.price,
                                    imageUrl: value!,
                                    isFavourite: _editProduct.isFavourite);
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
