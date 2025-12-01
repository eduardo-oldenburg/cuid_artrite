import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'education_detail_page.dart';

enum EducationSectionType { text, image, video, subtitle }

class EducationSection {
  final EducationSectionType type;
  final String data;     // texto, Caminho da Imagem ou URL do Vídeo
  final String? caption; // legenda opcional para imagem

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
      description: "Aprenda como a alimentação pode ajudar no controle da dor e na redução da inflamação.",
      time: "12 min",
      icon: Icons.restaurant,
      category: "Alimentação",
      color: Colors.purple,
      bgLight: Colors.purpleAccent,
      content: [
        EducationSection(
          type: EducationSectionType.text,
          data:
              "A alimentação pode ser uma grande aliada no combate à dor da artrite. "
              "Alguns alimentos aumentam a inflamação no corpo, enquanto outros agem como verdadeiros ‘bombeiros’, reduzindo o processo inflamatório.",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "Como a alimentação reduz a inflamação?",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Nosso corpo produz inflamação para nos proteger, mas na artrite esse processo não desliga. "
              "Quando escolhemos alimentos corretos, diminuímos substâncias pró-inflamatórias e fortalecemos a saúde das articulações.",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "🥦 Os Heróis (Coma Mais!)",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/alimentos_anti_inflamatorios.png",
          caption: "Peixes ricos em ômega-3, cúrcuma, frutas vermelhas e azeite de oliva",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Inclua no dia a dia:\n\n"
              "• 🐟 **Peixes ricos em ômega-3**: sardinha, salmão, anchova\n"
              "• 🍇 **Frutas vermelhas**: morango, amora, mirtilo\n"
              "• 🫒 **Azeite de oliva extra virgem**\n"
              "• 🥬 **Verduras verde-escuras**: espinafre, couve\n"
              "• 🫘 **Castanhas e sementes**: nozes, chia, linhaça\n"
              "• 🫚 **Cúrcuma e gengibre** como temperos\n"
              "• 🍅 **Tomate** – rico em licopeno\n"
              "• 🍵 **Chá-verde** – antioxidante poderoso\n",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "🔥 Os Vilões (Evite ao Máximo)",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/alimentos_inflamatorios.png",
          caption: "Refrigerantes, frituras e embutidos são grandes inimigos",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Esses alimentos aumentam a inflamação e pioram a dor:\n\n"
              "🚫 Açúcar em excesso (doces, refrigerantes)\n"
              "🚫 Frituras e fast-food\n"
              "🚫 Carnes processadas (salsicha, bacon, presunto)\n"
              "🚫 Farinhas brancas (pão branco, massas comuns)\n"
              "🚫 Margarina e gordura trans\n"
              "🚫 Consumo excessivo de álcool",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "💧 Hidratação Importa!",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "A água ajuda a manter a cartilagem nutrida e reduzir toxinas inflamatórias. "
              "Tente beber de 6 a 8 copos por dia.",
        ),
        EducationSection(
          type: EducationSectionType.subtitle,
          data: "⚖️ Dica Final",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Não existe alimento milagroso — é o **conjunto do que você come todos os dias** que fará diferença "
              "no controle da dor e na sua qualidade de vida.\n\n"
              "Pequenas escolhas → Grandes resultados! 💪",
        ),
      ],
    ),
    
    EducationItem(
      title: "Reconhecendo os Sinais",
      description: "Identifique sintomas da artrite e saiba quando buscar ajuda.",
      time: "10 min",
      icon: Icons.warning_amber_rounded,
      category: "Sinais",
      color: Colors.orange,
      bgLight: Colors.orangeAccent,
      content: [
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Muitas pessoas convivem com dor nas articulações e acham que é normal, "
              "resultado do trabalho, idade ou esforço físico. Mas alguns sinais "
              "podem indicar **artrite** e merecem atenção especial.",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "🟧 Quando a dor vira sinal de alerta?",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/sinais_inchaco_dor.png",
          caption: "Inchaço, calor e rigidez são sinais comuns de inflamação",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Observe se você sente:\n\n"
              "• 🔥 **Dor persistente** que dura por semanas\n"
              "• 🦵 **Inchaço nas articulações**\n"
              "• ♨️ **Calor e vermelhidão** no local dolorido\n"
              "• 🚫 **Dificuldade para mexer** quando acorda ou fica parado\n"
              "• 😣 **Fraqueza e cansaço constante**\n\n"
              "Se você respondeu sim a alguns desses sinais, é importante acompanhar.",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "⏰ A famosa “rigidez matinal”",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "A artrite costuma travar as articulações ao acordar. "
              "Se a rigidez durar **mais de 30 minutos**, pode ser um dos principais indicadores "
              "de doença inflamatória.",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "👣 Sinais em diferentes partes do corpo",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/sinais_maos_pes.png",
          caption: "Mãos e pés são regiões muito afetadas",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "A artrite pode afetar qualquer articulação, mas é comum começar em:\n\n"
              "• 🤲 **Dedos das mãos** – articulações ficam doloridas e grossas\n"
              "• 🦶 **Pés** – dor ao pisar, principalmente pela manhã\n"
              "• 🦵 **Joelhos** – dificuldade para subir escadas\n"
              "• 🦴 **Punhos e tornozelos**\n",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "⚠️ Sintomas que exigem consulta médica",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "Procure atendimento se apresentar:\n\n"
              "❗ Dor e inchaço em **mais de uma articulação**\n"
              "❗ Sintomas durando **mais de 6 semanas**\n"
              "❗ Febre, perda de peso ou cansaço extremo\n"
              "❗ Dificuldade para realizar tarefas simples do dia a dia",
        ),

        EducationSection(
          type: EducationSectionType.subtitle,
          data: "🎯 Quanto antes descobrir, melhor!",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "O diagnóstico precoce evita danos permanentes nas articulações e melhora "
              "muito a qualidade de vida. Escute seu corpo e busque ajuda sempre que sentir "
              "que algo não está certo. Você não precisa enfrentar isso sozinho(a). 💛",
        ),
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
          data:
              "O tratamento da artrite segue uma abordagem estruturada para controlar a dor, proteger as articulações e impedir a progressão da doença. Quanto mais cedo o tratamento é iniciado, melhores são os resultados."
              "\n\nA pirâmide do tratamento se divide em três pontos principais:"
              "\n1️⃣ Controle da dor e inflamação"
              "\n2️⃣ Proteção e fortalecimento das articulações"
              "\n3️⃣ Medicamentos modificadores da doença"
              "\n\nO tratamento é sempre individualizado e deve ser acompanhado por reumatologista.",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🟩 **Primeira linha do tratamento**"
              "\n• Analgésicos e anti-inflamatórios"
              "\n• Corticoides em curto prazo"
              "\n\nEles aliviam os sintomas, mas não impedem danos futuros.",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🟧 **DMARDs – Medicamentos modificadores da doença**"
              "\n• Metotrexato, Leflunomida, Sulfassalazina"
              "\n• Agem na causa da inflamação"
              "\n• Evitam deformidades"
              "\n\nSão o principal tratamento das artrites inflamatórias crônicas.",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🟥 **Terapias biológicas e agentes-alvo**"
              "\nIndicados quando os DMARDs não são suficientes."
              "\nAgem bloqueando moléculas específicas que geram inflamação."
              "\nEx.: anti-TNF, anti-IL-6, inibidores de JAK."
              "\n\nTransformaram a qualidade de vida de muitos pacientes.",
        ),
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
          data:
              "A dor e rigidez podem dificultar tarefas simples como abrir uma porta ou tomar banho. Pequenas adaptações reduzem o risco de quedas e ajudam a manter autonomia."
              "\n\nEssas mudanças não precisam ser caras — muitas podem ser improvisadas!",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🏡 **Banheiro mais seguro:**"
              "\n• Barras de apoio próximas ao vaso e no box"
              "\n• Piso antiderrapante"
              "\n• Banquinho para banho"
              "\n\nEstatística: o banheiro é o cômodo com mais quedas entre pessoas com limitações de mobilidade.",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/banheiro_adaptado.png",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🔑 **Cozinha acessível:**"
              "\n• Abridores de frascos ergonômicos"
              "\n• Utensílios com cabos grossos"
              "\n• Armários baixos de fácil acesso"
              "\n\nObjetivo: reduzir movimentos que forçam as mãos e punhos.",
        ),
        EducationSection(
          type: EducationSectionType.image,
          data: "assets/images/education/cozinha_adapatada.png", 
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🛋️ **Mobilidade dentro de casa:**"
              "\n• Tapetes antiderrapantes"
              "\n• Cadeiras com apoio para braços"
              "\n• Boa iluminação em todos os cômodos"
              "\n\nCada ajuste reduz uma dor e aumenta a liberdade!",
        ),
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
          data:
              "A dor crônica afeta o corpo — mas também as emoções, o sono e a socialização. Quando estamos tristes, estressados ou ansiosos, o cérebro percebe a dor de forma ainda mais intensa."
              "\n\nPor isso, cuidar da mente também é tratar a artrite!",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "🧠 **Terapias psicológicas ajudam a:**"
              "\n• Reduzir medo da dor e da limitação"
              "\n• Melhorar depressão e ansiedade"
              "\n• Recuperar autoestima e independência"
              "\n\nTerapia cognitivo-comportamental é especialmente recomendada.",
        ),
        EducationSection(
          type: EducationSectionType.text,
          data:
              "💤 **Sono e dor andam juntos**"
              "\nMaus hábitos de sono aumentam a inflamação e a fadiga."
              "\n\n📌 Dicas práticas:"
              "\n• Evite telas antes de dormir"
              "\n• Ambientes escuros e silenciosos"
              "\n• Rotina de relaxamento antes de deitar",
        ),
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