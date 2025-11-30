import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart'; // Make sure this path is correct

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Using white for login background specifically
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              
              // --- 1. Logo ---
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flash_on_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- 2. Title ---
              const Center(
                child: Text(
                  "Bem-vindo",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Entre na sua conta para continuar",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // --- 3. Inputs ---
              _buildLabel("E-mail"),
              const SizedBox(height: 8),
              _buildTextField(
                hint: "seu@email.com",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 24),

              _buildLabel("Senha"),
              const SizedBox(height: 8),
              _buildTextField(
                hint: "••••••••",
                icon: Icons.lock_outline_rounded,
                isPassword: true,
              ),

              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Esqueceu a senha?",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- 4. Login Button ---
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home Page on click
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 32),

              // --- 5. Social Divider ---
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      "ou continue com",
                      style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 32),

              // --- 6. Social Buttons ---
              _buildSocialButton(
                icon: Icons.g_mobiledata, 
                label: "Continuar com Google",
                iconColor: Colors.red,
              ),
              const SizedBox(height: 16),
              _buildSocialButton(
                icon: Icons.apple,
                label: "Continuar com Apple",
                iconColor: Colors.black,
              ),

              const SizedBox(height: 40),

              // --- 7. Footer ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Não tem uma conta?",
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Criar conta",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon, bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword ? !_isPasswordVisible : false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textGrey),
        prefixIcon: Icon(icon, color: AppColors.textGrey),
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
            : null,
        filled: true,
        fillColor: AppColors.inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String label, required Color iconColor}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}