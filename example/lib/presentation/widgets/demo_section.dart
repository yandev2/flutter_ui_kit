import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/theme/theme.dart';
import 'package:flutter_ui_kit/theme/scale.dart';

/// Reusable wrapper for each demo section.
/// Shows a title, description, optional rules, and the live widget demo.
class DemoSection extends StatelessWidget {
  final String title;
  final String description;
  final List<String>? rules;
  final String? codeSnippet;
  final Widget child;
  final GlobalKey? sectionKey;

  const DemoSection({
    super.key,
    required this.title,
    required this.description,
    this.rules,
    this.codeSnippet,
    required this.child,
    this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      margin: EdgeInsets.only(bottom: AppScale.h(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Title ──
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppScale.w(16),
              vertical: AppScale.h(12),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.08),
                  AppColors.primary.withValues(alpha: 0.0),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppScale.r(12)),
                topRight: Radius.circular(AppScale.r(12)),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: AppScale.w(4),
                  height: AppScale.h(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppScale.r(2)),
                  ),
                ),
                SizedBox(width: AppScale.w(10)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: AppScale.sp(20),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppScale.h(12)),

          // ── Description ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppScale.w(16)),
            child: Text(
              description,
              style: TextStyle(
                fontSize: AppScale.sp(14),
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),

          // ── Rules (optional) ──
          if (rules != null && rules!.isNotEmpty) ...[
            SizedBox(height: AppScale.h(12)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppScale.w(16)),
              padding: EdgeInsets.all(AppScale.w(12)),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppScale.r(8)),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: AppScale.sp(16),
                        color: AppColors.info,
                      ),
                      SizedBox(width: AppScale.w(6)),
                      Text(
                        'Design Rules',
                        style: TextStyle(
                          fontSize: AppScale.sp(12),
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppScale.h(8)),
                  ...rules!.map(
                    (rule) => Padding(
                      padding: EdgeInsets.only(bottom: AppScale.h(4)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: AppScale.sp(13),
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              rule,
                              style: TextStyle(
                                fontSize: AppScale.sp(13),
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Code Snippet (optional) ──
          if (codeSnippet != null && codeSnippet!.isNotEmpty) ...[
            SizedBox(height: AppScale.h(12)),
            _DemoCodeBlock(code: codeSnippet!),
          ],

          SizedBox(height: AppScale.h(16)),

          // ── Live Demo ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppScale.w(16)),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Inline code block widget for displaying usage snippets.
class _DemoCodeBlock extends StatelessWidget {
  final String code;

  const _DemoCodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppScale.w(16)),
      padding: EdgeInsets.all(AppScale.w(14)),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(AppScale.r(10)),
        border: Border.all(
          color: const Color(0xFF313244),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableText(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: AppScale.sp(12),
            color: const Color(0xFFCDD6F4),
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
