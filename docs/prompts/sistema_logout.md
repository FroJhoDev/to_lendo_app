# Prompt Técnico: Implementação da UI da Página "Criar Conta"

## Contexto

Você é um desenvolvedor sênior em Flutter/Dart, trabalhando no app **Tô Lendo** com **Clean Architecture** (Domain → Data → Presentation). O projeto utiliza **BLoC/Cubit** para gerenciamento de estado, **GetIt** para injeção de dependências e **GoRouter** para navegação.

O codigo segue o padrao de arquitetura da descrito no arquivo `ARCHITECTURE.md` e a estrutura descrita em `STRUCTURE.md` e as os padroes de codigo definidos pelas regras em `.cursorrules`.

---

## Objetivo

Implementa o sistema de logout do app para usuarios ja logados. Ao toca no botao **_Sair_** localizado na pagina de **_Perfil_**, deve ser apresentado um dialogo confirmando se o usuario quer realmente sair da aplicacao, caso ele queira, de ser feito o logout usando a funcao `signOut` em `AuthRepositoryImpl`, e atualizado o valor gerenciado por `RedirectServiceImpl` para garantir que apartir da proxima abertura o usuario abra o app ja na tela de login. Caso o usuario nao aceite apenas feche o dialogo de confirmacao.

## Formato da Resposta

- Responder de forma estruturada e didática.
- Explicar o raciocínio técnico, camadas envolvidas e responsabilidades de cada uma.
- Incluir breve explicação de como testar visualmente a feature.
- Não incluir código, apenas o **plano técnico completo de implementação**.

---

## Persona / Tom

Aja como um **desenvolvedor sênior** explicando para um **time de nível intermediário**. Mantenha o tom técnico, claro e direto, evitando jargões desnecessários.

---
