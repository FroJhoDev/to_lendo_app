import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template login_form_widget}
/// Login form widget.
/// {@endtemplate}
class LoginFormWidget extends StatefulWidget {
  /// {@macro login_form_widget}
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // if (_formKey.currentState?.validate() ?? false) {
    context.go(AppRoutes.home.path);
    // }
  }

  void _handleCreateAccount() => context.push(AppRoutes.register.path);

  void _handleForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Funcionalidade de recuperação de senha em desenvolvimento',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInputFieldWidget(
            label: 'Email',
            hint: 'seuemail@exemplo.com',
            icon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu email';
              }
              if (!value.contains('@')) {
                return 'Por favor, insira um email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppInputFieldWidget(
            label: 'Senha',
            hint: 'Sua senha',
            icon: Icons.lock_outline,
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _handleForgotPassword,
              child: const Text(
                'Esqueceu a senha?',
                style: AppTextStyles.forgotPassword,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButtonWidget(text: 'Entrar', onPressed: _handleLogin),
          const SizedBox(height: AppSpacing.md),
          const AppSeparatorWidget(),
          const SizedBox(height: AppSpacing.md),
          AppButtonWidget(
            text: 'Criar uma conta',
            onPressed: _handleCreateAccount,
            variant: ButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
