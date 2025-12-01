import 'package:flutter/material.dart';
import '../../../../practices/presentation/pages/pratice_detail/practice_detail_page.dart';

class StretchingTechniquesPage extends StatelessWidget {
  const StretchingTechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), 
      appBar: AppBar(
        title: const Text(
          "Alongamentos Guiados",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2962FF), 
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

                  // alongamento de maos e punhos
                  _PracticeCard(
                    title: "Alívio para Mãos e Punhos",
                    description: "Reduza a rigidez matinal e melhore a mobilidade dos dedos.",
                    time: "5-8 min",
                    level: "Iniciante",
                    icon: Icons.pan_tool, 
                    color: Colors.blue.shade100,
                    iconColor: Colors.blue.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Alívio para Mãos e Punhos",
                              imageUrl: "images/practices/stretching_hands.jpg",
                              timeRange: "5-8 minutos",
                              goodFor: "Rigidez matinal, artrite nas mãos, uso excessivo de celular",
                              durationDetail: "Repita 2 vezes em cada mão",
                              safetyAlert: "Pare se sentir dor aguda. O alongamento deve causar apenas uma leve tensão.",
                              steps: [
                                PracticeStep(
                                  title: "Aquecimento", 
                                  description: "Abra e feche as mãos suavemente, como se estivesse bombeando sangue.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Extensão do Punho (Direita)", 
                                  description: "Estenda o braço direito à frente, palma para cima. Com a mão esquerda, puxe suavemente os dedos para baixo.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Flexão do Punho (Direita)", 
                                  description: "Agora vire a palma para baixo e puxe a mão em direção ao corpo.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Extensão do Punho (Esquerda)", 
                                  description: "Repita o alongamento para cima com a mão esquerda.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Flexão do Punho (Esquerda)", 
                                  description: "Repita o alongamento para baixo com a mão esquerda.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Círculos com Punhos", 
                                  description: "Gire os punhos lentamente em sentido horário e anti-horário.",
                                  durationSeconds: 20
                                ),
                              ],
                              tips: ["Mantenha o cotovelo esticado, mas não travado", "Não force os dedos excessivamente"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // relaamento de pescoço-
                  _PracticeCard(
                    title: "Relaxamento de Pescoço",
                    description: "Solte a tensão acumulada nos ombros e cervical.",
                    time: "3-5 min",
                    level: "Iniciante",
                    icon: Icons.accessibility_new,
                    color: Colors.purple.shade100,
                    iconColor: Colors.purple.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Relaxamento de Pescoço",
                              imageUrl: "images/practices/stretching_neck.jpg",
                              timeRange: "3-5 minutos",
                              goodFor: "Dor cervical, tensão por má postura, estresse",
                              durationDetail: "Faça movimentos lentos",
                              steps: [
                                PracticeStep(
                                  title: "Postura Inicial", 
                                  description: "Sente-se com a coluna reta e ombros relaxados, longe das orelhas.",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Inclinação Lateral (Direita)", 
                                  description: "Leve a orelha direita em direção ao ombro direito. Sinta alongar o lado esquerdo.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Inclinação Lateral (Esquerda)", 
                                  description: "Leve a orelha esquerda em direção ao ombro esquerdo.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Olhar para Baixo", 
                                  description: "Leve o queixo em direção ao peito, alongando a nuca.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Rotação Suave", 
                                  description: "Faça um semicírculo com a cabeça, indo de um ombro ao outro passando por baixo.",
                                  durationSeconds: 20
                                ),
                              ],
                              tips: ["Não jogue a cabeça para trás bruscamente", "Mantenha a boca relaxada"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // alivio lombar
                  _PracticeCard(
                    title: "Alívio Lombar (Sentado)",
                    description: "Alongamento seguro para fazer na cadeira.",
                    time: "5-10 min",
                    level: "Iniciante",
                    icon: Icons.chair_alt,
                    color: Colors.orange.shade100,
                    iconColor: Colors.orange.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Alívio Lombar na Cadeira",
                              imageUrl: "images/practices/stretching_back.jpg",
                              timeRange: "5-10 minutos",
                              goodFor: "Dor nas costas, quem fica muito tempo sentado",
                              durationDetail: "Use uma cadeira firme",
                              safetyAlert: "Mantenha os pés firmes no chão para não desequilibrar.",
                              steps: [
                                PracticeStep(
                                  title: "Torção Sentada (Direita)", 
                                  description: "Sente-se de lado. Segure o encosto da cadeira e gire o tronco suavemente para a direita.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Torção Sentada (Esquerda)", 
                                  description: "Gire suavemente o tronco para a esquerda segurando o encosto.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Abraço de Joelho", 
                                  description: "Puxe o joelho direito em direção ao peito e segure.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Abraço de Joelho (Esq)", 
                                  description: "Puxe o joelho esquerdo em direção ao peito e segure.",
                                  durationSeconds: 15
                                ),
                                PracticeStep(
                                  title: "Flexão Frontal", 
                                  description: "Com os pés afastados, incline o tronco para frente, tentando tocar o chão (vá até onde conseguir).",
                                  durationSeconds: 15
                                ),
                              ],
                              tips: ["Não prenda a respiração durante a torção", "Cresça a coluna antes de girar"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // joelhos e pernas
                  _PracticeCard(
                    title: "Joelhos e Pernas",
                    description: "Fortalecimento leve e alongamento para membros inferiores.",
                    time: "8-12 min",
                    level: "Intermediário",
                    icon: Icons.directions_run,
                    color: Colors.green.shade100,
                    iconColor: Colors.green.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Joelhos e Pernas",
                              imageUrl: "images/practices/stretching_legs.jpg",
                              timeRange: "8-12 minutos",
                              goodFor: "Dor nos joelhos, rigidez nas pernas",
                              durationDetail: "Pode precisar de uma toalha ou cinto",
                              steps: [
                                PracticeStep(
                                  title: "Extensão de Perna (Sentado)", 
                                  description: "Sentado, estique a perna direita à frente e segure. Contraia a coxa.",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Extensão de Perna (Esq)", 
                                  description: "Estique a perna esquerda à frente e segure.",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Panturrilha (em pé)", 
                                  description: "Apoie as mãos na parede. Coloque uma perna atrás esticada e dobre a da frente. Sinta a panturrilha.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Panturrilha (outro lado)", 
                                  description: "Troque as pernas e alongue a outra panturrilha.",
                                  durationSeconds: 20
                                ),
                              ],
                              tips: ["Use uma cadeira para apoio se precisar de equilíbrio", "Não force o joelho além do conforto"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // alongamento matinal
                  _PracticeCard(
                    title: "Despertar do Corpo",
                    description: "Série rápida para fazer assim que acordar.",
                    time: "5 min",
                    level: "Iniciante",
                    icon: Icons.wb_sunny,
                    color: Colors.amber.shade100,
                    iconColor: Colors.amber.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Despertar do Corpo",
                              imageUrl: "images/practices/stretching_morning.jpg",
                              timeRange: "5 minutos",
                              goodFor: "Começar o dia com energia e menos dor",
                              durationDetail: "Pode ser feito na cama",
                              steps: [
                                PracticeStep(
                                  title: "Espreguiçar Total", 
                                  description: "Deitado, estique braços acima da cabeça e ponta dos pés para baixo. Cresça!",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Joelhos ao Peito", 
                                  description: "Abrace os dois joelhos e balance suavemente de um lado para o outro.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Rotação de Tornozelos", 
                                  description: "Gire os pés em círculos para lubrificar as articulações.",
                                  durationSeconds: 15
                                ),
                              ],
                              tips: ["Faça movimentos gentis, o corpo ainda está 'frio'", "Sorria para começar bem o dia"],
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
        color: Color(0xFF2962FF), 
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
            child: const Icon(Icons.directions_walk, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            "Movimento é Vida",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Exercícios suaves para reduzir a rigidez, melhorar a circulação e aumentar sua flexibilidade.",
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
          hintText: "Buscar alongamentos...",
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
                      const Icon(Icons.play_arrow, color: Color(0xFF2962FF), size: 20),
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
                      Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      const SizedBox(width: 16),
                      Icon(Icons.signal_cellular_alt, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(level, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
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