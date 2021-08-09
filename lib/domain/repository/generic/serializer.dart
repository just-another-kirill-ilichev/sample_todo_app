typedef Map<String, dynamic> ItemSerializer<T>(T item);
typedef T ItemDeserializer<T>(Map<String, dynamic> itemData);

class Serializer<T> {
  final ItemSerializer<T> _itemSerializer;
  final ItemDeserializer<T> _itemDeserializer;

  Serializer(this._itemSerializer, this._itemDeserializer);

  Map<String, dynamic> serializeSingle(T item) => _itemSerializer(item);

  List<Map<String, dynamic>> serializeMany(List<T> items) =>
      items.map((e) => serializeSingle(e)).toList();

  T deserializeSingle(Map<String, dynamic> itemData) =>
      _itemDeserializer(itemData);

  List<T> deserializeMany(List<Map<String, dynamic>> itemsData) =>
      itemsData.map((e) => deserializeSingle(e)).toList();
}
