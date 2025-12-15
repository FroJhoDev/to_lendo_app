import 'package:flutter/material.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template register_form_widget}
/// Registration form widget.
/// {@endtemplate}
class RegisterFormWidget extends StatefulWidget {
  /// {@macro register_form_widget}
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // TODO(team): Implement registration logic
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            label: 'Nome',
            hint: 'Seu nome completo',
            icon: Icons.person_outline,
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: AppSpacing.md),
          AppInputFieldWidget(
            label: 'Email',
            hint: 'seuemail@exemplo.com',
            icon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),
          AppInputFieldWidget(
            label: 'Senha',
            hint: 'Sua senha',
            icon: Icons.lock_outline,
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: AppSpacing.md),
          AppInputFieldWidget(
            label: 'Confirmar senha',
            hint: 'Confirme sua senha',
            icon: Icons.lock_outline,
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButtonWidget(text: 'Criar conta', onPressed: _handleRegister),
        ],
      ),
    );
  }
}
