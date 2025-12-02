# 📁 Estrutura e Organização de Pastas - Tô Lendo

Este documento descreve em detalhes a estrutura de pastas e organização do projeto **Tô Lendo**, seguindo os princípios de Clean Architecture e as melhores práticas do Flutter.

---

## 📋 Índice

1. [Estrutura Geral do Projeto](#estrutura-geral-do-projeto)
2. [Raiz do Projeto (lib/)](#raiz-do-projeto-lib)
3. [Core - Funcionalidades Compartilhadas](#core---funcionalidades-compartilhadas)
4. [Features - Módulos do Aplicativo](#features---módulos-do-aplicativo)
5. [Estrutura Detalhada de Cada Feature](#estrutura-detalhada-de-cada-feature)
6. [Convenções de Nomenclatura](#convenções-de-nomenclatura)
7. [Barrel Files](#barrel-files)
8. [Sistema de Packages](#sistema-de-packages)

---

## Estrutura Geral do Projeto

```
to_lendo_app/
├── android/                    # Configurações Android
├── ios/                        # Configurações iOS
├── packages/                   # Pacote local de dependências
│   ├── pubspec.yaml           # Dependências centralizadas
│   └── lib/
│       └── packages.dart     # Barrel file com exports
├── lib/                        # Código fonte principal
│   ├── main.dart
│   ├── main_dev.dart
│   ├── main_prod.dart
│   ├── initialization.dart
│   └── src/
│       ├── src.dart
│       ├── injections.dart
│       ├── my_app.dart
│       ├── core/
│       └── features/
├── test/                       # Testes unitários e de widget
├── assets/                     # Assets do projeto
│   ├── images/
│   └── animations/
├── docs/                       # Documentação
├── pubspec.yaml                # Dependências (referencia packages/)
└── README.md
```

---

## Raiz do Projeto (lib/)

### Arquivos Principais

```
lib/
├── main.dart                   # Entry point principal (produção)
├── main_dev.dart              # Entry point para desenvolvimento
├── main_prod.dart             # Entry point para produção
├── initialization.dart        # Inicialização do app (DB, Supabase, etc)
└── src/                       # Código fonte organizado
```

#### `main.dart`
- Entry point principal do aplicativo
- Configuração inicial básica
- Redireciona para `main_dev.dart` ou `main_prod.dart` conforme ambiente

#### `main_dev.dart`
- Configurações específicas para desenvolvimento
- Logs detalhados
- Hot reload otimizado
- Debug flags ativadas

#### `main_prod.dart`
- Configurações para produção
- Logs mínimos
- Performance otimizada
- Debug flags desativadas

#### `initialization.dart`
- Inicialização do banco de dados local (Sqflite)
- Configuração do Supabase Client
- Setup de serviços globais
- Verificação de primeira execução (onboarding)
- Preparação de assets (precache)

#### `src/src.dart`
- Barrel file principal
- Exporta todos os módulos do projeto
- Facilita imports

#### `src/injections.dart`
- Configuração centralizada de injeção de dependências (GetIt)
- Registro de serviços globais
- Inicialização de injeções de features
- Função `initInjection()` principal

#### `src/my_app.dart`
- Widget raiz da aplicação
- Configuração do tema
- Configuração do GoRouter
- Precaching de assets
- Providers globais

---

## Core - Funcionalidades Compartilhadas

```
lib/src/core/
├── core.dart                  # Barrel file do core
├── assets/                    # Constantes de assets
│   ├── assets.dart
│   ├── app_images.dart        # Paths de imagens
│   └── app_animations.dart    # Paths de animações Lottie
├── constants/                 # Constantes da aplicação
│   ├── constants.dart
│   ├── supabase_constants.dart
│   ├── database_constants.dart
│   └── util_constants.dart
├── database/                  # Configuração do banco de dados
│   ├── database.dart
│   ├── app_database.dart      # Singleton do banco SQLite
│   └── migrations/           # Migrações do banco
├── extensions/                # Extensions para otimizar código
│   ├── extensions.dart
│   ├── size_extension.dart    # Extensions de tamanho de tela
│   ├── string_extension.dart  # Extensions de String
│   └── datetime_extension.dart
├── mixins/                    # Mixins reutilizáveis
│   ├── mixins.dart
│   └── validations_mixins.dart
├── models/                    # Modelos compartilhados
│   ├── models.dart
│   └── user_model.dart        # Modelo de usuário (se compartilhado)
├── routers/                   # Configuração de rotas
│   ├── routers.dart
│   ├── app_route.dart         # Configuração do GoRouter
│   └── app_routes.dart        # Enum de rotas
├── services/                  # Serviços compartilhados
│   ├── services.dart
│   ├── http_client_service/   # Serviço HTTP
│   ├── localStorage/          # Armazenamento local seguro
│   ├── connection_checker/    # Verificação de conexão
│   ├── image_picker_service/  # Seleção de imagens
│   ├── image_upload_service/  # Upload de imagens
│   └── supabase_service/      # Serviço do Supabase
├── styles/                    # Tema e estilos
│   ├── styles.dart
│   ├── app_theme.dart         # Tema principal
│   ├── app_colors.dart        # Cores do app
│   ├── app_buttons.dart       # Estilos de botões
│   ├── app_inputs.dart        # Estilos de inputs
│   └── app_spacing.dart       # Espaçamentos
└── widgets/                   # Widgets reutilizáveis
    ├── widgets.dart
    ├── app_card_widget.dart
    ├── loading_widget.dart
    ├── empty_list_widget.dart
    ├── app_snackbar.dart
    └── ...
```

### Detalhamento do Core

#### `core/assets/`
- **`app_images.dart`**: Centraliza todos os paths de imagens do projeto
  ```dart
  class AppImages {
    static const String _basePath = 'assets/images';
    static String get logo => '$_basePath/logo.png';
    static String get placeholderBook => '$_basePath/placeholder_book.png';
  }
  ```

- **`app_animations.dart`**: Centraliza paths de animações Lottie
  ```dart
  class AppAnimations {
    static const String _basePath = 'assets/animations';
    static String get loading => '$_basePath/loading.json';
  }
  ```

#### `core/constants/`
- **`supabase_constants.dart`**: URLs, chaves e nomes de tabelas do Supabase
- **`database_constants.dart`**: Nome do banco, versão, nomes de tabelas e colunas
- **`util_constants.dart`**: Constantes utilitárias (chaves de storage, mapeamentos, etc.)

#### `core/database/`
- **`app_database.dart`**: Singleton que gerencia a conexão com SQLite
- **`migrations/`**: Scripts de migração do banco de dados

#### `core/extensions/`
- Extensions para BuildContext, String, DateTime, etc.
- Facilitam operações comuns e reduzem código repetitivo

#### `core/mixins/`
- **`validations_mixins.dart`**: Validações reutilizáveis (email, CPF, etc.)

#### `core/services/`
Cada serviço tem sua própria pasta com interface e implementação:
```
http_client_service/
├── http_client_service.dart        # Interface
└── http_client_service_impl.dart   # Implementação
```

---

## Features - Módulos do Aplicativo

O projeto possui as seguintes features principais:

```
lib/src/features/
├── features.dart              # Barrel file de todas as features
├── onboarding/               # Tela de onboarding
├── auth/                      # Autenticação (login, registro)
├── books/                     # Gerenciamento de livros
├── reading_sessions/          # Sessões de leitura
├── statistics/                # Estatísticas e gráficos
├── profile/                   # Perfil do usuário
└── sync/                      # Sincronização offline/online
```

---

## Estrutura Detalhada de Cada Feature

Cada feature segue o padrão **Clean Architecture** com três camadas: **Domain**, **Data** e **Presentation**.

### Template Base de uma Feature

```
feature_name/
├── feature_name.dart                    # Barrel file da feature
├── feature_name_injection.dart          # Injeção de dependências
├── data/                                 # Camada de Dados
│   ├── data.dart                        # Barrel file da camada
│   ├── datasources/                     # Fontes de dados
│   │   ├── datasources.dart
│   │   ├── feature_local_datasource.dart
│   │   └── feature_remote_datasource.dart
│   ├── models/                          # Modelos de dados
│   │   ├── models.dart
│   │   └── feature_model.dart
│   └── repositories/                    # Implementações
│       ├── repositories.dart
│       ├── feature_repository_impl.dart
│       └── exceptions/                   # Exceções específicas
│           └── feature_exception.dart
├── domain/                               # Camada de Domínio
│   ├── domain.dart                      # Barrel file da camada
│   ├── entities/                        # Entidades (opcional)
│   │   └── feature_entity.dart
│   ├── repositories/                    # Contratos
│   │   ├── repositories.dart
│   │   └── feature_repository.dart
│   └── usecases/                        # Casos de uso (opcional)
│       └── feature_usecase.dart
└── presentation/                        # Camada de Apresentação
    ├── presentation.dart                # Barrel file da camada
    ├── cubit/                          # Gerenciamento de estado
    │   ├── cubit.dart
    │   ├── feature_cubit.dart
    │   └── feature_state.dart
    ├── pages/                          # Páginas da feature
    │   ├── pages.dart
    │   └── feature_page.dart
    └── widgets/                         # Widgets específicos
        ├── widgets.dart
        └── feature_widget.dart
```

---

## 1. Feature: Onboarding

```
onboarding/
├── onboarding.dart
├── onboarding_injection.dart
└── presentation/
    ├── presentation.dart
    ├── pages/
    │   └── onboarding_page.dart
    └── widgets/
        ├── onboarding_slide_widget.dart
        └── onboarding_indicator_widget.dart
```

**Descrição**: Feature simples que exibe telas de apresentação do app para novos usuários.

**Arquivos Principais**:
- `onboarding_page.dart`: Página principal com PageView para slides
- `onboarding_slide_widget.dart`: Widget para cada slide de apresentação
- `onboarding_indicator_widget.dart`: Indicador de progresso (dots)

**Nota**: Esta feature geralmente não precisa de camadas Domain e Data, pois apenas exibe conteúdo estático e salva flag de primeira execução.

---

## 2. Feature: Auth (Autenticação)

```
auth/
├── auth.dart
├── auth_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   └── auth_remote_datasource.dart    # Supabase Auth
│   ├── models/
│   │   ├── models.dart
│   │   └── user_model.dart                # Modelo de usuário
│   └── repositories/
│       ├── repositories.dart
│       ├── auth_repository_impl.dart
│       └── exceptions/
│           └── auth_exception.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── auth_repository.dart
│   └── entities/
│       └── user_entity.dart
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── auth_cubit.dart
    │   └── auth_state.dart
    ├── pages/
    │   ├── pages.dart
    │   ├── login_page.dart
    │   ├── register_page.dart
    │   └── forgot_password_page.dart
    └── widgets/
        ├── widgets.dart
        ├── login_form_widget.dart
        ├── register_form_widget.dart
        └── password_field_widget.dart
```

**Descrição**: Gerencia autenticação de usuários via Supabase (Email/Senha, Google, Apple).

**Arquivos Principais**:
- **Domain**:
  - `auth_repository.dart`: Contrato para autenticação
  - `user_entity.dart`: Entidade de usuário (opcional)

- **Data**:
  - `auth_remote_datasource.dart`: Implementação com Supabase Auth
  - `user_model.dart`: Modelo com serialização JSON
  - `auth_repository_impl.dart`: Implementação do repositório

- **Presentation**:
  - `auth_cubit.dart`: Gerencia estado de autenticação
  - `auth_state.dart`: Estados (loading, success, error)
  - `login_page.dart`: Tela de login
  - `register_page.dart`: Tela de registro
  - `forgot_password_page.dart`: Recuperação de senha

---

## 3. Feature: Books (Livros)

```
books/
├── books.dart
├── books_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   ├── book_local_datasource.dart      # SQLite
│   │   └── book_remote_datasource.dart     # Supabase
│   ├── models/
│   │   ├── models.dart
│   │   ├── book_model.dart
│   │   └── book_status.dart                # Enum de status
│   └── repositories/
│       ├── repositories.dart
│       ├── book_repository_impl.dart
│       └── exceptions/
│           └── book_exception.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── book_repository.dart
│   └── entities/
│       └── book_entity.dart                 # Opcional
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── book_cubit.dart
    │   └── book_state.dart
    ├── pages/
    │   ├── pages.dart
    │   ├── home_page.dart                  # Lista de livros
    │   ├── add_book_page.dart              # Adicionar livro
    │   ├── edit_book_page.dart             # Editar livro
    │   └── book_details_page.dart          # Detalhes do livro
    └── widgets/
        ├── widgets.dart
        ├── book_card_widget.dart            # Card de livro na lista
        ├── book_list_widget.dart            # Lista de livros
        ├── book_filter_chip_widget.dart     # Filtros (Lendo/Concluídos)
        ├── book_cover_widget.dart            # Widget de capa
        ├── book_progress_widget.dart        # Barra de progresso
        ├── book_form_widget.dart            # Formulário de livro
        └── book_cover_picker_widget.dart    # Seletor de capa
```

**Descrição**: Gerencia CRUD de livros, incluindo upload de capas e filtros por status.

**Arquivos Principais**:
- **Domain**:
  - `book_repository.dart`: Contrato para operações de livros

- **Data**:
  - `book_local_datasource.dart`: CRUD local (SQLite)
  - `book_remote_datasource.dart`: CRUD remoto (Supabase)
  - `book_model.dart`: Modelo com `toMap()`, `fromMap()`, `toSupabaseMap()`
  - `book_status.dart`: Enum (reading, completed, all)

- **Presentation**:
  - `book_cubit.dart`: Gerencia estado da lista e operações
  - `home_page.dart`: Tela principal com lista e filtros
  - `add_book_page.dart`: Formulário para adicionar livro
  - `edit_book_page.dart`: Formulário para editar livro
  - `book_details_page.dart`: Detalhes completos do livro
  - `book_card_widget.dart`: Card reutilizável para lista

---

## 4. Feature: Reading Sessions (Sessões de Leitura)

```
reading_sessions/
├── reading_sessions.dart
├── reading_sessions_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   ├── reading_session_local_datasource.dart
│   │   └── reading_session_remote_datasource.dart
│   ├── models/
│   │   ├── models.dart
│   │   └── reading_session_model.dart
│   └── repositories/
│       ├── repositories.dart
│       ├── reading_session_repository_impl.dart
│       └── exceptions/
│           └── reading_session_exception.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── reading_session_repository.dart
│   └── usecases/
│       └── calculate_completion_estimate_usecase.dart
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── reading_session_cubit.dart
    │   └── reading_session_state.dart
    ├── pages/
    │   ├── pages.dart
    │   └── add_reading_session_page.dart
    └── widgets/
        ├── widgets.dart
        ├── reading_session_form_widget.dart
        ├── reading_session_timeline_widget.dart
        ├── reading_session_item_widget.dart
        └── completion_estimate_widget.dart
```

**Descrição**: Gerencia registro de sessões de leitura (páginas lidas, tempo, data).

**Arquivos Principais**:
- **Domain**:
  - `reading_session_repository.dart`: Contrato para operações
  - `calculate_completion_estimate_usecase.dart`: Cálculo de estimativa de término

- **Data**:
  - `reading_session_local_datasource.dart`: CRUD local
  - `reading_session_remote_datasource.dart`: CRUD remoto
  - `reading_session_model.dart`: Modelo com páginas, tempo, data

- **Presentation**:
  - `reading_session_cubit.dart`: Gerencia estado das sessões
  - `add_reading_session_page.dart`: Formulário para registrar sessão
  - `reading_session_timeline_widget.dart`: Timeline de histórico
  - `completion_estimate_widget.dart`: Widget de estimativa de conclusão

---

## 5. Feature: Statistics (Estatísticas)

```
statistics/
├── statistics.dart
├── statistics_injection.dart
├── data/
│   ├── data.dart
│   └── repositories/
│       ├── repositories.dart
│       └── statistics_repository_impl.dart  # Agrega dados de outras features
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── statistics_repository.dart
│   └── usecases/
│       ├── calculate_daily_average_usecase.dart
│       ├── calculate_streak_usecase.dart
│       └── calculate_reading_pace_usecase.dart
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── statistics_cubit.dart
    │   └── statistics_state.dart
    ├── pages/
    │   ├── pages.dart
    │   └── statistics_page.dart
    └── widgets/
        ├── widgets.dart
        ├── daily_average_widget.dart
        ├── progress_chart_widget.dart
        ├── streak_widget.dart
        ├── completed_books_widget.dart
        ├── reading_pace_widget.dart
        └── statistics_card_widget.dart
```

**Descrição**: Calcula e exibe estatísticas de leitura (média diária, streak, gráficos, etc.).

**Arquivos Principais**:
- **Domain**:
  - `statistics_repository.dart`: Contrato para buscar dados agregados
  - Use cases para cálculos específicos (média, streak, ritmo)

- **Data**:
  - `statistics_repository_impl.dart`: Agrega dados de Books e ReadingSessions

- **Presentation**:
  - `statistics_cubit.dart`: Gerencia estado das estatísticas
  - `statistics_page.dart`: Página principal com todos os widgets
  - Widgets específicos para cada métrica/gráfico

---

## 6. Feature: Profile (Perfil)

```
profile/
├── profile.dart
├── profile_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   └── profile_remote_datasource.dart    # Supabase
│   ├── models/
│   │   ├── models.dart
│   │   └── user_profile_model.dart
│   └── repositories/
│       ├── repositories.dart
│       ├── profile_repository_impl.dart
│       └── exceptions/
│           └── profile_exception.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── profile_repository.dart
│   └── usecases/
│       └── get_user_statistics_usecase.dart
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── profile_cubit.dart
    │   └── profile_state.dart
    ├── pages/
    │   ├── pages.dart
    │   ├── profile_page.dart
    │   └── edit_profile_page.dart
    └── widgets/
        ├── widgets.dart
        ├── profile_header_widget.dart
        ├── profile_avatar_widget.dart
        ├── profile_statistics_widget.dart
        ├── sync_status_widget.dart
        └── logout_button_widget.dart
```

**Descrição**: Gerencia perfil do usuário, estatísticas gerais e informações de sincronização.

**Arquivos Principais**:
- **Domain**:
  - `profile_repository.dart`: Contrato para operações de perfil
  - `get_user_statistics_usecase.dart`: Agrega estatísticas do usuário

- **Data**:
  - `profile_remote_datasource.dart`: Operações com Supabase
  - `user_profile_model.dart`: Modelo de perfil

- **Presentation**:
  - `profile_cubit.dart`: Gerencia estado do perfil
  - `profile_page.dart`: Tela principal de perfil
  - `edit_profile_page.dart`: Edição de perfil
  - `sync_status_widget.dart`: Widget de status de sincronização

---

## 7. Feature: Sync (Sincronização)

```
sync/
├── sync.dart
├── sync_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   └── sync_queue_local_datasource.dart
│   ├── models/
│   │   ├── models.dart
│   │   ├── sync_item_model.dart
│   │   └── entity_type.dart                # Enum (book, reading_session)
│   └── repositories/
│       ├── repositories.dart
│       └── sync_repository_impl.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── sync_repository.dart
│   └── entities/
│       └── sync_operation.dart             # Enum (create, update, delete)
└── services/
    ├── services.dart
    ├── sync_service.dart                    # Interface
    └── sync_service_impl.dart              # Implementação
```

**Descrição**: Gerencia sincronização offline/online entre banco local e Supabase.

**Arquivos Principais**:
- **Domain**:
  - `sync_repository.dart`: Contrato para operações de sincronização
  - `sync_operation.dart`: Enum de operações (create, update, delete)
  - `entity_type.dart`: Enum de tipos de entidades

- **Data**:
  - `sync_queue_local_datasource.dart`: Gerencia fila de sincronização
  - `sync_item_model.dart`: Modelo de item na fila

- **Services**:
  - `sync_service.dart`: Interface do serviço de sincronização
  - `sync_service_impl.dart`: Implementação com lógica de sincronização, resolução de conflitos, etc.

**Nota**: Esta feature pode não ter camada Presentation, sendo apenas um serviço usado por outras features.

---

## Convenções de Nomenclatura

### Arquivos
- **snake_case**: `book_repository.dart`, `auth_cubit.dart`, `user_model.dart`
- **Sufixos específicos**:
  - `*_model.dart`: Modelos de dados
  - `*_cubit.dart`: Gerenciadores de estado
  - `*_state.dart`: Estados do Cubit
  - `*_page.dart`: Páginas/telas
  - `*_widget.dart`: Widgets reutilizáveis
  - `*_datasource.dart`: Fontes de dados
  - `*_repository.dart`: Contratos de repositório
  - `*_repository_impl.dart`: Implementações de repositório
  - `*_service.dart`: Interfaces de serviços
  - `*_service_impl.dart`: Implementações de serviços
  - `*_exception.dart`: Exceções customizadas
  - `*_injection.dart`: Arquivos de injeção de dependências

### Classes
- **PascalCase**: `BookRepository`, `AuthCubit`, `UserModel`
- **Sufixos**:
  - `*Model`: Modelos de dados
  - `*Cubit`: Gerenciadores de estado
  - `*State`: Estados
  - `*Page`: Páginas
  - `*Widget`: Widgets
  - `*Datasource`: Fontes de dados
  - `*Repository`: Contratos
  - `*RepositoryImpl`: Implementações
  - `*Service`: Interfaces
  - `*ServiceImpl`: Implementações
  - `*Exception`: Exceções

### Pastas
- **snake_case**: `reading_sessions/`, `book_details/`
- **Singular para features principais**: `auth/`, `books/`
- **Plural quando faz sentido**: `reading_sessions/`, `statistics/`

---

## Barrel Files

Barrel files são arquivos que exportam múltiplos módulos, facilitando imports.

### Estrutura Hierárquica

```
src.dart
  └── core/core.dart
      ├── assets/assets.dart
      ├── constants/constants.dart
      └── ...
  └── features/features.dart
      ├── auth/auth.dart
      ├── books/books.dart
      └── ...
```

### Exemplo de Barrel File

**`lib/src/features/books/books.dart`**:
```dart
export 'books_injection.dart';
export 'data/data.dart';
export 'domain/domain.dart';
export 'presentation/presentation.dart';
```

**`lib/src/features/books/data/data.dart`**:
```dart
export 'datasources/datasources.dart';
export 'models/models.dart';
export 'repositories/repositories.dart';
```

**`lib/src/features/books/data/models/models.dart`**:
```dart
export 'book_model.dart';
export 'book_status.dart';
```

### Uso

```dart
// Ao invés de múltiplos imports:
import 'package:to_lendo_app/src/features/books/data/models/book_model.dart';
import 'package:to_lendo_app/src/features/books/presentation/cubit/book_cubit.dart';
import 'package:to_lendo_app/src/features/books/presentation/pages/home_page.dart';

// Usa apenas:
import 'package:to_lendo_app/src/src.dart';
// ou
import 'package:to_lendo_app/src/features/books/books.dart';
```

---

## Sistema de Packages

O projeto **Tô Lendo** utiliza um sistema de **pacote local** (`packages/`) para centralizar todas as dependências externas. Este padrão oferece controle centralizado de versões, imports mais limpos e facilita a migração de pacotes.

### Estrutura do Pacote

```
to_lendo_app/
├── packages/                    # Pacote local de dependências
│   ├── pubspec.yaml            # Dependências centralizadas
│   └── lib/
│       └── packages.dart       # Barrel file com todos os exports
├── lib/                        # Código fonte do app
│   └── src/
└── pubspec.yaml                # Dependências do app (apenas packages/)
```

### Configuração do Pacote Local

#### 1. Estrutura da Pasta `packages/`

```
packages/
├── pubspec.yaml                # Configuração do pacote
└── lib/
    └── packages.dart           # Barrel file principal
```

#### 2. `packages/pubspec.yaml`

Este arquivo contém **todas as dependências externas** do projeto:

```yaml
name: packages
description: Centralized dependencies package for Tô Lendo app
version: 1.0.0
publish_to: none  # Não publicar no pub.dev

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Roteamento
  go_router: ^13.0.0

  # Gerenciamento de Estado
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2

  # Injeção de Dependências
  get_it: ^7.6.4

  # Programação Funcional
  fpdart: ^1.1.0

  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # HTTP Client
  http: ^1.1.0
  dio: ^5.4.0

  # Banco de Dados Local
  sqflite: ^2.3.0
  path: ^1.8.3

  # Supabase
  supabase_flutter: ^2.0.0

  # Armazenamento Local
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2

  # Seleção de Imagens
  image_picker: ^1.0.5

  # Gráficos e Visualizações
  fl_chart: ^0.65.0
  syncfusion_flutter_charts: ^24.1.41

  # Utilitários
  intl: ^0.18.1
  uuid: ^4.2.1
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
  # Code Generation
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

**Características importantes**:
- `publish_to: none`: Impede publicação acidental no pub.dev
- Todas as dependências do projeto estão aqui
- Versões fixas ou com constraints específicas

#### 3. `packages/lib/packages.dart`

Este é o **barrel file** que exporta todas as dependências:

```dart
/// {@template packages}
/// Centralized package exports for Tô Lendo app.
/// 
/// This package centralizes all external dependencies, making it easier to:
/// - Manage package versions in one place
/// - Migrate packages across the project
/// - Keep imports clean and consistent
/// {@endtemplate}
library packages;

// ============================================
// Roteamento
// ============================================
export 'package:go_router/go_router.dart';

// ============================================
// Gerenciamento de Estado
// ============================================
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:bloc/bloc.dart';

// ============================================
// Injeção de Dependências
// ============================================
export 'package:get_it/get_it.dart';

// ============================================
// Programação Funcional
// ============================================
// Hide classes that conflict with Flutter/Dart core
export 'package:fpdart/fpdart.dart' hide Hash, State, Unit;

// ============================================
// Code Generation
// ============================================
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:json_annotation/json_annotation.dart';

// ============================================
// HTTP Client
// ============================================
export 'package:http/http.dart';
export 'package:dio/dio.dart';

// ============================================
// Banco de Dados Local
// ============================================
export 'package:sqflite/sqflite.dart';
export 'package:path/path.dart';

// ============================================
// Supabase
// ============================================
export 'package:supabase_flutter/supabase_flutter.dart';

// ============================================
// Armazenamento Local
// ============================================
export 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:shared_preferences/shared_preferences.dart';

// ============================================
// Seleção de Imagens
// ============================================
export 'package:image_picker/image_picker.dart';

// ============================================
// Gráficos e Visualizações
// ============================================
export 'package:fl_chart/fl_chart.dart';
export 'package:syncfusion_flutter_charts/syncfusion_flutter_charts.dart';

// ============================================
// Utilitários
// ============================================
export 'package:intl/intl.dart';
export 'package:uuid/uuid.dart';
export 'package:equatable/equatable.dart';
```

**Organização**:
- Comentários por categoria para facilitar navegação
- Uso de `hide` para evitar conflitos de nomes
- Documentação clara do propósito

### Configuração no Projeto Principal

#### `pubspec.yaml` do App

O `pubspec.yaml` do projeto principal (`to_lendo_app/pubspec.yaml`) deve referenciar o pacote local:

```yaml
name: to_lendo_app
description: Aplicativo de acompanhamento de leitura
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Pacote local com todas as dependências
  packages:
    path: packages/

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/animations/
```

**Importante**: O app principal **não declara dependências diretamente**, apenas referencia o pacote local.

### Uso no Código

#### Antes (Sem Sistema de Packages)

```dart
// Múltiplos imports espalhados pelo código
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepositoryImpl implements BookRepository {
  // ...
}
```

#### Depois (Com Sistema de Packages)

```dart
// Um único import para todas as dependências
import 'package:packages/packages.dart';

class BookRepositoryImpl implements BookRepository {
  // ...
}
```

### Exemplos Práticos

#### Exemplo 1: Uso em um Cubit

```dart
// lib/src/features/books/presentation/cubit/book_cubit.dart
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit({
    required BookRepository bookRepository,
  }) : _bookRepository = bookRepository,
       super(BookState());

  final BookRepository _bookRepository;

  Future<void> loadBooks() async {
    emit(state.copyWith(status: BookStateStatus.loading));
    
    final result = await _bookRepository.getBooks();
    
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
}
```

#### Exemplo 2: Uso em uma Page com GoRouter

```dart
// lib/src/features/books/presentation/pages/home_page.dart
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookCubit = injection<BookCubit>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tô Lendo'),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        bloc: bookCubit,
        builder: (context, state) {
          return switch (state.status) {
            BookStateStatus.loading => const LoadingWidget(),
            BookStateStatus.success => BooksListWidget(books: state.books),
            _ => const SizedBox(),
          };
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

#### Exemplo 3: Uso com Supabase

```dart
// lib/src/features/auth/data/datasources/auth_remote_datasource.dart
import 'package:packages/packages.dart';
import 'package:to_lendo_app/src/src.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource({required this.supabaseClient});
  
  final SupabaseClient supabaseClient;

  Future<Either<AuthException, UserModel>> signInWithEmail({
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
      
      return Left(AuthException('Falha no login'));
    } catch (error) {
      return Left(AuthException(error.toString()));
    }
  }
}
```

### Adicionando Novas Dependências

#### Passo 1: Adicionar no `packages/pubspec.yaml`

```yaml
dependencies:
  # ... outras dependências
  nova_dependencia: ^1.0.0
```

#### Passo 2: Exportar no `packages/lib/packages.dart`

```dart
// ============================================
// Nova Categoria
// ============================================
export 'package:nova_dependencia/nova_dependencia.dart';
```

#### Passo 3: Executar `flutter pub get` no pacote

```bash
cd packages
flutter pub get
cd ..
```

#### Passo 4: Executar `flutter pub get` no projeto principal

```bash
flutter pub get
```

#### Passo 5: Usar no código

```dart
import 'package:packages/packages.dart';

// Agora pode usar a nova dependência diretamente
```

### Vantagens do Sistema de Packages

#### 1. **Controle Centralizado de Versões**
- Todas as versões gerenciadas em um único lugar
- Facilita atualizações em massa
- Reduz conflitos de versão

#### 2. **Imports Mais Limpos**
- Um único import (`package:packages/packages.dart`) ao invés de múltiplos
- Código mais legível
- Menos linhas de import

#### 3. **Facilita Migração de Pacotes**
- Trocar um pacote requer mudança apenas no `packages.dart`
- Exemplo: Migrar de `http` para `dio` é simples

#### 4. **Melhor Organização**
- Dependências agrupadas por categoria
- Fácil identificar quais pacotes são usados
- Documentação clara do propósito de cada pacote

#### 5. **Reutilização em Múltiplos Projetos**
- O pacote pode ser compartilhado entre projetos
- Mantém consistência entre apps

#### 6. **Facilita Testes**
- Pode criar versões mock do pacote para testes
- Isolamento de dependências externas

### Estrutura Completa do Projeto com Packages

```
to_lendo_app/
├── packages/                          # Pacote local
│   ├── pubspec.yaml                  # Todas as dependências
│   └── lib/
│       └── packages.dart             # Barrel file
├── lib/                              # Código do app
│   ├── main.dart
│   └── src/
│       ├── src.dart
│       ├── injections.dart
│       ├── my_app.dart
│       ├── core/
│       └── features/
│           ├── auth/
│           │   └── ... (usa packages via import)
│           ├── books/
│           │   └── ... (usa packages via import)
│           └── ...
├── pubspec.yaml                      # Referencia packages/
└── README.md
```

### Fluxo de Trabalho

1. **Desenvolvimento**:
   ```dart
   // No código, sempre usar:
   import 'package:packages/packages.dart';
   ```

2. **Adicionar Nova Dependência**:
   - Adicionar em `packages/pubspec.yaml`
   - Exportar em `packages/lib/packages.dart`
   - Executar `flutter pub get` em ambos os lugares

3. **Atualizar Dependência**:
   - Atualizar versão em `packages/pubspec.yaml`
   - Executar `flutter pub get`

4. **Remover Dependência**:
   - Remover de `packages/pubspec.yaml`
   - Remover export de `packages/lib/packages.dart`
   - Executar `flutter pub get`

### Boas Práticas

1. **Sempre usar o pacote centralizado**:
   ```dart
   // ✅ Correto
   import 'package:packages/packages.dart';
   
   // ❌ Evitar
   import 'package:go_router/go_router.dart';
   ```

2. **Organizar exports por categoria**:
   - Agrupar exports relacionados
   - Usar comentários para separar categorias

3. **Documentar conflitos**:
   - Usar `hide` quando necessário para evitar conflitos
   - Documentar o motivo

4. **Manter versões atualizadas**:
   - Revisar dependências periodicamente
   - Atualizar para versões mais recentes quando seguro

5. **Testar após mudanças**:
   - Sempre testar após adicionar/atualizar dependências
   - Verificar se não há breaking changes

### Troubleshooting

#### Problema: "Package not found"
**Solução**: Verificar se o pacote está:
1. Declarado em `packages/pubspec.yaml`
2. Exportado em `packages/lib/packages.dart`
3. Executado `flutter pub get` em ambos os lugares

#### Problema: "Conflicting imports"
**Solução**: Usar `hide` no export:
```dart
export 'package:fpdart/fpdart.dart' hide Hash, State, Unit;
```

#### Problema: "Version conflict"
**Solução**: Verificar versões em `packages/pubspec.yaml` e garantir compatibilidade

---

## Estrutura de Testes

```
test/
├── unit/                          # Testes unitários
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl_test.dart
│   │   │   └── domain/
│   │   │       └── repositories/
│   │   │           └── auth_repository_test.dart
│   │   └── books/
│   └── core/
│       └── services/
├── widget/                        # Testes de widget
│   └── features/
│       ├── auth/
│       │   └── presentation/
│       │       └── pages/
│       │           └── login_page_test.dart
│       └── books/
└── integration/                  # Testes de integração
    └── features/
```

---

## Assets

```
assets/
├── images/
│   ├── logo.png
│   ├── placeholder_book.png
│   └── ...
└── animations/
    ├── loading.json
    └── ...
```

**Registro no `pubspec.yaml`**:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/animations/
```

---

## Resumo da Organização

### Princípios
1. **Separação por Features**: Cada funcionalidade é um módulo independente
2. **Clean Architecture**: Domain → Data → Presentation
3. **Barrel Files**: Facilita imports e organização
4. **Injeção de Dependências**: Centralizada por feature
5. **Reutilização**: Core contém código compartilhado
6. **Testabilidade**: Estrutura facilita testes unitários e de widget

### Benefícios
- ✅ Código organizado e fácil de navegar
- ✅ Manutenção simplificada
- ✅ Escalabilidade (fácil adicionar novas features)
- ✅ Testes isolados por feature
- ✅ Reutilização de código
- ✅ Separação clara de responsabilidades

---

## Checklist para Criar uma Nova Feature

1. ✅ Criar estrutura de pastas seguindo o template
2. ✅ Criar barrel files (`feature.dart`, `data.dart`, `domain.dart`, `presentation.dart`)
3. ✅ Definir contrato no Domain (Repository)
4. ✅ Implementar no Data (Repository, Datasources, Models)
5. ✅ Criar Cubit e State no Presentation
6. ✅ Criar Pages e Widgets
7. ✅ Configurar injeção de dependências (`feature_injection.dart`)
8. ✅ Adicionar rotas em `app_route.dart`
9. ✅ Exportar em `features.dart`
10. ✅ Criar testes (unit e widget)

---

## Exemplo Completo: Feature Books

Para referência, aqui está a estrutura completa esperada da feature Books:

```
books/
├── books.dart
├── books_injection.dart
├── data/
│   ├── data.dart
│   ├── datasources/
│   │   ├── datasources.dart
│   │   ├── book_local_datasource.dart
│   │   └── book_remote_datasource.dart
│   ├── models/
│   │   ├── models.dart
│   │   ├── book_model.dart
│   │   └── book_status.dart
│   └── repositories/
│       ├── repositories.dart
│       ├── book_repository_impl.dart
│       └── exceptions/
│           └── book_exception.dart
├── domain/
│   ├── domain.dart
│   ├── repositories/
│   │   ├── repositories.dart
│   │   └── book_repository.dart
│   └── entities/
│       └── book_entity.dart
└── presentation/
    ├── presentation.dart
    ├── cubit/
    │   ├── cubit.dart
    │   ├── book_cubit.dart
    │   └── book_state.dart
    ├── pages/
    │   ├── pages.dart
    │   ├── home_page.dart
    │   ├── add_book_page.dart
    │   ├── edit_book_page.dart
    │   └── book_details_page.dart
    └── widgets/
        ├── widgets.dart
        ├── book_card_widget.dart
        ├── book_list_widget.dart
        ├── book_filter_chip_widget.dart
        ├── book_cover_widget.dart
        ├── book_progress_widget.dart
        ├── book_form_widget.dart
        └── book_cover_picker_widget.dart
```

---

Este documento serve como guia completo para a estrutura e organização do projeto **Tô Lendo**. Siga estas convenções para manter o código organizado, escalável e fácil de manter.

