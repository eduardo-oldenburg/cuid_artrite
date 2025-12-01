import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // State Variables
  int _selectedPeriodIndex = 0; // 0: 7 days, 1: 30 days, 2: 3 months
  bool _isLoading = true;
  String? _userId;

  // --- Pain Statistics ---
  List<double> _chartData = [];
  List<String> _chartLabels = [];
  double _currentAverage = 0.0;
  double _previousAverage = 0.0;
  int _daysRecorded = 0;
  int _totalPainRecords = 0;

  // --- Practice Statistics ---
  int _totalPractices = 0;
  Map<String, int> _practiceCounts = {}; // e.g. {"Meditação": 5, "Yoga": 2}

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 1. Load User ID
  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');

    if (_userId == null) {
      // Handle case where user is not logged in
      setState(() => _isLoading = false);
      return;
    }
    await _fetchFirestoreData();
  }

  // 2. Fetch Data from Firestore
  Future<void> _fetchFirestoreData() async {
    final now = DateTime.now();
    DateTime startDate;
    DateTime previousPeriodStartDate;

    // Define Date Ranges
    if (_selectedPeriodIndex == 0) {
      // 7 Days
      startDate = now.subtract(const Duration(days: 7));
      previousPeriodStartDate = now.subtract(const Duration(days: 14));
    } else if (_selectedPeriodIndex == 1) {
      // 30 Days
      startDate = now.subtract(const Duration(days: 30));
      previousPeriodStartDate = now.subtract(const Duration(days: 60));
    } else {
      // 90 Days
      startDate = now.subtract(const Duration(days: 90));
      previousPeriodStartDate = now.subtract(const Duration(days: 180));
    }

    try {
      // Query 1: Current Pain Records
      final painSnapshot = await FirebaseFirestore.instance
          .collection('pain_records')
          .where('userId', isEqualTo: _userId)
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .orderBy('timestamp')
          .get();

      // Query 2: Previous Pain Records (For comparison)
      final prevPainSnapshot = await FirebaseFirestore.instance
          .collection('pain_records')
          .where('userId', isEqualTo: _userId)
          .where('timestamp', isGreaterThanOrEqualTo: previousPeriodStartDate)
          .where('timestamp', isLessThan: startDate)
          .get();

      // Query 3: Practice Records
      final practiceSnapshot = await FirebaseFirestore.instance
          .collection('practice_records')
          .where('userId', isEqualTo: _userId)
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      // Process Data
      _processPainData(painSnapshot.docs, prevPainSnapshot.docs);
      _processPracticeData(practiceSnapshot.docs);

    } catch (e) {
      debugPrint("Error loading reports: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 3. Process Practice Data
  void _processPracticeData(List<QueryDocumentSnapshot> docs) {
    _totalPractices = docs.length;
    _practiceCounts = {};

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      String title = data['practiceTitle'] ?? 'Outros';

      // Normalize titles for grouping
      if (title.toLowerCase().contains("medita")) {
        title = "Meditação";
      } else if (title.toLowerCase().contains("fito")) {
        title = "Fitoterapia";
      } else if (title.toLowerCase().contains("acu")) {
        title = "Acupressão";
      } else if (title.toLowerCase().contains("exerc")) {
        title = "Exercícios";
      }

      _practiceCounts[title] = (_practiceCounts[title] ?? 0) + 1;
    }
  }

  // 4. Process Pain Data
  void _processPainData(List<QueryDocumentSnapshot> docs, List<QueryDocumentSnapshot> prevDocs) {
    _totalPainRecords = docs.length;
    _chartData = [];
    _chartLabels = [];
    
    Map<String, List<double>> dailyPainMap = {};
    double sumPain = 0;

    // Initialize map keys to ensure all days appear in chart (even empty ones)
    int daysToIterate = _selectedPeriodIndex == 0 ? 7 : (_selectedPeriodIndex == 1 ? 30 : 90);
    for (int i = 0; i < daysToIterate; i++) {
       DateTime d = DateTime.now().subtract(Duration(days: (daysToIterate - 1) - i));
       String key = DateFormat('dd/MM').format(d);
       dailyPainMap[key] = [];
    }

    // Fill with real data
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      final int pain = data['painLevel'] ?? 0;
      final Timestamp? ts = data['timestamp'];
      
      if (ts != null) {
        sumPain += pain;
        String key = DateFormat('dd/MM').format(ts.toDate());
        if (dailyPainMap.containsKey(key)) {
          dailyPainMap[key]!.add(pain.toDouble());
        }
      }
    }

    // Prepare Chart Arrays
    int dayCount = 0;
    dailyPainMap.forEach((key, values) {
      // Calculate daily average
      double dailyAvg = values.isEmpty ? 0 : values.reduce((a, b) => a + b) / values.length;
      _chartData.add(dailyAvg);

      // Logic to not overcrowd X-Axis labels
      if (_selectedPeriodIndex == 0) {
        _chartLabels.add(key); // Show all for 7 days
      } else {
        // Show label every 5 days for longer periods
        if (dayCount % 5 == 0) _chartLabels.add(key);
        else _chartLabels.add(""); 
      }
      dayCount++;
    });

    _currentAverage = docs.isEmpty ? 0 : sumPain / docs.length;
    _daysRecorded = dailyPainMap.values.where((l) => l.isNotEmpty).length;

    // Calculate Previous Average
    double prevSum = 0;
    for (var doc in prevDocs) {
      prevSum += ((doc.data() as Map<String, dynamic>)['painLevel'] ?? 0);
    }
    _previousAverage = prevDocs.isEmpty ? 0 : prevSum / prevDocs.length;
  }

  // --- UI BUILD ---
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
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildPeriodSelector(),
                const SizedBox(height: 20),
                _buildChartCard(),
                const SizedBox(height: 20),
                _buildPracticeProgressCard(),
                const SizedBox(height: 20),
                _buildBeforeAfterCard(),
                const SizedBox(height: 20),
                _buildSummaryGrid(),
                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  // --- WIDGETS ---

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
        onTap: () {
          setState(() {
            _selectedPeriodIndex = index;
          });
          _fetchFirestoreData(); // Reload data
        },
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
    // Check if chart is empty
    bool isEmpty = _chartData.isEmpty || _chartData.every((v) => v == 0);

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
          
          if (isEmpty)
            const SizedBox(
              height: 150,
              child: Center(child: Text("Sem dados de dor neste período.", style: TextStyle(color: Colors.grey))),
            )
          else
            Column(
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _SimpleLineChartPainter(
                      data: _chartData,
                      color: const Color(0xFF2962FF),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // X-Axis Labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _chartLabels.map((l) => 
                    Text(l, style: const TextStyle(color: Colors.grey, fontSize: 10))
                  ).toList(),
                ),
              ],
            ),
          
          const SizedBox(height: 15),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Sem dor (0)", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("Insuportável (10)", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeProgressCard() {
    if (_practiceCounts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Nenhuma prática realizada neste período.")),
      );
    }

    // Sort practices by count (descending)
    var sortedKeys = _practiceCounts.keys.toList(growable: false)
      ..sort((k1, k2) => _practiceCounts[k2]!.compareTo(_practiceCounts[k1]!));

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
                "Práticas Realizadas",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.pie_chart, color: Colors.teal[400]),
            ],
          ),
          const SizedBox(height: 20),
          
          // Generate list items dynamically
          ...sortedKeys.map((key) {
            int count = _practiceCounts[key]!;
            double percent = count / (_totalPractices == 0 ? 1 : _totalPractices);
            
            // Assign colors based on name
            Color color = Colors.blue;
            IconData icon = Icons.circle;
            if (key == "Meditação") { color = Colors.purple; icon = Icons.self_improvement; }
            else if (key == "Fitoterapia") { color = Colors.green; icon = Icons.eco; }
            else if (key == "Acupressão") { color = Colors.orange; icon = Icons.fingerprint; }

            return _buildProgressItem(key, "$count sessões", percent, color, icon);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, String subtitle, double percent, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
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
    double improvement = 0;
    bool improved = false;
    
    if (_previousAverage > 0) {
      improvement = ((_previousAverage - _currentAverage) / _previousAverage) * 100;
      improved = improvement > 0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Comparativo (Período Anterior)",
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
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("PERÍODO ANTERIOR", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text(_previousAverage.toStringAsFixed(1), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                    Text("Média de dor", style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: improved ? Colors.green.shade50 : (_currentAverage == 0 ? Colors.grey.shade50 : Colors.red.shade50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("PERÍODO ATUAL", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    Text(_currentAverage.toStringAsFixed(1), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, 
                        color: improved ? Colors.green[700] : (_currentAverage == 0 ? Colors.grey[700] : Colors.red[700]))),
                    Text("Média de dor", style: TextStyle(fontSize: 11, color: improved ? Colors.green[700] : Colors.grey[700])),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_previousAverage > 0)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: improved ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: improved ? Colors.green.shade100 : Colors.orange.shade100),
            ),
            child: Row(
              children: [
                Icon(improved ? Icons.arrow_downward : Icons.arrow_upward, color: improved ? Colors.green[700] : Colors.orange[700], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: improved ? Colors.green[800] : Colors.orange[800], fontSize: 13),
                      children: [
                        TextSpan(text: improved ? "Melhora de ${improvement.abs().toStringAsFixed(0)}% na dor\n" : "Aumento da dor.\n", style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: improved ? "Continue assim!" : "Considere rever suas práticas.", style: const TextStyle(fontSize: 11)),
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
          "Resumo em Números",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildSummaryItem("$_daysRecorded", "Dias c/ Dor", Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _buildSummaryItem("$_totalPractices", "Total Práticas", Colors.green)),
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

// --- Custom Painter for Chart ---

class _SimpleLineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SimpleLineChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Defines how much space we leave on the left for the numbers
    const double leftPadding = 25.0; 
    // The actual width available for the line graph
    final double chartWidth = size.width - leftPadding;

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

    final paintGrid = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1;

    // Helper to draw text
    final textPainter = TextPainter(
      textDirection: ui.TextDirection.ltr,
    );

    // Draw Grid Lines & Y-Axis Labels (0, 2, 4, 6, 8, 10)
    for (int i = 0; i <= 5; i++) {
       // Values: 0, 2, 4, 6, 8, 10
       int value = i * 2; 
       
       // Calculate Y position
       double y = size.height - (value / 10 * size.height);

       // 1. Draw Text
       textPainter.text = TextSpan(
         text: value.toString(),
         style: const TextStyle(color: Colors.grey, fontSize: 10),
       );
       textPainter.layout();
       // Position text centered vertically on the line, at X=0
       textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));

       // 2. Draw Grid Line (Starts after the text padding)
       canvas.drawLine(Offset(leftPadding, y), Offset(size.width, y), paintGrid);
    }

    if (data.isEmpty) return;

    final path = Path();
    final double stepX = data.length > 1 ? chartWidth / (data.length - 1) : chartWidth;
    
    double getY(double val) => size.height - (val / 10 * size.height);

    // Start drawing the line (Shifted by leftPadding)
    path.moveTo(leftPadding, getY(data[0]));

    for (int i = 1; i < data.length; i++) {
      path.lineTo(leftPadding + (i * stepX), getY(data[i]));
    }

    canvas.drawPath(path, paintLine);

    // Draw dots
    if (data.length < 15) {
      for (int i = 0; i < data.length; i++) {
        // Shift dot X position by leftPadding
        final cx = leftPadding + (i * stepX);
        final cy = getY(data[i]);
        
        if (data[i] == 0) continue; 

        canvas.drawCircle(Offset(cx, cy), 6, paintDotBorder);
        canvas.drawCircle(Offset(cx, cy), 4, paintDot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}