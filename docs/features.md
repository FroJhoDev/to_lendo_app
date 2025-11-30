# 📋 Funcionalidades Detalhadas - Tô Lendo

Este documento descreve em detalhes todas as funcionalidades que o aplicativo **Tô Lendo** deve apresentar.

---

## 📘 1. Registro e Gerenciamento de Livros

### 1.1. Adicionar Livros
**Descrição:** Permite ao usuário cadastrar novos livros em sua biblioteca pessoal.

**Campos Obrigatórios:**
- **Título**: Nome do livro (texto livre)
- **Total de Páginas**: Número total de páginas do livro (número inteiro positivo)

**Campos Opcionais:**
- **Autor**: Nome do autor ou autores (texto livre)
- **Descrição**: Sinopse, resumo ou notas pessoais sobre o livro (texto longo)
- **Nota/Rating**: Avaliação do livro (ex: 1 a 5 estrelas, ou escala de 0 a 10)
- **Capa**: Imagem da capa do livro

**Funcionalidades:**
- Validação de campos obrigatórios antes de salvar
- Salvamento local imediato (offline-first)
- Marcação automática como "dirty" para sincronização posterior
- Upload da capa para Supabase Storage (quando houver conexão)

---

### 1.2. Editar Livros
**Descrição:** Permite modificar informações de livros já cadastrados.

**Funcionalidades:**
- Edição de todos os campos (título, autor, descrição, páginas, nota, capa)
- Atualização do timestamp `updatedAt` automaticamente
- Marcação como "dirty" para sincronização
- Validação de dados antes de salvar alterações
- Possibilidade de alterar o total de páginas (recalcula progresso automaticamente)

---

### 1.3. Remover Livros
**Descrição:** Permite excluir livros da biblioteca.

**Funcionalidades:**
- Confirmação antes de excluir (dialog de confirmação)
- Exclusão em cascata: remove também todas as sessões de leitura associadas
- Exclusão local imediata
- Marcação para exclusão remota na próxima sincronização
- Remoção da capa do Supabase Storage (quando aplicável)

---

### 1.4. Classificação por Status
**Descrição:** Sistema de filtros para organizar livros por status de leitura.

**Status Disponíveis:**
- **Lendo**: Livros em progresso (páginas lidas < total de páginas)
- **Concluídos**: Livros finalizados (páginas lidas = total de páginas)
- **Todos**: Exibe todos os livros independente do status

**Funcionalidades:**
- Filtros visuais (tabs ou botões) na tela principal
- Atualização automática do status baseado no progresso
- Contador de livros por status
- Persistência do filtro selecionado (opcional)

---

### 1.5. Capa Personalizada
**Descrição:** Sistema de upload e gerenciamento de imagens de capa dos livros.

**Funcionalidades:**
- **Upload de Galeria**: Seleção de imagem da galeria do dispositivo
- **Upload de Câmera**: Captura de foto diretamente pela câmera
- **Preview**: Visualização da imagem antes de confirmar
- **Redimensionamento**: Otimização automática da imagem (tamanho e qualidade)
- **Armazenamento Local**: Salvamento temporário/local da imagem
- **Upload para Supabase Storage**: Sincronização da imagem para nuvem
- **Fallback**: Imagem padrão quando não houver capa cadastrada
- **Edição**: Possibilidade de trocar a capa de um livro existente

---

## 📅 2. Registro de Sessões de Leitura

### 2.1. Registrar Páginas Lidas
**Descrição:** Permite registrar quantas páginas foram lidas em uma sessão de leitura.

**Funcionalidades:**
- **Campo de Entrada**: Input numérico para quantidade de páginas
- **Validação**: 
  - Não permitir valores negativos
  - Não permitir valores maiores que páginas restantes
  - Validar se o livro existe e está ativo
- **Data da Sessão**: 
  - Padrão: data atual
  - Opção de selecionar data anterior (para registrar leituras passadas)
- **Cálculo Automático**: 
  - Atualização do progresso total do livro
  - Cálculo de porcentagem de conclusão
  - Atualização do status (Lendo/Concluído)

---

### 2.2. Registrar Tempo de Leitura (Opcional)
**Descrição:** Permite registrar o tempo gasto na sessão de leitura.

**Funcionalidades:**
- **Campo Opcional**: Não obrigatório para registrar a sessão
- **Formato**: Tempo em minutos ou horas:minutos
- **Cálculo de Ritmo**: 
  - Páginas por minuto
  - Páginas por hora
  - Velocidade média de leitura

---

### 2.3. Histórico Completo de Leituras
**Descrição:** Visualização de todas as sessões de leitura registradas para um livro.

**Funcionalidades:**
- **Linha do Tempo**: Exibição cronológica das sessões
- **Informações por Sessão**:
  - Data e hora da leitura
  - Quantidade de páginas lidas
  - Tempo de leitura (se registrado)
  - Progresso acumulado naquela data
- **Ordenação**: 
  - Mais recentes primeiro (padrão)
  - Mais antigas primeiro (opção)
- **Filtros**:
  - Por período (última semana, mês, ano)
  - Por quantidade de páginas
- **Estatísticas do Histórico**:
  - Total de sessões
  - Média de páginas por sessão
  - Maior e menor quantidade lida em um dia

---

### 2.4. Estimativa de Término
**Descrição:** Cálculo automático de quando o livro será concluído baseado no ritmo de leitura.

**Funcionalidades:**
- **Cálculo Baseado em**:
  - Média de páginas lidas por dia
  - Ritmo dos últimos 7 dias (ou período configurável)
  - Páginas restantes do livro
- **Exibição**:
  - Data estimada de conclusão
  - Dias restantes estimados
  - Páginas por dia necessárias para concluir em X dias
- **Atualização Automática**: Recalcula sempre que uma nova sessão é registrada
- **Indicadores Visuais**: 
  - Gráfico de progresso
  - Barra de porcentagem
  - Mensagens motivacionais

---

## 📊 3. Estatísticas de Leitura

### 3.1. Média Diária de Páginas
**Descrição:** Cálculo e exibição da média de páginas lidas por dia.

**Funcionalidades:**
- **Períodos de Análise**:
  - Hoje
  - Últimos 7 dias
  - Últimos 30 dias
  - Último mês
  - Último ano
  - Todo o período
- **Cálculos**:
  - Média geral
  - Média apenas dos dias com leitura
  - Comparação com períodos anteriores
- **Visualização**:
  - Número destacado
  - Gráfico de linha ou barra
  - Tendência (aumento/diminuição)

---

### 3.2. Gráficos de Progresso
**Descrição:** Visualizações gráficas do progresso de leitura.

**Tipos de Gráficos:**
- **Gráfico de Progresso do Livro**: 
  - Barra circular ou linear mostrando porcentagem concluída
  - Páginas lidas vs. páginas totais
- **Gráfico Temporal**:
  - Linha do tempo mostrando páginas lidas por dia
  - Identificação de dias sem leitura
- **Gráfico Comparativo**:
  - Comparação entre diferentes livros
  - Comparação entre períodos diferentes
- **Gráfico de Distribuição**:
  - Páginas lidas por dia da semana
  - Identificação de padrões de leitura

**Funcionalidades:**
- Interatividade: zoom, detalhamento ao toque
- Exportação de gráficos (opcional)
- Personalização de período visualizado

---

### 3.3. Dias Consecutivos Lendo (Streak)
**Descrição:** Sistema de gamificação que conta dias consecutivos com leitura registrada.

**Funcionalidades:**
- **Cálculo Automático**:
  - Contagem de dias consecutivos com pelo menos uma sessão
  - Reset quando passar um dia sem leitura
- **Exibição**:
  - Número destacado de dias consecutivos
  - Indicador visual (chama, raio, etc.)
  - Recorde pessoal (maior streak alcançado)
- **Notificações** (opcional):
  - Lembrete quando próximo de perder o streak
  - Parabéns ao alcançar marcos (7, 30, 100 dias, etc.)
- **Histórico de Streaks**: Visualização de todos os períodos consecutivos

---

### 3.4. Livros Concluídos
**Descrição:** Estatísticas e visualização de livros finalizados.

**Funcionalidades:**
- **Contador Total**: Número de livros concluídos
- **Lista de Concluídos**: 
  - Visualização de todos os livros finalizados
  - Data de conclusão
  - Tempo total de leitura (se registrado)
  - Nota atribuída
- **Estatísticas**:
  - Livros concluídos por mês/ano
  - Média de tempo para concluir um livro
  - Total de páginas lidas em livros concluídos
- **Filtros e Ordenação**:
  - Por data de conclusão
  - Por nota
  - Por autor
  - Por total de páginas

---

### 3.5. Ritmo e Previsão de Conclusão
**Descrição:** Análise do ritmo de leitura e previsões de conclusão.

**Funcionalidades:**
- **Ritmo Atual**:
  - Páginas por dia (média)
  - Páginas por semana
  - Páginas por mês
- **Previsão de Conclusão**:
  - Data estimada para cada livro em progresso
  - Baseada no ritmo atual
  - Baseada no ritmo histórico
- **Metas**:
  - Definir meta de páginas por dia/semana/mês
  - Acompanhamento de progresso em relação à meta
  - Alertas quando abaixo da meta
- **Análise Comparativa**:
  - Comparação do ritmo atual com períodos anteriores
  - Identificação de tendências

---

## ☁️ 4. Sincronização Online/Offline com Supabase

### 4.1. Autenticação - Login via Email/Senha, Conta Google ou Conta Apple
**Descrição:** Sistema de autenticação usando Supabase Auth.

**Funcionalidades:**
- **Login**:
  - Campos: email e senha
  - Validação de formato de email
  - Validação de senha (mínimo de caracteres)
  - Mensagens de erro claras
  - Indicador de carregamento
- **Criação de Conta**:
  - Registro de novo usuário
  - Confirmação de senha
  - Validações de segurança
- **Recuperação de Senha**:
  - Link "Esqueci minha senha"
  - Envio de email de recuperação via Supabase
- **Persistência de Sessão**:
  - Manter usuário logado entre sessões
  - Refresh automático de token
  - Logout seguro

---

### 4.2. Sincronização Automática
**Descrição:** Sincronização automática de dados quando houver conexão com internet.

**Funcionalidades:**
- **Detecção de Conexão**:
  - Monitoramento de status de rede
  - Identificação de conexão Wi-Fi ou dados móveis
- **Sincronização em Background**:
  - Sincronização automática quando conexão é detectada
  - Sincronização periódica (configurável)
  - Sincronização ao abrir o app
- **Fila de Operações**:
  - Armazenamento de operações offline
  - Execução sequencial ou em lote
  - Retry automático em caso de falha
- **Indicadores Visuais**:
  - Status de sincronização (sincronizado/pendente/erro)
  - Última sincronização bem-sucedida
  - Contador de itens pendentes

---

### 4.3. Uso Offline Completo
**Descrição:** Funcionalidade completa do app sem necessidade de conexão com internet.

**Funcionalidades:**
- **Operações Disponíveis Offline**:
  - Adicionar, editar e remover livros
  - Registrar sessões de leitura
  - Visualizar estatísticas
  - Acessar histórico
  - Todas as funcionalidades principais
- **Armazenamento Local**:
  - Banco de dados local (Sqflite)
  - Cache de imagens
  - Dados de usuário
- **Marcação de Dados**:
  - Flag "dirty" em registros modificados offline
  - Timestamp de última modificação local
  - Identificação de conflitos potenciais

---

### 4.4. Armazenamento Local (Banco de Dados Interno)
**Descrição:** Sistema de persistência local usando Sqflite.

**Funcionalidades:**
- **Tabelas Locais**:
  - Books (livros)
  - ReadingSessions (sessões de leitura)
  - Users (dados do usuário)
  - SyncQueue (fila de sincronização)
- **Operações CRUD**:
  - Create, Read, Update, Delete locais
  - Queries otimizadas
  - Índices para performance
- **Migrações**:
  - Sistema de versionamento do banco
  - Migrações automáticas ao atualizar app
- **Backup e Restore** (opcional):
  - Exportação de dados locais
  - Importação de backup

---

### 4.5. Upload de Capas para Supabase Storage
**Descrição:** Sincronização de imagens de capa dos livros para o Supabase Storage.

**Funcionalidades:**
- **Upload**:
  - Upload automático quando houver conexão
  - Upload manual (opção de forçar)
  - Compressão e otimização antes do upload
- **Gerenciamento**:
  - Organização por usuário (pasta por user_id)
  - Nomenclatura única para evitar conflitos
  - Remoção de imagens antigas ao atualizar capa
- **Download**:
  - Download automático de capas ao sincronizar
  - Cache local de imagens baixadas
  - Fallback para imagem local se download falhar
- **Permissões**:
  - Acesso privado (apenas o dono)
  - Políticas de segurança do Supabase

---

### 4.6. Resolução de Conflitos
**Descrição:** Sistema para lidar com conflitos de sincronização.

**Funcionalidades:**
- **Estratégia de Conflito**:
  - Comparação por `updatedAt` (última modificação vence)
  - Identificação de conflitos
  - Notificação ao usuário (se necessário)
- **Sincronização Incremental**:
  - Sincronização apenas de dados modificados
  - Otimização de tráfego de rede
  - Timestamp de última sincronização (`lastSyncAt`)

---

## 👤 5. Perfil do Usuário

### 5.1. Foto de Perfil ou Avatar
**Descrição:** Gerenciamento de imagem de perfil do usuário.

**Funcionalidades:**
- **Upload de Foto**:
  - Seleção da galeria
  - Captura pela câmera
  - Preview antes de confirmar
  - Redimensionamento automático
- **Avatar Padrão**:
  - Geração de avatar baseado em iniciais
  - Ícones padrão disponíveis
  - Cores personalizadas
- **Sincronização**:
  - Upload para Supabase Storage
  - Download em outros dispositivos
  - Cache local

---

### 5.2. Nome e Email
**Descrição:** Exibição e edição de informações básicas do usuário.

**Funcionalidades:**
- **Exibição**:
  - Nome completo
  - Email cadastrado
  - Formatação clara e legível
- **Edição** (se permitido):
  - Alteração de nome
  - Alteração de email (com confirmação)
  - Validação de dados
  - Sincronização de alterações

---

### 5.3. Estatísticas Gerais
**Descrição:** Resumo das estatísticas gerais do usuário.

**Funcionalidades:**
- **Métricas Exibidas**:
  - Total de livros cadastrados
  - Total de livros concluídos
  - Total de livros em progresso
  - Total de páginas lidas (todos os livros)
  - Dias consecutivos lendo (streak)
  - Média diária de páginas
  - Tempo total de leitura (se registrado)
- **Visualização**:
  - Cards ou seções organizadas
  - Números destacados
  - Gráficos resumidos
  - Comparação com períodos anteriores

---

### 5.4. Informações de Sincronização
**Descrição:** Exibição do status e informações sobre sincronização.

**Funcionalidades:**
- **Status Atual**:
  - Online/Offline
  - Sincronizado/Pendente/Erro
  - Indicador visual (ícone, cor)
- **Detalhes**:
  - Última sincronização bem-sucedida (data/hora)
  - Quantidade de itens pendentes
  - Tamanho dos dados pendentes
- **Ações**:
  - Botão para forçar sincronização manual
  - Visualização de log de sincronização (opcional)
  - Resolução de erros de sincronização

---

### 5.5. Opção de Logout
**Descrição:** Funcionalidade para desconectar o usuário da conta.

**Funcionalidades:**
- **Logout**:
  - Botão de logout na tela de perfil
  - Confirmação antes de sair (opcional)
  - Limpeza de dados sensíveis locais (opcional)
  - Manutenção de dados locais para login futuro (opcional)
- **Pós-Logout**:
  - Redirecionamento para tela de login
  - Limpeza de cache de autenticação
  - Opção de manter dados locais ou limpar tudo

---

## 🎨 6. Interface do Usuário

### 6.1. Tela de Onboarding
**Descrição:** Tela inicial para novos usuários apresentando o app.

**Funcionalidades:**
- **Conteúdo**:
  - Apresentação das principais vantagens
  - Ilustrações minimalistas e modernas
  - Textos explicativos claros
- **Navegação**:
  - Múltiplas telas (swipe ou botões)
  - Indicador de progresso (dots)
  - Botão "Pular" (opcional)
  - Botão "Começar" na última tela
- **Persistência**:
  - Exibir apenas na primeira execução
  - Opção de revisar depois (nas configurações)

---

### 6.2. Tela de Login
**Descrição:** Tela de autenticação do usuário.

**Funcionalidades:**
- **Campos**:
  - Input de email (com validação)
  - Input de senha (com toggle de visibilidade)
  - Botão "Entrar"
  - Link "Esqueci minha senha"
  - Link "Criar conta"
- **Validações**:
  - Formato de email
  - Senha não vazia
  - Mensagens de erro claras
- **Indicadores**:
  - Loading durante autenticação
  - Status de sincronização (se já logado antes)
  - Mensagens de sucesso/erro

---

### 6.3. Tela Home
**Descrição:** Tela principal com lista de livros.

**Funcionalidades:**
- **Lista de Livros**:
  - Cards ou lista com informações principais
  - Capa do livro (thumbnail)
  - Título e autor
  - Progresso visual (barra de progresso)
  - Porcentagem de conclusão
  - Status (Lendo/Concluído)
- **Ações**:
  - Botão flutuante para adicionar novo livro
  - Toque no livro para ver detalhes
  - Swipe para ações rápidas (editar/excluir)
- **Filtros**:
  - Tabs ou botões: Lendo / Concluídos / Todos
  - Contador de livros por filtro
  - Persistência do filtro selecionado
- **Busca** (opcional):
  - Campo de busca por título/autor
  - Filtro em tempo real

---

### 6.4. Tela de Detalhes do Livro
**Descrição:** Tela com informações detalhadas de um livro específico.

**Funcionalidades:**
- **Cabeçalho**:
  - Capa grande e destacada
  - Título e autor em destaque
  - Botão de editar (ícone)
  - Botão de excluir (ícone, com confirmação)
- **Progresso Detalhado**:
  - Barra de progresso circular ou linear
  - Páginas lidas / Total de páginas
  - Porcentagem de conclusão
  - Data estimada de conclusão
  - Ritmo atual
- **Informações do Livro**:
  - Descrição/sinopse
  - Nota atribuída
  - Data de cadastro
  - Data de conclusão (se aplicável)
- **Histórico de Leituras**:
  - Lista ou timeline de sessões
  - Filtros por período
  - Estatísticas do histórico
- **Ações**:
  - Botão destacado "Registrar Leitura"
  - Compartilhar progresso (opcional)

---

### 6.5. Tela de Perfil
**Descrição:** Tela com informações e configurações do usuário.

**Funcionalidades:**
- **Cabeçalho**:
  - Foto de perfil ou avatar grande
  - Nome do usuário
  - Email
  - Botão de editar perfil
- **Estatísticas Gerais**:
  - Cards com métricas principais
  - Gráficos resumidos
  - Links para estatísticas detalhadas
- **Informações de Sincronização**:
  - Status atual (online/offline)
  - Última sincronização
  - Itens pendentes
  - Botão de sincronização manual
- **Configurações** (opcional):
  - Notificações
  - Tema (claro/escuro)
  - Idioma
  - Sobre o app
- **Ações**:
  - Botão de logout
  - Excluir conta (opcional, com confirmação)

---

## 🔔 7. Funcionalidades Adicionais (Opcionais)

### 7.1. Notificações
**Descrição:** Sistema de notificações para lembrar e motivar o usuário.

**Funcionalidades:**
- **Lembretes de Leitura**:
  - Notificação diária em horário configurável
  - Lembrete quando próximo de perder o streak
- **Conquistas**:
  - Notificação ao concluir um livro
  - Notificação ao alcançar marcos de streak
  - Notificação ao bater recordes pessoais
- **Configurações**:
  - Ativar/desativar notificações
  - Escolher horário dos lembretes
  - Tipos de notificações desejadas

---

### 7.2. Metas e Desafios
**Descrição:** Sistema de metas e desafios para gamificação.

**Funcionalidades:**
- **Definir Metas**:
  - Meta de páginas por dia/semana/mês
  - Meta de livros por ano
  - Meta de dias consecutivos
- **Acompanhamento**:
  - Progresso em relação à meta
  - Gráficos de acompanhamento
  - Alertas quando abaixo da meta
- **Conquistas/Badges**:
  - Conquistas por marcos alcançados
  - Badges visuais
  - Histórico de conquistas

---

### 7.3. Compartilhamento
**Descrição:** Compartilhar progresso e conquistas.

**Funcionalidades:**
- **Compartilhar Progresso**:
  - Imagem do progresso de um livro
  - Estatísticas gerais
  - Conquistas alcançadas
- **Formatos**:
  - Imagem personalizada
  - Texto formatado
  - Links (se houver versão web)
- **Plataformas**:
  - Compartilhar em redes sociais
  - Copiar para área de transferência
  - Enviar por mensagem

---

### 7.4. Busca e Filtros Avançados
**Descrição:** Sistema de busca e filtros para encontrar livros rapidamente.

**Funcionalidades:**
- **Busca**:
  - Por título
  - Por autor
  - Por descrição (busca textual)
- **Filtros**:
  - Por status
  - Por nota/rating
  - Por data de cadastro
  - Por data de conclusão
  - Por total de páginas
  - Por autor
- **Ordenação**:
  - Por título (A-Z, Z-A)
  - Por data de cadastro
  - Por progresso
  - Por nota
  - Por autor

---

### 7.5. Exportação de Dados
**Descrição:** Exportar dados do usuário para backup ou análise externa.

**Funcionalidades:**
- **Formatos de Exportação**:
  - JSON (dados completos)
  - CSV (para planilhas)
  - PDF (relatório formatado)
- **Dados Incluídos**:
  - Lista de livros
  - Histórico de sessões
  - Estatísticas
- **Destino**:
  - Salvar no dispositivo
  - Compartilhar por email
  - Enviar para nuvem (Google Drive, iCloud, etc.)

---

## 📱 8. Requisitos de Performance e UX

### 8.1. Performance
- **Tempo de Abertura**: App deve abrir em menos de 2 segundos
- **Navegação Fluida**: Transições suaves entre telas
- **Carregamento de Imagens**: Lazy loading e cache eficiente
- **Operações Locais**: Todas as operações locais devem ser instantâneas
- **Sincronização**: Não bloquear interface durante sincronização

### 8.2. Experiência do Usuário
- **Feedback Visual**: Indicadores de loading, sucesso e erro
- **Mensagens Claras**: Erros e validações com mensagens compreensíveis
- **Acessibilidade**: Suporte a leitores de tela, tamanhos de fonte ajustáveis
- **Design Responsivo**: Adaptação a diferentes tamanhos de tela
- **Animações Suaves**: Transições e animações que melhoram a experiência

### 8.3. Confiabilidade
- **Tratamento de Erros**: Tratamento robusto de erros de rede, banco, etc.
- **Validações**: Validação de dados em todas as entradas
- **Backup Automático**: Sincronização automática para evitar perda de dados
- **Recuperação**: Capacidade de recuperar de falhas sem perder dados

---

## 🔒 9. Segurança e Privacidade

### 9.1. Segurança de Dados
- **Autenticação Segura**: Uso de tokens JWT do Supabase
- **Dados Locais**: Criptografia de dados sensíveis no dispositivo
- **Comunicação**: HTTPS para todas as comunicações com servidor
- **Permissões**: Solicitar apenas permissões necessárias (câmera, galeria)

### 9.2. Privacidade
- **Dados do Usuário**: Apenas dados necessários são coletados
- **Armazenamento**: Dados armazenados de forma segura e privada
- **Sincronização**: Dados sincronizados apenas com a conta do usuário
- **Exclusão**: Opção de excluir conta e todos os dados associados

---
