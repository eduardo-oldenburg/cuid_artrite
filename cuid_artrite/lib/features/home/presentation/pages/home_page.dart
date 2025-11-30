import 'package:flutter/material.dart';
// IMPORTANTE: Importe o arquivo de cores que acabamos de criar
import '../../../../core/theme/app_colors.dart'; 
import '../../../education/presentation/pages/education_page.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Usando a cor centralizada
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),

            const SizedBox(height: 24),

            // Título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Acesso Rápido",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark, // Usando a cor centralizada
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Grid de Botões
            _buildMenuGrid(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary, // Usando a cor centralizada
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
      child: Column(
        children: [
          // Top Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: AppColors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CuidArtrite",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Cuidando de você",
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications, color: AppColors.white),
              ),
            ],
          ),
          
          const SizedBox(height: 30),

          // Card de Status
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Como está hoje?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Nível de Dor: 3",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildMenuGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          // Linha 1
          Row(
            children: [
              Expanded(
                child: _MenuCard(
                  title: "Registrar Dor",
                  icon: Icons.priority_high,
                  color: AppColors.cardRedBg,       // Usando AppColors
                  iconColor: AppColors.cardRedIcon, // Usando AppColors
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MenuCard(
                  title: "Técnicas de Alívio",
                  icon: Icons.spa,
                  color: AppColors.cardBlueBg,
                  iconColor: AppColors.cardBlueIcon,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Linha 2
          Row(
            children: [
              Expanded(
                child: _MenuCard(
                  title: "Diário",
                  icon: Icons.book,
                  color: AppColors.cardGreenBg,
                  iconColor: AppColors.cardGreenIcon,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MenuCard(
                  title: "Relatórios",
                  icon: Icons.show_chart,
                  color: AppColors.cardPurpleBg,
                  iconColor: AppColors.cardPurpleIcon,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Centralizado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: _MenuCard(
                  title: "Conteúdo Educativo",
                  icon: Icons.school,
                  color: AppColors.cardOrangeBg,
                  iconColor: AppColors.cardOrangeIcon,
                  onTap: () {
                    // Adicione esta navegação
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EducationPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// O widget _MenuCard continua igual ao anterior, 
// pois ele apenas recebe as cores que passamos acima.
class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: iconColor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}