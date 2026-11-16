import 'dart:js_interop';

@JS('fetch')
external JSPromise<_Response> _fetch(JSString url);

extension type _Response(JSObject _) implements JSObject {
  external bool get ok;
  external JSPromise<JSString> text();
}

Future<String> fetchText(Uri uri) async {
  final response = await _fetch(
    uri.toString().toJS,
  ).toDart.timeout(const Duration(seconds: 15));
  if (!response.ok) throw Exception('Veri alınamadı');
  return (await response.text().toDart.timeout(
    const Duration(seconds: 15),
  )).toDart;
}
