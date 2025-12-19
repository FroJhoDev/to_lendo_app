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
  final AuthCubit _authCubit = injection<AuthCubit>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleRegister() => _formKey.currentState?.validate() ?? false
      ? _authCubit.signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
        )
      : null;

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
          AppSnackbar.success(
            context,
            message: 'Conta criada com sucesso! Você será redirecionado para a tela inicial.',
          );
          context.go(AppRoutes.home.path);
          return;
        }

        if (state.status == AuthStateStatus.error) {
          AppSnackbar.error(context, message: state.message);
          return;
        }
      },
      builder: (context, state) => switch (state.status) {
        AuthStateStatus.loading => const AppLoadingWidget(
          title: 'Preparando tudo para você...',
          subtitle: 'Por favor, aguarde...',
        ),
        _ => Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppInputFieldWidget(
                label: 'Nome',
                hint: 'Seu nome completo',
                icon: AppIcons.user,
                controller: _nameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputFieldWidget(
                label: 'Email',
                hint: 'seuemail@exemplo.com',
                icon: AppIcons.email,
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
                icon: AppIcons.password,
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
                icon: AppIcons.password,
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
              AppButtonWidget.primary(text: 'Criar conta', onPressed: _handleRegister),
            ],
          ),
        ),
      },
    );
  }
}
