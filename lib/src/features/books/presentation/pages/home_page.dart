import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/core/core.dart';

/// {@template home_page}
/// Main page with book list (My Library).
/// {@endtemplate}
class HomePage extends StatefulWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFilter = 'Lendo';

  // Mock data
  final List<Map<String, dynamic>> _books = [
    {
      'title': 'A Arte da Guerra',
      'author': 'Sun Tzu',
      'pagesRead': 150,
      'totalPages': 300,
      'isCompleted': false,
    },
    {
      'title': 'O Hobbit',
      'author': 'J.R.R. Tolkien',
      'pagesRead': 310,
      'totalPages': 310,
      'isCompleted': true,
    },
    {
      'title': 'Duna',
      'author': 'Frank Herbert',
      'pagesRead': 80,
      'totalPages': 688,
      'isCompleted': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredBooks {
    if (_selectedFilter == 'Todos') {
      return _books;
    } else if (_selectedFilter == 'Concluídos') {
      return _books.where((book) => book['isCompleted'] == true).toList();
    } else {
      return _books.where((book) => book['isCompleted'] == false).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Minha Estante', style: AppTextStyles.appBarTitle),
        iconTheme: const IconThemeData(color: AppColors.black),
        leading: IconButton(
          icon: const Icon(Icons.menu_book_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(AppRoutes.profile.path),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xs,
              bottom: AppSpacing.nano,
            ),
            child: Row(
              children: [
                AppFilterChipWidget(
                  label: 'Lendo',
                  isSelected: _selectedFilter == 'Lendo',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFilter = 'Lendo';
                      });
                    }
                  },
                ),
                const SizedBox(width: AppSpacing.sm),
                AppFilterChipWidget(
                  label: 'Concluídos',
                  isSelected: _selectedFilter == 'Concluídos',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFilter = 'Concluídos';
                      });
                    }
                  },
                ),
                const SizedBox(width: AppSpacing.sm),
                AppFilterChipWidget(
                  label: 'Todos',
                  isSelected: _selectedFilter == 'Todos',
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFilter = 'Todos';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          // Books List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxs),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.nano,
                ),
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = _filteredBooks[index];
                  final progress =
                      (book['pagesRead'] as int) / (book['totalPages'] as int);
                  return AppBookCardWidget(
                    title: book['title'] as String,
                    author: book['author'] as String,
                    progress: progress,
                    totalPages: book['totalPages'] as int,
                    pagesRead: book['pagesRead'] as int,
                    isCompleted: book['isCompleted'] as bool,
                    onTap: () {
                      // TODO(team): Update when BookModel is implemented with proper ID
                      final bookId = (book['title'] as String?) ?? 'unknown';
                      context.push(
                        AppRoutes.bookDetails.path.replaceAll(':id', bookId),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Funcionalidade de adicionar livro em desenvolvimento',
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            child: const Icon(Icons.add, color: AppColors.white, size: 32),
          ),
        ),
      ),
    );
  }
}
