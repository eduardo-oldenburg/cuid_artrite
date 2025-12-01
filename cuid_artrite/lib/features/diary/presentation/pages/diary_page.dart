import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPrefs
import '../../../../core/theme/app_colors.dart'; 

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  // State
  String _selectedMood = "Bem";
  double _energyLevel = 5.0;
  final List<String> _selectedSensations = [];
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false; // Added loading state

  // Emoji Data
  final List<Map<String, dynamic>> _moods = [
    {"label": "Ótimo", "emoji": "😄", "color": Colors.green},
    {"label": "Bem", "emoji": "🙂", "color": Colors.lightGreen},
    {"label": "Ok", "emoji": "😐", "color": Colors.amber},
    {"label": "Baixo", "emoji": "😔", "color": Colors.orange},
    {"label": "Mal", "emoji": "😢", "color": Colors.red},
  ];

  // Sensation Data
  final List<Map<String, dynamic>> _sensations = [
    {"label": "Relaxado", "icon": Icons.spa_outlined},
    {"label": "Energizado", "icon": Icons.bolt},
    {"label": "Leve", "icon": Icons.cloud_outlined},
    {"label": "Pesado", "icon": Icons.landscape},
    {"label": "Aquecido", "icon": Icons.wb_sunny_outlined},
    {"label": "Refrescado", "icon": Icons.ac_unit},
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _toggleSensation(String label) {
    setState(() {
      if (_selectedSensations.contains(label)) {
        _selectedSensations.remove(label);
      } else {
        _selectedSensations.add(label);
      }
    });
  }

  // --- Logic: Save to Firestore ---
  Future<void> _saveDiaryEntry() async {
    setState(() => _isLoading = true);

    try {
      // 1. Get User ID
      final prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      if (userId == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Erro: Usuário não identificado.")),
          );
        }
        return;
      }

      // 2. Prepare Data
      final Map<String, dynamic> diaryData = {
        'userId': userId,
        'mood': _selectedMood,
        'energyLevel': _energyLevel.toInt(),
        'sensations': _selectedSensations,
        'notes': _notesController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'dateString': DateTime.now().toIso8601String(), // Useful for sorting
      };

      // 3. Send to Firestore (Collection: 'diary_records')
      await FirebaseFirestore.instance.collection('diary_records').add(diaryData);

      // 4. Success Feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Diário salvo com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Close page
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao salvar: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF5E81F4), 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Diário de Sensações",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF5E81F4), 
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
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
                    child: const Icon(Icons.favorite, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Como você se sente após a prática?",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mood Section
                  const Text(
                    "Estado emocional",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _moods.map((mood) {
                      return _buildMoodOption(
                        label: mood['label'],
                        emoji: mood['emoji'],
                        isSelected: _selectedMood == mood['label'],
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // Energy Level Section
                  const Text(
                    "Nível de energia",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xFF2962FF),
                      inactiveTrackColor: Colors.grey[300],
                      thumbColor: const Color(0xFF2962FF),
                      overlayColor: const Color(0xFF2962FF).withOpacity(0.2),
                      trackHeight: 6.0,
                    ),
                    child: Slider(
                      value: _energyLevel,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      onChanged: (value) {
                        setState(() {
                          _energyLevel = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Baixa", style: TextStyle(color: Colors.grey)),
                        Text("Moderada", style: TextStyle(color: Colors.grey)),
                        Text("Alta", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${_energyLevel.toInt()}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5E81F4),
                              ),
                            ),
                            const TextSpan(
                              text: " /10",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Sensations Section
                  const Text(
                    "Sensações físicas",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _sensations.map((sensation) {
                      final width = (MediaQuery.of(context).size.width - 40 - 12) / 2;
                      return _buildSensationCard(
                        width: width,
                        label: sensation['label'],
                        icon: sensation['icon'],
                        isSelected: _selectedSensations.contains(sensation['label']),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // Notes Section
                  const Text(
                    "Anotações pessoais",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Descreva como foi sua experiência, insights ou qualquer observação...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${_notesController.text.length}/500",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E81F4), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _isLoading ? null : _saveDiaryEntry, // Logic attached
                      child: _isLoading 
                        ? const SizedBox(
                            height: 24, width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            "Salvar no Diário",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Mood Option
  Widget _buildMoodOption({required String label, required String emoji, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = label;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFF9C4) : Colors.white, 
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isSelected)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
              ],
              border: isSelected ? Border.all(color: Colors.amber, width: 2) : null,
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Sensation Card
  Widget _buildSensationCard({
    required double width,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _toggleSensation(label),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF5E81F4) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? const Color(0xFF5E81F4) : const Color(0xFF5E81F4), 
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.black87 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}