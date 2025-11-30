import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'education_page.dart';

class EducationDetailPage extends StatelessWidget {
  final EducationItem item;

  const EducationDetailPage({
    super.key,
    required this.item,
  });

  // Função auxiliar para pegar o ID do vídeo do Youtube
  String? _getYoutubeThumbnail(String url) {
    // Tenta extrair o ID do vídeo da URL
    try {
      final uri = Uri.parse(url);
      if (uri.host.contains('youtube.com')) {
        return "https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg";
      } else if (uri.host.contains('youtu.be')) {
        return "https://img.youtube.com/vi/${uri.pathSegments.first}/0.jpg";
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: Text(
          item.category.toUpperCase(),
          style: TextStyle(
            color: item.color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CABEÇALHO ---
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: item.bgLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: item.color, size: 40),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 18, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  "Leitura: ${item.time}",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(height: 1),
            const SizedBox(height: 32),

            // --- CONTEÚDO DINÂMICO ---
            ...item.content.map((section) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _buildSection(context, section),
              );
            }).toList(),

            const SizedBox(height: 40),
            // Botão Concluir
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check),
                label: const Text("Concluir Leitura"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.bgLight,
                  foregroundColor: item.color,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, EducationSection section) {
    switch (section.type) {
      case EducationSectionType.text:
        return Text(
          section.data,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF4A4A4A),
            height: 1.6,
          ),
        );

      case EducationSectionType.image:
        return Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // Lógica de Fallback: Tenta Asset -> Se falhar, tenta Network -> Se falhar, mostra erro
              child: Image.asset(
                section.data,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Se não achar no asset (pasta), tenta carregar como URL da internet
                  return Image.network(
                    section.data,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                       // Se falhar tudo, mostra placeholder
                       return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text("Imagem indisponível", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (section.caption != null) ...[
              const SizedBox(height: 8),
              Text(
                section.caption!,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic),
              ),
            ]
          ],
        );

      case EducationSectionType.video:
        // Pega a thumbnail real do YouTube
        final thumbnailUrl = _getYoutubeThumbnail(section.data);

        return GestureDetector(
          onTap: () {
           final url = Uri.parse(section.data);
          launchUrl(url, mode: LaunchMode.externalApplication);

          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              image: thumbnailUrl != null 
                ? DecorationImage(
                    image: NetworkImage(thumbnailUrl),
                    fit: BoxFit.cover,
                    opacity: 0.7, // Escurece um pouco para o ícone de play aparecer melhor
                  )
                : null,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
              ),
            ),
          ),
        );

      case EducationSectionType.subtitle:
        return Text(
          section.data,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        );
    }
  }
}