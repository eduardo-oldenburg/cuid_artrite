import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../../../../core/theme/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // --- Controllers for Text Fields ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- State Variables ---
  String _selectedGender = '';
  bool _lgpdProcessing = false;
  bool _lgpdCommunications = false;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Logic: Select Date ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // --- Logic: Save to Firestore ---
  Future<void> _registerUser() async {
    // 1. Basic Validation
    if (_nameController.text.isEmpty ||
        _birthDateController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty || // Validate Password
        _selectedGender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos.")),
      );
      return;
    }

    if (!_lgpdProcessing) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O consentimento LGPD é obrigatório.")),
      );
      return;
    }

    // 2. Start Loading
    setState(() => _isLoading = true);

    try {
      // 3. Send to Firestore
      // NOTE: In production, use FirebaseAuth for passwords, not Firestore!
      await FirebaseFirestore.instance.collection('users').add({
        'fullName': _nameController.text.trim(),
        'birthDate': _birthDateController.text,
        'gender': _selectedGender,
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        // Storing password here is for demo purposes only. 
        // Ideally, do not store passwords in DB.
        'password': _passwordController.text, 
        'lgpd_processing': _lgpdProcessing,
        'lgpd_communications': _lgpdCommunications,
        'created_at': FieldValue.serverTimestamp(),
      });

      // 4. Success Feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cadastro realizado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); 
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Cadastro",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Progress Bar ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: AppColors.background,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Etapa 1 de 4", style: TextStyle(color: AppColors.textDark)),
                      Text("25%", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.25,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informações Básicas",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 4),
                  const Text("Preencha seus dados pessoais", style: TextStyle(color: AppColors.textGrey)),
                  const SizedBox(height: 24),

                  // --- Form Fields ---
                  
                  _buildLabel("Nome Completo", Icons.person),
                  _buildInput("Digite seu nome completo", controller: _nameController),

                  _buildLabel("Data de Nascimento", Icons.calendar_today),
                  _buildInput(
                    "DD/MM/AAAA",
                    controller: _birthDateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),

                  _buildLabel("Sexo", Icons.transgender),
                  Row(
                    children: [
                      Expanded(child: _buildGenderButton("Masculino")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildGenderButton("Feminino")),
                      const SizedBox(width: 8),
                      Expanded(child: _buildGenderButton("Outro")),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildLabel("Telefone", Icons.phone),
                  _buildInput("(11) 99999-9999", isNumber: true, controller: _phoneController),

                  _buildLabel("Email", Icons.email),
                  _buildInput("seu@email.com", controller: _emailController),

                  // 3. New Password Field UI
                  _buildLabel("Senha", Icons.lock),
                  _buildInput(
                    "Crie uma senha segura", 
                    controller: _passwordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),

                  // --- LGPD ---
                  const Text(
                    "Consentimento LGPD",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 16),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.security, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Proteção de Dados Pessoais",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Seus dados serão utilizados exclusivamente para prestação de serviços de saúde, conforme a Lei Geral de Proteção de Dados (LGPD).",
                                style: TextStyle(fontSize: 12, color: Color(0xFF1E3A8A)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildCheckbox(
                    value: _lgpdProcessing,
                    text: "Aceito o processamento dos meus dados pessoais para prestação de serviços de saúde",
                    onChanged: (v) => setState(() => _lgpdProcessing = v!),
                  ),
                  const SizedBox(height: 12),
                  _buildCheckbox(
                    value: _lgpdCommunications,
                    text: "Aceito receber comunicações sobre meus cuidados de saúde via email/SMS",
                    onChanged: (v) => setState(() => _lgpdCommunications = v!),
                  ),

                  const SizedBox(height: 24),

                  // --- Action Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              "Continuar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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

  // --- Helpers ---

  Widget _buildLabel(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 4. Updated Helper to handle Passwords
  Widget _buildInput(String hint, {
    bool isNumber = false, 
    TextEditingController? controller, 
    bool readOnly = false,
    VoidCallback? onTap,
    bool isPassword = false, // New parameter
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        obscureText: isPassword ? !_isPasswordVisible : false, // Mask text if password
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
          filled: true,
          fillColor: AppColors.inputBg,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          // Suffix Logic: Eye icon for password OR Calendar icon for date
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : (readOnly ? const Icon(Icons.calendar_month, color: AppColors.textGrey) : null),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label) {
    final bool isSelected = _selectedGender == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppColors.inputBg,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.primary : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox({required bool value, required String text, required Function(bool?) onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textDark, fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}