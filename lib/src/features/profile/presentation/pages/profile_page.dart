import 'dart:async';

import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

/// {@template profile_page}
/// User profile page.
/// {@endtemplate}
class ProfilePage extends StatefulWidget {
  /// {@macro profile_page}
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authCubit = injection<AuthCubit>();

  Future<void> _confirmAndLogout() async {
    final shouldLogout =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Sair do aplicativo'),
            content: const Text('Você realmente deseja sair do aplicativo?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancelar')),
              TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Sair')),
            ],
          ),
        ) ??
        false;

    if (!shouldLogout) {
      return;
    }

    unawaited(_authCubit.signOut());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) {
        if (state.status == AuthStateStatus.unauthenticated) {
          context.go(AppRoutes.auth.path);
          return;
        }

        if (state.status == AuthStateStatus.error) {
          AppSnackbar.error(context, message: state.message);
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const HugeIcon(icon: AppIcons.back, color: AppColors.black, size: 20),
            onPressed: () => context.pop(),
          ),
          title: const Text('Perfil'),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - AppSpacing.lg * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.lightLavender,
                            border: Border.all(color: AppColors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const HugeIcon(icon: AppIcons.user, size: 21, color: AppColors.mediumPurple),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        // User Name
                        const Text('Ana Oliveira', style: AppTextStyles.heading2),
                        const SizedBox(height: AppSpacing.nano),
                        // User Email
                        Text(
                          'ana.oliveira@email.com',
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        // Statistics Cards
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.push(AppRoutes.statistics.path),
                                child: AppCardWidget(
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Livros Concluídos',
                                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text('15', style: AppTextStyles.heading1.copyWith(fontSize: 32)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context.push(AppRoutes.statistics.path),
                                child: AppCardWidget(
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Páginas Lidas',
                                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text('4350', style: AppTextStyles.heading1.copyWith(fontSize: 32)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          width: double.infinity,
                          child: AppButtonWidget(
                            text: 'Editar Perfil',
                            onPressed: () {
                              context.push(AppRoutes.statistics.path);
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton(
                          onPressed: _confirmAndLogout,
                          child: Text(
                            'Sair',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.orangeAlt,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: Text(
                        'Última sincronização: hoje, às 14:30',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
