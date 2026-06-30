import 'package:flutter/services.dart';

/// Formatter khusus untuk masa berlaku Kartu Kredit / Debit (Format: MM/YY).
/// Akan otomatis memblokir nomor bulan tidak valid (misal mengubah `13` menjadi `12`),
/// serta otomatis menyisipkan simbol garis miring `/`.
class CardExpiryFormatter extends TextInputFormatter {
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

    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < cleanText.length; i++) {
      if (i == 0 && int.parse(cleanText[i]) > 1) {
        // Jika angka pertama > 1 (misal 2..9), otomatis beri awalan 0 dan slash
        buffer.write('0');
        buffer.write(cleanText[i]);
        buffer.write('/');
      } else if (i == 1) {
        // Validasi batasan bulan maksimal 12
        int month = int.parse(cleanText.substring(0, 2));
        if (month == 0) {
          buffer.write('1'); // Paksa 00 menjadi 01
        } else if (month > 12) {
          buffer.write(
            '2',
          ); // Jika bulan > 12, turunkan digit keduanya menjadi 2 (sehingga jadi 12)
        } else {
          buffer.write(cleanText[i]);
        }

        // Pasang pemisah tahun
        if (cleanText.length > 2) {
          buffer.write('/');
        }
      } else if (i < 4) {
        // Hanya tampung maksimal 4 digit murni (2 digit bulan + 2 digit tahun)
        buffer.write(cleanText[i]);
      }
    }

    final result = buffer.toString();
    return newValue.copyWith(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}
