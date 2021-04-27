import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

import 'product_with_images.dart';

export 'database/shared.dart';

part 'database.g.dart';

/// Tabla para los productos
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get price => text()();
  TextColumn get description => text()();
}

/// Tabla donde guardamos la vinculación producto - imagen
@DataClassName('ProductsEntry')
class ProductsEntries extends Table {
  IntColumn get product => integer()();
  IntColumn get item => integer()();
}

/// Tabla para guardar las imagenes de los productos
class ImagesProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get image => text()();
}

/// Generamos la database MyDatabase
@UseMoor(tables: [Products, ImagesProducts, ProductsEntries])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Queries
  /// Recuperamos todos los productos
  Future<List<Product>> getAllProducts() => select(products).get();

  /// Introducimos un producto
  Future insertProduct(Product product) => into(products).insert(product);

  /// Modificamos un producto
  Future updateProduct(Product product) => update(products).replace(product);

  /// Eliminamos un producto
  Future deleteProduct(Product product) => delete(products).delete(product);

  /// Recuperamos todas las imagenes
  Future<List<ImagesProduct>> getAllImagesProduct() => select(imagesProducts).get();

  /// Introducimos una imagen
  Future insertImagesProduct(ImagesProduct imagesProduct) => into(imagesProducts).insert(imagesProduct);

  /// Modificamos una imagen
  Future updateImagesProduct(ImagesProduct imagesProduct) => update(imagesProducts).replace(imagesProduct);

  /// Eliminamos una imagen
  Future deleteImagesProduct(ImagesProduct imagesProduct) => delete(imagesProducts).delete(imagesProduct);

  /// Añadimos un producto con sus imagenes
  Future<void> writeProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;

      // Insertamos el producto y recuperamos el id de producto generado
      var productID = await into(products).insert(product);

      var imageId;
      for (final item in entry.imagesProduct) {
        // Guardamos las imagenes
        imageId = await into(imagesProducts).insert(item);
        // Guardamos la vinculación producto - imagen
        await into(productsEntries).insert(ProductsEntry(product: productID, item: imageId));
      }
    });
  }

  /// Modificamos un producto con sus imagenes
  Future<void> updateWritedProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;

      // Modificamos el producto
      await update(products).replace(product);

      // Eliminamos las posibles vinculaciones  del producto
      await (delete(productsEntries)
        ..where((entry) => entry.product.equals(product.id)))
          .go();

      var imageId;
      for (final item in entry.imagesProduct) {
        if (item.id != null) {
          // Sí la imagen ya existia la modificamos
          await update(imagesProducts).replace(item);
          imageId = item.id;
        } else {
          // Sí la imagen es nueva la insertamos
          imageId = await into(imagesProducts).insert(item);
        }
        // Guardamos la vinculación producto - imagen
        await into(productsEntries).insert(ProductsEntry(product: product.id, item: imageId));
      }
    });
  }

  /// Eliminamos un producto con sus imagenes
  Future<void> removeProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;

      // Eliminamos la imagenes vinculadas al producto
      for (final item in entry.imagesProduct) {
        await delete(imagesProducts).delete(item);
      }

      // Eliminamos la vinculación producto - imagen
      await (delete(productsEntries)
        ..where((entry) => entry.product.equals(product.id)))
          .go();

      // Elimiinamos el producto
      await delete(products).delete(product);
    });
  }

  /// Recuperamos todos los productos con sus imagenes
  Stream<List<ProductWithImages>> watchAllProducts() {
    // Recuperamos los productos
    final productStream = select(products).watch();
    return productStream.switchMap((imagesProduct) {
      final idToProduct = {for (var image in imagesProduct) image.id: image};
      // Recuperamos los ids de los productos
      final ids = idToProduct.keys;

      // Recuperamos las imagenes vinculadas a cada producto
      final entryQuery = select(productsEntries).join(
        [
          innerJoin(
            imagesProducts,
            imagesProducts.id.equalsExp(productsEntries.item),
          )
        ],
      )..where(productsEntries.product.isIn(ids));

      // Recorremos las filas resultantes de la query anterior para devolver un array de [ProductWithImages]
      return entryQuery.watch().map((rows) {
        final idToItems = <int, List<ImagesProduct>>{};
        for (var row in rows) {
          final item = row.readTable(imagesProducts);
          final id = row.readTable(productsEntries).product;

          idToItems.putIfAbsent(id, () => []).add(item);
        }

        return [
          for (var id in ids)
            ProductWithImages(idToProduct[id], idToItems[id] ?? []),
        ];
      });
    });
  }

}