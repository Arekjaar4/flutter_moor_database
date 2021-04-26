import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

import 'product_with_images.dart';

export 'database/shared.dart';

part 'database.g.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get price => text()();
  TextColumn get description => text()();
}

@DataClassName('ProductsEntry')
class ProductsEntries extends Table {
  IntColumn get product => integer()();
  IntColumn get item => integer()();
}
class ImagesProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get image => text()();
}
@UseMoor(tables: [Products, ImagesProducts, ProductsEntries])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // Queries
  Future<List<Product>> getAllProducts() => select(products).get();

  Future insertProduct(Product product) => into(products).insert(product);

  // Update user
  Future updateProduct(Product product) => update(products).replace(product);

  // Delete user
  Future deleteProduct(Product product) => delete(products).delete(product);

  Future<List<ImagesProduct>> getAllImagesProduct() => select(imagesProducts).get();

  // Add user
  Future insertImagesProduct(ImagesProduct imagesProduct) => into(imagesProducts).insert(imagesProduct);

  // Update user
  Future updateImagesProduct(ImagesProduct imagesProduct) => update(imagesProducts).replace(imagesProduct);

  // Delete user
  Future deleteImagesProduct(ImagesProduct imagesProduct) => delete(imagesProducts).delete(imagesProduct);

  Future<void> writeProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;

      var productID = await into(products).insert(product, mode: InsertMode.replace);

      await (delete(productsEntries)
        ..where((entry) => entry.product.equals(product.id)))
          .go();

      var imageId;
      for (final item in entry.imagesProduct) {
        imageId = await into(imagesProducts).insert(item);
        await into(productsEntries).insert(ProductsEntry(product: productID, item: imageId));
      }
    });
  }
  Future<void> updateWritedProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;

      await update(products).replace(product);
      await (delete(productsEntries)
        ..where((entry) => entry.product.equals(product.id)))
          .go();

      var imageId;
      for (final item in entry.imagesProduct) {
        if (item.id != null) {
          await update(imagesProducts).replace(item);
          imageId = item.id;
        } else {
          imageId = await into(imagesProducts).insert(item);
        }
        await into(productsEntries).insert(ProductsEntry(product: product.id, item: imageId));
      }
    });
  }
  Future<void> removeProduct(ProductWithImages entry) {
    return transaction(() async {
      final product = entry.product;
      for (final item in entry.imagesProduct) {
        await delete(imagesProducts).delete(item);
      }
      await (delete(productsEntries)
        ..where((entry) => entry.product.equals(product.id)))
          .go();
      await delete(products).delete(product);
    });
  }
  Stream<List<ProductWithImages>> watchAllProducts() {
    final productStream = select(products).watch();
    return productStream.switchMap((imagesProduct) {
      final idToProduct = {for (var image in imagesProduct) image.id: image};
      final ids = idToProduct.keys;

      final entryQuery = select(productsEntries).join(
        [
          innerJoin(
            imagesProducts,
            imagesProducts.id.equalsExp(productsEntries.item),
          )
        ],
      )..where(productsEntries.product.isIn(ids));

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