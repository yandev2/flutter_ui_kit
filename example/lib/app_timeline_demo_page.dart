import 'package:flutter/material.dart';
import 'package:ui_component_flutter/ui_component_flutter.dart';

class AppTimelineDemoPage extends StatefulWidget {
  const AppTimelineDemoPage({super.key});

  @override
  State<AppTimelineDemoPage> createState() => _AppTimelineDemoPageState();
}

class _AppTimelineDemoPageState extends State<AppTimelineDemoPage> {
  bool _isLoading = false;
  Axis _direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Timeline',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: context.uiTheme.onPrimary,
                fontSize: size(20),
              ),
        ),
        backgroundColor: context.uiTheme.primary,
        iconTheme: IconThemeData(color: context.uiTheme.onPrimary),
        actions: [
          IconButton(
            tooltip: 'Toggle Skeleton',
            icon: Icon(
              _isLoading ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
          ),
          IconButton(
            tooltip: 'Toggle Direction',
            icon: Icon(
              _direction == Axis.vertical
                  ? Icons.horizontal_distribute
                  : Icons.vertical_align_bottom,
            ),
            onPressed: () {
              setState(() {
                _direction = _direction == Axis.vertical
                    ? Axis.horizontal
                    : Axis.vertical;
              });
            },
          ),
        ],
      ),
      backgroundColor: context.uiTheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Status',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: size(24)),
            AppTimeline(
              direction: _direction,
              isLoading: _isLoading,
              nodes: [
                const AppTimelineNode(
                  title: 'Pesanan Dibuat',
                  subtitle: '12 Agt 2026, 10:00 WIB',
                  status: TimelineStatus.completed,
                ),
                const AppTimelineNode(
                  title: 'Pembayaran Dikonfirmasi',
                  subtitle: '12 Agt 2026, 10:15 WIB',
                  status: TimelineStatus.completed,
                ),
                AppTimelineNode(
                  title: 'Pesanan Diproses',
                  subtitle: 'Sedang dikemas',
                  status: TimelineStatus.active,
                  isHighlighted: true,
                  content: AppButton(
                    text: 'Lacak Lokasi',
                    size: AppButtonSize.small,
                    onPressed: () {},
                  ),
                ),
                const AppTimelineNode(
                  title: 'Dalam Pengiriman',
                  subtitle: 'Estimasi tiba hari ini',
                  status: TimelineStatus.inactive,
                ),
                const AppTimelineNode(
                  title: 'Pesanan Diterima',
                  status: TimelineStatus.disabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
