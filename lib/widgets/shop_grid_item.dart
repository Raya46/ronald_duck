import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopGridItem extends StatelessWidget {
  final String imagePath;
  final String price;
  final bool isOwned;
  final bool isEquipped;
  final VoidCallback? onTap;

  const ShopGridItem({
    super.key,
    required this.imagePath,
    required this.price,
    this.isOwned = false,
    this.isEquipped = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isEquipped ? 6 : 2, // Higher elevation for equipped items
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isEquipped
                ? const BorderSide(color: Color(0xFF78B96A), width: 2)
                : BorderSide.none, // Green border for equipped items
      ),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Main item image
                    Center(
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 40,
                          );
                        },
                      ),
                    ),
                    // Equipped indicator overlay
                    if (isEquipped)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Color(0xFF78B96A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildButtonOrPrice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonOrPrice() {
    if (isEquipped) {
      return _buildStatusChip('Terpakai', Colors.grey.shade600);
    }
    if (isOwned) {
      return _buildStatusChip('Pakai', const Color(0xFF78B96A));
    }
    return _buildPriceTag(price);
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunito(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPriceTag(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEA8538),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 2),
          Flexible(
            child: Text(
              price,
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
