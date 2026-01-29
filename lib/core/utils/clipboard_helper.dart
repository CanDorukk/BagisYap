import 'package:flutter/services.dart';

/// Pano işlemleri için yardımcı sınıf.
class ClipboardHelper {
  ClipboardHelper._();

  /// Metni panoya kopyalar.
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// Panodan metin okur.
  static Future<String?> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}
