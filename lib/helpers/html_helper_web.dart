import 'dart:html' as html;

void downloadHtmlContent(String fileName, String content) {
  final blob = html.Blob([content], 'text/html');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
}