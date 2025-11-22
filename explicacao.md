# 📚 GUIA TÉCNICO COMPLETO - AGENDEI
## Manual de Referência Técnica | Projeto Integrador III

> **Sistema de Agendamento para Salões de Beleza**  
> **Stack:** MERN (MongoDB, Express.js, React.js, Node.js)  
> **Arquitetura:** Cliente-Servidor (REST API)

---

## 📖 ÍNDICE RÁPIDO

1. [Visão Geral e Arquitetura](#parte-1-fundamentos-e-arquitetura)
2. [Banco de Dados e Modelos](#parte-2-banco-de-dados-mongodb)
3. [Backend - API REST](#parte-3-backend-nodejs--express)
4. [Frontend - React e Redux](#parte-4-frontend-react)
5. [Fluxo de Agendamento Completo](#parte-5-fluxo-de-agendamento-detalhado)
6. [Ferramentas e Bibliotecas](#parte-6-ferramentas-e-bibliotecas)
7. [Roteiro de Apresentação](#parte-7-roteiro-de-apresentação)

---

# 📑 PARTE 1: FUNDAMENTOS E ARQUITETURA

## 🎯 1.1 CONTEXTO DO PROJETO

### **Problema Real Identificado**
Microempreendedores do setor de beleza (salões, barbearias, clínicas de estética) enfrentam desafios na gestão de agendamentos:

❌ **Problemas sem o sistema:**
- Cadernos de papel sujeitos a perda e desorganização
- WhatsApp sem histórico estruturado
- Conflitos de horário (duplo agendamento)
- Perda de tempo em ligações para confirmar disponibilidade
- Esquecimento de compromissos
- Falta de visão da agenda completa
- Dificuldade em gerenciar múltiplos colaboradores

✅ **Solução proposta:**
Sistema web completo que digitaliza e automatiza todo o processo de agendamento, oferecendo:
- Interface para clientes agendarem com autonomia
- Painel administrativo para gestão centralizada
- Verificação automática de disponibilidade
- Histórico de atendimentos

### **Público-Alvo**
1. **Administradores (Donos de salão):**
   - Pequenos e médios salões de beleza
   - Barbearias
   - Clínicas de estética
   - Profissionais autônomos

2. **Clientes finais:**
   - Pessoas que buscam serviços de beleza
   - Necessidade de praticidade e autonomia
   - Preferência por agendamento online

---

## 🏗️ 1.2 ARQUITETURA DO SISTEMA

### **Padrão Arquitetural: Cliente-Servidor (Three-Tier)**

```
┌─────────────────────────────────────────────────────────┐
│                    CAMADA DE APRESENTAÇÃO                │
│                      (FRONTEND - React)                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Páginas     │  │  Componentes │  │    Redux     │  │
│  │  Cliente     │  │  Reutilizáveis│  │   (Estado)   │  │
│  │  e Admin     │  │              │  │              │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└────────────────────────┬────────────────────────────────┘
                         │
                         │ HTTP/HTTPS
                         │ JSON (REST API)
                         │
┌────────────────────────▼────────────────────────────────┐
│                    CAMADA DE LÓGICA                      │
│                   (BACKEND - Node.js)                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │    Rotas     │  │ Controllers  │  │  Middlewares │  │
│  │   (Express)  │  │  (Lógica de  │  │  (Auth, CORS)│  │
│  │              │  │   Negócio)   │  │              │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└────────────────────────┬────────────────────────────────┘
                         │
                         │ Mongoose ODM
                         │
┌────────────────────────▼────────────────────────────────┐
│                     CAMADA DE DADOS                      │
│                      (MongoDB)                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Collections │  │    Índices   │  │ Relacionamen-│  │
│  │  (Tabelas)   │  │              │  │    tos        │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### **Fluxo de Comunicação Completo**

```
1. USUÁRIO INTERAGE COM A INTERFACE
   ↓
2. REACT CAPTURA EVENTO (onClick, onChange, etc.)
   ↓
3. COMPONENTE DISPARA AÇÃO REDUX (dispatch)
   ↓
4. REDUX THUNK EXECUTA CHAMADA ASSÍNCRONA
   ↓
5. AXIOS FAZ REQUISIÇÃO HTTP PARA API
   ↓
6. EXPRESS ROTEIA PARA O CONTROLLER CORRETO
   ↓
7. CONTROLLER VALIDA DADOS
   ↓
8. MONGOOSE INTERAGE COM MONGODB
   ↓
9. MONGODB RETORNA DADOS
   ↓
10. CONTROLLER FORMATA RESPOSTA JSON
   ↓
11. AXIOS RECEBE RESPOSTA
   ↓
12. REDUX ATUALIZA O ESTADO GLOBAL
   ↓
13. REACT RENDERIZA NOVAMENTE (useSelector detecta mudança)
   ↓
14. USUÁRIO VÊ RESULTADO NA TELA
```

---

## 🎯 1.3 OBJETIVOS DO PROJETO

### **Objetivo Geral**
Desenvolver uma plataforma web responsiva e funcional para gestão completa de agendamentos em estabelecimentos do setor de beleza, proporcionando autonomia aos clientes e controle centralizado aos administradores.

### **Objetivos Específicos**

1. ✅ **Autenticação e Autorização**
   - Sistema de cadastro de clientes
   - Login seguro com JWT
   - Criptografia de senhas com bcrypt
   - Separação de permissões (cliente vs admin)
   - Protected Routes

2. ✅ **Gestão Administrativa**
   - CRUD completo de colaboradores
   - CRUD completo de serviços
   - Configuração de horários de atendimento
   - Visualização de agendamentos em calendário
   - Upload de imagens (Cloudinary)

3. ✅ **Sistema de Agendamento Inteligente**
   - Seleção de múltiplos serviços
   - Escolha de data e colaborador
   - Cálculo automático de disponibilidade
   - Verificação de conflitos em tempo real
   - Cálculo automático de preço total

4. ✅ **Visualização e Controle**
   - Calendário interativo (mensal/semanal/diário)
   - Histórico de agendamentos
   - Cancelamento de agendamentos
   - Filtros por data, cliente, colaborador

5. ✅ **Integração Full-Stack**
   - API RESTful completa
   - Gerenciamento de estado global (Redux)
   - Comunicação assíncrona (Axios)
   - Tratamento de erros

---

## 🛠️ 1.4 METODOLOGIA DE DESENVOLVIMENTO

### **Processo de Trabalho**
- **Modelo:** Desenvolvimento iterativo com sprints semanais
- **Reuniões:** Alinhamentos regulares para definição de tarefas
- **Divisão:** Tarefas separadas por área (Frontend, Backend, Banco)
- **Controle de versão:** Git com GitHub (branches, commits, pull requests)
- **Testes:** Testes manuais após cada implementação

### **Ferramentas Utilizadas**

| Categoria           | Ferramenta               | Uso                           |
| ------------------- | ------------------------ | ----------------------------- |
| **Design**          | Figma                    | Prototipagem de interfaces    |
| **Desenvolvimento** | VS Code                  | Editor de código              |
| **Versionamento**   | Git + GitHub             | Controle de versão            |
| **API Testing**     | Postman / Thunder Client | Testes de endpoints           |
| **Banco de Dados**  | MongoDB Compass          | Gerenciamento visual do banco |
| **Deploy**          | Vercel                   | Hospedagem do frontend        |
| **Armazenamento**   | Cloudinary               | Upload de imagens             |

---

# 📑 ESTRUTURA COMPLETA DA APRESENTAÇÃO

---

## **PARTE 1: INTRODUÇÃO GERAL** ⏰ 5 min
### 👤 Responsável: **Pessoa 1A**

### ✅ 1.1 CONTEXTO E PROBLEMA

**O QUE FALAR:**
```
"O AGENDEI nasceu da necessidade de modernizar o agendamento em salões 
de beleza e microempreendedores do setor. Hoje, muitos profissionais 
ainda usam cadernos, WhatsApp ou dependem da memória para controlar 
horários, causando:

❌ Conflitos de agendamento (dois clientes no mesmo horário)
❌ Perda de tempo em ligações para confirmar disponibilidade
❌ Dificuldade de visualizar a agenda completa
❌ Esquecimento de compromissos por parte dos clientes
❌ Falta de histórico organizado de atendimentos

🎯 PÚBLICO-ALVO:
- Proprietários de salões de beleza (pequeno e médio porte)
- Profissionais autônomos (cabeleireiros, manicures, esteticistas)
- Clientes que buscam praticidade e autonomia para agendar
"
```

**PERGUNTAS ESPERADAS:**
- *"Por que não usar agenda do Google?"* → Resposta: Falta de integração com gestão de serviços, profissionais e preços específicos do setor de beleza.
- *"Qual o diferencial do sistema?"* → Resposta: Sistema completo com cadastro de serviços, especialistas, controle de horários e visão separada para admin e cliente.

---

### ✅ 1.2 OBJETIVOS DO PROJETO

**O QUE FALAR:**
```
📌 OBJETIVO GERAL:
Desenvolver uma plataforma web responsiva para gestão de agendamentos 
em salões de beleza, oferecendo autonomia aos clientes e controle 
centralizado aos administradores.

📌 OBJETIVOS ESPECÍFICOS:
1. ✅ Cadastro e autenticação de clientes com controle de sessão
2. ✅ Área administrativa para gestão de colaboradores, serviços e horários
3. ✅ Sistema de agendamento inteligente com verificação de disponibilidade
4. ✅ Visualização de agenda em calendário (mensal/semanal/diária)
5. ✅ Cadastro de múltiplos serviços por agendamento
6. ✅ Controle de status de agendamentos (confirmado, cancelado, concluído)
7. ✅ Integração entre frontend e backend com API RESTful
```

**3 FUNCIONALIDADES ESSENCIAIS:**
1. **Agendamento em tempo real** com verificação de disponibilidade
2. **Painel administrativo completo** para gestão
3. **Área do cliente** para consulta e criação de agendamentos

---

### ✅ 1.3 METODOLOGIA DE TRABALHO

**O QUE FALAR:**
```
🔄 METODOLOGIA:
- Desenvolvimento baseado em sprints semanais
- Reuniões de alinhamento regulares
- Divisão de tarefas: Frontend, Backend e Banco de Dados
- Uso de Git/GitHub para controle de versão e colaboração
- Testes manuais após cada implementação

🛠️ FERRAMENTAS UTILIZADAS:
- Figma: Prototipagem de telas
- VS Code: Desenvolvimento
- GitHub: Versionamento
- Postman/Thunder Client: Testes de API
- MongoDB Compass: Gerenciamento do banco
```

---

### ✅ 1.4 ARQUITETURA E TECNOLOGIAS

**O QUE FALAR:**
```
🏗️ ARQUITETURA: Cliente-Servidor (MVC)

┌─────────────┐      HTTP/REST      ┌─────────────┐
│  FRONTEND   │ ←────────────────→  │   BACKEND   │
│  (React.js) │      JSON API       │  (Node.js)  │
└─────────────┘                     └─────────────┘
                                           │
                                           ↓
                                    ┌─────────────┐
                                    │   MONGODB   │
                                    │  (Database) │
                                    └─────────────┘

📦 TECNOLOGIAS - FRONTEND:
- React.js 18 - Biblioteca JavaScript para interfaces dinâmicas
- Redux Toolkit - Gerenciamento de estado global
- React Router DOM v7 - Navegação entre páginas (SPA)
- Axios - Requisições HTTP
- TailwindCSS - Estilização responsiva
- React Big Calendar - Visualização de agendamentos
- React Day Picker - Seleção de datas
- Date-fns - Manipulação de datas

📦 TECNOLOGIAS - BACKEND:
- Node.js + Express - Servidor e API REST
- MongoDB + Mongoose - Banco de dados NoSQL e ODM
- Bcryptjs - Criptografia de senhas
- JWT - Autenticação via token
- Cloudinary - Upload de imagens
- CORS - Comunicação entre domínios
- Dotenv - Variáveis de ambiente

🔗 FLUXO DA APLICAÇÃO:
1. Cliente acessa o frontend (React)
2. Frontend faz requisição HTTP para API (Node.js)
3. Backend valida dados e consulta/salva no MongoDB
4. Resposta é retornada em JSON para o frontend
5. React renderiza a interface com os dados
```

**PERGUNTAS ESPERADAS:**
- *"Por que MongoDB?"* → Resposta: Flexibilidade de schema, facilidade de uso com JavaScript (MERN Stack) e escalabilidade.
- *"O que é Redux?"* → Resposta: Biblioteca para gerenciar estado global da aplicação (dados compartilhados entre componentes).

---

---

## **PARTE 2: ÁREA ADMINISTRATIVA** ⏰ 8-10 min
### 👥 Responsáveis: **Pessoa 1A + Pessoa 1B**

---

### 📊 2.1 PAINEL ADMINISTRATIVO - VISÃO GERAL
**👤 Responsável: Pessoa 1A**

**O QUE FALAR:**
```
"O painel administrativo é o coração do sistema, onde o dono do salão 
gerencia todo o negócio. Ele tem acesso a 4 módulos principais:"

🔐 ACESSO RESTRITO: Apenas administradores autenticados
```

---

### 📄 2.2 PÁGINA: COLABORADORES
**👤 Responsável: Pessoa 1A**

**📂 Arquivo:** `web/src/pages/Admin/Colaboradores/index.js`

**O QUE MOSTRAR NA TELA:**
- Listagem de colaboradores em tabela
- Botão "+ Novo Colaborador"
- Campos: Nome, Telefone, Email, Status, Foto
- Vinculação de especialidades (serviços que realiza)

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Busca colaboradores do salão
const response = await api.post('/colaborador/filter', {
  salaoId: CONSTS.salaoId
});

// Salva novo colaborador com upload de foto
const formData = new FormData();
formData.append('foto', arquivo);
formData.append('colaborador', JSON.stringify(dados));

await api.post('/colaborador', formData);
```

**FUNCIONALIDADES:**
- ✅ Cadastrar novo colaborador
- ✅ Editar dados (nome, contato, foto)
- ✅ Associar especialidades (ex: manicure → serviço de unhas)
- ✅ Ativar/Desativar colaborador
- ✅ Upload de foto (Cloudinary)

**PERGUNTAS ESPERADAS:**
- *"Como funciona o upload de imagem?"* → Resposta: Frontend envia arquivo via FormData, backend usa Multer + Cloudinary para armazenar na nuvem e retorna URL.
- *"O que são especialidades?"* → Resposta: Relação entre colaborador e serviços que ele pode realizar (many-to-many).

---

### 🛠️ 2.3 PÁGINA: SERVIÇOS
**👤 Responsável: Pessoa 1A**

**📂 Arquivo:** `web/src/pages/Admin/Servicos/index.js`

**O QUE MOSTRAR NA TELA:**
- Listagem de serviços disponíveis
- Campos: Nome do Serviço, Duração (min), Preço, Status, Foto
- Serviços por categoria (corte, manicure, design de sobrancelhas...)

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Busca serviços do salão
const response = await api.post('/servico/filter', {
  salaoId: CONSTS.salaoId
});

// Cadastra novo serviço
await api.post('/servico', {
  salaoId,
  nomeServico: "Corte Feminino",
  duracao: 60, // minutos
  preco: 50.00,
  status: "A" // Ativo
});
```

**FUNCIONALIDADES:**
- ✅ Cadastrar serviços com nome, preço, duração
- ✅ Editar e desativar serviços
- ✅ Upload de foto ilustrativa

**PERGUNTAS ESPERADAS:**
- *"Como a duração é usada?"* → Resposta: Para calcular disponibilidade de horários e intervalo entre agendamentos.

---

### 📅 2.4 PÁGINA: HORÁRIOS DE ATENDIMENTO
**👤 Responsável: Pessoa 1B**

**📂 Arquivo:** `web/src/pages/Admin/HorariosAtendimento/index.js`

**O QUE MOSTRAR NA TELA:**
- Configuração de horários por dia da semana
- Seleção de colaborador
- Horários de início e fim (ex: seg 9h-18h)
- Múltiplos intervalos por dia

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Salva horário de atendimento
await api.post('/horario', {
  salaoId,
  colaboradorId,
  dias: [1, 2, 3, 4, 5], // seg a sex
  horaInicio: "09:00",
  horaFim: "18:00"
});
```

**FUNCIONALIDADES:**
- ✅ Definir dias e horários de trabalho
- ✅ Configurar para cada colaborador
- ✅ Permitir múltiplos turnos (manhã/tarde)

**PERGUNTAS ESPERADAS:**
- *"Como o sistema usa esses horários?"* → Resposta: Para calcular quais horários estão disponíveis ao cliente agendar.

---

### 📆 2.5 PÁGINA: AGENDAMENTOS (CALENDÁRIO)
**👤 Responsável: Pessoa 1B**

**📂 Arquivo:** `web/src/pages/Admin/Agendamentos/index.js`

**O QUE MOSTRAR NA TELA:**
- Calendário com visualização mensal/semanal/diária
- Agendamentos coloridos no calendário
- Informações: Cliente, Serviço, Hora, Colaborador

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Filtra agendamentos por período
const response = await api.post('/agendamento/filter', {
  salaoId,
  range: {
    start: "2025-11-01",
    end: "2025-11-30"
  }
});

// Formata para o calendário
const eventos = agendamentos.map(ag => ({
  title: `${ag.servicoId.nomeServico} - ${ag.clienteId.nome}`,
  start: new Date(ag.data),
  end: addMinutes(new Date(ag.data), ag.servicoId.duracao)
}));
```

**BIBLIOTECA USADA:**
```javascript
import { Calendar } from 'react-big-calendar';
// Biblioteca para renderizar calendário interativo
```

**FUNCIONALIDADES:**
- ✅ Visualizar todos os agendamentos
- ✅ Trocar entre visão mensal/semanal/diária
- ✅ Clicar no evento para ver detalhes
- ✅ Filtrar por período

---

### 🔧 2.6 BACKEND - API E ROTAS
**👤 Responsável: Pessoa 1B**

**📂 Arquivo:** `ws/src/routes/agendamento.routes.js`

**EXPLICAR MÉTODOS HTTP:**

#### **GET** - Buscar dados
```javascript
// Não usado diretamente, mas POST /filter faz a busca
// GET normalmente seria: GET /agendamento/:id
```

#### **POST** - Criar ou buscar dados
```javascript
// POST /agendamento/filter - Buscar agendamentos
router.post('/filter', async (req, res) => {
  const { range, salaoId, clienteId } = req.body;
  
  const agendamentos = await Agendamento.find({
    salaoId,
    data: {
      $gte: startOfDay(new Date(range.start)),
      $lte: endOfDay(new Date(range.end))
    }
  }).populate(['servicoId', 'clienteId', 'colaboradorId']);
  
  res.json({ error: false, agendamentos });
});

// POST /agendamento - Criar novo agendamento
router.post('/', async (req, res) => {
  const { clienteId, salaoId, servicoId, colaboradorId, data } = req.body;
  
  // Validação
  const servico = await Servico.findById(servicoId);
  const cliente = await Cliente.findById(clienteId);
  
  // Criação
  const agendamento = new Agendamento({
    salaoId,
    clienteId,
    servicoId,
    colaboradorId,
    data: new Date(data),
    preco: servico.preco,
    status: 'A'
  });
  
  await agendamento.save();
  res.json({ error: false, agendamento });
});
```

#### **PUT** - Atualizar dados
```javascript
// PUT /agendamento/:id - Atualizar agendamento
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const dados = req.body;
  
  const agendamento = await Agendamento.findByIdAndUpdate(
    id,
    dados,
    { new: true } // retorna o documento atualizado
  );
  
  res.json({ error: false, agendamento });
});
```

#### **DELETE** - Remover dados
```javascript
// DELETE /agendamento/:id - Cancelar agendamento
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  
  await Agendamento.findByIdAndUpdate(id, { status: 'C' }); // C = Cancelado
  
  res.json({ error: false });
});
```

**CONCEITOS IMPORTANTES:**

**1. Populate (JOIN do MongoDB)**
```javascript
// Traz dados relacionados automaticamente
.populate('servicoId', 'nomeServico duracao preco')
// Ao invés de retornar só o ID, retorna o objeto completo
```

**2. Transaction (Transação)**
```javascript
const session = await mongoose.startSession();
session.startTransaction();

try {
  await operacao1({ session });
  await operacao2({ session });
  await session.commitTransaction(); // Confirma tudo
} catch (err) {
  await session.abortTransaction(); // Reverte tudo
}
```

**3. Validação**
```javascript
if (!cliente || !servico) {
  throw new Error('Dados inválidos');
}
```

**PERGUNTAS ESPERADAS:**
- *"Diferença entre POST e PUT?"* → POST cria novo recurso, PUT atualiza existente.
- *"Por que usar POST para buscar?"* → Permite enviar filtros complexos no body (mais flexível que query params).
- *"O que é populate?"* → Função do Mongoose que faz JOIN, trazendo dados de coleções relacionadas.

---

---

## **PARTE 3: ÁREA DO CLIENTE** ⏰ 8-10 min
### 👥 Responsáveis: **Pessoa 2A + Pessoa 2B**

---

### 🔐 3.1 PÁGINA: CADASTRO
**👤 Responsável: Pessoa 2A**

**📂 Arquivo:** `web/src/pages/Cliente/Cadastro/index.jsx`

**O QUE MOSTRAR NA TELA:**
- Formulário de cadastro
- Campos: Nome, Email, Senha, Telefone, Endereço
- Botão "Já tem conta? Faça login"

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Cadastra cliente
const handleCadastro = async (dados) => {
  const response = await api.post('/cliente', {
    salaoId: CONSTS.salaoId,
    nome: dados.nome,
    email: dados.email,
    senha: dados.senha, // será criptografada no backend
    telefone: dados.telefone,
    endereco: dados.endereco
  });
  
  // Salva token e redireciona
  localStorage.setItem('token', response.data.token);
  navigate('/cliente/home');
};
```

**NO BACKEND (bcryptjs):**
```javascript
const bcrypt = require('bcryptjs');

// Criptografa senha antes de salvar
const senhaHash = await bcrypt.hash(senha, 10);

cliente.senha = senhaHash;
await cliente.save();
```

**FUNCIONALIDADES:**
- ✅ Validação de campos obrigatórios
- ✅ Verificação de email único
- ✅ Criptografia de senha
- ✅ Autenticação automática após cadastro

---

### 🔑 3.2 PÁGINA: LOGIN
**👤 Responsável: Pessoa 2A**

**📂 Arquivo:** `web/src/pages/Cliente/Login/index.js`

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Login do cliente
const handleLogin = async (email, senha) => {
  const response = await api.post('/auth/login', {
    email,
    senha,
    tipo: 'cliente' // diferencia de login admin
  });
  
  // Salva token no localStorage
  localStorage.setItem('token', response.data.token);
  localStorage.setItem('cliente', JSON.stringify(response.data.cliente));
  
  // Redux atualiza estado global
  dispatch(setCliente(response.data.cliente));
  
  navigate('/cliente/home');
};
```

**NO BACKEND (JWT):**
```javascript
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

// Verifica senha
const senhaValida = await bcrypt.compare(senha, cliente.senha);

if (!senhaValida) {
  return res.json({ error: true, message: 'Senha inválida' });
}

// Gera token JWT
const token = jwt.sign(
  { id: cliente._id, tipo: 'cliente' },
  process.env.JWT_SECRET,
  { expiresIn: '7d' }
);

res.json({ error: false, token, cliente });
```

**CONCEITOS:**
- **Token JWT**: Credencial criptografada que identifica o usuário
- **LocalStorage**: Armazenamento no navegador (persiste ao recarregar)
- **Protected Routes**: Rotas que exigem autenticação

**PERGUNTAS ESPERADAS:**
- *"Como funciona JWT?"* → Token assinado contendo informações do usuário, validado em cada requisição.
- *"Por que usar bcryptjs?"* → Criptografa senhas de forma irreversível (não é possível descriptografar).

---

### 🏠 3.3 PÁGINA: HOME (LISTA DE SERVIÇOS)
**👤 Responsável: Pessoa 2A**

**📂 Arquivo:** `web/src/pages/Cliente/Home/index.js`

**O QUE MOSTRAR NA TELA:**
- Grid de cards com serviços disponíveis
- Cada card: Foto, Nome, Duração, Preço
- Botão "Agendar"

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Busca serviços ativos
useEffect(() => {
  dispatch(allServicos()); // Redux action
}, []);

// Renderiza cards
{servicos.map(servico => (
  <div key={servico._id} className="card">
    <img src={servico.foto} alt={servico.nomeServico} />
    <h3>{servico.nomeServico}</h3>
    <p>{servico.duracao} min - R$ {servico.preco}</p>
    <button onClick={() => handleAgendar(servico)}>
      Agendar
    </button>
  </div>
))}
```

**FUNCIONALIDADES:**
- ✅ Listagem de serviços disponíveis
- ✅ Filtro/busca (opcional)
- ✅ Redirecionamento para agendamento

---

### 📅 3.4 PÁGINA: AGENDAMENTO (FLUXO COMPLETO)
**👤 Responsável: Pessoa 2B**

**📂 Arquivo:** `web/src/pages/Cliente/Agendamento/index.js`

**FLUXO DO AGENDAMENTO (PASSO A PASSO):**

#### **PASSO 1: Seleção de Serviços**
```javascript
// Componente: DrawerServicos
const handleSelecionarServicos = (servicosSelecionados) => {
  dispatch(setServicosSelecionados(servicosSelecionados));
  
  // Serviço principal
  const principal = servicosSelecionados[0];
  dispatch(updateAgendamento({ 
    campo: 'servicoId', 
    valor: principal._id 
  }));
  
  // Serviços adicionais (ex: corte + barba)
  dispatch(updateAgendamento({ 
    campo: 'servicosAdicionais', 
    valor: servicosSelecionados.slice(1) 
  }));
  
  // Busca disponibilidade
  dispatch(fetchDisponibilidade());
};
```

#### **PASSO 2: Escolha de Data**
```javascript
// Componente: CardDataHorario
const handleChangeDate = (novaData) => {
  dispatch(updateAgendamento({ 
    campo: 'dataSelecionada', 
    valor: novaData 
  }));
  
  // Recarrega horários disponíveis
  dispatch(fetchDisponibilidade());
};
```

#### **PASSO 3: Seleção de Colaborador**
```javascript
// Componente: EspecialistaPicker
const handleSelectColaborador = (colaboradorId) => {
  dispatch(updateAgendamento({ 
    campo: 'colaboradorSelecionado', 
    valor: colaboradorId 
  }));
  
  // Recarrega horários
  dispatch(fetchDisponibilidade());
};
```

#### **PASSO 4: Escolha de Horário**
```javascript
const handleSelectHorario = (hora) => {
  dispatch(updateAgendamento({ 
    campo: 'horaSelecionada', 
    valor: hora 
  }));
};
```

#### **PASSO 5: Confirmação**
```javascript
const handleConfirmar = async () => {
  const cliente = JSON.parse(localStorage.getItem('cliente'));
  
  const agendamento = {
    clienteId: cliente._id,
    salaoId: CONSTS.salaoId,
    servicoId: servicosSelecionados[0]._id,
    servicosAdicionais: servicosSelecionados.slice(1).map(s => s._id),
    colaboradorId: colaboradorSelecionado,
    data: `${dataSelecionada}T${horaSelecionada}:00.000Z`
  };
  
  const response = await api.post('/agendamento', agendamento);
  
  if (!response.data.error) {
    toast.success('Agendamento realizado!');
    navigate('/cliente/agenda');
  }
};
```

**VERIFICAÇÃO DE DISPONIBILIDADE:**
```javascript
// Redux slice: salaoSlice.js
export const fetchDisponibilidade = createAsyncThunk(
  'salao/fetchDisponibilidade',
  async (_, { getState }) => {
    const { servicosSelecionados, dataSelecionada, colaboradorSelecionado } = getState().salao;
    
    const response = await api.post('/agendamento/disponibilidade', {
      salaoId: CONSTS.salaoId,
      servicoId: servicosSelecionados[0]._id,
      colaboradorId: colaboradorSelecionado,
      data: dataSelecionada
    });
    
    return response.data.horariosDisponiveis;
  }
);
```

**NO BACKEND:**
```javascript
// Calcula horários disponíveis
router.post('/disponibilidade', async (req, res) => {
  const { salaoId, servicoId, colaboradorId, data } = req.body;
  
  // 1. Busca horários de atendimento do colaborador
  const horarios = await Horario.find({
    salaoId,
    colaboradorId,
    dias: getDay(new Date(data))
  });
  
  // 2. Busca agendamentos existentes na data
  const agendamentos = await Agendamento.find({
    colaboradorId,
    data: {
      $gte: startOfDay(new Date(data)),
      $lte: endOfDay(new Date(data))
    }
  });
  
  // 3. Calcula intervalos disponíveis
  const servico = await Servico.findById(servicoId);
  const duracao = servico.duracao;
  
  const disponiveis = calcularHorariosLivres(horarios, agendamentos, duracao);
  
  res.json({ horariosDisponiveis: disponiveis });
});
```

**FUNCIONALIDADES:**
- ✅ Seleção de múltiplos serviços
- ✅ Escolha de data e hora
- ✅ Seleção de especialista
- ✅ Verificação em tempo real de disponibilidade
- ✅ Cálculo automático de preço total
- ✅ Confirmação e salvamento

**PERGUNTAS ESPERADAS:**
- *"Como funciona a verificação de disponibilidade?"* → Sistema consulta horários de trabalho, subtrai agendamentos existentes e retorna intervalos livres.
- *"O que acontece se dois clientes agendarem ao mesmo tempo?"* → Backend valida antes de salvar (pode usar transações ou locks).

---

### 📋 3.5 PÁGINA: AGENDA (MEUS AGENDAMENTOS)
**👤 Responsável: Pessoa 2B**

**📂 Arquivo:** `web/src/pages/Cliente/Agenda/index.js`

**CÓDIGO-CHAVE PARA EXPLICAR:**
```javascript
// Busca agendamentos do cliente logado
useEffect(() => {
  const cliente = JSON.parse(localStorage.getItem('cliente'));
  
  dispatch(filterAgendamentos({
    clienteId: cliente._id,
    start: format(new Date(), 'yyyy-MM-dd'),
    end: format(addDays(new Date(), 90), 'yyyy-MM-dd')
  }));
}, []);

// Renderiza lista ou calendário
{agendamentos.map(ag => (
  <div key={ag._id}>
    <h3>{ag.servicoId.nomeServico}</h3>
    <p>Data: {format(new Date(ag.data), 'dd/MM/yyyy HH:mm')}</p>
    <p>Colaborador: {ag.colaboradorId.nome}</p>
    <p>Status: {ag.status === 'A' ? 'Confirmado' : 'Cancelado'}</p>
    <button onClick={() => handleCancelar(ag._id)}>
      Cancelar
    </button>
  </div>
))}
```

**FUNCIONALIDADES:**
- ✅ Visualizar agendamentos futuros
- ✅ Histórico de agendamentos passados
- ✅ Cancelar agendamento
- ✅ Filtro por data/status

---

### 👤 3.6 PÁGINA: PERFIL
**👤 Responsável: Pessoa 2B**

**📂 Arquivo:** `web/src/pages/Cliente/Perfil/index.js`

**FUNCIONALIDADES:**
- ✅ Visualizar dados pessoais
- ✅ Editar nome, telefone, endereço
- ✅ Alterar senha
- ✅ Logout

**CÓDIGO-CHAVE:**
```javascript
const handleAtualizar = async (dadosAtualizados) => {
  const cliente = JSON.parse(localStorage.getItem('cliente'));
  
  const response = await api.put(`/cliente/${cliente._id}`, dadosAtualizados);
  
  // Atualiza localStorage e Redux
  localStorage.setItem('cliente', JSON.stringify(response.data.cliente));
  dispatch(setCliente(response.data.cliente));
};
```

---

### 🔄 3.7 REDUX - GERENCIAMENTO DE ESTADO
**👤 Responsável: Pessoa 2B**

**📂 Arquivo:** `web/src/store/slices/agendamentoSlice.js`

**O QUE É REDUX:**
```
Redux é uma biblioteca de gerenciamento de estado global.
Permite que múltiplos componentes acessem e modifiquem os mesmos dados 
sem precisar passar props manualmente por toda a árvore de componentes.
```

**ESTRUTURA:**
```javascript
// 1. SLICE (Fatia de estado)
const agendamentoSlice = createSlice({
  name: 'agendamento',
  initialState: {
    agendamentos: [],
    loading: false,
    error: null
  },
  reducers: {
    // Ações síncronas
    clearAgendamentos: (state) => {
      state.agendamentos = [];
    }
  },
  extraReducers: (builder) => {
    // Ações assíncronas (API)
    builder.addCase(filterAgendamentos.fulfilled, (state, action) => {
      state.agendamentos = action.payload;
      state.loading = false;
    });
  }
});

// 2. ASYNC THUNK (Chamada API)
export const filterAgendamentos = createAsyncThunk(
  'agendamento/filter',
  async (filtros) => {
    const response = await api.post('/agendamento/filter', filtros);
    return response.data.agendamentos;
  }
);

// 3. USO NO COMPONENTE
const dispatch = useDispatch();
const agendamentos = useSelector(state => state.agendamento.agendamentos);

// Dispara ação
dispatch(filterAgendamentos({ start: '2025-11-01', end: '2025-11-30' }));
```

**VANTAGENS:**
- ✅ Estado centralizado e previsível
- ✅ Facilita debug (Redux DevTools)
- ✅ Evita prop drilling
- ✅ Separa lógica de negócio dos componentes

**PERGUNTAS ESPERADAS:**
- *"Por que usar Redux e não useState?"* → useState é local ao componente, Redux é global e compartilhado.
- *"O que é um Thunk?"* → Função assíncrona que permite executar lógica (como chamadas de API) antes de despachar uma ação.

---

---

## **PARTE 4: RESULTADOS E DISCUSSÃO** ⏰ 3-4 min
### 👤 Responsável: **Qualquer pessoa da equipe**

### ✅ O QUE DEU CERTO:
```
✔️ Arquitetura cliente-servidor bem definida
✔️ Integração completa entre frontend e backend
✔️ Sistema de autenticação funcional com JWT
✔️ Cadastro e gestão de colaboradores, serviços e horários
✔️ Agendamento com verificação de disponibilidade
✔️ Visualização em calendário (admin e cliente)
✔️ Interface responsiva e moderna
✔️ Gerenciamento de estado com Redux
```

### ❌ DIFICULDADES ENFRENTADAS:
```
🔸 Cálculo de horários disponíveis (conflitos, durações variáveis)
🔸 Manipulação de datas e fusos horários (Date-fns ajudou muito)
🔸 Gerenciamento de estado complexo (Redux teve curva de aprendizado)
🔸 Upload de imagens (integração com Cloudinary)
🔸 Validações e tratamento de erros
```

### 🚧 LIMITAÇÕES ATUAIS:
```
⚠️ Sistema de notificações (email/SMS) não implementado
⚠️ Falta painel de relatórios/estatísticas
⚠️ Não tem sistema de pagamento integrado
⚠️ Responsividade pode ser melhorada em alguns pontos
⚠️ Testes automatizados não foram implementados
```

### 🚀 MELHORIAS FUTURAS:
```
📌 Notificações por email/WhatsApp (lembrete de agendamento)
📌 Sistema de avaliação de serviços/colaboradores
📌 Integração com pagamento online
📌 Relatórios de faturamento e ocupação
📌 Modo offline (PWA)
📌 App mobile nativo (React Native)
📌 Multi-salão (gestão de múltiplas filiais)
```

---

## **PARTE 5: CONCLUSÃO** ⏰ 2-3 min
### 👤 Responsável: **Pessoa 1A ou quem iniciou**

### 📚 APRENDIZADOS TÉCNICOS:
```
💡 Desenvolvimento full-stack com MERN (MongoDB, Express, React, Node.js)
💡 Arquitetura de API RESTful
💡 Autenticação com JWT e bcrypt
💡 Gerenciamento de estado com Redux
💡 Manipulação de datas e calendários
💡 Upload e armazenamento de arquivos na nuvem
💡 Integração frontend-backend
💡 Banco de dados NoSQL e relacionamentos
```

### 👥 APRENDIZADOS DE EQUIPE:
```
🤝 Divisão de tarefas e responsabilidades
🤝 Comunicação e alinhamento constante
🤝 Versionamento de código com Git
🤝 Resolução de conflitos de merge
🤝 Revisão de código entre membros
```

### 🎯 GANHO PARA O USUÁRIO:
```
✨ PARA O CLIENTE:
- Autonomia para agendar a qualquer hora
- Visualização clara de horários disponíveis
- Histórico de agendamentos
- Redução de tempo em ligações

✨ PARA O SALÃO:
- Redução de conflitos de horário
- Organização e controle centralizado
- Histórico de clientes e serviços
- Profissionalização do negócio
- Aumento de produtividade
```

---

---

## 🎤 DICAS PARA A APRESENTAÇÃO

### ✅ ANTES:
- [ ] Teste TODAS as funcionalidades no dia anterior
- [ ] Prepare banco de dados com dados realistas (não "teste123")
- [ ] Abra todas as abas necessárias no navegador
- [ ] Deixe o código aberto nos arquivos-chave
- [ ] Teste microfone e projeção
- [ ] Cronometre o tempo (máx 30 min)

### ✅ DURANTE:
- [ ] Fale com clareza e volume adequado
- [ ] Mostre a tela ANTES de explicar o código
- [ ] Não leia slides/código, explique
- [ ] Dê exemplos práticos (ex: "Imagina que sou um cliente...")
- [ ] Interaja com a equipe (não seja robótico)
- [ ] Mantenha contato visual com a professora

### ✅ CÓDIGO NA TELA:
- [ ] Aumente o zoom (mínimo 150%)
- [ ] Destaque as linhas importantes
- [ ] Explique a LÓGICA, não linha por linha
- [ ] Use comentários visuais (setas, círculos)

### ✅ RESPONDENDO PERGUNTAS:
- [ ] Não invente se não souber → "Essa parte ainda estamos estudando"
- [ ] Seja honesto sobre limitações
- [ ] Mostre no código se necessário
- [ ] Conecte com o que já explicou

---

## 📊 CHECKLIST DE CONTEÚDO POR PESSOA

### **PESSOA 1A (Introdução + Admin Colaboradores/Serviços)**
- [ ] Contexto e problema resolvido
- [ ] Objetivos do projeto
- [ ] Metodologia e ferramentas
- [ ] Arquitetura e tecnologias
- [ ] Página de colaboradores (CRUD + upload)
- [ ] Página de serviços
- [ ] Conceito de especialidades

### **PESSOA 1B (Admin Agendamentos/Horários + Backend)**
- [ ] Página de horários de atendimento
- [ ] Página de agendamentos (calendário)
- [ ] Explicação de GET, POST, PUT, DELETE
- [ ] Conceito de populate (JOIN)
- [ ] Transações no MongoDB
- [ ] Validações no backend

### **PESSOA 2A (Cliente Cadastro/Login/Home)**
- [ ] Página de cadastro
- [ ] Criptografia de senha (bcrypt)
- [ ] Página de login
- [ ] Autenticação com JWT
- [ ] LocalStorage e Protected Routes
- [ ] Página Home (lista de serviços)

### **PESSOA 2B (Cliente Agendamento/Agenda/Perfil + Redux)**
- [ ] Fluxo completo de agendamento (5 passos)
- [ ] Verificação de disponibilidade
- [ ] Página de agenda (meus agendamentos)
- [ ] Página de perfil
- [ ] Redux: conceito, slices, thunks
- [ ] useSelector e useDispatch

---

## ❓ PERGUNTAS PROVÁVEIS DA PROFESSORA

### Sobre Arquitetura:
**P:** "Por que separar frontend e backend?"
**R:** Separação de responsabilidades, escalabilidade, possibilidade de criar app mobile usando a mesma API.

### Sobre Banco de Dados:
**P:** "Por que MongoDB e não MySQL?"
**R:** Flexibilidade de schema (não precisa definir estrutura rígida), melhor integração com JavaScript (MERN stack), escalabilidade horizontal.

### Sobre Segurança:
**P:** "Como garantem que a senha é segura?"
**R:** Usamos bcrypt para criptografar (hash) a senha antes de salvar. É irreversível, nem nós conseguimos ver a senha real.

### Sobre Disponibilidade:
**P:** "Como calculam os horários disponíveis?"
**R:** 
1. Pegamos os horários de trabalho do colaborador
2. Subtraímos os horários já agendados
3. Consideramos a duração do serviço
4. Retornamos apenas intervalos livres

### Sobre Performance:
**P:** "E se tiver muitos acessos simultâneos?"
**R:** Atualmente é um protótipo, mas melhorias futuras incluiriam: caching (Redis), balanceamento de carga, otimização de queries, uso de índices no MongoDB.

### Sobre Testes:
**P:** "Fizeram testes automatizados?"
**R:** Nesta versão focamos em testes manuais durante o desenvolvimento. Testes automatizados (Jest, Cypress) são uma melhoria futura.

---

## 🎯 FRASE DE IMPACTO PARA FECHAR

```
"O AGENDEI não é apenas um sistema de agendamento, 
é uma solução completa que moderniza e profissionaliza 
a gestão de microempreendedores do setor de beleza, 
trazendo autonomia para os clientes e eficiência para os negócios."
```

---

## 📎 MATERIAIS COMPLEMENTARES

### Diagramas para projetar (se possível):

1. **Diagrama de Arquitetura:**
```
┌──────────────┐
│   CLIENTE    │
│   (React)    │
└──────┬───────┘
       │ HTTP/JSON
       ↓
┌──────────────┐
│  SERVIDOR    │
│  (Node.js)   │
└──────┬───────┘
       │
       ↓
┌──────────────┐
│   MONGODB    │
└──────────────┘
```

2. **Fluxo de Agendamento:**
```
Cliente → Escolhe Serviço → Seleciona Data → 
Escolhe Colaborador → Vê Horários → Confirma → 
Backend Valida → Salva no BD → Confirmação
```

3. **Modelo de Dados (Relacionamentos):**
```
Salão (1) ──→ (N) Colaboradores
Salão (1) ──→ (N) Serviços
Salão (1) ──→ (N) Clientes
Agendamento (N) ──→ (1) Cliente
Agendamento (N) ──→ (1) Colaborador
Agendamento (N) ──→ (1) Serviço
Agendamento (N) ──→ (N) Serviços Adicionais
```

---

## ✅ BOA SORTE NA APRESENTAÇÃO! 🚀

**Lembre-se:**
- Vocês construíram algo incrível
- Falem com orgulho do trabalho
- Erros acontecem, mantenham a calma
- Trabalho em equipe é visível e valorizado
- Mostrem entusiasmo e conhecimento

**Sucesso! 🎉**
