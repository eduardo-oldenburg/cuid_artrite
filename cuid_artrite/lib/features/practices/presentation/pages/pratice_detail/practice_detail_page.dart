import 'dart:async'; //utilizado para o timer
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PracticeStep {
  final String title;
  final String description;
  final int durationSeconds;  // tempo em sefundos

  PracticeStep({
    required this.title,
    required this.description,
    this.durationSeconds = 0, // caso seja zero trata como apenas leitura
  });
}

class PracticeData {
  final String title;
  final String imageUrl;
  final String timeRange;
  final String goodFor;
  final String durationDetail;
  final String? safetyAlert;
  final List<PracticeStep> steps;
  final List<String> tips;

  PracticeData({
    required this.title,
    required this.imageUrl,
    required this.timeRange,
    required this.goodFor,
    required this.durationDetail,
    this.safetyAlert,
    required this.steps,
    required this.tips,
  });
}


class PracticeDetailPage extends StatelessWidget {
  final PracticeData data;

  const PracticeDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoSection(),
                        const SizedBox(height: 20),
                        if (data.safetyAlert != null) ...[
                          _buildSafetyAlert(),
                          const SizedBox(height: 24),
                        ],
                        const Text(
                          "Como Fazer",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStepsList(),
                        const SizedBox(height: 24),
                        _buildTipsBox(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250, width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            image: DecorationImage(image: AssetImage(data.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.center, colors: [Colors.black.withOpacity(0.4), Colors.transparent])),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                Expanded(child: Text(data.title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoSection() {  return Container(); } 
  Widget _buildSafetyAlert() { return Container(); }
  Widget _buildTipsBox() { return Container(); } 

  Widget _buildStepsList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.steps.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final step = data.steps[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30, height: 30,
                decoration: const BoxDecoration(color: Color(0xFF5E81F4), shape: BoxShape.circle),
                child: Center(child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(step.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333)))),
                        if (step.durationSeconds > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                const Icon(Icons.timer, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text("${step.durationSeconds}s", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                              ],
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(step.description, style: const TextStyle(color: Color(0xFF666666), fontSize: 14, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PracticeSessionPage(data: data),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5E81F4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          icon: const Icon(Icons.play_arrow, color: Colors.white),
          label: const Text("Iniciar Prática", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}

// tela da pratica do passo a passo

class PracticeSessionPage extends StatefulWidget {
  final PracticeData data;

  const PracticeSessionPage({super.key, required this.data});

  @override
  State<PracticeSessionPage> createState() => _PracticeSessionPageState();
}

class _PracticeSessionPageState extends State<PracticeSessionPage> {
  int _currentStepIndex = 0;
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isPaused = false;
  bool _isCompleted = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _startStep();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStep() {
    final step = widget.data.steps[_currentStepIndex];
    setState(() {
      _remainingSeconds = step.durationSeconds;
      _isPaused = false;
      _isCompleted = false;
    });

    _timer?.cancel();
    
    //caso tenha o timer inciia ele
    if (step.durationSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!_isPaused) {
          setState(() {
            if (_remainingSeconds > 0) {
              _remainingSeconds--;
            } else {
              // Tempo acabou
              timer.cancel();
              _isCompleted = true; 
            }
          });
        }
      });
    } else {
      // Passo sem tempo 
      setState(() {
        _isCompleted = true;
      });
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _nextStep() {
    if (_currentStepIndex < widget.data.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
      _startStep();
    } else {
      _showCompletionDialog(); //finalizou
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
      _startStep();
    }
  }

  Future<void> _savePracticeSession() async {
    setState(() => _isSaving = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (userId != null) {
        await FirebaseFirestore.instance.collection('practice_records').add({
          'userId': userId,
          'practiceTitle': widget.data.title, // e.g., "Meditação Guiada"
          'durationTotal': widget.data.durationDetail,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      debugPrint("Error saving practice: $e");
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showCompletionDialog() {
    _savePracticeSession();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Prática Concluída! 🎉"),
        content: const Text("Parabéns! Sua sessão foi registrada no seu histórico."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close page
            },
            child: const Text("Concluir"),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.data.steps[_currentStepIndex];
    final totalSteps = widget.data.steps.length;
    final progress = (_currentStepIndex + 1) / totalSteps;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Passo ${_currentStepIndex + 1} de $totalSteps",
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5E81F4)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentStep.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 20),

            // cronometro se existir
            if (currentStep.durationSeconds > 0) ...[
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: _remainingSeconds / currentStep.durationSeconds,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5E81F4)),
                    ),
                  ),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5E81F4),
                    ),
                  ),
                ],
              ),
            ] else ...[
              //caso nao tenha tempo
               Container(
                 width: 150, height: 150,
                 decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                 child: const Icon(Icons.menu_book, size: 60, color: Color(0xFF5E81F4)),
               )
            ],
            
            const SizedBox(height: 30),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  currentStep.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF555555),
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botão Anterior
                IconButton(
                  onPressed: _currentStepIndex > 0 ? _previousStep : null,
                  icon: const Icon(Icons.skip_previous_rounded, size: 40),
                  color: Colors.grey,
                ),

                // Botão Play/Pause (Só aparece se tiver timer e não acabou)
                if (currentStep.durationSeconds > 0 && !_isCompleted)
                  Container(
                    width: 70, height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5E81F4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _togglePause,
                      icon: Icon(_isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded),
                      color: Colors.white,
                      iconSize: 40,
                    ),
                  )
                else
                // Botão proximo, aparece caso cacabou o tempo ou seja leitura
                  SizedBox(
                    height: 60,
                    width: 160,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853), 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        _currentStepIndex == widget.data.steps.length - 1 ? "Finalizar" : "Próximo",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),

                // Botão pular
                IconButton(
                  onPressed: _nextStep,
                  icon: const Icon(Icons.skip_next_rounded, size: 40),
                  color: _isCompleted ? const Color(0xFF00C853) : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}