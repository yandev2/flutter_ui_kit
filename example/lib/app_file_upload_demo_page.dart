import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppFileUploadDemoPage extends StatefulWidget {
  const AppFileUploadDemoPage({super.key});

  @override
  State<AppFileUploadDemoPage> createState() => _AppFileUploadDemoPageState();
}

class _AppFileUploadDemoPageState extends State<AppFileUploadDemoPage> {
  // State untuk varian TextField
  String? _textFieldDocPath;
  String? _textFieldExistingUrl =
      'https://example.com/files/laporan-keuangan-2025.pdf';

  // State untuk varian Card
  String? _selectedFilePath;
  String? _selectedPdfPath;
  String? _updateDocLocalPath;

  Widget _buildSectionTitle(String title, String description) {
    final uiTheme = context.uiTheme;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: size(16),
            color: uiTheme.onBackground,
          ),
        ),
        SizedBox(height: size(4)),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: uiTheme.hintColor,
            fontSize: size(12),
          ),
        ),
        SizedBox(height: size(16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App File Upload',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: size(20),
          ),
        ),
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. VARIAN TEXT FIELD (FORM INPUT COMPACT)
            // ==========================================
            _buildSectionTitle(
              '1. Tipe Text Field (Compact)',
              'Menyerupai komponen TextField: ada hint saat kosong, dan muncul icon cancel saat file dipilih.',
            ),

            // Demo 1.1: Standard Text Field File Upload (Empty -> Pick -> Clear)
            AppFileUpload(
              type: AppFileUploadType.textField,
              title: 'Upload Dokumen / Surat',
              hint: 'Pilih atau upload file dokumen...',
              subtitle: 'Format yang didukung: PDF, DOCX (Maks 10MB)',
              localFilePath: _textFieldDocPath,
              allowedExtensions: const ['pdf', 'docx'],
              onFileSelected: (path) {
                setState(() {
                  _textFieldDocPath = path;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File dipilih: $path')),
                );
              },
              onCancel: () {
                setState(() {
                  _textFieldDocPath = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File dihapus')),
                );
              },
            ),
            SizedBox(height: size(20)),

            // Demo 1.2: Text Field dengan Initial File URL (Existing File)
            AppFileUpload(
              type: AppFileUploadType.textField,
              title: 'Lampiran Kontrak (Existing File)',
              hint: 'Pilih file...',
              subtitle: 'Klik icon silang untuk menghapus file yang ada',
              initialFileUrl: _textFieldExistingUrl,
              allowedExtensions: const ['pdf'],
              onFileSelected: (path) {
                setState(() {
                  _textFieldExistingUrl = path;
                });
              },
              onCancel: () {
                setState(() {
                  _textFieldExistingUrl = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File existing dihapus')),
                );
              },
            ),
            SizedBox(height: size(20)),

            // Demo 1.3: Text Field Read-Only
            const AppFileUpload(
              type: AppFileUploadType.textField,
              title: 'Dokumen Terkunci (Read Only)',
              hint: 'Tidak dapat diubah',
              readOnly: true,
              initialFileUrl: 'https://example.com/berkas-final.pdf',
              prefixIcon: HeroIcons.lockClosed,
            ),

            SizedBox(height: size(36)),
            const Divider(),
            SizedBox(height: size(24)),

            // ==========================================
            // 2. VARIAN CARD (DROPZONE BESAR)
            // ==========================================
            _buildSectionTitle(
              '2. Tipe Card (Dropzone Besar)',
              'Tampilan card dropzone dotted border dengan tombol aksi di bawahnya.',
            ),

            AppFileUpload(
              type: AppFileUploadType.card,
              title: 'Update Document',
              subtitle: 'Replace existing document on server',
              initialFileUrl:
                  'https://example.com/files/employment-contract.pdf',
              localFilePath: _updateDocLocalPath,
              allowedExtensions: const ['pdf', 'docx'],
              onFileSelected: (path) {
                setState(() {
                  _updateDocLocalPath = path;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New file picked: $path')),
                );
              },
              onCancel: () {
                setState(() {
                  _updateDocLocalPath = null;
                });
              },
            ),
            SizedBox(height: size(24)),

            AppFileUpload(
              type: AppFileUploadType.card,
              title: 'Upload Any File',
              subtitle: 'Select any file from your device',
              localFilePath: _selectedFilePath,
              onFileSelected: (path) {
                setState(() {
                  _selectedFilePath = path;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File Selected!')),
                );
              },
              onCancel: () {
                if (_selectedFilePath != null) {
                  setState(() {
                    _selectedFilePath = null;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upload Canceled')),
                  );
                }
              },
            ),
            SizedBox(height: size(24)),

            AppFileUpload(
              type: AppFileUploadType.card,
              title: 'Upload Document',
              subtitle: 'Select PDF or DOCX only',
              allowedExtensions: const ['pdf', 'docx'],
              localFilePath: _selectedPdfPath,
              onFileSelected: (path) {
                setState(() {
                  _selectedPdfPath = path;
                });
                AppDialog.show(
                  context,
                  variant: AppDialogVariant.success,
                  title: 'Success',
                  description: 'Document file selected!',
                );
              },
              onCancel: () {
                setState(() {
                  _selectedPdfPath = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
