import 'package:flutter/material.dart';
import '../../../../practices/presentation/pages/pratice_detail/practice_detail_page.dart'; 

class BreathingTechniquesPage extends StatelessWidget {
  const BreathingTechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), 
      appBar: AppBar(
        title: const Text(
          "Práticas de Bem-estar",
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
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // respiração profunda
                  _PracticeCard(
                    title: "Respiração Profunda",
                    description: "Técnica simples para acalmar a mente e reduzir a ansiedade.",
                    time: "0.5-1 min",
                    level: "Iniciante",
                    icon: Icons.air,
                    color: Colors.blue.shade100,
                    iconColor: Colors.blue.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Respiração Profunda",
                              imageUrl: "images/practices/respiracao_profunda.jpg",
                              timeRange: "0.5-1 min minutos",
                              goodFor: "Ansiedade imediata, estresse e clareza mental",
                              durationDetail: "1 minuto • Pode ser feito sentado ou deitado",
                              steps: [
                                PracticeStep(
                                  title: "Acomode-se", 
                                  description: "Sente-se com a coluna reta ou deite-se confortavelmente. Feche os olhos.",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Inspire", 
                                  description: "Inspire lentamente pelo nariz contando até 4, sentindo a barriga expandir.",
                                  durationSeconds: 4
                                ),
                                PracticeStep(
                                  title: "Segure", 
                                  description: "Segure o ar nos pulmões por 2 segundos.",
                                  durationSeconds: 2
                                ),
                                PracticeStep(
                                  title: "Expire", 
                                  description: "Solte o ar pela boca lentamente, contando até 6, como se soprasse uma vela.",
                                  durationSeconds: 6
                                ),
                              ],
                              tips: ["Coloque a mão no abdômen para sentir o movimento", "Mantenha os ombros relaxados"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // respiração 4-7-8 
                  _PracticeCard(
                    title: "Respiração 4-7-8",
                    description: "Método poderoso para induzir relaxamento e sono.",
                    time: "1-1.5 min",
                    level: "Intermediário",
                    icon: Icons.filter_vintage,
                    color: Colors.purple.shade100,
                    iconColor: Colors.purple.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Respiração 4-7-8",
                              imageUrl: "images/practices/respiracao_478.jpg",
                              timeRange: "1-1:30 minuto",
                              goodFor: "Insônia, crises de ansiedade e relaxamento profundo",
                              durationDetail: "4 ciclos completos • Ideal antes de dormir",
                              steps: [
                                PracticeStep(
                                  title: "Prepare-se", 
                                  description: "Coloque a ponta da língua no céu da boca, logo atrás dos dentes da frente.",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Inspire (4s)", 
                                  description: "Inspire silenciosamente pelo nariz contando até 4.",
                                  durationSeconds: 4
                                ),
                                PracticeStep(
                                  title: "Segure (7s)", 
                                  description: "Prenda a respiração contando até 7.",
                                  durationSeconds: 7
                                ),
                                PracticeStep(
                                  title: "Expire (8s)", 
                                  description: "Expire completamente pela boca fazendo um som de sopro (whoosh), contando até 8.",
                                  durationSeconds: 8
                                ),
                              ],
                              tips: ["Se sentir tontura, volte a respirar normalmente", "A contagem é mais importante que a velocidade"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // suspiro de alivio 
                  _PracticeCard(
                    title: "Suspiro de Alívio",
                    description: "Libere tensões acumuladas rapidamente.",
                    time: "2-3 min",
                    level: "Iniciante",
                    icon: Icons.favorite,
                    color: Colors.green.shade100,
                    iconColor: Colors.green.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Suspiro de Alívio",
                              imageUrl: "images/practices/suspiro.jpg",
                              timeRange: "2-3 minutos",
                              goodFor: "Alívio imediato de tensão e reset do sistema nervoso",
                              durationDetail: "Repita 3 a 5 vezes",
                              steps: [
                                PracticeStep(
                                  title: "Inspiração Dupla", 
                                  description: "Inspire pelo nariz até encher os pulmões. Sem soltar, inspire mais um pouquinho para preencher o finalzinho.",
                                  durationSeconds: 4
                                ),
                                PracticeStep(
                                  title: "Exalação Longa", 
                                  description: "Solte o ar pela boca em um suspiro longo e audível (Ahhhh...).",
                                  durationSeconds: 6
                                ),
                                PracticeStep(
                                  title: "Repetição", 
                                  description: "Respire normalmente por alguns segundos antes de repetir.",
                                  durationSeconds: 5
                                ),
                              ],
                              tips: ["Faça barulho ao soltar o ar, ajuda a relaxar", "Relaxe a mandíbula ao suspirar"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // relaxamento muscular
                  _PracticeCard(
                    title: "Relaxamento Muscular",
                    description: "Técnica progressiva para aliviar tensões físicas.",
                    time: "3-5 min",
                    level: "Intermediário",
                    icon: Icons.spa,
                    color: Colors.orange.shade100,
                    iconColor: Colors.orange.shade800,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Relaxamento Muscular Progressivo",
                              imageUrl: "images/practices/relaxamento_muscular.jpg",
                              timeRange: "3-5 minutos",
                              goodFor: "Dores no corpo, tensão muscular crônica",
                              durationDetail: "Percorra todo o corpo",
                              steps: [
                                PracticeStep(
                                  title: "Pés e Pernas", 
                                  description: "Contraia os músculos dos pés e pernas com força. Segure a tensão...",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Relaxe as Pernas", 
                                  description: "Solte de uma vez! Sinta o alívio percorrendo as pernas.",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Mãos e Braços", 
                                  description: "Feche as mãos e contraia os braços. Segure...",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Relaxe os Braços", 
                                  description: "Solte tudo. Sinta as mãos ficarem leves.",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Ombros e Rosto", 
                                  description: "Erga os ombros e aperte o rosto numa careta. Segure...",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Relaxe Total", 
                                  description: "Solte os ombros e a face. Respire fundo e aproveite a sensação.",
                                  durationSeconds: 15
                                ),
                              ],
                              tips: ["Foque na diferença entre a tensão e o relaxamento", "Não prenda a respiração ao contrair"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // toque calmante
                  _PracticeCard(
                    title: "Toque Calmante",
                    description: "Técnicas de auto-toque terapêutico.",
                    time: "1:30-3 min",
                    level: "Iniciante",
                    icon: Icons.volunteer_activism,
                    color: Colors.pink.shade100,
                    iconColor: Colors.pink.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Toque Calmante",
                              imageUrl: "images/practices/toque_calmante.jpg",
                              timeRange: "1:30-3 minutos",
                              goodFor: "Sentimento de solidão, medo ou angústia",
                              durationDetail: "Mantenha a posição por alguns minutos",
                              steps: [
                                PracticeStep(
                                  title: "Mão no Coração", 
                                  description: "Coloque uma mão sobre o centro do peito. Sinta o calor da sua mão.",
                                  durationSeconds: 10
                                ),
                                PracticeStep(
                                  title: "Mão na Barriga", 
                                  description: "Coloque a outra mão sobre o abdômen.",
                                  durationSeconds: 5
                                ),
                                PracticeStep(
                                  title: "Conexão", 
                                  description: "Respire suavemente sentindo o movimento do corpo sob suas mãos. Diga: 'Estou seguro'.",
                                  durationSeconds: 20
                                ),
                              ],
                              tips: ["A pressão deve ser suave e reconfortante", "Pode ser feito de olhos fechados"],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // mindfullness basico
                  _PracticeCard(
                    title: "Mindfulness Básico",
                    description: "Introdução à atenção plena.",
                    time: "10-15 min",
                    level: "Iniciante",
                    icon: Icons.psychology,
                    color: Colors.indigo.shade100,
                    iconColor: Colors.indigo.shade700,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeDetailPage(
                            data: PracticeData(
                              title: "Mindfulness Básico",
                              imageUrl: "images/practices/mindfulness.jpg",
                              timeRange: "2-5 minutos",
                              goodFor: "Foco, redução de pensamentos acelerados",
                              durationDetail: "Prática diária recomendada",
                              steps: [
                                PracticeStep(
                                  title: "Foco na Respiração", 
                                  description: "Leve sua atenção apenas para a entrada e saída do ar no nariz.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Observe os Pensamentos", 
                                  description: "Quando um pensamento surgir, não julgue. Apenas note que ele veio.",
                                  durationSeconds: 20
                                ),
                                PracticeStep(
                                  title: "Retorne", 
                                  description: "Gentilmente, traga sua atenção de volta para a respiração.",
                                  durationSeconds: 20
                                ),
                              ],
                              tips: ["Não existe 'não pensar em nada', o objetivo é apenas observar", "Seja gentil consigo mesmo quando se distrair"],
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
        color: Color(0xFF5E81F4),
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
            child: const Icon(Icons.eco, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          const Text(
            "Encontre sua paz interior",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Descubra técnicas comprovadas para reduzir o estresse e melhorar seu bem-estar mental",
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
}

//widget reutilizavel para os cards
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
                      const Icon(Icons.play_arrow, color: Color(0xFF5E81F4), size: 20),
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