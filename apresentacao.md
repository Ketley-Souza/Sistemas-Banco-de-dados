# Roteiro Oral — AGENDEI

> **Arquivo fonte:** [explicacao.md](/mnt/data/explicacao.md)

**Duração sugerida:** 20–25 minutos
**Equipe:** 4 pessoas

---

## Instruções gerais

* Apresentação **oral**, sem slides — mostrar o sistema ao vivo conforme o roteiro.
* Cada membro deve ler e decorar *suas falas*.
* Tenham o repositório e a aplicação abertos e com dados de teste.
* Antes de começar: abrir as abas necessárias (admin, cliente, DevTools).

---

## 1 — Abertura (Pessoa 1) — 1 minuto

**Fala (decorada):**

> "Boa tarde, professora. Nós somos o grupo responsável pelo **AGENDEI**, um sistema completo de agendamento para salões de beleza desenvolvido como Projeto Integrador. Nosso objetivo foi resolver problemas reais de microempreendedores do setor, como conflitos de horários, perda de registros, desorganização e excesso de dependência de WhatsApp ou papel.

> O sistema foi construído usando **MERN stack** — MongoDB, Express, React e Node — e conta com uma área administrativa completa, uma área do cliente e um fluxo inteligente de agendamentos."

**Transição:**

> "Vou explicar rapidamente o contexto e a arquitetura e, em seguida, meus colegas mostrarão as funcionalidades na aplicação."
> (Entregar a vez para Pessoa 1 mostrar a pasta/GitHub e em seguida passar para Pessoa 2)

---

## 2 — Contexto, objetivo e arquitetura (Pessoa 1) — 2 minutos

**O que mostrar:** pasta do projeto ou README no GitHub (apenas como referência visual).

**Fala (decorada):**

> "Percebemos que muitos salões ainda usam caderno e WhatsApp. Isso causa duplicidade de horários, falta de histórico e perda de produtividade. Nosso objetivo é digitalizar o processo: permitir que o cliente agende sozinho, e que o administrador controle serviços, colaboradores e horários."

> "Arquitetura: Cliente (React + Redux) ↔ API (Node + Express) ↔ Banco (MongoDB + Mongoose). Comunicação via REST/JSON."

**Transição:**

> "Agora vamos mostrar a área administrativa em funcionamento." (passar o controle para Pessoa 2)

---

## 3 — Área Administrativa (Pessoa 2) — 6 minutos

**Abra o sistema na conta administrativa.**

### 3.1 Colaboradores (2 min)

**O que mostrar:** página de colaboradores (lista e botão de novo colaborador).

**Fala (decorada):**

> "Aqui é onde o administrador cadastra colaboradores: nome, telefone, email e foto. Fazemos upload via FormData; o backend usa Multer + Cloudinary e retorna a URL. Também vinculamos especialidades (quais serviços o profissional realiza)."

**Demonstração técnica breve:** abrir DevTools → Network → enviar um upload e mostrar a requisição FormData.

### 3.2 Serviços (1,5 min)

**O que mostrar:** página de serviços.

**Fala:**

> "Os serviços têm nome, preço, duração e foto. A duração é usada no cálculo de disponibilidade do agendamento."

**Dica para professor:** passe o mouse sobre um serviço e destaque o campo `duracao`.

### 3.3 Horários de Atendimento (1 min)

**O que mostrar:** tela de horários por colaborador.

**Fala:**

> "Configuramos dias e turnos por colaborador — por exemplo, segunda a sexta, 9h às 18h. Esses horários são essenciais para o cálculo dos horários livres."

### 3.4 Calendário do Admin (1,5 min)

**O que mostrar:** React Big Calendar com eventos; clicar em um evento para ver detalhes.

**Fala:**

> "No calendário o administrador visualiza todos os agendamentos. Cada evento mostra cliente, serviço e horário. Os dados são retornados do backend com populate para trazer objetos relacionados."

**Transição final:**

> "Agora vamos para a experiência do cliente — cadastro e fluxo de agendamento." (passar para Pessoa 3)

---

## 4 — Área do Cliente (Pessoa 3) — 6 minutos

**Abra a interface do cliente.**

### 4.1 Cadastro (1 min)

**O que mostrar:** formulário de cadastro; fazer um cadastro rápido (dados de teste).

**Fala:**

> "O cliente se cadastra com nome, email, telefone, endereço e senha. A senha é criptografada com bcrypt no backend antes de salvar."

Mostre a requisição POST no Network.

### 4.2 Login (1 min)

**O que mostrar:** tela de login -> logar (usar credenciais de teste).

**Fala:**

> "No login o backend valida a senha e retorna um token JWT, que armazenamos no localStorage para autorizar rotas protegidas."

### 4.3 Home — Lista de Serviços (1 min)

**O que mostrar:** home com cards de serviços.

**Fala:**

> "Aqui o cliente vê serviços com foto, duração e preço. Ao clicar em Agendar, inicia-se o fluxo de agendamento."

**Transição para Pessoa 4**: clique em *Agendar* em um serviço.

---

## 5 — Fluxo de Agendamento (Pessoa 4) — 6 minutos

**Essa é a parte crítica: execute com calma e paciência.**

### Passo 1 — Seleção de serviços (1 min)

**Mostrar:** seleção de serviços (um ou mais).

**Fala:**

> "O cliente pode escolher múltiplos serviços. O primeiro é o principal e os demais são adicionais; a soma das durações influencia o cálculo de disponibilidade."

### Passo 2 — Seleção de data (1 min)

**Mostrar:** calendário de datas.

**Fala:**

> "Ao escolher a data, o frontend chama o endpoint de disponibilidade para buscar horários livres naquele dia."

### Passo 3 — Seleção do colaborador (1 min)

**Mostrar:** lista de colaboradores filtrada pelos serviços selecionados.

**Fala:**

> "A lista mostra apenas colaboradores que realizam os serviços selecionados."

### Passo 4 — Horários disponíveis (2 min)

**Mostrar:** horários retornados pelo backend; selecione um horário.

**Fala (explanação técnica):**

> "O endpoint `/agendamento/disponibilidade` realiza os seguintes passos:
>
> 1. busca os horários de trabalho do colaborador;
> 2. busca agendamentos já existentes na data;
> 3. considera a duração total dos serviços;
> 4. subtrai os intervalos ocupados;
> 5. retorna horários compatíveis.
>    Isso impede conflitos de horário antes do salvamento."

### Passo 5 — Confirmação (1 min)

**Mostrar:** confirmar agendamento; mostrar que aparece no calendário do admin.

**Fala:**

> "Ao confirmar, o agendamento é salvo no MongoDB e aparece imediatamente tanto para o cliente quanto no calendário do administrador."

**Transição:** mostrar a tela "Meus Agendamentos" e o perfil rapidamente.

---

## 6 — Meus Agendamentos, Perfil e Redux (Pessoa 4) — 1 minuto

**O que mostrar:** página "Meus Agendamentos" e tela de Perfil.

**Fala curta:**

> "Na agenda o cliente vê futuros e passados, e pode cancelar. No perfil ele atualiza dados pessoais. Usamos Redux para gerenciar o estado global, com slices e thunks para chamadas assíncronas."

---

## 7 — Resultados, dificuldades e melhorias (qualquer pessoa) — 3 minutos

**Fala (resumida):**

> "O que deu certo: integração completa MERN, autenticação com JWT, CRUD de colaboradores/serviços, cálculo de disponibilidade e calendário interativo.
> Dificuldades: cálculo de horários (conflitos e durações variáveis), manipulação de datas, curva de aprendizado do Redux e integração com Cloudinary.
> Limitações: notificações, pagamentos e relatórios ainda não implementados.
> Melhorias futuras: notificações por e-mail/WhatsApp, integração de pagamento, relatórios e app mobile."

---

## 8 — Conclusão e abertura para perguntas (Pessoa 1) — 1 minuto

**Fala de encerramento:**

> "O AGENDEI digitaliza o agendamento de salões, trazendo autonomia para clientes e eficiência para administradores. Estamos disponíveis para perguntas."

---

## Perguntas prováveis e respostas curtas (imprimir como roteiro de Q&A)

* **Segurança de senhas?** – bcrypt com salt; não armazenamos senha em texto.
* **Evitar duplicidade de agendamentos?** – validação de conflito no backend; cálculo de disponibilidade antes de salvar.
* **Por que MongoDB?** – flexibilidade de schema e sinergia com MERN.
* **O que é populate?** – equivalente a JOIN: traz objetos relacionados em uma consulta.
* **Por que Redux?** – estado complexo e compartilhado entre muitos componentes.
* **Por que usar POST para filtros?** – permite enviar filtros complexos no body.

---

## Checklist rápido (para levar impresso)

* Banco com dados reais de teste
* Credenciais de teste prontas
* .env.example com variáveis documentadas
* Scripts de seed disponíveis
* GitHub aberto (branch principal) e README com instruções

---

**Boa apresentação!**

> *Treinem em voz alta ao menos 2 vezes com o cronômetro. Cada pessoa deve controlar a própria parte no sistema.*
