import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _selectedPeriodIndex = 0; // 0: 7 dias, 1: 30 dias, 2: 3 meses

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Meus Relatórios",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // seletor de periodo
            _buildPeriodSelector(),
            const SizedBox(height: 20),

            // grafico
            _buildChartCard(),
            const SizedBox(height: 20),

            // progresso pratica
            _buildProgressCard(),
            const SizedBox(height: 20),

            // antes vs dps
            _buildBeforeAfterCard(),
            const SizedBox(height: 20),

            //  resumo de praticas
            _buildSummaryGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Período de Análise",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildPeriodButton(0, "7 dias"),
              _buildPeriodButton(1, "30 dias"),
              _buildPeriodButton(2, "3 meses"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(int index, String text) {
    final isSelected = _selectedPeriodIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriodIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2962FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    // Dados fictícios para o gráfico (7 dias) ALTERAR PARA OS DO BANCO
    final dataPoints = [8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 4.0];
    final labels = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Evolução da Dor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.show_chart, color: Colors.blue[700]),
            ],
          ),
          const SizedBox(height: 20),
          
          // Área do Gráfico Customizado
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(
              painter: _SimpleLineChartPainter(
                data: dataPoints,
                color: const Color(0xFF2962FF),
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // Legendas do eixo X
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels.map((l) => Text(l, style: const TextStyle(color: Colors.grey, fontSize: 12))).toList(),
          ),
          const SizedBox(height: 15),
          
          // Legenda Inferior
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Sem dor", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("Dor insuportável", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Progresso das Práticas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.pie_chart, color: Colors.teal[400]),
            ],
          ),
          const SizedBox(height: 20),
          _buildProgressItem("Meditação", "15 sessões", 0.75, Colors.blue),
          _buildProgressItem("Fitoterapia", "12 doses", 0.60, Colors.green),
          _buildProgressItem("Acupressão", "8 sessões", 0.40, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, String subtitle, double percent, MaterialColor color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              title == "Meditação" ? Icons.spa : 
              title == "Fitoterapia" ? Icons.eco : Icons.fingerprint,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${(percent * 100).toInt()}%", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              SizedBox(
                width: 60,
                child: LinearProgressIndicator(
                  value: percent,
                  backgroundColor: Colors.grey[200],
                  color: color,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBeforeAfterCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Antes vs Depois",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.balance, color: Colors.orange[400]),
            ],
          ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("ANTES DAS PRÁTICAS", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text("7.2", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red[700])),
                    Text("Nível de dor médio", style: TextStyle(fontSize: 11, color: Colors.red[700])),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("DEPOIS DAS PRÁTICAS", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text("4.1", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[700])),
                    Text("Nível de dor médio", style: TextStyle(fontSize: 11, color: Colors.green[700])),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_downward, color: Colors.green[700], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.green[800], fontSize: 13),
                    children: const [
                      TextSpan(text: "Melhora de 43% na dor\n", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Parabéns! Suas práticas estão funcionando muito bem!", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resumo das Práticas",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildSummaryItem("18", "Dias praticando", Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _buildSummaryItem("35", "Total de práticas", Colors.green)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildSummaryItem("85%", "Meta atingida", Colors.purple)),
            const SizedBox(width: 12),
            Expanded(child: _buildSummaryItem("12", "Dias seguidos", Colors.orange)),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String value, String label, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color[700]),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color[700]),
          ),
        ],
      ),
    );
  }
}

//classe para desenhar o grafico 
class _SimpleLineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SimpleLineChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintDot = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final paintDotBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

  //linhas da grade por tras
    final paintGrid = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
       double y = size.height * (i / 4);
       canvas.drawLine(Offset(0, y), Offset(size.width, y), paintGrid);
    }

    if (data.isEmpty) return;

    final path = Path();
    final double stepX = size.width / (data.length - 1);
    
    // 0 fica embaixo (size.height), 10 fica em cima (0).
    double getY(double val) => size.height - (val / 10 * size.height);

    path.moveTo(0, getY(data[0]));

    for (int i = 1; i < data.length; i++) {
      path.lineTo(i * stepX, getY(data[i]));
    }

    canvas.drawPath(path, paintLine);

    // Desenha os pontos (bolinhas)
    for (int i = 0; i < data.length; i++) {
      final cx = i * stepX;
      final cy = getY(data[i]);
      
      // Borda branca da bolinha
      canvas.drawCircle(Offset(cx, cy), 6, paintDotBorder);
      // Centro colorido da bolinha
      canvas.drawCircle(Offset(cx, cy), 4, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}