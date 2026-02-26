import '../../application/extensions/hardcoded_string_extension.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

Future<void> launchUrl(String goUrl) async {
  final Uri url = Uri.parse(goUrl);

  if (!await ul.launchUrl(url, mode: ul.LaunchMode.externalApplication)) {
    throw Exception('Can`t open the url: $url'.hardcoded);
  }
}
