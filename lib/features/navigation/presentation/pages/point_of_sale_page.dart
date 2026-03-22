import 'package:flutter/material.dart';
import 'package:nativus_pos_desktop/application/theme/theme.dart';
import 'package:nativus_pos_desktop/l10n/app_localizations.dart';

class PointOfSalePage extends StatelessWidget {
  const PointOfSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;
    final isCompact = MediaQuery.sizeOf(context).width < 1180;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colorScheme.softBorder),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.exampleEyebrow,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.accentPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.pointOfSaleExampleTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.pointOfSaleExampleDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _MetricCard(
                title: localizations.pointOfSaleMetricSales,
                value: '152',
                color: colorScheme.accentPrimary,
              ),
              _MetricCard(
                title: localizations.pointOfSaleMetricRevenue,
                value: '\$4,280',
                color: const Color(0xFF47C98B),
              ),
              _MetricCard(
                title: localizations.pointOfSaleMetricTables,
                value: '18',
                color: const Color(0xFF6DA7FF),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Flex(
              direction: isCompact ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _Panel(
                    title: localizations.pointOfSaleRecentOrders,
                    child: Column(
                      children: [
                        _OrderRow(
                          orderCode: '#1082',
                          customer: localizations.pointOfSaleOrderTable4,
                          total: '\$42.00',
                          status: localizations.orderStatusPaid,
                        ),
                        _OrderRow(
                          orderCode: '#1081',
                          customer: localizations.pointOfSaleOrderCounter,
                          total: '\$18.50',
                          status: localizations.orderStatusPending,
                        ),
                        _OrderRow(
                          orderCode: '#1080',
                          customer: localizations.pointOfSaleOrderTable2,
                          total: '\$63.40',
                          status: localizations.orderStatusPreparing,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: isCompact ? 0 : 18, height: isCompact ? 18 : 0),
                Expanded(
                  flex: 5,
                  child: _Panel(
                    title: localizations.pointOfSaleQuickActions,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ActionTile(
                          icon: Icons.add_shopping_cart_rounded,
                          label: localizations.pointOfSaleNewSale,
                        ),
                        const SizedBox(height: 12),
                        _ActionTile(
                          icon: Icons.receipt_long_rounded,
                          label: localizations.pointOfSaleViewTickets,
                        ),
                        const SizedBox(height: 12),
                        _ActionTile(
                          icon: Icons.table_bar_rounded,
                          label: localizations.pointOfSaleAssignTable,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.insights_rounded, color: color, size: 22),
          const SizedBox(height: 18),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.textMuted,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.darkSurfaceAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  const _OrderRow({
    required this.orderCode,
    required this.customer,
    required this.total,
    required this.status,
  });

  final String orderCode;
  final String customer;
  final String total;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderCode,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.baseWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customer,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.textMuted,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            total,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.baseWhite,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.accentPrimary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              status,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.accentPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.darkSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.softBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colorScheme.accentPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: colorScheme.accentPrimary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.baseWhite,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
