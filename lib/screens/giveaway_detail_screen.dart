import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/giveaway.dart';

class GiveawayDetailScreen extends StatelessWidget {
  final Giveaway giveaway;

  const GiveawayDetailScreen({super.key, required this.giveaway});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    if (urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No URL provided for this giveaway.')),
      );
      return;
    }

    final uri = Uri.parse(urlString);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the giveaway link.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(giveaway.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            tooltip: 'Open Giveaway',
            onPressed: () => _launchUrl(context, giveaway.openGiveawayUrl),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () => _launchUrl(context, giveaway.openGiveawayUrl),
            icon: const Icon(Icons.card_giftcard),
            label: Text(
              giveaway.worth != 'N/A' && giveaway.worth.isNotEmpty
                  ? 'Claim Giveaway (Worth ${giveaway.worth})'
                  : 'Claim Free Giveaway',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            CachedNetworkImage(
              imageUrl: giveaway.image.isNotEmpty ? giveaway.image : giveaway.thumbnail,
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 230,
                color: colorScheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 230,
                color: colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image, size: 60),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    giveaway.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Chips row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.local_offer, size: 16),
                        label: Text(
                          giveaway.worth != 'N/A' && giveaway.worth.isNotEmpty
                              ? 'Worth: ${giveaway.worth}'
                              : '100% Free',
                        ),
                        backgroundColor: colorScheme.primaryContainer,
                        labelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
                      ),
                      Chip(
                        avatar: const Icon(Icons.category, size: 16),
                        label: Text(giveaway.type),
                      ),
                      Chip(
                        avatar: const Icon(Icons.check_circle_outline, size: 16),
                        label: Text(giveaway.status),
                        backgroundColor: Colors.green.withValues(alpha: 0.15),
                        labelStyle: const TextStyle(color: Colors.green),
                      ),
                      if (giveaway.users > 0)
                        Chip(
                          avatar: const Icon(Icons.people_outline, size: 16),
                          label: Text('${giveaway.users} Claimed'),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Metadata summary
                  _buildInfoRow(
                    context,
                    icon: Icons.devices,
                    label: 'Platforms',
                    value: giveaway.platforms,
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Published',
                    value: giveaway.publishedDate.isNotEmpty ? giveaway.publishedDate : 'N/A',
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    context,
                    icon: Icons.timer_outlined,
                    label: 'End Date',
                    value: giveaway.endDate != 'N/A' ? giveaway.endDate : 'While supplies last',
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    'About Giveaway',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    giveaway.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.85),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Instructions
                  Text(
                    'How to Claim',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      giveaway.instructions.isNotEmpty
                          ? giveaway.instructions
                          : 'Click "Claim Giveaway" below to open the official giveaway page.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
