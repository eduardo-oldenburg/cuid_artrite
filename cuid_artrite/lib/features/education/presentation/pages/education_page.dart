import 'package:flutter/material.dart';
// Certifique-se de importar o arquivo de cores que criamos
import '../../../../core/theme/app_colors.dart'; 

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de dados mockados (baseados no seu PDF)
    final List<EducationItem> items = [
      EducationItem(
        title: "Entendendo sua Condição",
        description: "Aprenda sobre os fundamentos da sua condição de saúde e como ela afeta seu corpo.",
        time: "5 min",
        icon: Icons.psychology, 
        color: Colors.blue,
        bgLight: Colors.blue.shade50,
      ),
      EducationItem(
        title: "Reconhecendo os Sinais",
        description: "Identifique os sintomas e sinais importantes no seu dia a dia.",
        time: "7 min",
        icon: Icons.warning_amber_rounded,
        color: Colors.orange,
        bgLight: Colors.orange.shade50,
      ),
      EducationItem(
        title: "Opções de Tratamento",
        description: "Explore as diferentes abordagens de tratamento disponíveis para sua condição.",
        time: "10 min",
        icon: Icons.medication,
        color: Colors.green,
        bgLight: Colors.green.shade50,
      ),
      EducationItem(
        title: "Comendo para Aliviar",
        description: "Descubra quais alimentos podem ajudar a aliviar seus sintomas e melhorar sua qualidade.",
        time: "8 min",
        icon: Icons.restaurant,
        color: Colors.purple,
        bgLight: Colors.purple.shade50,
      ),
      EducationItem(
        title: "Adaptações Práticas",
        description: "Aprenda a fazer adaptações simples em casa e no trabalho.",
        time: "8 min",
        icon: Icons.home,
        color: Colors.indigo,
        bgLight: Colors.indigo.shade50,
      ),
       EducationItem(
        title: "Cuidando da Mente",
        description: "Estratégias para manter sua saúde mental e emocional durante o tratamento.",
        time: "9 min",
        icon: Icons.favorite,
        color: Colors.teal,
        bgLight: Colors.teal.shade50,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Fundo cinza claro
      appBar: AppBar(
        title: const Text(
          "Conteúdo Educativo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Área de Busca e Filtros
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                // Barra de Busca
                TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar artigos...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Filtros (Chips)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip("Todos", isSelected: true),
                      _buildFilterChip("Básico", isSelected: false),
                      _buildFilterChip("Tratamento", isSelected: false),
                      _buildFilterChip("Alimentação", isSelected: false),
                      _buildFilterChip("Exercícios", isSelected: false),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Lista de Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildArticleCard(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para os Filtros (Pílulas)
  Widget _buildFilterChip(String label, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget para o Card do Artigo
  Widget _buildArticleCard(EducationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone Colorido
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item.bgLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color, size: 28),
          ),
          const SizedBox(width: 16),
          
          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Rodapé do Card (Tempo e "Ler mais")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          item.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Ler mais",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Classe de modelo simples para organizar os dados
class EducationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  final Color bgLight;

  EducationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    required this.bgLight,
  });
}