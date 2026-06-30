import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class StringExtensionDemoPage extends StatefulWidget {
  const StringExtensionDemoPage({super.key});

  @override
  State<StringExtensionDemoPage> createState() =>
      _StringExtensionDemoPageState();
}

class _StringExtensionDemoPageState extends State<StringExtensionDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'String Extension',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: context.uiTheme.onPrimary),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          _buildSectionTitle(context, '1. Numeric Parsers'),
          _buildFormatDemo(
            context,
            '"15".toIntOrNull()',
            "15".toIntOrNull()?.toString() ?? 'null',
          ),
          _buildFormatDemo(
            context,
            '"abc".toInt(defaultValue: 7)',
            "abc".toInt(defaultValue: 7).toString(),
          ),

          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '2. Case Manipulators'),
          _buildFormatDemo(
            context,
            '"hello".capitalize()',
            "hello".capitalize(),
          ),
          _buildFormatDemo(
            context,
            '"hello world flutter".toTitleCase()',
            "hello world flutter".toTitleCase(),
          ),
          _buildFormatDemo(
            context,
            '"hello world".toCamelCase()',
            "hello world".toCamelCase(),
          ),
          _buildFormatDemo(
            context,
            '"HelloWorldFlutter".toSnakeCase()',
            "HelloWorldFlutter".toSnakeCase(),
          ),
          _buildFormatDemo(
            context,
            '"HelloWorldFlutter".toKebabCase()',
            "HelloWorldFlutter".toKebabCase(),
          ),

          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '3. Utility'),
          _buildFormatDemo(
            context,
            '"This is a very long text".truncate(10)',
            "This is a very long text".truncate(10),
          ),
          _buildFormatDemo(
            context,
            '"  hello   world  ".removeWhitespace()',
            "  hello   world  ".removeWhitespace(),
          ),
          _buildFormatDemo(context, '"flutter".reverse()', "flutter".reverse()),

          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '4. Hex Color Parser'),
          ListTile(
            title: Text(
              '"#FF5733".toColor()',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            subtitle: Container(
              height: sizeHeight(40),
              margin: EdgeInsets.only(top: AppSpacing.xs),
              decoration: BoxDecoration(
                color: "#FF5733".toColor(),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          ),

          SizedBox(height: AppSpacing.xl),
          _buildSectionTitle(context, '5. Validators'),
          _buildFormatDemo(
            context,
            '"test@email.com".isEmail',
            "test@email.com".isEmail.toString(),
            color: "test@email.com".isEmail
                ? context.uiTheme.success
                : context.uiTheme.error,
          ),
          _buildFormatDemo(
            context,
            '"helloworld123".isAlphabet',
            "helloworld123".isAlphabet.toString(),
            color: "helloworld123".isAlphabet
                ? context.uiTheme.success
                : context.uiTheme.error,
          ),
          _buildFormatDemo(
            context,
            '"https://flutter.dev".isUrl',
            "https://flutter.dev".isUrl.toString(),
            color: "https://flutter.dev".isUrl
                ? context.uiTheme.success
                : context.uiTheme.error,
          ),
          _buildFormatDemo(
            context,
            '"WeakPass".isStrongPassword',
            "WeakPass".isStrongPassword.toString(),
            color: "WeakPass".isStrongPassword
                ? context.uiTheme.success
                : context.uiTheme.error,
          ),
          _buildFormatDemo(
            context,
            '"StrongP@ssw0rd".isStrongPassword',
            "StrongP@ssw0rd".isStrongPassword.toString(),
            color: "StrongP@ssw0rd".isStrongPassword
                ? context.uiTheme.success
                : context.uiTheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: context.uiTheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFormatDemo(
    BuildContext context,
    String label,
    String value, {
    Color? color,
  }) {
    return Card(
      color: context.uiTheme.surface,
      elevation: 0,
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: context.uiTheme.borderColor),
      ),
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.labelMedium),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: color ?? context.uiTheme.success,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
