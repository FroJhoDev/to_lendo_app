# 📚 Tô Lendo – Aplicativo de Acompanhamento de Leitura

## 📱 Visão Geral

O **Tô Lendo** é um aplicativo mobile projetado para ajudar usuários a **registrar, organizar e acompanhar seu progresso de leitura** de forma simples, moderna e intuitiva.  
O app permite adicionar livros, registrar quantas páginas foram lidas por dia, acompanhar estatísticas e sincronizar tudo automaticamente com a nuvem através do **Supabase** — mantendo sempre a experiência **offline-first**, funcionando mesmo sem internet.

---

## 🎯 Funcionalidades Principais

### 📘 Registro e Gerenciamento de Livros
- **Adicionar Livros**: Informar título, autor, capa, descrição, nota e total de páginas  
- **Editar ou Remover** livros cadastrados  
- **Classificação por Status**: Filtrar entre *Lendo*, *Concluídos* e *Todos*  
- **Capa Personalizada**: Upload de imagem da galeria ou câmera  

---

### 📅 Registro de Sessões de Leitura
- **Páginas Lidas**: Registrar quantas páginas foram lidas em um dia  
- **Tempo de Leitura** (opcional)  
- **Histórico Completo**: Linha do tempo com datas e sessões anteriores  
- **Estimativa de Término** baseada no ritmo do usuário  

---

### 📊 Estatísticas de Leitura
- **Média Diária de Páginas**  
- **Gráficos de Progresso**  
- **Dias Consecutivos Lendo (Streak)**  
- **Livros Concluídos**  
- **Ritmo e Previsão de Conclusão**  

---

### ☁️ Sincronização Online/Offline com Supabase
- **Login via Email/Senha**  
- **Sincronização Automática** quando houver internet  
- **Uso Offline** completo, sem restrições  
- **Armazenamento Local** através de banco de dados interno  
- **Upload de Capas** para o Supabase Storage  

---

### 👤 Perfil do Usuário
- **Foto de Perfil ou Avatar**  
- **Nome e Email**  
- **Estatísticas Gerais**  
- **Informações de Sincronização**  
- **Opção de Logout**  

---

## 🔧 Especificações Técnicas

### 🧱 Arquitetura
- **Frontend:** Flutter  
- **Gerenciamento de Estado:** Bloc/Cubit  
- **Banco Local:** Sqflite (offline-first)  
- **Backend:** Supabase (Auth, Database e Storage)  

---

### 🔄 Sincronização de Dados
- Sistema de **fila de operações offline**  
- Registros marcados como *dirty* até sincronização completa  
- Comparação por `updatedAt` para resolver conflitos  
- Suporte a upload de capas via Supabase Storage  
- Sincronização incremental quando reconectar à internet  

---

### 🗂️ Modelo de Dados
- **Book:** id, título, autor, descrição, páginas, capas, rating, updatedAt  
- **ReadingSession:** id, bookId, páginas lidas, data, tempo de leitura  
- **User:** dados básicos + configurações  
- **Sincronização:** timestamps, dirty flags, lastSyncAt  

---

## 📋 Casos de Uso

### 📖 Caso Principal: Acompanhamento de um Livro Atual
**Cenário:** Usuário está lendo um livro e deseja acompanhar seu progresso  
- **Ação:** Adiciona o livro e registra páginas lidas diariamente  
- **Funcionamento:** O app calcula progresso, estatísticas e previsão de término  
- **Resultado:** Usuário visualiza evolução de forma clara e motivadora  
- **Benefício:** Ajuda a manter o hábito de leitura e entender seu ritmo  

---

### 📝 Outros Casos de Uso
1. Registrar vários livros simultaneamente  
2. Controlar metas e ritmo de leitura  
3. Armazenar histórico de livros concluídos  
4. Usar o app offline em viagens, estudos ou leituras externas  
5. Trocar de dispositivo sem perder dados (via Supabase)  

---

## 🚀 Fluxo de Funcionamento

1. **Login ou Criar Conta**  
2. **Adicionar Livros** com capa, título e quantidade de páginas  
3. **Registrar Leituras** diariamente  
4. **Acompanhar Estatísticas** e progresso visual  
5. **Usar o App Offline**; dados salvos localmente  
6. **Sincronizar Automaticamente** quando a internet voltar  

---

## 🎨 Interface do Usuário

### 🌟 Tela de Onboarding
- Apresenta as principais vantagens do app  
- Ilustrações minimalistas  
- Botão “Começar”  

### 🔐 Tela de Login
- Email e senha (Supabase Auth)  
- Esqueci minha senha  
- Indicador de sincronização  

### 🏠 Tela Home
- Lista de livros com progresso  
- Botão para adicionar novo livro  
- Filtros (Lendo / Concluídos / Todos)  

### 📖 Tela de Detalhes do Livro
- Capa grande  
- Progresso detalhado  
- Histórico de leituras  
- Botão “Registrar Leitura”  

### 👤 Tela de Perfil
- Foto, nome e email  
- Estatísticas gerais  
- Última sincronização  
- Opção de logout  

---