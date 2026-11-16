import 'dart:convert';
import 'dart:io';

Future<String> fetchText(Uri uri) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 15);
  try {
    final request = await client
        .getUrl(uri)
        .timeout(const Duration(seconds: 15));
    final response = await request.close().timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) throw const HttpException('Veri alınamadı');
    return await response
        .transform(utf8.decoder)
        .join()
        .timeout(const Duration(seconds: 15));
  } finally {
    client.close(force: true);
  }
}
