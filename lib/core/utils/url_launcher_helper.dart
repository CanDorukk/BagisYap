import 'package:url_launcher/url_launcher.dart' as launcher;

/// URL açma işlemleri için yardımcı sınıf.
class UrlLauncherHelper {
  UrlLauncherHelper._();

  /// Verilen [url] adresini varsayılan tarayıcıda açar.
  static Future<bool> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    try {
      return await launcher.launchUrl(
        uri,
        mode: launcher.LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }
}
