# Robot Framework para Automação de Testes e APIs

Este projeto é uma atividade de automação de testes End-to-End (E2E) do estágio da Compass Uol, onde realizei um curso ideal para programação em automação. Construído com **Robot Framework eXpress**.

---

### **O que este Projeto Inclui?**

Este repositório contém uma série de cenários de teste E2E (ponta a ponta) que simulam o comportamento de uma aplicação real, cobrindo fluxos desde a verificação de disponibilidade de APIs até o fluxo completo de CRUD (criação, leitura, atualização e exclusão) de tarefas e usuários. A estrutura modular e a reutilização de componentes garantem que os testes sejam robustos e de fácil manutenção.

### **Tecnologias Utilizadas**

* **Robot Framework**: Um framework de automação de testes de aceitação e RPA (Automação de Processos Robóticos), que é de código aberto e multiplataforma.
* **Python**: A linguagem de programação na qual o Robot Framework é implementado.
* **Browser Library**: Biblioteca para automação de navegadores.
* **RequestsLibrary**: Biblioteca para testar APIs REST, permitindo o envio de requisições HTTP.
* **FakerLibrary**: Utilizada para gerar dados de teste fictícios, como nomes e e-mails, tornando os testes independentes.
* **JSONLibrary**: Para manipular arquivos de dados no formato JSON, usados para os cenários de teste.

---

### **Estrutura do Projeto**

A organização do projeto segue uma abordagem modular, dividindo as responsabilidades para maior clareza e reutilização.

* **`/tests`**: Contém os arquivos de teste principais (`.robot`), onde os cenários são definidos e os fluxos são executados. Eles são subdivididos por funcionalidade, como `login.robot`, `tasks/create.robot`, `tasks/delete.robot`, `online.robot`, etc.
* **`/resources`**: Armazena arquivos de recursos (`.resource`) que contêm keywords reutilizáveis, elementos de interface e configurações de ambiente.
    * **`/components`**: Keywords para componentes de interface comuns, como alertas (`Alert.resource`), notificações (`Notice.resource`), e cabeçalhos (`Header.resource`).
    * **`/pages`**: Keywords específicas para interações em páginas da aplicação, como a página de login (`loginPage.resource`), criação de tarefas (`TaskCreatePage.resource`), e a página principal de tarefas (`TaskPage.resource`).
    * **`/fixtures`**: Arquivos JSON (`tasks.json`) com dados de teste pré-definidos para diferentes cenários, como criação, duplicação e deleção de tarefas.
    * **`/env`**: Variáveis globais, como a URL base da aplicação (`env.resource`).
* **`E2E.robot`**: Arquivo principal que organiza e executa os cenários de teste E2E.

---

### **Cenários de Teste Abrangidos**

Os cenários foram criados com um enfoque prático, explorando a ferramenta e compreendendo a estrutura de testes, variáveis, bibliotecas e keywords.

#### **API e Páginas**
* **Verificação de Disponibilidade**: Confirma se a API está online.
* **Validação de Interface**: Verifica a presença de elementos importantes nas páginas de cadastro usando **XPath** e **CSS**.

#### **Cadastro e Login**
* **Cadastro de Usuário**: Cenários de sucesso e falha, incluindo:
    * Cadastro preenchendo os campos.
    * Cadastro com dados gerados pela **FakerLibrary**.
    * Validação de erros para e-mail duplicado e e-mail inválido.
    * Verificação de campos obrigatórios vazios.
* **Autenticação**:
    * Login com um usuário pré-cadastrado.
    * Não deve logar com senha inválida.

#### **Gerenciamento de Tarefas (CRUD)**
* **Criação**: Cadastro de tarefa com sucesso e validação para não permitir tarefas duplicadas.
* **Validações Específicas**: Não deve cadastrar uma tarefa quando o limite de tags é atingido.
* **Atualização**: Marca uma tarefa como concluída.
* **Deleção**: Apaga uma tarefa indesejada.

---

### **Mapeamento de Elementos Web**

A documentação incluída detalha o mapeamento de elementos para diferentes sites. A tabela de mapeamento demonstra a aplicação prática de várias estratégias de localização, como **ID**, **Classe**, **CSS Selector**, e **XPath**. Essa seção reforça a importância de seletores robustos e de fácil manutenção para o sucesso da automação.
