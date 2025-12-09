import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template onboarding_page}
/// Onboarding page with app presentation slides.
/// {@endtemplate}
class OnboardingPage extends StatefulWidget {
  /// {@macro onboarding_page}
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Registre seu progresso diariamente.',
      'description':
          'Crie o hábito da leitura e veja sua evolução a cada página.',
    },
    {
      'title': 'Acompanhe suas estatísticas.',
      'description':
          'Veja quantas páginas você leu, seus dias consecutivos e muito mais.',
    },
    {
      'title': 'Sincronize na nuvem.',
      'description':
          'Seus livros e progresso são salvos automaticamente na nuvem.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to auth page
      Navigator.of(context).pushReplacementNamed('/auth');
    }
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.peachBackgroundAlt,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return OnboardingSlideWidget(
                    title: _slides[index]['title']!,
                    description: _slides[index]['description']!,
                    illustration: _buildBookIllustration(),
                  );
                },
              ),
            ),
            // Bottom section with indicators and buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  OnboardingIndicatorWidget(
                    currentIndex: _currentPage,
                    totalPages: _slides.length,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skip,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                        ),
                        child: Text(
                          'Pular',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.mediumPurpleAlt,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: AppButtonWidget(
                          text: 'Próximo',
                          onPressed: _nextPage,
                          variant: ButtonVariant.secondary,
                        ),
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

  Widget _buildBookIllustration() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Book pages
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 4,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 60,
                            height: 4,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 4,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 80,
                            height: 4,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Book spine
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 8,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFD4DDE8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
