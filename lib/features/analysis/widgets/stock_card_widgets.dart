import 'package:flutter/material.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:saifsyn/features/analysis/data/model/analysis_response_model.dart';

class StockCardWidget extends StatelessWidget {
  final AnalysisItemModel stock;
  final VoidCallback? onTap;

  const StockCardWidget({super.key, required this.stock, this.onTap});

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = stock.status.trim().toUpperCase();
    final isCompliant = normalizedStatus == 'COMPLIANT';
    final isNonCompliant = normalizedStatus == 'NON_COMPLIANT';
    final statusColor = isCompliant
        ? Colors.green
        : isNonCompliant
            ? Colors.red
            : Colors.white;
    final statusLabel = isCompliant
        ? 'Halal'
        : isNonCompliant
            ? 'Non Halal'
            : '';
    const cardColor = Color(0xff0A0A8F);
    const titleColor = Colors.white;
    const subtitleColor = Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    stock.symbol,
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _statusBadge(normalizedStatus, statusColor),
                  const Spacer(),
                  if (isCompliant || isNonCompliant)
                    Row(
                      children: [
                        Image.asset(
                          ImagePath.premiumComplete,
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                          color: statusColor,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          statusLabel,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                stock.name,
                style: TextStyle(
                  color: subtitleColor,
                ),
              ),
              if (stock.note.trim().isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  'Note: ${stock.note}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status, Color statusColor) {
    final text = status.isEmpty ? 'UNKNOWN' : status;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.2),
        border: Border.all(color: statusColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
