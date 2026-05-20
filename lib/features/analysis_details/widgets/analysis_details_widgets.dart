import 'package:flutter/material.dart';

class AnalysisDetailsHeaderWidget extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onFavoriteTap;
  final String symbol;
  final String name;
  final String status;
  final bool isFavorite;
  final bool isFavoriteLoading;

  const AnalysisDetailsHeaderWidget({
    super.key,
    required this.onBackTap,
    required this.onFavoriteTap,
    required this.symbol,
    required this.name,
    required this.status,
    required this.isFavorite,
    required this.isFavoriteLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xff0A0A8F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackTap,
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _FavoriteActionButton(
                isFavorite: isFavorite,
                isLoading: isFavoriteLoading,
                onTap: onFavoriteTap,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            symbol.isEmpty ? 'N/A' : symbol,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name.isEmpty ? 'Unknown Company' : name,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          AnalysisStatusBadge(status: status),
        ],
      ),
    );
  }
}

class _FavoriteActionButton extends StatelessWidget {
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onTap;

  const _FavoriteActionButton({
    required this.isFavorite,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0x22FFFFFF),
            border: Border.all(color: const Color(0x44FFFFFF)),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? const Color(0xFFFF4D67) : Colors.white,
                    size: 22,
                  ),
          ),
        ),
      ),
    );
  }
}

class AnalysisStatusBadge extends StatelessWidget {
  final String status;

  const AnalysisStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.trim().toUpperCase();
    final displayText = normalizedStatus.isEmpty ? 'UNKNOWN' : normalizedStatus;

    Color backgroundColor;
    Color textColor;

    switch (normalizedStatus) {
      case 'COMPLIANT':
        backgroundColor = const Color(0xFFDFF5E7);
        textColor = const Color(0xFF1A7F37);
        break;
      case 'NON_COMPLIANT':
        backgroundColor = const Color(0xFFFDE2E1);
        textColor = const Color(0xFFB42318);
        break;
      default:
        backgroundColor = const Color(0xFFE4E7EC);
        textColor = const Color(0xFF344054);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class AnalysisInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color iconColor;
  final Color iconBackgroundColor;

  const AnalysisInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff0A0A8F),
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
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lightbulb_outline, size: 18, color: iconColor),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value.trim().isEmpty ? 'N/A' : value.trim(),
            style: const TextStyle(
              color: Colors.white,
              height: 1.45,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class AnalysisMetaRow extends StatelessWidget {
  final String label;
  final String value;

  const AnalysisMetaRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value.trim().isEmpty ? 'N/A' : value.trim(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
