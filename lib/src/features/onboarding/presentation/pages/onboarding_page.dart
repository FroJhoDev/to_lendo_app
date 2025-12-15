import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/injections.dart';
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

  Future<void> _nextPage() async {
    if (_currentPage < _slides.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Mark onboarding as completed
      await injection<RedirectService>().markOnboardingCompleted();
      // Navigate to auth page
      if (mounted) {
        context.go(AppRoutes.auth.path);
      }
    }
  }

  Future<void> _skip() async {
    // Mark onboarding as completed
    await injection<RedirectService>().markOnboardingCompleted();
    if (mounted) {
      context.go(AppRoutes.auth.path);
    }
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
                    illustration: const BookIllustrationWidget(),
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
}
