import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_database/database/database.dart';
import 'package:flutter_app_database/database/product_with_images.dart';

MyDatabase db;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.db}) : super(key: key);

  final title;
  final db;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var context;
  Stream<List<ProductWithImages>> products;


  void _addProduct([ProductWithImages productWithImages]) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var name;
          var price;
          var description;
          ImagesProduct image;
          List<ImagesProduct> availableColours = [];
          if (productWithImages != null) {
            name = productWithImages.product.name;
            price = productWithImages.product.price;
            description = productWithImages.product.description;
            availableColours = productWithImages.imagesProduct;
          }
          var firstTimeName = true;
          var firstTimePrice = true;
          var firstTimeDescription = true;
          var firstTimeImage = true;
          bool _isButtonDisabled = true;
          var _controller = TextEditingController();
          return AlertDialog(content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            bool isButtonDisabled() {
              return image == null ||
                  image.image.isEmpty ||
                  !image.image.startsWith('http');
            }

            return Stack(
              children: <Widget>[
                Container(
                    width: 300,
                    child: SingleChildScrollView(
                        child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Nombre del producto',
                                  labelText: 'Nombre',
                                ),
                                initialValue: name,
                                onChanged: (String value) {
                                  firstTimeName = false;
                                },
                                onSaved: (String value) {
                                  name = value;
                                },
                                validator: (String value) {
                                  return (value.isEmpty && !firstTimeName)
                                      ? 'Campo obligatorio'
                                      : null;
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Precio del producto',
                                  labelText: 'Precio',
                                ),
                                initialValue: price,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[.,0-9]')),
                                ],
                                onChanged: (String value) {
                                  firstTimePrice = false;
                                },
                                onSaved: (String value) {
                                  price =
                                      double.parse(value).toStringAsFixed(2);
                                },
                                validator: (String value) {
                                  return (value.isEmpty && !firstTimePrice)
                                      ? 'Campo obligatorio'
                                      : null;
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Descripción del producto',
                                  labelText: 'Descripción',
                                ),
                                initialValue: description,
                                onChanged: (String value) {
                                  firstTimeDescription = false;
                                },
                                onSaved: (String value) {
                                  description = value;
                                },
                                validator: (String value) {
                                  return (value.isEmpty &&
                                          !firstTimeDescription)
                                      ? 'Campo obligatorio'
                                      : null;
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    hintText: 'Url de la imagen del producto',
                                    labelText: 'Imagen',
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: _isButtonDisabled
                                            ? null
                                            : () {
                                                setState(() {
                                                  availableColours.add(image);
                                                  image = null;
                                                  _controller.clear();
                                                  firstTimeImage = true;
                                                  _isButtonDisabled = true;
                                                });
                                              })),
                                onChanged: (String value) {
                                  firstTimeImage = false;
                                  image = new ImagesProduct(image: value);
                                  setState(() {
                                    _isButtonDisabled = isButtonDisabled();
                                  });
                                },
                                validator: (String value) {
                                  return firstTimeImage
                                      ? null
                                      : value.isEmpty &&
                                              availableColours.isEmpty
                                          ? 'Campo obligatorio'
                                          : value.isNotEmpty &&
                                                  !value.startsWith('http')
                                              ? 'Introduce una url valida'
                                              : value.isNotEmpty &&
                                                      value.startsWith('http')
                                                  ? 'Clica en + para añadir la imagen'
                                                  : null;
                                }),
                          ),
                          if (availableColours.isNotEmpty)
                            Container(
                                height: 100.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 16.0),
                                  itemBuilder: /*1*/ (context, i) {
                                    final index = i; /*3*/
                                    if (availableColours == null ||
                                        index >= availableColours.length) {
                                      return null;
                                    }
                                    return Container(
                                      width: 80,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                            availableColours[index].image,
                                          ),
                                        ),
                                      ),
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                          right: 0.0,
                                          top: 0.0,
                                          child: IconButton(
                                            icon: Icon(Icons.clear),
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                availableColours
                                                    .removeAt(index);
                                              });
                                            },
                                          ),
                                        )
                                      ]),
                                    );
                                  },
                                )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Guardar"),
                              onPressed: () {
                                firstTimeName = false;
                                firstTimePrice = false;
                                firstTimeDescription = false;
                                firstTimeImage = false;
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() {
                                    var product;
                                    if (productWithImages == null) {
                                      product = new Product(
                                          name: name,
                                          price: price,
                                          description: description);
                                      var newProductWithImages =
                                          new ProductWithImages(
                                              product, availableColours);
                                      db.writeProduct(newProductWithImages);
                                    } else {
                                      product = new Product(
                                          id: productWithImages.product.id,
                                          name: name,
                                          price: price,
                                          description: description);
                                      var updateProductWithImages =
                                          new ProductWithImages(
                                              product, availableColours);
                                      db.updateWritedProduct(
                                          updateProductWithImages);
                                    }
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ))),
              ],
            );
          }));
        });
  }

  Widget _buildCards(ProductWithImages productWithImages) {
    Product product = productWithImages.product;
    List<ImagesProduct> imagesProduct = productWithImages.imagesProduct;
    var colourAvailableSelected =
        imagesProduct.isNotEmpty ? imagesProduct[0].image : null;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child:
                        Center(child: Image.network(colourAvailableSelected))),
                ExpandableNotifier(
                    child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                      tapBodyToCollapse: true,
                      headerAlignment: ExpandablePanelHeaderAlignment.center),
                  header: Text(
                    product.name,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  expanded: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Colores dsponibles',
                          style: TextStyle(fontSize: 10),
                        ),
                        Container(
                            height: 100.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0),
                              itemBuilder: /*1*/ (context, i) {
                                final index = i; /*3*/
                                if (imagesProduct == null ||
                                    index >= imagesProduct.length) {
                                  return null;
                                }
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        colourAvailableSelected =
                                            imagesProduct[index].image;
                                      });
                                    },
                                    child: Image.network(
                                      imagesProduct[index].image,
                                      width: 80,
                                    ));
                              },
                            ))
                      ]),
                )),
                Text(product.description,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(product.price + '€',
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        _addProduct(productWithImages);
                      },
                      child: Text('Edit'),
                      style: TextButton.styleFrom(primary: Colors.orangeAccent),
                    ),
                    TextButton(
                        onPressed: () async {
                          await db.removeProduct(productWithImages);
                        },
                        child: Text('Remove'),
                        style: TextButton.styleFrom(primary: Colors.redAccent))
                  ],
                )
              ],
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    db = widget.db;
    this.context = context;
    products = db.watchAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OrientationBuilder(builder: (context, or) {
        int cac = (or == Orientation.portrait) ? 2 : 4;
        return StreamBuilder<List<ProductWithImages>>(
            stream: products,
            builder: (context, snapshot) {
              final List<ProductWithImages> products = snapshot.data ?? [];
              return GridView.count(
                crossAxisCount: cac,
                childAspectRatio: (1 / 1.5),
                children: List.generate(products.length, (index) {
                  return _buildCards(products[index]);
                }),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        tooltip: 'Añadir elemento',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
