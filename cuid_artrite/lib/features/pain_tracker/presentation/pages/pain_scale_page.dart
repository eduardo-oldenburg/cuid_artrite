import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PainScalePage extends StatefulWidget {
  const PainScalePage({super.key});

  @override
  State<PainScalePage> createState() => _PainScalePageState();
}

class _PainScalePageState extends State<PainScalePage> {
  int? _selectedPainLevel; // Stores pain level
  final List<String> _selectedBodyParts = []; // Stores selected body parts
  bool _isLoading = false; // Loading state for the button

  // --- Logic: Save to Firebase ---
  Future<void> _savePainRecord() async {
    // 1. Validation
    if (_selectedPainLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione um nível de dor."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. Get User ID from Session
      final prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('userId');

      if (userId == null) {
        // Just in case session is lost
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro: Usuário não identificado.")),
        );
        return;
      }

      // 3. Prepare Data
      final Map<String, dynamic> painData = {
        'userId': userId,
        'painLevel': _selectedPainLevel,
        'painDescription': _getPainDescription(),
        'bodyParts': _selectedBodyParts,
        'timestamp': FieldValue.serverTimestamp(), // Server time is accurate
        'dateString': DateTime.now().toString(), // Helper for sorting locally if needed
      };

      // 4. Send to Firestore
      await FirebaseFirestore.instance.collection('pain_records').add(painData);

      // 5. Success Feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registro salvo com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        
        // Optional: Clear form or go back
        setState(() {
          _selectedPainLevel = null;
          _selectedBodyParts.clear();
        });
        // Navigator.pop(context); // Uncomment if you want to close page after save
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

  // Colors based on scale
  Color _getPainColor(int level) {
    if (level <= 2) return const Color(0xFFC8E6C9); 
    if (level <= 4) return const Color(0xFFFFF9C4); 
    if (level <= 6) return const Color(0xFFFFCCBC); 
    if (level <= 8) return const Color(0xFFFFAB91); 
    return const Color(0xFFFFCDD2); 
  }
  
  Color _getPainTextColor(int level) {
    if (level <= 2) return Colors.green.shade800;
    if (level <= 4) return Colors.orange.shade800;
    if (level <= 6) return Colors.deepOrange.shade800;
    if (level <= 8) return Colors.red.shade800;
    return Colors.red.shade900;
  }

  // Description based on level
  String _getPainDescription() {
    if (_selectedPainLevel == null) {
      return "Selecione um número para ver a descrição";
    }
    final level = _selectedPainLevel!;
    if (level == 0) return "Sem dor. Sente-se normal.";
    if (level <= 2) return "Dor leve. Quase imperceptível.";
    if (level <= 4) return "Dor moderada. Incomoda, mas suportável.";
    if (level <= 6) return "Dor forte. Atrapalha atividades diárias.";
    if (level <= 8) return "Dor muito forte. Difícil de ignorar.";
    return "Dor insuportável. Necessita de ajuda urgente.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),  
      appBar: AppBar(
        title: const Text(
          "Escala da Dor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF5E81F4), 
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Como está sua dor hoje?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 10),
              
              // Legends
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sem dor", style: TextStyle(color: Colors.grey)),
                  Text("Insuportável", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(11, (index) {
                    final isSelected = _selectedPainLevel == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPainLevel = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? _getPainTextColor(index)
                              : _getPainColor(index),    
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected 
                              ? Border.all(color: Colors.black12, width: 2) 
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "$index",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected 
                                ? Colors.white 
                                : _getPainTextColor(index),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  _getPainDescription(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedPainLevel == null 
                        ? Colors.grey 
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Onde está a dor?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // Geometric Body
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildBodyPart("Cabeça", width: 60, height: 60, shape: BoxShape.circle),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBodyPart("Braço Esq", width: 30, height: 80),
                        const SizedBox(width: 5),
                        _buildBodyPart("Tronco", width: 70, height: 100),
                        const SizedBox(width: 5),
                        _buildBodyPart("Braço Dir", width: 30, height: 80),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                             _buildBodyPart("Coxa Esq", width: 30, height: 60),
                             const SizedBox(height: 2),
                             _buildBodyPart("Perna Esq", width: 30, height: 60),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                             _buildBodyPart("Coxa Dir", width: 30, height: 60),
                             const SizedBox(height: 2),
                             _buildBodyPart("Perna Dir", width: 30, height: 60),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Áreas selecionadas:",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      _selectedBodyParts.isEmpty
                          ? "Nenhuma área selecionada"
                          : _selectedBodyParts.join(", "),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- Save Button Updated ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2962FF), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _savePainRecord, // Disable if loading
                  icon: _isLoading 
                      ? Container() // Hide icon when loading
                      : const Icon(Icons.save, color: Colors.white),
                  label: _isLoading
                      ? const SizedBox(
                          height: 20, 
                          width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Text(
                          "Salvar Avaliação",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to create clickable body parts
  Widget _buildBodyPart(String id, {required double width, required double height, BoxShape shape = BoxShape.rectangle}) {
    final isSelected = _selectedBodyParts.contains(id);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedBodyParts.remove(id);
          } else {
            _selectedBodyParts.add(id);
          }
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFCDD2) : Colors.white, 
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(4) : null,
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}