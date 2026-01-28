# Library System (Ruby on Rails)

> 🚧 **Projeto em desenvolvimento**  
> Este projeto está em **desenvolvimento ativo**. Algumas funcionalidades podem estar incompletas, sofrer alterações ou ainda não estarem disponíveis.  
> Não é recomendado para uso em produção no estado atual.

## Descrição

Este é um **sistema de biblioteca em desenvolvimento**, cujo objetivo é permitir o gerenciamento de livros, usuários e empréstimos de forma centralizada.

O sistema foi idealizado para que gerentes possam administrar o acervo e os empréstimos, enquanto usuários podem consultar livros disponíveis e solicitar empréstimos de forma simples.

## Funcionalidades

### Gerente
- Cadastro e gerenciamento de livros
- Gerenciamento de usuários
- Aprovação e confirmação de devoluções
- Aplicação de multa em caso de atraso
- Recebimento de alertas sobre prazos de empréstimo

### Usuário
- Visualização da lista de livros disponíveis
- Pesquisa e filtro de livros por categoria
- Solicitação de empréstimo
- Indicação de devolução do livro no sistema
- Recebimento de alertas sobre o fim do período de empréstimo

## Fluxo de Empréstimo
1. O usuário solicita o empréstimo de um livro.
2. O sistema controla o período do empréstimo.
3. Próximo ao vencimento, alertas são enviados ao usuário e ao gerente.
4. O usuário informa a devolução pelo sistema.
5. O gerente confirma a devolução.
6. Em caso de atraso ou conflito, uma multa é aplicada automaticamente após o prazo final.

## Status do Projeto
- Estrutura inicial do sistema em desenvolvimento
- Funcionalidades básicas de cadastro em implementação
- Sistema de empréstimos em evolução
- Sistema de notificações planejado

## Funcionalidades Planejadas
- Sistema de autenticação e controle de permissões
- Notificações automáticas de vencimento de empréstimos
- Sistema de multas por atraso
- Histórico de empréstimos por usuário
- Melhoria na organização e validações do sistema

## Tecnologias Utilizadas
- Ruby on Rails
- Banco de dados relacional
- HTML / ERB

## Requisitos
- Ruby **3.4.7**

## Como executar o projeto
1. Clone o repositório:
   ```bash
   git clone https://github.com/RafaelAdamRamos/Library-System-Rails.git

2. Acesse o diretório do projeto:

   ```bash
   cd Library-System-Rails
   ```

3. Instale as dependências:

   ```bash
   bundle install
   ```

4. Configure o banco de dados:

   ```bash
   rails db:create db:migrate
   ```

5. Inicie o servidor:

   ```bash
   rails server
   ```

6. Acesse no navegador:

   ```
   http://localhost:3000
   ```

## Observações

* Projeto desenvolvido para fins de estudo e aprendizado
* Estrutura, funcionalidades e decisões técnicas podem mudar ao longo do desenvolvimento
