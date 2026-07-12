import 'dart:io';
import 'dart:typed_data';

void main() {
  final files = ['images/one.jpeg', 'images/two.jpeg', 'images/three.jpeg', 'images/cer.JPG'];
  for (final file in files) {
    final bytes = File(file).readAsBytesSync();
    final dims = getJpegSize(bytes);
    print('$file: ${dims != null ? "${dims[0]}x${dims[1]}" : "unknown"}');
  }
}

List<int>? getJpegSize(Uint8List bytes) {
  if (bytes.length < 4 || bytes[0] != 0xFF || bytes[1] != 0xD8) return null;
  int i = 2;
  while (i < bytes.length - 8) {
    if (bytes[i] != 0xFF) return null;
    int marker = bytes[i + 1];
    if (marker == 0xD9) break; // EOI
    if (marker == 0xC0 || marker == 0xC1 || marker == 0xC2 || marker == 0xC3 ||
        marker == 0xC5 || marker == 0xC6 || marker == 0xC7 || marker == 0xC9 ||
        marker == 0xCA || marker == 0xCB || marker == 0xCD || marker == 0xCE ||
        marker == 0xCF) {
      // SOF marker found
      int height = (bytes[i + 5] << 8) + bytes[i + 6];
      int width = (bytes[i + 7] << 8) + bytes[i + 8];
      return [width, height];
    }
    int length = (bytes[i + 2] << 8) + bytes[i + 3];
    i += length + 2;
  }
  return null;
}
