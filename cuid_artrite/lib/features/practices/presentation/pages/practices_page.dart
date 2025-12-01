import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart'; 
import '../../../practices/presentation/pages/breathAndRelax/breathing_techniques_page.dart'; 
import '../../../practices/presentation/pages/stretching_techniques/stretching_techniques_page.dart'; 
import '../../../practices/presentation/pages/lian_gong/lian_gong_page.dart'; 

class ReliefTechniquesPage extends StatelessWidget {
  const ReliefTechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Técnicas de Alívio",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5E81F4), 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // cabeçalho
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Alongamento
                  _TechniqueCard(
                    title: "Alongamentos Guiados",
                    description: "Movimentos suaves e orientados...",
                    duration: "5-15 minutos",
                    icon: Icons.directions_walk,
                    color: const Color(0xFF2962FF),
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StretchingTechniquesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _TechniqueCard(
                    title: "Respiração e Relaxamento",
                    description:
                        "Técnicas de respiração profunda para acalmar a mente e reduzir a tensão. Diminui o estresse e ajuda no controle da dor.",
                    duration: "3-10 minutos",
                    icon: Icons.air,
                    color: const Color(0xFF00C853), 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BreathingTechniquesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  //  Lian Gong
                  _TechniqueCard(
                    title: "Exercícios Adaptados (Lian Gong)",
                    description: "Movimentos da medicina chinesa...",
                    duration: "10-20 minutos",
                    icon: Icons.self_improvement,
                    color: const Color(0xFFFF6D00),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LianGongPage(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // card dica
                  _buildTipCard(),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF5E81F4),
            Color(0xFFF5F6FA),
          ],
          stops: [0.0, 0.9],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF2962FF), 
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            "Práticas para seu Bem-estar",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Escolha uma técnica natural para aliviar os sintomas da osteoartrite e melhorar sua qualidade de vida",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb, color: Color(0xFF2962FF), size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            "Dica Importante",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Comece devagar e respeite os limites do seu corpo. Se sentir dor, pare e descanse. A constância é mais importante que a intensidade.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// widget Reutilizável para os Cards de Técnicas
class _TechniqueCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TechniqueCard({
    required this.title,
    required this.description,
    required this.duration,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: color),
                  const SizedBox(width: 6),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2962FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text(
                    "Começar",
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}