import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template register_page}
/// Registration (create account) page.
/// {@endtemplate}
class RegisterPage extends StatelessWidget {
  /// {@macro register_page}
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Criar conta', style: AppTextStyles.appBarTitle),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: context.pop,
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.xl,
          ),
          child: Column(
            children: [
              Text(
                'Bem-vindo ao Tô Lendo!',
                style: AppTextStyles.largeTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Salve seu progresso e sincronize sua biblioteca em todos os seus dispositivos.',
                style: AppTextStyles.secondaryMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.md),
              // Register Form
              RegisterFormWidget(),
              SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
