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
  final _authCubit = injection<AuthCubit>();

  void _handleLogin() => _formKey.currentState?.validate() ?? false
      ? _authCubit.signInWithEmail(email: _emailController.text.trim(), password: _passwordController.text)
      : null;

  void _handleCreateAccount() => context.push(AppRoutes.register.path);

  void _handleForgotPassword() {
    // TODO(team): Navigate to forgot password page when implemented
    AppSnackbar.info(context, message: 'Funcionalidade de recuperação de senha em desenvolvimento');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

        if (state.status == AuthStateStatus.error) {
          AppSnackbar.error(context, message: state.message);
          return;
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStateStatus.loading;

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
                  onPressed: isLoading ? null : _handleForgotPassword,
                  child: const Text('Esqueceu a senha?', style: AppTextStyles.forgotPassword),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButtonWidget(text: isLoading ? 'Entrando...' : 'Entrar', onPressed: isLoading ? null : _handleLogin),
              const SizedBox(height: AppSpacing.md),
              const AppSeparatorWidget(),
              const SizedBox(height: AppSpacing.md),
              AppButtonWidget(
                text: 'Criar uma conta',
                onPressed: isLoading ? null : _handleCreateAccount,
                variant: ButtonVariant.secondary,
              ),
            ],
          ),
        );
      },
    );
  }
}
