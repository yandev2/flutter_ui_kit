import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppImageUploadDemoPage extends StatefulWidget {
  const AppImageUploadDemoPage({super.key});

  @override
  State<AppImageUploadDemoPage> createState() => _AppImageUploadDemoPageState();
}

class _AppImageUploadDemoPageState extends State<AppImageUploadDemoPage> {
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Image Upload',
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
            AppImageUpload(
              title: 'Upload Profile Picture',
              subtitle: 'PNG, JPG, or JPEG (Max 5MB)',
              localImagePath: _selectedImagePath,
              onImageSelected: (path) {
                setState(() {
                  _selectedImagePath = path;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image Selected!')),
                );
              },
              onCancel: () {
                if (_selectedImagePath != null) {
                  setState(() {
                    _selectedImagePath = null;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upload Canceled')),
                  );
                }
              },
            ),
            SizedBox(height: size(24)),
            AppImageUpload(
              title: 'Upload Document (Camera Only)',
              subtitle: 'Take a clear photo of your ID card',
              sourceGallery: false,
              primaryButtonText: 'Open Camera',
              onImageSelected: (path) {
                AppDialog.show(
                  context,
                  variant: AppDialogVariant.success,
                  title: 'Success',
                  description: 'Document image captured: $path',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
