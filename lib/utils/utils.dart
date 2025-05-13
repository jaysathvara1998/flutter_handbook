import 'package:html/parser.dart' as html_parser;

class Utils {
  static String htmlToPlainText(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }
}
