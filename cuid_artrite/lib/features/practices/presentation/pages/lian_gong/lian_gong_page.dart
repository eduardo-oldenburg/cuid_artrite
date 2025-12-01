import 'package:flutter/material.dart';
import '../../../../practices/presentation/pages/pratice_detail/practice_detail_page.dart';

class LianGongPage extends StatelessWidget {
  const LianGongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Lian Gong (Exercícios)",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6D00),
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
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),

                  // movimento pescoço
                  _PracticeCard(
                    title: "Soltar o Pescoço",
                    description: "Movimentos suaves para destravar a cervical e aliviar tensão nos ombros.",
                    time: "3-5 min",
                    level: "Iniciante",
                    icon: Icons.accessibility_new,
                    color: Colors.orange.shade100,
                    iconColor: Colors.orange.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Soltar o Pescoço",
                              imageUrl: "images/practices/lian_gong_neck.jpg",
                              timeRange: "3-5 minutos",
                              goodFor: "Torcicolo, dor na nuca e tensão nos ombros",
                              durationDetail: "Faça devagar, sem forçar",
                              steps: [
                                PracticeStep(
                                  title: "Postura Inicial",
                                  description: "Fique em pé, pés na largura dos ombros, braços soltos. Respire fundo.",
                                  durationSeconds: 10,
                                ),
                                PracticeStep(
                                  title: "Olhar para o Céu",
                                  description: "Inspire e levante o queixo suavemente. Expire e traga o queixo ao peito.",
                                  durationSeconds: 20,
                                ),
                                PracticeStep(
                                  title: "Olhar para os Lados",
                                  description: "Gire a cabeça para a esquerda, volte ao centro, gire para a direita. Repita suavemente.",
                                  durationSeconds: 30,
                                ),
                                PracticeStep(
                                  title: "Rodar os Ombros",
                                  description: "Gire os ombros para trás, abrindo o peito.",
                                  durationSeconds: 20,
                                ),
                              ],
                              tips: [
                                "Mantenha os joelhos levemente flexionados",
                                "O movimento deve ser contínuo e fluido, como água",
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // arqueiro
                  _PracticeCard(
                    title: "O Arqueiro (Abrir o Peito)",
                    description: "Expande a caixa torácica e melhora a postura.",
                    time: "5-8 min",
                    level: "Iniciante",
                    icon: Icons.crop_landscape, 
                    color: Colors.amber.shade100,
                    iconColor: Colors.amber.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "O Arqueiro (Abrir o Peito)",
                              imageUrl: "images/practices/lian_gong_archer.jpg",
                              timeRange: "5-8 minutos",
                              goodFor: "Postura curvada, dor nas costas alta, respiração curta",
                              durationDetail: "Repita 4 vezes para cada lado",
                              steps: [
                                PracticeStep(
                                  title: "Preparar o Arco",
                                  description: "Cruze os braços à frente do peito. Dê um passo lateral largo.",
                                  durationSeconds: 10,
                                ),
                                PracticeStep(
                                  title: "Atirar a Flecha (Esq)",
                                  description: "Estenda o braço esquerdo para o lado (apontando) e puxe o cotovelo direito para trás (corda). Olhe para a mão esquerda.",
                                  durationSeconds: 15,
                                ),
                                PracticeStep(
                                  title: "Relaxar",
                                  description: "Volte ao centro cruzando os braços.",
                                  durationSeconds: 5,
                                ),
                                PracticeStep(
                                  title: "Atirar a Flecha (Dir)",
                                  description: "Estenda o braço direito e puxe o cotovelo esquerdo. Abra bem o peito.",
                                  durationSeconds: 15,
                                ),
                              ],
                              tips: [
                                "Imagine que está puxando um arco pesado",
                                "Sinta as escápulas se juntando nas costas",
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // rodar cintura
                  _PracticeCard(
                    title: "Rodar a Cintura",
                    description: "Solta a região lombar e fortalece os rins.",
                    time: "5 min",
                    level: "Iniciante",
                    icon: Icons.loop,
                    color: Colors.deepOrange.shade100,
                    iconColor: Colors.deepOrange.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Rodar a Cintura",
                              imageUrl: "images/practices/lian_gong_waist.jpg",
                              timeRange: "5 minutos",
                              goodFor: "Dor lombar, rigidez no quadril",
                              durationDetail: "Movimentos amplos",
                              steps: [
                                PracticeStep(
                                  title: "Mãos na Cintura",
                                  description: "Pés afastados na largura dos ombros. Mãos apoiadas nos rins (lombar).",
                                  durationSeconds: 5,
                                ),
                                PracticeStep(
                                  title: "Giro Horário",
                                  description: "Gire o quadril em círculos grandes e lentos no sentido horário.",
                                  durationSeconds: 20,
                                ),
                                PracticeStep(
                                  title: "Giro Anti-horário",
                                  description: "Inverta o sentido. Gire o quadril no sentido anti-horário.",
                                  durationSeconds: 20,
                                ),
                                PracticeStep(
                                  title: "Esfregar os Rins",
                                  description: "Com as mãos fechadas, esfregue suavemente a região lombar para aquecer.",
                                  durationSeconds: 15,
                                ),
                              ],
                              tips: [
                                "Mantenha a cabeça parada, mova apenas o quadril",
                                "Respire naturalmente",
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // fortalecer joelhos
                  _PracticeCard(
                    title: "Fortalecer Joelhos",
                    description: "Agachamento suave assistido para estabilidade.",
                    time: "8-10 min",
                    level: "Intermediário",
                    icon: Icons.directions_walk,
                    color: Colors.brown.shade100,
                    iconColor: Colors.brown.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Fortalecer Joelhos",
                              imageUrl: "images/practices/lian_gong_knees.jpg",
                              timeRange: "8-10 minutos",
                              goodFor: "Fraqueza nas pernas, instabilidade no joelho",
                              durationDetail: "Não desça muito se sentir dor",
                              safetyAlert: "Mantenha a coluna reta. Se doer o joelho, faça o movimento menor.",
                              steps: [
                                PracticeStep(
                                  title: "Apoio nas Coxas",
                                  description: "Pés juntos. Apoie as mãos logo acima dos joelhos.",
                                  durationSeconds: 10,
                                ),
                                PracticeStep(
                                  title: "Flexão Suave",
                                  description: "Dobre levemente os joelhos e estique. Não precisa descer até o chão.",
                                  durationSeconds: 20,
                                ),
                                PracticeStep(
                                  title: "Rotação de Joelhos",
                                  description: "Com os joelhos flexionados e mãos apoiadas, gire os joelhos em pequenos círculos.",
                                  durationSeconds: 20,
                                ),
                                PracticeStep(
                                  title: "Massagem",
                                  description: "Fique em pé e massageie as laterais dos joelhos com as palmas das mãos.",
                                  durationSeconds: 15,
                                ),
                              ],
                              tips: [
                                "O peso do corpo deve ficar nos calcanhares, não na ponta dos pés",
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // alongar meriddianos
                  _PracticeCard(
                    title: "Alongar Meridianos",
                    description: "Esticamento total do corpo para circulação de energia.",
                    time: "5 min",
                    level: "Iniciante",
                    icon: Icons.accessibility,
                    color: Colors.yellow.shade100,
                    iconColor: Colors.orange.shade900,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Alongar Meridianos",
                              imageUrl: "images/practices/lian_gong_stretch.jpg",
                              timeRange: "5 minutos",
                              goodFor: "Sensação de cansaço, má circulação",
                              durationDetail: "Sinta esticar do pé à mão",
                              steps: [
                                PracticeStep(
                                  title: "Entrelaçar Dedos",
                                  description: "Entrelace os dedos e vire as palmas para cima.",
                                  durationSeconds: 5,
                                ),
                                PracticeStep(
                                  title: "Empurrar o Céu",
                                  description: "Eleve os braços acima da cabeça, empurrando as palmas para o teto. Fique na ponta dos pés.",
                                  durationSeconds: 15,
                                ),
                                PracticeStep(
                                  title: "Relaxar",
                                  description: "Desça os braços pelas laterais soltando o ar.",
                                  durationSeconds: 10,
                                ),
                                PracticeStep(
                                  title: "Repetir",
                                  description: "Repita o movimento, tentando crescer ainda mais.",
                                  durationSeconds: 20,
                                ),
                              ],
                              tips: [
                                "Imagine que você quer tocar o teto",
                                "Sorria enquanto espreguiça",
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
        color: Color(0xFFFF6D00), 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.self_improvement, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            "Equilíbrio e Movimento",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Exercícios terapêuticos chineses para fortalecer o corpo e prevenir dores crônicas.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar exercícios...",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

// Widget Reutilizável para os Cards
class _PracticeCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String level;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _PracticeCard({
    required this.title,
    required this.description,
    required this.time,
    required this.level,
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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
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
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      const Icon(Icons.play_arrow, color: Color(0xFFFF6D00), size: 20),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.signal_cellular_alt, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        level,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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