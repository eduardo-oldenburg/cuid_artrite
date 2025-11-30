import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'education_detail_page.dart';

// --- ENUMS E CLASSES DE MODELO (Ficam no topo ou num arquivo separado) ---

enum EducationSectionType { text, image, video, subtitle }

class EducationSection {
  final EducationSectionType type;
  final String data; // Texto, Caminho da Imagem ou URL do Vídeo
  final String? caption; // Legenda opcional para imagem

  EducationSection({required this.type, required this.data, this.caption});
}

class EducationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final String category;
  final Color color;
  final Color bgLight;
  // MUDANÇA: Content agora é uma lista de seções!
  final List<EducationSection> content;

  EducationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.category,
    required this.color,
    required this.bgLight,
    required this.content,
  });
}

// --- TELA PRINCIPAL ---

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "Todos";

  final List<String> _categories = [
    "Todos",
    "Básico",
    "Sinais",
    "Tratamento",
    "Alimentação",
    "Mente",
    "Adaptações"
  ];

  // --- DADOS MOCKADOS COM MULTIMÍDIA ---
  final List<EducationItem> _allItems = [
    EducationItem(
      title: "Entendendo sua Condição",
      description: "Descubra o que realmente acontece nas suas articulações com a osteoartrite.",
      time: "15 min",
      icon: Icons.psychology,
      category: "Básico",
      color: Colors.blue,
      bgLight: Colors.blue.shade50,
      content: [
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "O que exatamente é osteoartrite?",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "A osteoartrite é uma doença crônica que afeta não apenas o osso, mas **toda a articulação**: cartilagem, líquido sinovial, ligamentos e até o músculo ao redor. "
              "Ao longo do tempo, a cartilagem vai se desgastando e perde sua capacidade natural de amortecimento, causando dor, rigidez e estalos ao se movimentar.",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/osteoartriteXsaudavel.png",
          caption: "Articulação saudável vs. articulação com osteoartrite",
        ),
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "O que acontece dentro da articulação?",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "📌 Conforme a cartilagem se desgasta, o corpo tenta compensar formando pequenos ossos extras chamados **osteófitos** (ou “bicos-de-papagaio”). "
              "Isso reduz o espaço articular e dificulta os movimentos.\n\n"
              "Além disso:\n"
              "• O **líquido sinovial** pode ficar mais espesso e menos eficiente.\n"
              "• O **músculo ao redor** enfraquece, piorando ainda mais a movimentação.\n"
              "• A articulação inflama com mais facilidade.\n\n"
              "➡ Por isso, a dor não vem só do desgaste, mas de **inflamação + fraqueza muscular**.",
        ),
        EducationSection(
          type: EducationSectionType.video,
          data: "https://www.youtube.com/watch?v=Oj1_CxEqVsE",
          caption: "Entenda a osteoartrite em 8 minutos (vídeo brasileiro)",
        ),
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "A osteoartrite piora sempre?",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Não necessariamente! A progressão da doença **varia muito entre as pessoas**.\n\n"
              "Ela pode **estabilizar** por muitos anos quando o tratamento é seguido corretamente.\n\n"
              "Os principais fatores que aceleram o desgaste são:\n"
              "• Excesso de peso\n"
              "• Sedentarismo\n"
              "• Lesões antigas\n"
              "• Movimentos repetitivos nas articulações\n"
              "• Histórico familiar",
        ),
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "Como você pode proteger suas articulações?",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "✔ Exercitar os músculos que protegem a articulação\n"
              "✔ Controlar o peso\n"
              "✔ Cuidar da postura ao sentar e caminhar\n"
              "✔ Evitar sobrecargas repetitivas\n\n"
              "➡ Pequenas mudanças trazem grandes resultados a longo prazo!",
        ),
        EducationSection(
          type: EducationSectionType.video,
          data: "https://www.youtube.com/watch?v=IEYYAGQNPwU",
          caption: "Dicas de fortalecimento e como proteger as articulações",
        ),
      ],
    ),

    
    EducationItem(
      title: "Comendo para Desinflamar",
      description: "Alimentos que ajudam a combater a dor.",
      time: "8 min",
      icon: Icons.restaurant,
      category: "Alimentação",
      color: Colors.purple,
      bgLight: Colors.purple.shade50,
      content: [
        EducationSection(
          type: EducationSectionType.text,
          data: "Alguns alimentos aumentam a inflamação no corpo, enquanto outros agem como bombeiros, apagando o fogo.",
        ),
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "Os Heróis (Coma Mais)",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/alimentos_anti_inflamatorios.png",
          caption: "Peixes, Cúrcuma e Frutas Vermelhas",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data: "🐟 Ômega-3: Presente em peixes (sardinha, atum).\n🍊 Vitamina C: Essencial para formar colágeno.\n🫚 Cúrcuma: Potente anti-inflamatório natural.",
        ),
      ],
    ),
    
    // Adicionei um exemplo genérico para os outros itens não quebrarem
    // Você deve preencher o resto seguindo esse padrão
    EducationItem(
      title: "Reconhecendo os Sinais",
      description: "Aprenda a diferenciar a dor.",
      time: "8 min",
      icon: Icons.warning_amber_rounded,
      category: "Sinais",
      color: Colors.orange,
      bgLight: Colors.orange.shade50,
      content: [
        EducationSection(
            type: EducationSectionType.text, 
            data: "Conteúdo sobre sinais de alerta...")
      ],
    ),
     EducationItem(
      title: "Tratamentos que Funcionam",
      description: "A pirâmide do tratamento.",
      time: "12 min",
      icon: Icons.medication,
      category: "Tratamento",
      color: Colors.green,
      bgLight: Colors.green.shade50,
      content: [
        EducationSection(
            type: EducationSectionType.text, 
            data: "Conteúdo sobre tratamentos...")
      ],
    ),
    EducationItem(
      title: "Adaptações e Casa Segura",
      description: "Truques para o dia a dia.",
      time: "9 min",
      icon: Icons.home,
      category: "Adaptações",
      color: Colors.indigo,
      bgLight: Colors.indigo.shade50,
       content: [
        EducationSection(
            type: EducationSectionType.text, 
            data: "Conteúdo sobre adaptações...")
      ],
    ),
     EducationItem(
      title: "Mente Sã, Corpo Sem Dor",
      description: "Psicologia da dor.",
      time: "10 min",
      icon: Icons.favorite,
      category: "Mente",
      color: Colors.teal,
      bgLight: Colors.teal.shade50,
       content: [
        EducationSection(
            type: EducationSectionType.text, 
            data: "Conteúdo sobre saúde mental...")
      ],
    ),
  ];

  List<EducationItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _runFilter() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        bool matchesSearch = item.title.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
        bool matchesCategory =
            _selectedCategory == "Todos" || item.category == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _openArticleDetails(EducationItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EducationDetailPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Conteúdo Educativo",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => _runFilter(),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _buildFilterChip(
                          category,
                          isSelected: _selectedCategory == category,
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _runFilter();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          "Nenhum artigo encontrado",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return _buildArticleCard(_filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label,
      {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  Widget _buildArticleCard(EducationItem item) {
    return GestureDetector(
      onTap: () => _openArticleDetails(item),
      child: Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            item.time,
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => _openArticleDetails(item),
                        child: const Text(
                          "Ler mais",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}