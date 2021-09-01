---
date: "2021-09-01"
author: 'Wllyssys Alves'
title: Git
publishdate: "2021-09-01"
lastmod: "2021-09-01"
type: blog
---

# Git


Compilei esse resumão do curso da Alura sobre o Git. No momento ele funciona como um guia de referência sobre os tópicos a serem estudados, mas quero deixar mais ágil. Minha idéia é criar três partes, conceito, miscelânea de códigos e exercícios.


- https://git-school.github.io/visualizing-git/ - Ferramentas para visualizar os comandos git

- https://git-scm.com/book/pt-br/v2/Fundamentos-de-Git-Gravando-Alterações-em-Seu-Repositório - ver depois

## 01 O que é Git?

-   O que são (e para que servem) **sistemas de controle de versões** e como eles podem ajudar o nosso fluxo de desenvolvimento
    -   Nos ajudam a manter um histórico de alterações;
    -   Nos ajudam a ter controle sobre cada alteração no código;
    -   Nos ajudam para que uma alteração de determinada pessoa não influencie na alteração realizada por outra;
    -   Etc.
-   Que com o comando `git init` nós conseguimos criar um repositório Git;
-   Como analisar o estado do nosso repositório através do comando `git status`.

## 02 Iniciando os trabalhos

### 02A Para saber mais: Quem é você

Antes de qualquer interação com o git, você precisa informar quem é você para que ele armazene corretamente os dados do autor de cada uma das alterações no código.

Basta digitar os seguintes comandos (estando na pasta do repositório git):

```
git config --local user.name "Seu nome aqui"
git config --local user.email "seu@email.aqui"
```


### 02B Para saber mais: git status

Ao executar o comando `git status`, recebemos algumas informações que talvez não estejam tão claras, principalmente quando nos deparamos com termos como `HEAD`, `working tree`, `index`, etc.

-   `HEAD`: Estado atual do nosso código, ou seja, onde o Git os colocou
-   `Working tree`: Local onde os arquivos realmente estão sendo armazenados e editados
-   `index`: Local onde o Git armazena o que será _commitado_, ou seja, o local entre a _working tree_ e o repositório Git em si.

Além disso, os possíveis estados dos nossos arquivos são explicados com detalhes neste link: <[https://git-scm.com/book/pt-br/v2/Fundamentos-de-Git-Gravando-Altera%C3%A7%C3%B5es-em-Seu-Reposit%C3%B3rio](https://git-scm.com/book/pt-br/v2/Fundamentos-de-Git-Gravando-Altera%C3%A7%C3%B5es-em-Seu-Reposit%C3%B3rio).

### 02C Para saber mais: git log

 - `git log` - podemos visualizar o histórico de alterações em nosso projeto.

Apesar de ser fácil, este comando é muito poderoso. Execute `git log --help` e veja algumas das opções possíveis. Para alguns exemplos mais fáceis de entender, você pode pesquisar sobre `git log` ou dar uma olhada neste link: [https://devhints.io/git-log](https://devhints.io/git-log).

### 02D Para saber mais: Quando commitar

Devemos gerar um _commit_ sempre que a nossa base de código está em um estado do qual gostaríamos de nos lembrar. Nunca devemos ter _commits_ de códigos que não funcionam, mas também não é interessante deixar para _commitar_ apenas no final de uma _feature_.

### 02E O que apendemos?

-   Que um `commit` é a forma de salvar um estado ou versão do nosso código;
-   Como adicionar arquivos para serem _commitados_ com `git add`;
-   Como _commitar_ arquivos, utilizando o comando `git commit`;
-   Como verificar o histórico de _commits_, através do `git log` e algumas de suas opções:
    -   `git log --oneline`
    -   `git log -p`
    -   `git log --pretty="parametros de formatação"`
-   Como fazer o Git não monitorar arquivos, através do **.gitignore**
-   Que não devemos realizar `commit`, ou seja, salvar um estado, da nossa aplicação que não esteja funcionando.

## 03 Compartilhando o trabalho

### 03A Para saber mais: GitHub

No último vídeo, nós conhecemos (bem por alto) um dos serviços mais famosos e utilizados por pessoas que desenvolvem software: o **GitHub**.

Com o **GitHub**, podemos ter repositórios remotos públicos e privados gratuitos para armazenar e compartilhar o código dos nossos projetos.

O **GitHub** fornece muitas outras funcionalidades bem legais. Explore-as, brinque com elas, e em outros cursos aqui na Alura nós vamos falar mais sobre esse assunto.

### 03B O que aprendemos?

-   O que são repositórios remotos;
-   Como criar um repositório Git sem uma cópia dos arquivos (com `--bare`) para ser utilizado como servidor;
-   Como adicionar links para os repositórios remotos, com o comando `git remote add`;
-   Como baixar um repositório pela primeira vez, clonando-o com o comando `git clone`;
-   Como enviar as nossas alterações para um repositório remoto, com `git push`;
-   Como atualizar o nosso repositório com os dados no repositório remoto, utilizando `git pull`;
-   O que é e para que serve o **GitHub**;
-   Como criar um repositório no **GitHub**;
-   Como adicionar um repositório do **GitHub** como repositório remoto.

## 04 Trabalhando em equipe

### 04A Para saber mais: Ramificações

_Branches_ ("ramos") são utilizados para desenvolver funcionalidades isoladas umas das outras. A _branch_ `master` é a _branch_ "padrão" quando você cria um repositório.

É interessante separar o desenvolvimento de funcionalidades em _branches_ diferentes, para que as mudanças no código para uma não influencie no funcionamento de outra.

### 04B Para saber mais: Conflitos com rebase

Vimos como é simples resolver conflitos identificados pelo Git ao tentar realizar o `merge`.

Agora, gere um conflito e, ao invés de utilizar o `merge`, utilize o `rebase` para atualizar o `master`:

-   Vá para a _branch_ `titulo`
-   _Commite_ algo
-   Vá para a _branch_ master, _commite_ uma alteração na mesma linha
-   Execute `git rebase titulo`

Veja a saída do Git e utilize as informações que ela te der para, após corrigir o conflito, continuar o `rebase`.


### 04C O que aprendemos?

-   Que uma _branch_ (ou ramo) é uma linha de _commits_ separada, e que pode ser utilizada para desenvolver funcionalidades independentes;
-   Que com _branches_ separados, podemos evitar que o código de uma funcionalidade interfira em outra;
-   Como trazer o trabalho realizado em uma _branch_ para outra _branch_, como por exemplo, o `master`, através do comando `git merge`;
-   Que o `git merge` gera um novo _commit_, informando que houve uma mescla entre duas _branches_;
-   Como trazer os _commits_ de uma _branch_ para outra, com o `git rebase`
-   Que o `git rebase` não gera um _commit_ de `merge`, simplificando o nosso _log_;
-   Como os conflitos são apresentados pelo Git;
-   Como resolver os conflitos e manter apenas as alterações desejadas com o Git.

## 05 Manipulando as versões

-   Que o Git pode nos ajudar a desfazer alterações que não vamos utilizar;
-   Que, para desfazer uma alteração antes de adicioná-la para `commit` (com `git add`), podemos utilizar o comando `git checkout -- <arquivos>`;
-   Que, para desfazer uma alteração após adicioná-la para `commit`, antes precisamos executar o `git reset HEAD <arquivos>` e depois podemos desfazê-las com `git checkout -- <arquivos>`;
-   Que, para revertermos as alterações realizadas em um `commit`, o comando `git revert` pode ser a solução;
-   Que o comando `git revert` gera um novo `commit` informando que alterações foram desfeitas;
-   Que, para guardar um trabalho para retomá-lo posteriormente, podemos utilizar o `git stash`;
-   Que, para visualizar quais alterações estão na `stash`, podemos utilizar o comando `git stash list`;
-   Que, com o comando `git stash apply <numero>`, podemos aplicar uma alteração específica da `stash`;
-   Que o comando `git stash drop <numero>` remove determinado item da `stash`;
-   Que o comando `git stash pop` aplica e remove a última alteração que foi adicionada na `stash`;
-   Que o `git checkout` serve para deixar a cópia do código da nossa aplicação no estado que desejarmos:
    -   `git checkout <branch>` deixa o código no estado de uma `branch` com o nome `<branch>`;
    -   `git checkout <hash>` deixa o código no estado do _commit_ com o hash `<hash>`.

## 06 Gerando entregas

-   Que é possível visualizar quais alterações foram realizadas em cada arquivo, com o comando `git diff`;
-   Que, digitando apenas `git diff`, vemos as alterações em nossos arquivos que não foram adicionadas para `commit` (com `git add`);
-   Que é possível comparar as alterações entre duas _branches_ com `git diff <branch1>..<branch2>`
-   Que é possível comparar as alterações feitas entre um `commit` e outro, através do comando `git diff <commit1>..<commit2>`;
-   Que o Git nos possibilita salvar marcos da nossa aplicação, como por exemplo, lançamento de versões, através do `git tag`;
-   Que o comando `git tag -a` é utilizado para gerar uma nova _tag_;
-   As **_Releases_** do GitHub, que são geradas para cada _tag_ do Git criada em nosso repositório.

---

---

## Exercício 01

1) Crie uma pasta (onde preferir) e dentro dela salve o arquivo **index.html**, com o seguinte conteúdo:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cursos da Alura</title>
</head>
<body>
    <ul>
        <li>Vagrant</li>
        <li>Docker</li>
        <li>Ansible</li>
        <li>Integração Continua</li>
    </ul>
</body>
</html>
```

2) No terminal (ou **Git Bash**, no Windows) navegue até a pasta recém criada (utilize o comando `cd` para navegar entre pastas);

3) Na pasta do projeto, execute o comando `git init` para inicializar um repositório Git;

4) Execute o comando `git status` para garantir que você está em um repositório Git e que o arquivo **index.html** é reconhecido. Leia com calma a saída deste comando. Nem tudo estará claro ainda, mas durante o treinamento ficará!


## Exercício 02

1) No terminal (ou **Git Bash**, no Windows) navegue até a pasta recém criada (utilize o comando `cd` para navegar entre pastas);

2) Execute o comando `git add index.html` para marcar o arquivo para ser salvo (_commitado_);

3) Execute `git status` e confira que o arquivo agora mudou de estado e está pronto para ser salvo (_commitado_);

4) Após adicionar, execute o comando `git commit -m "Criando arquivo index.html com lista de cursos"`. Sinta-se à vontade para alterar a mensagem de _commit_, se desejar;

5) Altere o arquivo **index.html**. Adicione o acento em "Integração Continua", por exemplo;

6) Adicione o arquivo para ser salvo, com `git add .`;

7) Execute o comando `git commit -m "Acento adicionado no curso de Integração Contínua"`. Sinta-se à vontade para alterar a mensagem de _commit_, se desejar;

8) Execute o comando `git log` e analise a sua saída. Execute também `git log --oneline`, `git log -p` e outras alternativas que quiser testar;

9) Crie um arquivo vazio com o nome que quiser, por exemplo, `ide-config`;

10) Crie o arquivo **.gitignore** e adicione uma linha com o nome do arquivo recém-criado (`ide-config`, no exemplo acima);

11) Execute `git status` e verifique que o arquivo **ide-config** não está na lista para ser adicionado;

12) Adicione (com `git add .gitignore`) e realize o `commit` (com `git commit -m "Adicionando .gitignore"`) o arquivo **.gitignore**.

## Exercício 03

1) Crie uma pasta nova em seu computador;

2) No terminal (ou **Git Bash**, no Windows) navegue até a pasta recém criada (utilize o comando `cd` para navegar entre pastas);

3) Execute o comando `git init --bare`;

4) Navegue até a pasta onde se encontra o seu projeto;

5) Execute o comando `git remote add local {caminho}`. Substitua `{caminho}` pelo caminho completo da pasta recém criada;

6) Crie uma nova pasta em seu computador, para representar o trabalho de outra pessoa;

7) No terminal (ou **Git Bash**, no Windows) navegue até a pasta recém criada;

8) Execute o comando `git clone {caminho} projeto`. Substitua `{caminho}` pelo caminho completo da pasta que criamos no primeiro passo;

9) Observe que o repositório clonado está vazio;

10) Acesse a pasta Projeto e execute o comando 'git remote rename origin local' para renomear o repositório local da outra pessoa de "origin" para "local";

11) Navegue até a pasta onde se encontra o seu projeto original;

12) Execute o comando `git push local main` para enviar as suas modificações para o seu servidor;

13) Navegue até a pasta criada no passo 6;

14) Execute o comando `git pull local main` para baixar as modificações;

15) Abra o seu navegador e acesse [http://github.com/](http://github.com/);

16) Crie uma conta;

17) Crie um novo repositório, clicando no símbolo de adição no canto superior direito;

18) No terminal (ou **Git Bash**, no Windows) adicione, ao seu projeto inicial, o repositório remoto recém criado (os comandos são mostrados pelo próprio GitHub);

19) Execute `git push origin main` para enviar as suas alterações para o repositório no GitHub.

## Exercício 04

1) Execute o comando `git branch` e veja que apenas a _branch_ `master` existe no seu repositório;

2) Execute o comando `git branch titulo` e logo após execute o comando `git branch`. Veja que uma nova _branch_ foi criada;

3) Agora, para começar a trabalhar nesta _branch_, digite `git checkout titulo`;

4) Execute novamente `git branch` e confira que agora você está na _branch_ chamado `titulo`;

5) Altere o título da página **index.html** para "Cursos de DevOps da Alura";

6) Adicione as alterações com `git add index.html`;

7) Faça o _commit_, com `git commit -m "Alterando título da página"`;

8) Execute o comando `git log` e confira o novo _commit_;

9) Altere o título da página para "Lista de cursos de DevOps da Alura";

10) Repita os passos 6 e 7, para adicionar um novo _commit_, alterando a mensagem;

11) Repita o passo 8 para conferir o novo _commit_;

12) Execute o comando `git checkout master` para voltar à linha de desenvolvimento `master`;

13) Execute `git log` para conferir que os últimos dois _commits_ não estão lá. Confira se o conteúdo do seu arquivo também voltou ao seu estado original;

14) Na pasta criada para representar o trabalho de outra pessoa na aula anterior:

-   Execute `git checkout -b lista` para criar uma nova _branch_, chamada `lista` e passar a trabalhar nela;
-   Adicione o curso de "Kubernetes" na lista;
-   Repita os passos 6 e 7 para adicionar um novo _commit_, alterando a mensagem;
-   Execute o comando `git checkout master` para voltar à linha de desenvolvimento `master`;

15) Volte para a pasta que representa o seu próprio trabalho;

16) Altere o nome do curso de Docker para "Docker: Criando containers sem dor de cabeça";

17) Repita os passos 6 e 7 para adicionar um novo _commit_, alterando a mensagem;

18) Execute o comando `git merge titulo` para trazer o trabalho feito na _branch_ `titulo` para a _branch_ `master`;

19) Execute o comando `git log --graph` para ver as linhas de desenvolvimento (_branches_);

20) Execute `git checkout titulo` para trabalhar na _branch_ chamada `titulo`;

21) Altere o título para ter a palavra "Cursos" com letra maiúscula;

22) Repita os passos 6 e 7 para adicionar um novo _commit_, alterando a mensagem;

23) Execute o comando `git checkout master` para voltar à linha de desenvolvimento `master`;

24) Execute o comando `git rebase titulo`;

25) Execute o comando `git log` e confira que o _commit_ foi adicionado antes do _commit_ realizado diretamente na _branch_ `master`;

26) Execute o comando `git push local master` para enviar suas alterações para o repositório remoto que criamos na última aula;

27) Na pasta criada para representar o trabalho de outra pessoa na aula anterior:

-   Execute o comando `git pull local master` para baixar as alterações que você já realizou;
-   Execute o comando `git checkout lista` para continuar trabalhando na lista de cursos;
-   Altere o nome do curso de Docker para "Curso de Docker: Criando containers sem dor de cabeça";
-   Repita os passos 6 e 7 para adicionar um novo _commit_, alterando a mensagem;
-   Execute o comando `git checkout master` para voltar à linha de desenvolvimento `master`;
-   Tente juntar seu trabalho com `git merge lista`;
-   Veja que há conflitos. Corrija-os, deixando apenas a linha com o nome correto do curso;
-   Execute o comando `git add index.html` para informar que os conflitos neste arquivo foram corrigidos;
-   Execute o comando `git commit` para que o Git finalize o _merge_;
-   Execute o comando `git push local master` para enviar as suas alterações;

28) Volte para a pasta que representa o seu próprio trabalho;

29) Altere o nome do curso de Vagrant para "Vagrant: Gerenciando máquinas virtuais";

30) Repita os passos 6 e 7 para adicionar um novo _commit_, alterando a mensagem;

31) Tente executar o comando `git push local master`. Veja a falha;

32) Execute o comando `git pull local master` para trazer as alterações da outra pessoa;

33) Agora sim, execute o comando `git push local master` para enviar as alterações.

## Exercício 05

1) Na pasta que representa o seu projeto, faça uma alteração qualquer no arquivo **index.html**;

2) Execute o `git status` e veja que há uma alteração para adicionar;

3) Execute o comando `git checkout -- index.html`. Confira se sua alteração foi desfeita;

4) Novamente, faça alguma alteração no arquivo **index.html**;

5) Execute o comando `git add index.html`;

6) Execute o comando `git reset HEAD index.html` para trazer o arquivo **index.html** de volta para a `HEAD` do projeto (remover do `stage`, que é o que será enviado para o `commit`);

7) Repita o passo 3;

8) Faça mais uma vez alguma alteração no código;

9) Execute o comando `git add index.html` e o comando `git commit -m "Alterando o código"` para realizar um `commit`;

10) Execute o comando `git log` e copie o `hash` deste _commit_ recém criado;

11) Rode o comando `git revert {hash}`, substituindo `{hash}` pelo _hash_ que você copiou anteriormente;

12) Confira que suas alterações foram desfeitas;

13) Mude o nome do curso de Ansible para "Ansible: Infraestrutura como código";

14) Execute o comando `git stash` para salvar estas alterações na `stash`;

15) Altere o nome do curso de Kubernetes para "Kubernetes: Introdução a orquestração de containers";

16) Execute o comando `git add index.html` e o comando `git commit -m "Alterando o nome do curso de Kubernetes"` para realizar um _commit_;

17) Execute o comando `git stash pop` para trazer a última alteração da _stash_;

18) Execute o comando `git add index.html` e o comando `git commit -m "Alterando o nome do curso de Ansible"` para realizar um _commit_;

19) Execute o comando `git push local master` para enviar todas as suas alterações;

20) Execute o comando `git log --oneline` para ver os _commits_ de forma resumida. Copie o _hash_ do _commit_ de `merge` com a _branch_ `lista`;

21) Execute o comando `git checkout {hash}` substituindo `{hash}` pelo _hash_ que você copiou;

22) Veja que diversas alterações não estão mais presentes;

23) Execute `git checkout master` para voltar à linha principal de desenvolvimento.

## Exercício 06

1) Execute o comando `git log -p` para ver, junto a cada _commit_, as alterações nele realizadas;

2) Execute agora o comando `git log --oneline`;

3) Execute o comando `git diff {hash do commit de merge com lista}..{hash do último commit realizado}`;

4) Execute alguma (pequena) alteração no **index.html**;

5) Execute o comando `git diff` e veja esta alteração;

6) Desfaça esta última alteração;

7) Execute o comando `git tag -a v0.1.0` para criar uma _tag_ no seu código;

8) Execute o comando `git push origin v0.1.0` para enviar esta _tag_ para o GitHub;

9) Abra a página do repositório do GitHub que você criou e confira a aba de **_Releases_**.


---

Fonte: Curso de Git da Alura - 20210901
