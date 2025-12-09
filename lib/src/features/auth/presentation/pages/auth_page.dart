import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template auth_page}
/// Authentication (login) page.
/// {@endtemplate}
class AuthPage extends StatelessWidget {
  /// {@macro auth_page}
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl),
              // Logo and App Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book,
                    color: AppColors.orange,
                    size: 40,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Tô Lendo',
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              // Welcome Message
              const Text(
                'Bem-vindo de volta!',
                style: AppTextStyles.largeTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Faça login para acessar seus livros.',
                style: AppTextStyles.secondaryMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              // Login Form
              const LoginFormWidget(),
              const SizedBox(height: AppSpacing.xl),
              // Footer with cloud sync info
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.mediumPurple,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'Seus livros e progresso são salvos na nuvem.',
                    style: AppTextStyles.secondaryMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
