import 'package:flutter/material.dart';

class AppColors {
  // O construtor privado impede que a classe seja instanciada. 
  // Queremos usar apenas as propriedades estáticas.
  AppColors._();

  // --- Cores Principais ---
  static const Color primary = Color(0xFF6C7BF8); // Aquele azul bonito do topo
  static const Color background = Color(0xFFF5F7FA); // O fundo cinza bem clarinho
  static const Color white = Color(0xFFFFFFFF);
  
  static const Color textGrey = Color(0xFF9CA3AF);       // Grey text (secondary)
  static const Color inputBg = Color(0xFFF5F6FA);        // Input field background
  static const Color border = Color(0xFFE0E0E0);    
 
  // --- Textos ---
  static const Color textDark = Color(0xFF37474F); // Cinza escuro para títulos
  static const Color textLight = Colors.white; // Texto em cima de fundos escuros

  // --- Cores dos Cards (Menu) ---
  // Vermelho (Registrar Dor)
  static const Color cardRedBg = Color(0xFFFFCDD2);
  static const Color cardRedIcon = Color(0xFFD32F2F);

  // Azul (Técnicas)
  static const Color cardBlueBg = Color(0xFFBBDEFB);
  static const Color cardBlueIcon = Color(0xFF1976D2);

  // Verde (Diário)
  static const Color cardGreenBg = Color(0xFFC8E6C9);
  static const Color cardGreenIcon = Color(0xFF388E3C);

  // Roxo (Relatórios)
  static const Color cardPurpleBg = Color(0xFFE1BEE7);
  static const Color cardPurpleIcon = Color(0xFF7B1FA2);

  // Laranja (Educativo)
  static const Color cardOrangeBg = Color(0xFFFFE0B2);
  static const Color cardOrangeIcon = Color(0xFFF57C00);
}