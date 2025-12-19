import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xl),
              Image.asset(AppImages.appLogo, height: 80, fit: BoxFit.contain),
              const SizedBox(height: AppSpacing.xl),
              const Text('Bem-vindo de volta!', style: AppTextStyles.largeTitle, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Faça login para acessar seus livros.',
                style: AppTextStyles.secondaryMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              const LoginFormWidget(),
              const SizedBox(height: AppSpacing.xl),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(icon: AppIcons.cloudSync, color: AppColors.mediumPurple, size: 20),
                  SizedBox(width: AppSpacing.xs),
                  Text('Seus livros e progresso são salvos na nuvem.', style: AppTextStyles.secondaryMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
