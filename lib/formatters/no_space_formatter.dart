import 'package:flutter/services.dart';

/// Memblokir dan menghapus setiap input spasi dari pengguna.
/// Berguna untuk form seperti Username, Email, atau Password.
class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains(' ')) {
      final String text = newValue.text.replaceAll(' ', '');

      // Mengembalikan kursor ke posisi yang tepat setelah spasi dihapus
      int spacesBeforeSelection = 0;
      for (
        int i = 0;
        i < newValue.selection.end && i < newValue.text.length;
        i++
      ) {
        if (newValue.text[i] == ' ') spacesBeforeSelection++;
      }

      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(
          offset: (newValue.selection.end - spacesBeforeSelection).clamp(
            0,
            text.length,
          ),
        ),
      );
    }
    return newValue;
  }
}
