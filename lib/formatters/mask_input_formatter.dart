import 'package:flutter/services.dart';

/// Memformat teks secara dinamis berdasarkan pola (mask) yang diberikan.
/// Karakter `#` melambangkan satu digit angka. Karakter lain akan otomatis disisipkan.
/// Sangat berguna untuk form Nomor Telepon, Nomor KTP, NPWP, atau Kartu Kredit.
///
/// Contoh KTP: `MaskInputFormatter(mask: '####-####-####-####')`
/// Contoh NPWP: `MaskInputFormatter(mask: '##.###.###.#-###.###')`
class MaskInputFormatter extends TextInputFormatter {
  final String mask;

  MaskInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // Ekstrak angka murni saja dari hasil pengetikan
    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    int cleanIndex = 0;
    StringBuffer buffer = StringBuffer();

    // Loop melewati pola mask dan tempatkan angka pada posisi '#'
    for (int i = 0; i < mask.length; i++) {
      if (cleanIndex >= cleanText.length) break;

      if (mask[i] == '#') {
        buffer.write(cleanText[cleanIndex]);
        cleanIndex++;
      } else {
        buffer.write(mask[i]);
      }
    }

    String result = buffer.toString();
    return newValue.copyWith(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
