# Documentação de Arquitetura

## Índice

1. [Visão Geral](#visão-geral)
2. [Estrutura de Pastas](#estrutura-de-pastas)
3. [Arquitetura Clean](#arquitetura-clean)
4. [Padrões de Código](#padrões-de-código)
5. [Injeção de Dependências](#injeção-de-dependências)
6. [Gerenciamento de Estado](#gerenciamento-de-estado)
7. [Roteamento](#roteamento)
8. [Tema e Estilos](#tema-e-estilos)
9. [Componentização de Widgets](#componentização-de-widgets)
10. [Extensions](#extensions)
11. [Mixins](#mixins)
12. [Constants e Assets](#constants-e-assets)
13. [Barrel Files](#barrel-files)
14. [Pacote Packages](#pacote-packages)
15. [Database e Datasources](#database-e-datasources)
16. [Services](#services)
17. [Modelo de Dados do App](#modelo-de-dados-do-app)
18. [Models](#models)
19. [Sincronização Offline/Online](#sincronização-offlineonline)
20. [Boas Práticas](#boas-práticas)

---

## Visão Geral

O **Tô Lendo** é uma aplicação Flutter desenvolvida seguindo os princípios da **Clean Architecture**, com separação clara de responsabilidades em camadas (Domain, Data, Presentation). O projeto utiliza **BLoC/Cubit** para gerenciamento de estado, **GetIt** para injeção de dependências, e **GoRouter** para navegação.

O aplicativo é projetado com arquitetura **offline-first**, permitindo que os usuários registrem e acompanhem seu progresso de leitura mesmo sem conexão com a internet, sincronizando automaticamente com o Supabase quando houver conectividade.

### Tecnologias Principais

- **Frontend**: Flutter SDK
- **Gerenciamento de Estado**: flutter_bloc (Bloc/Cubit)
- **Banco de Dados Local**: SQLite (sqflite) - offline-first
- **Backend**: Supabase (Auth, Database e Storage)
- **Injeção de Dependências**: GetIt
- **Roteamento**: GoRouter
- **HTTP Client**: Supabase Client + dio package (quando necessário)
- **Funcional Programming**: fpdart (Either pattern)
- **Code Generation**: freezed, json_serializable
- **Seleção de Imagens**: image_picker (galeria e câmera)
- **Gráficos e Visualizações**: Pacotes para gráficos de progresso e estatísticas

---

## Estrutura de Pastas

```
lib/
├── main.dart                    # Entry point principal
├── main_dev.dart                # Entry point para desenvolvimento
├── main_prod.dart               # Entry point para produção
├── initialization.dart          # Inicialização do app (Firebase, DB, etc)
└── src/
    ├── src.dart                 # Barrel file principal
    ├── injections.dart          # Configuração de injeção de dependências
    ├── my_app.dart              # Widget raiz da aplicação
    ├── core/                    # Funcionalidades compartilhadas
    │   ├── assets/              # Constantes de assets (imagens, animações)
    │   ├── constants/            # Constantes da aplicação
    │   ├── database/            # Configuração e datasources do banco
    │   ├── extensions/          # Extensions para otimizar código
    │   ├── mixins/              # Mixins reutilizáveis
    │   ├── models/              # Modelos compartilhados
    │   ├── routers/             # Configuração de rotas
    │   ├── services/           # Serviços compartilhados
    │   ├── styles/             # Tema e estilos
    │   └── widgets/             # Widgets reutilizáveis
    └── features/                # Features do app (Clean Architecture)
        ├── onboarding/          # Tela de onboarding
        ├── auth/                # Autenticação (login, registro)
        ├── books/               # Gerenciamento de livros
        ├── reading_sessions/    # Sessões de leitura
        ├── statistics/         # Estatísticas e gráficos
        ├── profile/             # Perfil do usuário
        └── sync/                # Sincronização offline/online
```

### Estrutura de uma Feature

Cada feature segue o padrão Clean Architecture com três camadas:

```
feature_name/
├── feature_name.dart            # Barrel file da feature
├── feature_name_injection.dart  # Injeção de dependências da feature
├── data/                        # Camada de Dados
│   ├── data.dart               # Barrel file
│   ├── datasources/            # Fontes de dados (opcional)
│   ├── models/                 # Modelos específicos da feature
│   └── repositories/           # Implementações dos repositórios
│       └── exceptions/         # Exceções específicas
├── domain/                      # Camada de Domínio
│   ├── domain.dart             # Barrel file
│   ├── entities/               # Entidades de negócio (opcional)
│   ├── repositories/           # Contratos dos repositórios
│   └── usecases/               # Casos de uso (opcional)
└── presentation/               # Camada de Apresentação
    ├── presentation.dart       # Barrel file
    ├── cubit/                  # Gerenciamento de estado
    ├── pages/                  # Páginas da feature
    └── widgets/                # Widgets específicos da feature
```

---

## Arquitetura Clean

O projeto implementa **Clean Architecture** com três camadas principais:

### 1. Domain Layer (Camada de Domínio)

**Responsabilidade**: Contém a lógica de negócio pura, independente de frameworks e bibliotecas externas.

**Componentes**:
- **Repositories (Contratos)**: Interfaces abstratas que definem os contratos de acesso a dados
- **Entities**: Entidades de negócio (quando necessário)
- **Use Cases**: Casos de uso específicos (quando necessário)
- **Exceptions**: Exceções de domínio

**Exemplo - Repository Contract**:
```dart
// domain/repositories/book_repository.dart
abstract interface class BookRepository {
  Future<Either<BookException, BookModel>> addBook({
    required BookModel book,
  });
  
  Future<Either<BookException, List<BookModel>>> getBooks({
    BookStatus? status,
  });
  
  Future<Either<BookException, BookModel>> updateBook({
    required BookModel book,
  });
  
  Future<Either<BookException, void>> deleteBook({
    required String bookId,
  });
}
```

**Características**:
- Não depende de nenhuma camada externa
- Define contratos através de interfaces abstratas
- Usa `Either` do fpdart para tratamento de erros
- Exceções customizadas para cada feature

### 2. Data Layer (Camada de Dados)

**Responsabilidade**: Implementa os contratos definidos na camada de domínio, gerencia fontes de dados (API, banco local, etc).

**Componentes**:
- **Repository Implementations**: Implementam os contratos do domain
- **Datasources**: Acesso direto a fontes de dados (API, banco local)
- **Models**: Modelos de dados com serialização JSON
- **Exception Implementations**: Implementações de exceções

**Exemplo - Repository Implementation**:
```dart
// data/repositories/book_repository_impl.dart
class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.syncService,
  });
  
  final BookLocalDatasource localDatasource;
  final BookRemoteDatasource remoteDatasource;
  final SyncService syncService;
  
  @override
  Future<Either<BookException, BookModel>> addBook({
    required BookModel book,
  }) async {
    try {
      // Salva localmente primeiro (offline-first)
      final localBook = await localDatasource.insertBook(book);
      
      // Marca para sincronização
      await syncService.markForSync(
        entityType: EntityType.book,
        entityId: localBook.id,
        operation: SyncOperation.create,
      );
      
      // Tenta sincronizar se houver conexão
      await syncService.syncIfConnected();
      
      return Right(localBook);
    } catch (error) {
      return Left(BookException(error.toString()));
    }
  }
  
  @override
  Future<Either<BookException, List<BookModel>>> getBooks({
    BookStatus? status,
  }) async {
    try {
      // Busca sempre do banco local (offline-first)
      final books = await localDatasource.getBooks(status: status);
      return Right(books);
    } catch (error) {
      return Left(BookException(error.toString()));
    }
  }
}
```

**Características**:
- Implementa interfaces do domain
- Usa datasources para acesso a dados
- Converte modelos de API para modelos de domínio
- Trata exceções e retorna `Either<Exception, Success>`

### 3. Presentation Layer (Camada de Apresentação)

**Responsabilidade**: Interface do usuário, widgets, páginas e gerenciamento de estado.

**Componentes**:
- **Cubits/Blocs**: Gerenciamento de estado usando flutter_bloc
- **Pages**: Páginas da aplicação
- **Widgets**: Widgets específicos da feature

**Exemplo - Cubit**:
```dart
// presentation/cubit/book_cubit.dart
class BookCubit extends Cubit<BookState> {
  BookCubit({
    required BookRepository bookRepository,
    required SyncService syncService,
  })  : _bookRepository = bookRepository,
        _syncService = syncService,
        super(BookState());
  
  final BookRepository _bookRepository;
  final SyncService _syncService;
  
  Future<void> loadBooks({BookStatus? status}) async {
    emit(state.copyWith(status: BookStateStatus.loading));
    
    final result = await _bookRepository.getBooks(status: status);
    
    result.fold(
      (error) => emit(state.copyWith(
        status: BookStateStatus.error,
        message: error.message ?? '',
      )),
      (books) => emit(state.copyWith(
        status: BookStateStatus.success,
        books: books,
      )),
    );
  }
  
  Future<void> addBook({
    required String title,
    required String author,
    required int totalPages,
    String? description,
    double? rating,
    String? coverImagePath,
  }) async {
    emit(state.copyWith(status: BookStateStatus.loading));
    
    final book = BookModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      author: author,
      totalPages: totalPages,
      pagesRead: 0,
      description: description,
      rating: rating,
      coverImagePath: coverImagePath,
      status: BookStatus.reading,
      updatedAt: DateTime.now(),
      isDirty: true,
    );
    
    final result = await _bookRepository.addBook(book: book);
    
    result.fold(
      (error) => emit(state.copyWith(
        status: BookStateStatus.error,
        message: error.message ?? '',
      )),
      (addedBook) {
        // Recarrega a lista
        loadBooks(status: state.currentFilter);
      },
    );
  }
}
```

**Exemplo - Page**:
```dart
// presentation/pages/home_page.dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bookCubit = injection<BookCubit>();
  BookStatus _currentFilter = BookStatus.all;
  
  @override
  void initState() {
    super.initState();
    _bookCubit.loadBooks();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tô Lendo'),
        actions: [
          // Filtros
          _buildFilterChip(BookStatus.all, 'Todos'),
          _buildFilterChip(BookStatus.reading, 'Lendo'),
          _buildFilterChip(BookStatus.completed, 'Concluídos'),
        ],
      ),
      body: BlocConsumer<BookCubit, BookState>(
        bloc: _bookCubit,
        listener: (context, state) {
          if (state.status == BookStateStatus.error) {
            AppSnackbar.error(context, message: state.message);
          }
        },
        builder: (context, state) => switch (state.status) {
          BookStateStatus.loading => const LoadingWidget(),
          BookStateStatus.success => state.books.isEmpty
              ? const EmptyListWidget(message: 'Nenhum livro cadastrado')
              : BooksListWidget(books: state.books),
          _ => const SizedBox(),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addBook.path),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Características**:
- Usa Cubit para gerenciamento de estado
- Estados definidos com Freezed para imutabilidade
- BlocConsumer para escutar mudanças e reagir
- Switch expressions para renderização condicional
- Uso de mixins para validações

---

## Padrões de Código

### 1. Nomenclatura

- **Classes**: PascalCase (ex: `AuthRepository`, `UserModel`)
- **Arquivos**: snake_case (ex: `auth_repository.dart`, `user_model.dart`)
- **Variáveis e métodos**: camelCase (ex: `signInUser`, `authRepository`)
- **Constantes**: camelCase com prefixo (ex: `ApiConstants.authentication`)
- **Enums**: PascalCase (ex: `AuthStateStatus`, `HttpMethod`)

### 2. Documentação

Todas as classes públicas usam documentação Dart:

```dart
/// {@template auth_repository}
/// Interface of Repository to Manage the Auth Feature.
/// {@endtemplate}
abstract interface class AuthRepository {
  /// Make user sign in
  ///
  /// * Requires a [login]
  /// * Requires a [password]
  Future<Either<AuthException, String>> signInUser({
    required String login,
    required String password,
  });
}
```

### 3. Tratamento de Erros

Uso do padrão **Either** do `fpdart`:

```dart
Future<Either<AuthException, String>> signInUser(...) async {
  try {
    // Sucesso
    return Right(token);
  } catch (error) {
    // Erro
    return Left(AuthException(error.message));
  }
}
```

### 4. Imutabilidade

- Estados do Cubit são imutáveis usando Freezed
- Models usam `copyWith` para criar novas instâncias
- Uso de `const` sempre que possível

### 5. Sealed Classes

Para classes que não devem ser instanciadas diretamente:

```dart
/// App Theme Colors
sealed class AppColors {
  AppColors._(); // Construtor privado
  
  static const MaterialColor primaryColor = MaterialColor(...);
}
```

---

## Injeção de Dependências

O projeto usa **GetIt** para injeção de dependências. A configuração é feita em dois níveis:

### 1. Injeção Global (`lib/src/injections.dart`)

Registra serviços compartilhados e inicializa injeções de features:

```dart
/// Get it instance
final injection = GetIt.I;

/// Init Dependencies Injections
Future<void> initInjection() async {
  injection
    ..registerLazySingleton<AppDatabase>(AppDatabase.new)
    ..registerLazySingleton<LocalStorage>(SecureStorageImpl.new)
    ..registerLazySingleton<HttpClientService>(
      () => HttpClientServiceImpl(client: Client())
    )
    ..registerLazySingleton<ConnectionCheckerService>(
      InternetConnectionCheckerImpl.new
    )
    // ... outros serviços
    
  // Supabase Client
  injection.registerLazySingleton<SupabaseClient>(
    () => SupabaseClient(
      SupabaseConstants.supabaseUrl,
      SupabaseConstants.supabaseAnonKey,
    ),
  );
  
  // List of Feature Injections
  final features = [
    initDatasourcesInjection(),
    initSupabaseInjection(),
    initSyncInjection(),
    initAuthInjection(),
    initBooksInjection(),
    initReadingSessionsInjection(),
    initStatisticsInjection(),
    initProfileInjection(),
  ];
  
  // Init All Features Injections
  await Future.wait(features);
}
```

**Tipos de Registro**:
- `registerLazySingleton`: Instância única criada sob demanda
- `registerFactory`: Nova instância a cada chamada (usado para Cubits)

### 2. Injeção por Feature (`feature_name_injection.dart`)

Cada feature tem seu próprio arquivo de injeção:

```dart
// features/books/books_injection.dart
Future<void> initBooksInjection() async {
  injection
    // Datasources
    ..registerLazySingleton(() => BookLocalDatasource(
      appDatabase: injection<AppDatabase>(),
    ))
    ..registerLazySingleton(() => BookRemoteDatasource(
      supabaseClient: injection<SupabaseClient>(),
    ))
    
    // Repository
    ..registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
      localDatasource: injection<BookLocalDatasource>(),
      remoteDatasource: injection<BookRemoteDatasource>(),
      syncService: injection<SyncService>(),
    ))
    
    // Cubit (Factory para nova instância por uso)
    ..registerFactory(() => BookCubit(
      bookRepository: injection<BookRepository>(),
      syncService: injection<SyncService>(),
    ));
}
```

### 3. Uso da Injeção

```dart
// Em widgets ou outras classes
final _authCubit = injection<AuthCubit>();
final _httpClient = injection<HttpClientService>();
```

---

## Gerenciamento de Estado

O projeto usa **flutter_bloc** com **Cubit** (versão simplificada do BLoC).

### Estrutura do Estado

Estados são definidos usando Freezed para imutabilidade:

```dart
// presentation/cubit/auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStateStatus.initial) AuthStateStatus status,
    @Default('') String message,
  }) = _AuthState;
}

enum AuthStateStatus {
  initial,
  loading,
  success,
  error,
}
```

### Cubit

```dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState());
  
  final AuthRepository _authRepository;
  
  Future<void> signInUser({required String userName, required String password}) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    
    final result = await _authRepository.signInUser(...);
    
    result.fold(
      (error) => emit(state.copyWith(
        status: AuthStateStatus.error,
        message: error.message ?? '',
      )),
      (success) => emit(state.copyWith(
        status: AuthStateStatus.success,
      )),
    );
  }
}
```

### Uso em Widgets

```dart
BlocConsumer<AuthCubit, AuthState>(
  bloc: _authCubit,
  listener: (context, state) {
    // Reações a mudanças de estado (navegação, snackbars, etc)
    if (state.status == AuthStateStatus.success) {
      context.pushReplacement(AppRoutes.home.path);
    }
  },
  builder: (context, state) {
    // Build baseado no estado
    return switch (state.status) {
      AuthStateStatus.loading => const LoadingWidget(),
      AuthStateStatus.error => ErrorWidget(message: state.message),
      _ => FormWidget(),
    };
  },
)
```

---

## Roteamento

O projeto usa **GoRouter** para navegação declarativa.

### Configuração de Rotas (`lib/src/core/routers/app_route.dart`)

```dart
class AppRoute {
  static GoRouter routes = GoRouter(
    initialLocation: RedirectService.isFirstOpen
        ? AppRoutes.onboarding.path
        : (AuthService.currentUser.isLogged 
            ? AppRoutes.home.path 
            : AppRoutes.auth.path),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding.path,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.auth.path,
        builder: (_, __) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.addBook.path,
        builder: (_, __) => const AddBookPage(),
      ),
      GoRoute(
        path: AppRoutes.bookDetails.path,
        builder: (_, state) => BookDetailsPage(
          bookId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.profile.path,
        builder: (_, __) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.statistics.path,
        builder: (_, __) => const StatisticsPage(),
      ),
    ],
  );
}
```

### Enum de Rotas

```dart
enum AppRoutes {
  onboarding('/onboarding'),
  auth('/auth'),
  home('/home'),
  addBook('/add-book'),
  bookDetails('/book/:id'),
  profile('/profile'),
  statistics('/statistics'),
  
  const AppRoutes(this.path);
  final String path;
}
```

### Navegação

```dart
// Push
context.push(AppRoutes.collect.path);

// Push com argumentos
context.push(
  AppRoutes.collect.path,
  extra: CollectPageArgsModel(...),
);

// Push e substituir
context.pushReplacement(AppRoutes.home.path);

// Pop
context.pop();
```

---

## Tema e Estilos

O tema é centralizado em `lib/src/core/styles/`.

### Tema Principal (`app_theme.dart`)

```dart
sealed class AppTheme {
  AppTheme._();
  
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor
    ),
    primaryColor: AppColors.primaryColor,
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.background
    ),
    inputDecorationTheme: AppInputs.inputDecorationStyle(),
    elevatedButtonTheme: AppButtons.elevatedButtonStyle(),
    outlinedButtonTheme: AppButtons.outlinedButtonStyle(),
  );
}
```

### Cores (`app_colors.dart`)

```dart
sealed class AppColors {
  AppColors._();
  
  static const int _customPrimary = 0xFF0373E3;
  
  static const MaterialColor primaryColor = MaterialColor(
    _customPrimary,
    <int, Color>{
      50: Color(0xFFe2f2ff),
      100: Color(0xFFbadeff),
      // ... gradientes
      700: Color(_customPrimary),
      // ...
    },
  );
  
  static const Color secondary = Color(0xFF011224);
  static const Color background = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF0adfc8);
  static const Color danger = Color(0xFFFF5630);
  // ...
}
```

### Botões (`app_buttons.dart`)

```dart
class AppButtons {
  static ElevatedButtonThemeData elevatedButtonStyle() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
      ),
    );
  }
}
```

### Inputs (`app_inputs.dart`)

```dart
class AppInputs {
  static InputDecorationTheme inputDecorationStyle() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // ... outros estilos
    );
  }
}
```

### Espaçamento (`app_spacing.dart`)

```dart
class AppSpacing {
  static const double nano = 4.0;
  static const double xxs = 8.0;
  static const double xs = 12.0;
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
  static const double xxl = 64.0;
}
```

---

## Componentização de Widgets

Widgets reutilizáveis estão em `lib/src/core/widgets/`.

### Estrutura de um Widget

```dart
/// {@template app_card_widget}
/// Widget to custom App Card
/// {@endtemplate}
class AppCardWidget extends StatelessWidget {
  /// {@macro app_card_widget}
  const AppCardWidget({
    super.key,
    required this.content,
    this.title,
    this.action,
    this.spacing = AppSpacing.xxs,
  });
  
  final String? title;
  final List<Widget> content;
  final Widget? action;
  final double spacing;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Column(
          spacing: spacing,
          children: [
            if (title != null) CardTitleWidget(title: title ?? ''),
            ...content,
          ],
        ),
      ),
    );
  }
}
```

### Widgets Disponíveis

- `AppCardWidget`: Card customizado
- `AppRadioWidget`: Radio button customizado
- `AppSwitchWidget`: Switch customizado
- `AppTextButton`: Text button customizado
- `LoadingWidget`: Indicador de carregamento
- `EmptyListWidget`: Widget para listas vazias
- `DropdownSearchWidget`: Dropdown com busca
- `CustomAppBarWidget`: AppBar customizado
- `DismissibleKeyboardWidget`: Widget para fechar teclado
- `AlertWidget`: Alertas customizados
- `AppSnackbar`: Snackbars customizados

---

## Extensions

Extensions são usadas para otimizar e simplificar o código.

### Size Extension (`size_extension.dart`)

```dart
extension SizesExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  
  double percentWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;
}

// Uso
final width = context.screenWidth;
final height = context.percentHeight(0.5);
```

### String Extension (`string.extension.dart`)

```dart
extension StringExtension on String {
  /// Formata como CPF brasileiro
  String toCpfFormat() {
    final cpf = replaceAll(RegExp(r'\D'), '').padLeft(11, '0');
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }
  
  /// Adiciona asterisco indicando obrigatório
  String get mandatory => '$this *';
  
  /// Remove caracteres não numéricos
  String get onlyNumbers => replaceAll(RegExp('[^0-9]'), '');
  
  /// Nome único com timestamp
  String get uniqueName {
    final newText = splitMapJoin('', 
      onNonMatch: (char) => UtilConstants.mapAccents[char] ?? char
    ).replaceAll(' ', '');
    return '${DateTime.now().microsecondsSinceEpoch}$newText';
  }
}

// Uso
final cpf = '12345678901'.toCpfFormat(); // '123.456.789-01'
final numbers = 'abc123'.onlyNumbers; // '123'
```

### Text Input Formatter Extension

Extensions para formatação de inputs (máscaras, etc).

---

## Mixins

Mixins são usados para compartilhar funcionalidades entre classes.

### ValidationsMixins (`validations_mixins.dart`)

```dart
mixin ValidationsMixins {
  String? isEmpty(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Campo obrigatório';
    }
    return null;
  }
  
  String? isValidCpf(String value, [String message = 'Por favor, insira um CPF válido']) {
    final cpf = value.replaceAll(RegExp('[^0-9]'), '');
    if (cpf.length != 11) return message;
    // Validação de CPF...
    return null; // Válido
  }
  
  String? isValidEmail(String? value, [String? message]) {
    final patternEmail = RegExp(r'...');
    if (value == null || !patternEmail.hasMatch(value)) {
      return message ?? 'Por favor, insira um e-mail válido';
    }
    return null;
  }
  
  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}

// Uso
class _AuthPageState extends State<AuthPage> with ValidationsMixins {
  // ...
  validator: (textFieldValue) => combine([
    () => isEmpty(textFieldValue),
    () => isValidEmail(textFieldValue),
  ]),
}
```

---

## Constants e Assets

### Constants

Constantes são organizadas por categoria em `lib/src/core/constants/`:

#### Supabase Constants (`supabase_constants.dart`)

```dart
class SupabaseConstants {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Tables
  static const String booksTable = 'books';
  static const String readingSessionsTable = 'reading_sessions';
  static const String usersTable = 'users';
  
  // Storage Buckets
  static const String bookCoversBucket = 'book-covers';
  static const String profilePicturesBucket = 'profile-pictures';
}
```

#### Database Constants (`database_constants.dart`)

```dart
class DatabaseConstants {
  static const String databaseName = 'to_lendo.db';
  static const int databaseVersion = 1;
  
  // Tables
  static const String booksTable = 'books';
  static const String readingSessionsTable = 'reading_sessions';
  static const String syncQueueTable = 'sync_queue';
  
  // Columns
  static const String idColumn = 'id';
  static const String updatedAtColumn = 'updated_at';
  static const String isDirtyColumn = 'is_dirty';
  static const String lastSyncAtColumn = 'last_sync_at';
}
```

#### Util Constants (`util_constants.dart`)

Constantes utilitárias como mapeamento de acentos, chaves de storage, etc.

### Assets

Paths de assets são centralizados em classes:

#### App Images (`app_images.dart`)

```dart
class AppImages {
  static List<String> get imagesList => [
    logo,
    logoNoTag,
    logoLight,
    // ...
  ];
  
  static const String _basePath = 'assets/images';
  
  static String get logo => '$_basePath/IMAGE_PATH.png';
  static String get logoNoTag => '$_basePath/IMAGE_PATH.png';
  // ...
}
```

#### App Animations (`app_animations.dart`)

Similar ao AppImages, mas para animações Lottie.

**Vantagens**:
- Facilita refatoração (mudança de path em um só lugar)
- Evita erros de digitação
- Autocomplete no IDE
- Lista centralizada para precarregamento

**Uso**:
```dart
// Em my_app.dart - precarregamento
for (final path in AppImages.imagesList) {
  precacheImage(AssetImage(path), context);
}

// Em widgets
Image.asset(AppImages.logo)
```

---

## Barrel Files

Barrel files (arquivos de exportação) são usados extensivamente para simplificar imports.

### Estrutura Hierárquica

```
src.dart
  └── core/core.dart
      ├── assets/assets.dart
      ├── constants/constants.dart
      ├── extensions/extensions.dart
      └── ...
  └── features/features.dart
      ├── auth/auth.dart
      └── ...
```

### Exemplo - Core Barrel

```dart
// core/core.dart
export 'assets/assets.dart';
export 'constants/constants.dart';
export 'database/database.dart';
export 'extensions/extensions.dart';
export 'mixins/mixins.dart';
export 'models/models.dart';
export 'routers/routers.dart';
export 'services/services.dart';
export 'styles/styles.dart';
export 'widgets/widgets.dart';
```

### Exemplo - Feature Barrel

```dart
// features/auth/auth.dart
export 'auth_injection.dart';
export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
```

### Uso

```dart
// Ao invés de múltiplos imports:
import 'package:cerurbjus_app/src/core/models/user_model.dart';
import 'package:cerurbjus_app/src/core/services/http_service/http_client_service.dart';
import 'package:cerurbjus_app/src/core/widgets/loading_widget.dart';

// Usa apenas um:
import 'package:cerurbjus_app/src/src.dart';
```

**Vantagens**:
- Imports mais limpos
- Facilita refatoração (mover arquivo = atualizar um export)
- Melhor organização
- Reduz duplicação de imports

---

## Pacote Packages

O projeto usa um **pacote local** (`packages/`) para centralizar todas as dependências externas.

### Estrutura

```
packages/
├── pubspec.yaml          # Dependências do projeto
└── lib/
    └── packages.dart     # Barrel file com todos os exports
```

### packages.dart

```dart
library packages;

export 'package:go_router/go_router.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:get_it/get_it.dart';
export 'package:fpdart/fpdart.dart' hide Hash, State, Unit;
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:http/http.dart';
export 'package:sqflite/sqflite.dart';
// ... todas as dependências
```

### Uso

```dart
// Ao invés de:
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Usa apenas:
import 'package:packages/packages.dart';
```

**Vantagens**:
- Controle centralizado de versões
- Imports mais limpos
- Facilita migração de pacotes
- Melhor organização

---

## Database e Datasources

### AppDatabase (`app_database.dart`)

Classe singleton que gerencia o banco SQLite:

```dart
class AppDatabase {
  static final AppDatabase appDatabase = AppDatabase();
  Database? _database;
  
  Future<Database> get database async {
    _database ??= await createDatabase();
    return _database!;
  }
  
  Future<Database> createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, DatabaseConstants.databaseName);
    
    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _initDatabase,
      onConfigure: _configureDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }
}
```

### Datasources

Cada entidade tem seu próprio datasource. No Tô Lendo, temos datasources locais e remotos:

#### Local Datasource

```dart
class BookLocalDatasource {
  BookLocalDatasource({required this.appDatabase});
  final AppDatabase appDatabase;
  final _tableName = DatabaseConstants.booksTable;
  
  Future<BookModel> insertBook({required BookModel book}) async {
    try {
      final dataBase = await appDatabase.database;
      final id = await dataBase.insert(
        _tableName,
        book.copyWith(
          updatedAt: DateTime.now(),
          isDirty: true,
        ).toMap(),
      );
      return book.copyWith(id: id.toString());
    } catch (error) {
      throw DatabaseException('Erro ao inserir livro: $error');
    }
  }
  
  Future<List<BookModel>> getBooks({BookStatus? status}) async {
    try {
      final dataBase = await appDatabase.database;
      String query = 'SELECT * FROM $_tableName';
      List<dynamic> args = [];
      
      if (status != null && status != BookStatus.all) {
        query += ' WHERE status = ?';
        args.add(status.name);
      }
      
      query += ' ORDER BY updated_at DESC';
      
      final books = await dataBase.rawQuery(query, args);
      return books.map((map) => BookModel.fromMap(map)).toList();
    } catch (error) {
      throw DatabaseException('Erro ao buscar livros: $error');
    }
  }
  
  Future<BookModel> updateBook({required BookModel book}) async {
    try {
      final dataBase = await appDatabase.database;
      await dataBase.update(
        _tableName,
        book.copyWith(
          updatedAt: DateTime.now(),
          isDirty: true,
        ).toMap(),
        where: 'id = ?',
        whereArgs: [book.id],
      );
      return book;
    } catch (error) {
      throw DatabaseException('Erro ao atualizar livro: $error');
    }
  }
  
  Future<void> deleteBook({required String bookId}) async {
    try {
      final dataBase = await appDatabase.database;
      await dataBase.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [bookId],
      );
    } catch (error) {
      throw DatabaseException('Erro ao deletar livro: $error');
    }
  }
}
```

#### Remote Datasource (Supabase)

```dart
class BookRemoteDatasource {
  BookRemoteDatasource({required this.supabaseClient});
  final SupabaseClient supabaseClient;
  
  Future<BookModel> createBook({required BookModel book}) async {
    try {
      final response = await supabaseClient
          .from(SupabaseConstants.booksTable)
          .insert(book.toMap())
          .select()
          .single();
      
      return BookModel.fromMap(response);
    } catch (error) {
      throw SupabaseException('Erro ao criar livro no Supabase: $error');
    }
  }
  
  Future<List<BookModel>> getBooks({String? userId}) async {
    try {
      var query = supabaseClient
          .from(SupabaseConstants.booksTable)
          .select();
      
      if (userId != null) {
        query = query.eq('user_id', userId);
      }
      
      final response = await query;
      return (response as List)
          .map((map) => BookModel.fromMap(map as Map<String, dynamic>))
          .toList();
    } catch (error) {
      throw SupabaseException('Erro ao buscar livros do Supabase: $error');
    }
  }
}
```

**Características**:
- Um datasource local e um remoto por entidade
- Métodos CRUD específicos
- Tratamento de erros com exceções customizadas
- Conversão automática entre Map e Model
- Marcação de registros como "dirty" para sincronização

---

## Services

Services são interfaces e implementações para funcionalidades compartilhadas.

### Estrutura

Cada service tem:
- Interface abstrata (contrato)
- Implementação concreta
- Injeção de dependência

### Exemplos de Services

#### HttpClientService

```dart
abstract interface class HttpClientService {
  Future<dynamic> request({
    required String endPoint,
    required HttpMethod method,
    Map<dynamic, dynamic>? body,
    Map<dynamic, dynamic>? headers,
    String? serverUrl,
  });
}

class HttpClientServiceImpl implements HttpClientService {
  HttpClientServiceImpl({required this.client});
  final Client client;
  
  @override
  Future<dynamic> request({...}) async {
    // Implementação usando http package
  }
}
```

#### LocalStorage

```dart
abstract interface class LocalStorage {
  Future<void> save(String key, String value);
  Future<String?> get(String key);
  Future<void> delete(String key);
}

class SecureStorageImpl implements LocalStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  @override
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  // ...
}
```

#### SupabaseService

```dart
abstract interface class SupabaseService {
  Future<Either<SupabaseException, UserModel>> signInWithEmail({
    required String email,
    required String password,
  });
  
  Future<Either<SupabaseException, UserModel>> signInWithGoogle();
  Future<Either<SupabaseException, UserModel>> signInWithApple();
  Future<void> signOut();
  UserModel? getCurrentUser();
}

class SupabaseServiceImpl implements SupabaseService {
  SupabaseServiceImpl({required this.supabaseClient});
  final SupabaseClient supabaseClient;
  
  @override
  Future<Either<SupabaseException, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        final user = UserModel.fromSupabaseUser(response.user!);
        return Right(user);
      }
      return Left(SupabaseException('Falha no login'));
    } catch (error) {
      return Left(SupabaseException(error.toString()));
    }
  }
  // ... outros métodos
}
```

#### SyncService

```dart
abstract interface class SyncService {
  Future<void> syncIfConnected();
  Future<void> markForSync({
    required EntityType entityType,
    required String entityId,
    required SyncOperation operation,
  });
  Future<List<SyncItem>> getPendingSyncs();
}

class SyncServiceImpl implements SyncService {
  SyncServiceImpl({
    required this.connectionChecker,
    required this.bookRepository,
    required this.readingSessionRepository,
  });
  
  final ConnectionCheckerService connectionChecker;
  final BookRepository bookRepository;
  final ReadingSessionRepository readingSessionRepository;
  
  @override
  Future<void> syncIfConnected() async {
    if (!await connectionChecker.hasConnection()) {
      return; // Sem conexão, não sincroniza
    }
    
    final pendingSyncs = await getPendingSyncs();
    
    for (final syncItem in pendingSyncs) {
      try {
        await _syncItem(syncItem);
        await _markAsSynced(syncItem);
      } catch (error) {
        // Log erro, mas continua com próximo item
        print('Erro ao sincronizar ${syncItem.entityId}: $error');
      }
    }
  }
  
  Future<void> _syncItem(SyncItem item) async {
    switch (item.entityType) {
      case EntityType.book:
        await _syncBook(item);
        break;
      case EntityType.readingSession:
        await _syncReadingSession(item);
        break;
    }
  }
  
  // ... implementação dos métodos de sincronização
}
```

#### Outros Services

- `ConnectionCheckerService`: Verifica conectividade
- `ImagePickerService`: Seleção de imagens (galeria/câmera)
- `ImageUploadService`: Upload de imagens para Supabase Storage
- `StatisticsService`: Cálculo de estatísticas de leitura
- `StreakService`: Cálculo de dias consecutivos lendo

---

## Modelo de Dados do App

O Tô Lendo trabalha com as seguintes entidades principais:

### Book (Livro)
- **id**: Identificador único
- **title**: Título do livro
- **author**: Autor
- **description**: Descrição/sinopse (opcional)
- **totalPages**: Total de páginas
- **pagesRead**: Páginas lidas
- **rating**: Nota/avaliação (opcional)
- **coverImagePath**: Caminho local da capa
- **coverImageUrl**: URL da capa no Supabase Storage
- **status**: Status (reading, completed)
- **updatedAt**: Data da última atualização
- **createdAt**: Data de criação
- **isDirty**: Flag para sincronização
- **lastSyncAt**: Data da última sincronização
- **userId**: ID do usuário dono

### ReadingSession (Sessão de Leitura)
- **id**: Identificador único
- **bookId**: ID do livro relacionado
- **pagesRead**: Páginas lidas nesta sessão
- **readingTime**: Tempo de leitura em minutos (opcional)
- **date**: Data da sessão
- **updatedAt**: Data da última atualização
- **isDirty**: Flag para sincronização
- **lastSyncAt**: Data da última sincronização
- **userId**: ID do usuário

### User (Usuário)
- **id**: Identificador único (Supabase Auth)
- **email**: Email do usuário
- **name**: Nome completo
- **avatarUrl**: URL da foto de perfil
- **createdAt**: Data de criação da conta
- **lastSyncAt**: Data da última sincronização

### SyncQueue (Fila de Sincronização)
- **id**: Identificador único
- **entityType**: Tipo da entidade ('book', 'reading_session')
- **entityId**: ID da entidade
- **operation**: Operação ('create', 'update', 'delete')
- **createdAt**: Data de criação da entrada
- **syncedAt**: Data de sincronização (null se pendente)

---

## Models

Models são classes de dados com serialização JSON.

### Estrutura de um Model

```dart
class BookModel {
  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.totalPages,
    required this.pagesRead,
    this.description,
    this.rating,
    this.coverImagePath,
    this.coverImageUrl,
    this.status = BookStatus.reading,
    required this.updatedAt,
    this.createdAt,
    this.isDirty = false,
    this.lastSyncAt,
    this.userId,
  });
  
  // Factory para estado vazio
  factory BookModel.empty() => BookModel(
    id: '',
    title: '',
    author: '',
    totalPages: 0,
    pagesRead: 0,
    updatedAt: DateTime.now(),
  );
  
  // Factory para JSON string
  factory BookModel.fromJson(String source) => 
    BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  // Factory para Map (banco local)
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      totalPages: map['total_pages'] as int,
      pagesRead: map['pages_read'] as int,
      description: map['description'] as String?,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      coverImagePath: map['cover_image_path'] as String?,
      coverImageUrl: map['cover_image_url'] as String?,
      status: BookStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => BookStatus.reading,
      ),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at'] as String)
          : null,
      isDirty: (map['is_dirty'] as int? ?? 0) == 1,
      lastSyncAt: map['last_sync_at'] != null
          ? DateTime.parse(map['last_sync_at'] as String)
          : null,
      userId: map['user_id'] as String?,
    );
  }
  
  // Propriedades
  final String id;
  final String title;
  final String author;
  final int totalPages;
  final int pagesRead;
  final String? description;
  final double? rating;
  final String? coverImagePath;
  final String? coverImageUrl;
  final BookStatus status;
  final DateTime updatedAt;
  final DateTime? createdAt;
  final bool isDirty;
  final DateTime? lastSyncAt;
  final String? userId;
  
  // Computed properties
  double get progressPercentage => 
      totalPages > 0 ? (pagesRead / totalPages) * 100 : 0.0;
  
  bool get isCompleted => pagesRead >= totalPages;
  
  // Serialização para banco local
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'total_pages': totalPages,
      'pages_read': pagesRead,
      'description': description,
      'rating': rating,
      'cover_image_path': coverImagePath,
      'cover_image_url': coverImageUrl,
      'status': status.name,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'is_dirty': isDirty ? 1 : 0,
      'last_sync_at': lastSyncAt?.toIso8601String(),
      'user_id': userId,
    };
  }
  
  // Serialização para Supabase
  Map<String, dynamic> toSupabaseMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'total_pages': totalPages,
      'pages_read': pagesRead,
      'description': description,
      'rating': rating,
      'cover_image_url': coverImageUrl,
      'status': status.name,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
    };
  }
  
  String toJson() => json.encode(toMap());
  
  // Copy with para imutabilidade
  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    int? totalPages,
    int? pagesRead,
    String? description,
    double? rating,
    String? coverImagePath,
    String? coverImageUrl,
    BookStatus? status,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? isDirty,
    DateTime? lastSyncAt,
    String? userId,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      totalPages: totalPages ?? this.totalPages,
      pagesRead: pagesRead ?? this.pagesRead,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      isDirty: isDirty ?? this.isDirty,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      userId: userId ?? this.userId,
    );
  }
}
```

**Características**:
- Imutabilidade (propriedades `final`)
- Factories para diferentes formatos de entrada
- Métodos `toMap()` e `toJson()` para serialização
- `copyWith()` para criar novas instâncias
- Alguns models usam Freezed para code generation

---

## Boas Práticas

### 1. Separação de Responsabilidades

- Cada camada tem responsabilidade única
- Domain não conhece Data ou Presentation
- Data implementa contratos do Domain
- Presentation consome Domain

### 2. Injeção de Dependências

- Sempre injetar dependências via construtor
- Usar GetIt para gerenciar instâncias
- Preferir `registerLazySingleton` para serviços
- Preferir `registerFactory` para Cubits

### 3. Tratamento de Erros

- Usar `Either<Exception, Success>` do fpdart
- Exceções customizadas por feature
- Tratar erros em cada camada apropriadamente

### 4. Imutabilidade

- Estados imutáveis (Freezed)
- Models imutáveis (final properties)
- Usar `copyWith()` para modificações

### 5. Nomenclatura Consistente

- Seguir padrões estabelecidos
- Nomes descritivos e claros
- Documentar classes públicas

### 6. Reutilização

- Widgets reutilizáveis em `core/widgets`
- Extensions para funcionalidades comuns
- Mixins para comportamentos compartilhados
- Constants centralizadas

### 7. Performance

- Lazy loading de dependências
- Precaching de assets
- Uso de `const` sempre que possível
- Evitar rebuilds desnecessários

### 8. Testabilidade

- Interfaces abstratas facilitam mocks
- Dependências injetadas facilitam testes
- Lógica de negócio isolada no Domain

---

## Fluxo de Desenvolvimento

### Criando uma Nova Feature

1. **Criar estrutura de pastas**:
   ```
   features/new_feature/
   ├── new_feature.dart
   ├── new_feature_injection.dart
   ├── data/
   ├── domain/
   └── presentation/
   ```

2. **Definir contrato no Domain**:
   - Criar interface do Repository
   - Definir exceções

3. **Implementar no Data**:
   - Implementar Repository
   - Criar Models se necessário
   - Criar Datasources se necessário

4. **Criar Presentation**:
   - Criar Cubit e State
   - Criar Pages
   - Criar Widgets específicos

5. **Configurar Injeção**:
   - Adicionar `initNewFeatureInjection()` em `injections.dart`
   - Registrar dependências

6. **Adicionar Rotas**:
   - Adicionar em `AppRoute.routes`
   - Criar enum em `AppRoutes`

7. **Exportar em Barrel Files**:
   - Adicionar export em `features.dart`
   - Criar barrel files nas subpastas

---

## Sincronização Offline/Online

O Tô Lendo implementa uma arquitetura **offline-first**, garantindo que todas as funcionalidades funcionem mesmo sem conexão com a internet.

### Estratégia de Sincronização

1. **Operações Locais Primeiro**: Todas as operações (criar, editar, deletar) são salvas primeiro no banco local
2. **Marcação como Dirty**: Registros modificados são marcados com `isDirty = true`
3. **Fila de Sincronização**: Operações pendentes são armazenadas em uma tabela de sincronização
4. **Sincronização Automática**: Quando há conexão, o app sincroniza automaticamente
5. **Resolução de Conflitos**: Usa `updatedAt` para determinar qual versão é mais recente

### Fluxo de Sincronização

```dart
// Exemplo de sincronização de um livro
Future<void> syncBook(BookModel book) async {
  if (!book.isDirty) return; // Já sincronizado
  
  try {
    // Verifica se já existe no Supabase
    final existingBook = await remoteDatasource.getBook(book.id);
    
    if (existingBook != null) {
      // Resolve conflito: usa a versão mais recente
      if (book.updatedAt.isAfter(existingBook.updatedAt)) {
        await remoteDatasource.updateBook(book);
      } else {
        // Atualiza local com versão do servidor
        await localDatasource.updateBook(existingBook);
      }
    } else {
      // Cria novo no Supabase
      await remoteDatasource.createBook(book);
    }
    
    // Marca como sincronizado
    await localDatasource.updateBook(
      book.copyWith(
        isDirty: false,
        lastSyncAt: DateTime.now(),
      ),
    );
  } catch (error) {
    // Mantém como dirty para tentar novamente depois
    print('Erro na sincronização: $error');
  }
}
```

### Tabela de Sincronização

```dart
// Estrutura da tabela sync_queue
CREATE TABLE sync_queue (
  id TEXT PRIMARY KEY,
  entity_type TEXT NOT NULL, -- 'book', 'reading_session'
  entity_id TEXT NOT NULL,
  operation TEXT NOT NULL, -- 'create', 'update', 'delete'
  created_at TEXT NOT NULL,
  synced_at TEXT
);
```

---

## Conclusão

O **Tô Lendo** demonstra uma arquitetura bem estruturada e escalável, seguindo princípios de Clean Architecture, SOLID e boas práticas Flutter. A separação clara de responsabilidades, uso de injeção de dependências, gerenciamento de estado reativo e organização modular facilitam manutenção, testes e evolução do código.

**Principais Destaques**:
- ✅ Clean Architecture com três camadas bem definidas
- ✅ Arquitetura offline-first com sincronização automática
- ✅ Integração com Supabase (Auth, Database, Storage)
- ✅ Injeção de dependências centralizada
- ✅ Gerenciamento de estado reativo (Cubit)
- ✅ Roteamento declarativo (GoRouter)
- ✅ Componentização e reutilização
- ✅ Extensions e Mixins para otimização
- ✅ Constants e Assets centralizados
- ✅ Barrel files para organização
- ✅ Pacote local para dependências
- ✅ Tratamento de erros robusto (Either)
- ✅ Imutabilidade e type safety
- ✅ Sistema de sincronização com resolução de conflitos
- ✅ Suporte a múltiplos métodos de autenticação (Email, Google, Apple)

---