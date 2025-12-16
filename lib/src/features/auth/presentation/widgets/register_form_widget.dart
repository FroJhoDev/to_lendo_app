import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
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
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = injection<AuthCubit>();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      _authCubit.signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
      );
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
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) {
        if (state.status == AuthStateStatus.authenticated) {
          context.go(AppRoutes.home.path);
          return;
        }

        AppSnackbar.error(context, message: state.message);
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStateStatus.loading;

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
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputFieldWidget(
                label: 'Confirmar senha',
                hint: 'Confirme sua senha',
                icon: Icons.lock_outline,
                obscureText: true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButtonWidget(
                text: isLoading ? 'Criando conta...' : 'Criar conta',
                onPressed: isLoading ? null : _handleRegister,
              ),
            ],
          ),
        );
      },
    );
  }
}
