import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopGridItem extends StatelessWidget {
  final String imagePath;
  final String price;
  final bool isOwned; // Menentukan apakah item sudah dimiliki
  final VoidCallback? onTap;

  const ShopGridItem({
    super.key,
    required this.imagePath,
    required this.price,
    this.isOwned = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, color: Colors.grey, size: 40);
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Tampilkan tombol 'Pakai' atau harga
              isOwned
                  ? _buildEquipButton()
                  : _buildPriceTag(price),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan tombol "Pakai"
  Widget _buildEquipButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF78B96A), // Warna hijau
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Pakai',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget untuk menampilkan harga
  Widget _buildPriceTag(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEA8538),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            price,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
