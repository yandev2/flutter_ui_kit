import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppFileUploadDemoPage extends StatefulWidget {
  const AppFileUploadDemoPage({super.key});

  @override
  State<AppFileUploadDemoPage> createState() => _AppFileUploadDemoPageState();
}

class _AppFileUploadDemoPageState extends State<AppFileUploadDemoPage> {
  String? _selectedFilePath;
  String? _selectedPdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App File Upload',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: context.uiTheme.onPrimary,
            fontSize: size(20),
          ),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            AppFileUpload(
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
