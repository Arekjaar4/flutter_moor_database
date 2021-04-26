// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String price;
  final String description;
  Product(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.description});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Product(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<String>(price);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<String>(json['price']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<String>(price),
      'description': serializer.toJson<String>(description),
    };
  }

  Product copyWith({int id, String name, String price, String description}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(price.hashCode, description.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.description == this.description);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> price;
  final Value<String> description;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String price,
    @required String description,
  })  : name = Value(name),
        price = Value(price),
        description = Value(description);
  static Insertable<Product> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> price,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
    });
  }

  ProductsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> price,
      Value<String> description}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedTextColumn _price;
  @override
  GeneratedTextColumn get price => _price ??= _constructPrice();
  GeneratedTextColumn _constructPrice() {
    return GeneratedTextColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, price, description];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class ImagesProduct extends DataClass implements Insertable<ImagesProduct> {
  final int id;
  final String image;
  ImagesProduct({@required this.id, @required this.image});
  factory ImagesProduct.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ImagesProduct(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  ImagesProductsCompanion toCompanion(bool nullToAbsent) {
    return ImagesProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory ImagesProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ImagesProduct(
      id: serializer.fromJson<int>(json['id']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'image': serializer.toJson<String>(image),
    };
  }

  ImagesProduct copyWith({int id, String image}) => ImagesProduct(
        id: id ?? this.id,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('ImagesProduct(')
          ..write('id: $id, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, image.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ImagesProduct &&
          other.id == this.id &&
          other.image == this.image);
}

class ImagesProductsCompanion extends UpdateCompanion<ImagesProduct> {
  final Value<int> id;
  final Value<String> image;
  const ImagesProductsCompanion({
    this.id = const Value.absent(),
    this.image = const Value.absent(),
  });
  ImagesProductsCompanion.insert({
    this.id = const Value.absent(),
    @required String image,
  }) : image = Value(image);
  static Insertable<ImagesProduct> custom({
    Expression<int> id,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (image != null) 'image': image,
    });
  }

  ImagesProductsCompanion copyWith({Value<int> id, Value<String> image}) {
    return ImagesProductsCompanion(
      id: id ?? this.id,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesProductsCompanion(')
          ..write('id: $id, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $ImagesProductsTable extends ImagesProducts
    with TableInfo<$ImagesProductsTable, ImagesProduct> {
  final GeneratedDatabase _db;
  final String _alias;
  $ImagesProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, image];
  @override
  $ImagesProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'images_products';
  @override
  final String actualTableName = 'images_products';
  @override
  VerificationContext validateIntegrity(Insertable<ImagesProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImagesProduct map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ImagesProduct.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ImagesProductsTable createAlias(String alias) {
    return $ImagesProductsTable(_db, alias);
  }
}

class ProductsEntry extends DataClass implements Insertable<ProductsEntry> {
  final int product;
  final int item;
  ProductsEntry({@required this.product, @required this.item});
  factory ProductsEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return ProductsEntry(
      product:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product']),
      item: intType.mapFromDatabaseResponse(data['${effectivePrefix}item']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || product != null) {
      map['product'] = Variable<int>(product);
    }
    if (!nullToAbsent || item != null) {
      map['item'] = Variable<int>(item);
    }
    return map;
  }

  ProductsEntriesCompanion toCompanion(bool nullToAbsent) {
    return ProductsEntriesCompanion(
      product: product == null && nullToAbsent
          ? const Value.absent()
          : Value(product),
      item: item == null && nullToAbsent ? const Value.absent() : Value(item),
    );
  }

  factory ProductsEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductsEntry(
      product: serializer.fromJson<int>(json['product']),
      item: serializer.fromJson<int>(json['item']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product': serializer.toJson<int>(product),
      'item': serializer.toJson<int>(item),
    };
  }

  ProductsEntry copyWith({int product, int item}) => ProductsEntry(
        product: product ?? this.product,
        item: item ?? this.item,
      );
  @override
  String toString() {
    return (StringBuffer('ProductsEntry(')
          ..write('product: $product, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(product.hashCode, item.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductsEntry &&
          other.product == this.product &&
          other.item == this.item);
}

class ProductsEntriesCompanion extends UpdateCompanion<ProductsEntry> {
  final Value<int> product;
  final Value<int> item;
  const ProductsEntriesCompanion({
    this.product = const Value.absent(),
    this.item = const Value.absent(),
  });
  ProductsEntriesCompanion.insert({
    @required int product,
    @required int item,
  })  : product = Value(product),
        item = Value(item);
  static Insertable<ProductsEntry> custom({
    Expression<int> product,
    Expression<int> item,
  }) {
    return RawValuesInsertable({
      if (product != null) 'product': product,
      if (item != null) 'item': item,
    });
  }

  ProductsEntriesCompanion copyWith({Value<int> product, Value<int> item}) {
    return ProductsEntriesCompanion(
      product: product ?? this.product,
      item: item ?? this.item,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (product.present) {
      map['product'] = Variable<int>(product.value);
    }
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsEntriesCompanion(')
          ..write('product: $product, ')
          ..write('item: $item')
          ..write(')'))
        .toString();
  }
}

class $ProductsEntriesTable extends ProductsEntries
    with TableInfo<$ProductsEntriesTable, ProductsEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsEntriesTable(this._db, [this._alias]);
  final VerificationMeta _productMeta = const VerificationMeta('product');
  GeneratedIntColumn _product;
  @override
  GeneratedIntColumn get product => _product ??= _constructProduct();
  GeneratedIntColumn _constructProduct() {
    return GeneratedIntColumn(
      'product',
      $tableName,
      false,
    );
  }

  final VerificationMeta _itemMeta = const VerificationMeta('item');
  GeneratedIntColumn _item;
  @override
  GeneratedIntColumn get item => _item ??= _constructItem();
  GeneratedIntColumn _constructItem() {
    return GeneratedIntColumn(
      'item',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [product, item];
  @override
  $ProductsEntriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products_entries';
  @override
  final String actualTableName = 'products_entries';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product'], _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('item')) {
      context.handle(
          _itemMeta, item.isAcceptableOrUnknown(data['item'], _itemMeta));
    } else if (isInserting) {
      context.missing(_itemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ProductsEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductsEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsEntriesTable createAlias(String alias) {
    return $ProductsEntriesTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $ImagesProductsTable _imagesProducts;
  $ImagesProductsTable get imagesProducts =>
      _imagesProducts ??= $ImagesProductsTable(this);
  $ProductsEntriesTable _productsEntries;
  $ProductsEntriesTable get productsEntries =>
      _productsEntries ??= $ProductsEntriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [products, imagesProducts, productsEntries];
}
