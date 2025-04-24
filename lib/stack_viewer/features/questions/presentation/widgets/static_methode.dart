import 'package:url_launcher/url_launcher.dart';

class StaticMethode{
  static   Future<void> launchUrlMethode(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }


  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

}