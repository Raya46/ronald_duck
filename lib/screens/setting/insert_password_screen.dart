import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronald_duck/screens/parent/parent_dashboard_screen.dart';

class InsertPassword extends StatefulWidget {
  const InsertPassword({super.key});

  @override
  State<InsertPassword> createState() => _InsertPasswordState();
}

class _InsertPasswordState extends State<InsertPassword> {
  @override
  Widget build(BuildContext context) {
    // Warna-warna dari desain
    const Color secondaryColor = Color(0xFFF3D06E);
    const Color contentBgColor = Color(0xFFF9E08B);
    const Color headerColor = Color(0xFFF39237);
    const Color fieldColor = Color(0xFFFEF8E7);
    const Color textDarkColor = Color(0xFF6B4F2C);

    return Scaffold(
      // backgroundColor dihapus karena akan tertutup oleh gambar
      body: Stack(
        children: [
          // --- PENAMBAHAN BACKGROUND ---
          Image.asset(
            'assets/images/bg-pattern.png', // Pastikan path asset benar
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // --- AKHIR PENAMBAHAN ---

          // Konten utama (kartu password)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Lapisan paling bawah untuk efek 3D
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const SizedBox(height: 180), // Placeholder
                  ),

                  // Kartu utama dengan tepian bergelombang
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: contentBgColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        // TextField untuk Password
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Tulis password',
                            hintStyle: GoogleFonts.poppins(
                              color: textDarkColor.withOpacity(0.7),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: textDarkColor,
                            ),
                            filled: true,
                            fillColor: fieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Tombol Masuk
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParentDashboardScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: fieldColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Masuk',
                              style: GoogleFonts.poppins(
                                color: textDarkColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Header "MASUKKAN PASSWORD"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'MASUKKAN PASSWORD',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
