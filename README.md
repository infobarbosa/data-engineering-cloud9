# AWS Cloud9

Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

---
## Introdução
AWS Cloud9 é um ambiente de desenvolvimento integrado (IDE) baseado em nuvem que permite escrever, executar e depurar seu código com apenas um navegador. Ele inclui um editor de código, depurador e terminal. O Cloud9 vem pré-empacotado com ferramentas essenciais para linguagens de programação populares, incluindo JavaScript, Python, PHP, Ruby, Go e muito mais.

O objetivo deste tutorial é fornecer instruções para criação de um ambiente que servirá de suporte para aulas.

---

## Custo
**Atenção:** O AWS Cloud9 utiliza instâncias EC2 e outros recursos da AWS que geram custos. Embora o Cloud9 em si não tenha custo adicional, a instância EC2 subjacente e outros serviços utilizados (como EBS para armazenamento) são cobrados de acordo com as taxas padrão da AWS. Certifique-se de desligar ou encerrar seu ambiente Cloud9 quando não estiver em uso para evitar cobranças desnecessárias.

---

## Opção 1 - Criação direta via script

1. Verifique a região no topo à direita do console AWS, normalmente é **Norte da Virgínia**.<br>
**Não** altere essa configuração!
2. Abra o console da AWS e na barra de busca superior digite **CloudShell**.
3. Clique no link **CloudShell**
4. Será disponibilizado um shell para você.
5. Execute o comando a seguir no shell:
  ```sh
  curl -sS https://raw.githubusercontent.com/infobarbosa/data-engineering-cloud9/main/assets/scripts/lab-data-eng-cloud9-environment.sh | bash

  ```
  >Leva de 2 a 3 minutos para o ambiente ser criado. 

6. Na barra de busca superior digite **Cloud9**.
7. Clique no link **Cloud9** (será aberto o painel do serviço Cloud9 com a lista de ambientes).
8. Para abrir o IDE do ambiente criado, clique em **Em aberto**:
9. Uma nova aba será aberta com o IDE do Cloud9 criado.
10. No **terminal** do seu ambiente execute o comando a seguir :

  ```sh
  curl -sS https://raw.githubusercontent.com/infobarbosa/data-engineering-cloud9/main/assets/scripts/setup_cloud9_env.sh | bash

  ```

---

## Opção 2 - Criação manual via console

1. Verifique a região no topo à direita do console AWS, normalmente é **Norte da Virgínia**.<br>
**Não** altere essa configuração!
2. Abra o console da AWS e na caixa de busca superior digite **Cloud9**.
3. Clique no link Cloud9
4. Clique em **Criar ambiente**
5. Será exibida a tela **Criar ambiente**
6. No campo **Nome** informe `lab`
7. No Campo **Descrição** deixe em branco.
8. No campo **Tipo de ambiente** selecione `Nova instância do EC2`.
9. Na área **Tipo instância** selecione `m5.large`
10. No combo **Plataforma** selecione `Ubuntu Server 22.04 LTS` 
11. No combo **Tempo limite**: selecione `1 hora`
12. Na área **Conexão** selecione `Secure Shell (SSH)`
13. Clique em **Criar** ao final da página

    >Leva de 2 a 3 minutos para o ambiente ser criado. 

14. Para abrir o IDE do ambiente criado, clique em **Em aberto**:
15. Uma nova aba será aberta com o IDE do Cloud9 criado
16. Execute o comando a seguir no terminal do seu ambiente:

```sh
curl -sS https://raw.githubusercontent.com/infobarbosa/data-engineering-cloud9/main/assets/scripts/setup_cloud9_env.sh | bash

```

Esse script executa algumas tarefas administrativas importantes para esse laboratório.
- atualização de pacotes
- instalação do jq
- instalação do boto3
- redimensionamento de disco

O output será algo assim:

```
...

### Aguardando a finalização do redimensionamento. ###
waiting volume...
### Executando lsblk para verificar o nome do disco. ###
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0 27.2M  1 loop /snap/amazon-ssm-agent/11320
loop1          7:1    0 63.8M  1 loop /snap/core20/2501
loop2          7:2    0 73.9M  1 loop /snap/core22/1908
loop3          7:3    0 69.8M  1 loop /snap/go/10888
loop4          7:4    0 89.4M  1 loop /snap/lxd/31333
loop5          7:5    0 44.4M  1 loop /snap/snapd/23771
loop6          7:6    0 50.9M  1 loop /snap/snapd/24505
loop7          7:7    0 73.9M  1 loop /snap/core22/1963
nvme0n1      259:0    0  150G  0 disk 
├─nvme0n1p1  259:1    0  9.9G  0 part /
├─nvme0n1p14 259:2    0    4M  0 part 
└─nvme0n1p15 259:3    0  106M  0 part /boot/efi
### O nome do disco é: nvme0n1 ###
### Reescrevendo a tabela de partição para uso full do espaço solicitado. ###
CHANGED: partition=1 start=227328 old: size=20744159 end=20971487 new: size=314345439 end=314572767
### Expandindo o tamanho do sistema de arquivos. ###
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/nvme0n1p1 is mounted on /; on-line resizing required
old_desc_blocks = 2, new_desc_blocks = 19
The filesystem on /dev/nvme0n1p1 is now 39293179 (4k) blocks long.

```

17. Ao término da execução, é possível conferir o tamanho do disco através do comando `df -h`:

```sh
df -h

```

Output:

```
voclabs:~/environment/data-engineering-infra-with-terraform (main) $ df -h
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        146G  6.7G  139G   5% /
tmpfs            3.9G     0  3.9G   0% /dev/shm
tmpfs            1.6G  876K  1.6G   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock
/dev/nvme0n1p15  105M  6.1M   99M   6% /boot/efi
tmpfs            784M  4.0K  784M   1% /run/user/1000
voclabs:~/environment/data-engineering-infra-with-terraform (main) $  
```



-----

## Tutorial: Conectando seu Projeto AWS Cloud9 ao GitHub com SSH

Este guia mostrará como pegar um projeto que você **já iniciou** no Cloud9 e enviá-lo para um **novo repositório** no GitHub usando autenticação por chave SSH.

### Parte 1: Gerar sua Chave SSH no AWS Cloud9

Primeiro, precisamos criar um par de chaves (pública e privada) no seu ambiente Cloud9. Isso permitirá que o GitHub "reconheça" seu ambiente Cloud9 sem que você precise digitar usuário e senha a cada `push`.

1.  Abra um novo terminal no seu ambiente AWS Cloud9.

2.  Execute o comando a seguir para gerar uma nova chave SSH. Use o algoritmo `ed25519`, que é moderno e seguro. **Substitua pelo seu e-mail do GitHub.**

    ```bash
    ssh-keygen -t ed25519 -C "seu_email@exemplo.com"
    ```

3.  O terminal fará algumas perguntas:

      * `Enter file in which to save the key...`: Pressione **Enter** para aceitar o local padrão (`/home/ubuntu/.ssh/id_ed25519`).
      * `Enter passphrase (empty for no passphrase):`: Para este exercício de aula, é mais simples **pressionar Enter** (deixando a senha em branco).
      * `Enter same passphrase again:`: Pressione **Enter** novamente.

4.  Sua chave foi criada\! Agora, precisamos ver o conteúdo da sua **chave pública** para copiá-la. Use o comando `cat`:

    ```bash
    cat ~/.ssh/id_ed25519.pub
    ```

5.  O terminal exibirá sua chave pública. Ela começará com `ssh-ed25519...` e terminará com o seu e-mail. **Selecione e copie o texto inteiro**, da primeira à última letra.

    *Dica:* Tenha cuidado para não copiar nenhum espaço extra ou quebra de linha.

### Parte 2: Adicionar sua Chave SSH Pública ao GitHub

Agora, vamos informar ao GitHub sobre sua chave pública, permitindo que o Cloud9 se conecte.

1.  Abra o [GitHub](https://github.com/) no seu navegador e faça login.
2.  Clique na sua **foto de perfil** no canto superior direito.
3.  No menu suspenso, clique em **Settings** (Configurações).
4.  No menu de navegação à esquerda, clique em **SSH and GPG keys** (Chaves SSH e GPG).
5.  Clique no botão verde **New SSH key** (Nova chave SSH).
6.  Preencha os campos:
      * **Title (Título):** Dê um nome descritivo para que você saiba de onde é esta chave. Exemplo: `AWS Cloud9 Aula`.
      * **Key type (Tipo de chave):** Deixe como `Authentication Key` (Chave de Autenticação).
      * **Key (Chave):** **Cole** a chave pública inteira que você copiou do terminal do Cloud9.
7.  Clique em **Add SSH key** (Adicionar chave SSH). O GitHub pode pedir sua senha para confirmar.

### Parte 3: Testar a Conexão SSH (Opcional, mas recomendado)

Vamos verificar se o Cloud9 e o GitHub conseguem se comunicar via SSH.

1.  Volte ao seu terminal do Cloud9.

2.  Digite o seguinte comando:

    ```bash
    ssh -T git@github.com
    ```

3.  Você provavelmente verá uma mensagem de autenticidade (é a primeira vez que você se conecta):
    `Are you sure you want to continue connecting (yes/no/[fingerprint])?`
    Digite **yes** e pressione **Enter**.

4.  Se tudo deu certo, você verá uma mensagem de boas-vindas:
    `Hi seu-username! You've successfully authenticated, but GitHub does not provide shell access.`
    Isso é um **sucesso**\! Significa que a autenticação funcionou.

### Parte 4: Criar o Repositório no GitHub

Agora, vamos criar o "contêiner" vazio no GitHub que receberá seus arquivos.

1.  No GitHub, clique no ícone de **+** (mais) no canto superior direito e selecione **New repository** (Novo repositório).
2.  **Repository name (Nome do repositório):** Dê um nome ao seu projeto (ex: `meu-projeto-academy`).
3.  **Description (Descrição):** (Opcional) Escreva uma breve descrição.
4.  **Public** ou **Private:** Escolha se seu projeto será visível para todos (Público) ou só para você (Privado).
5.  **IMPORTANTE:** *Não* marque nenhuma das caixas:
      * `Add a README file`
      * `Add .gitignore`
      * `Choose a license`
        Seu repositório precisa estar **completamente vazio** para que possamos enviar seu projeto existente.
6.  Clique em **Create repository** (Criar repositório).

### Parte 5: Conectar seu Projeto Local (Cloud9) ao Repositório Remoto (GitHub)

O GitHub agora mostrará uma página com instruções. Vamos seguir os passos da seção **"...or push an existing repository from the command line"**.

1.  Volte ao seu terminal do **AWS Cloud9**.

2.  Use o comando `cd` para navegar até a pasta raiz do seu projeto (a pasta que contém seu código).

    ```bash
    # Exemplo:
    cd ~/environment/meu-projeto
    ```

3.  **Configurar seu nome e e-mail no Git:** (Se os alunos nunca usaram o Git antes, este passo é crucial\!)

    ```bash
    git config --global user.name "Seu Nome Completo"
    git config --global user.email "seu_email@exemplo.com"
    ```

4.  **Inicializar o Git:** Transforme sua pasta de projeto em um repositório Git local. O comando `-b main` já define `main` como o nome da branch principal (a prática moderna).

    ```bash
    git init -b main
    ```

5.  **Conectar ao Remoto:** Agora, vamos dizer ao seu Git local onde fica o repositório remoto no GitHub. Copie o URL SSH da página do seu repositório no GitHub (deve ser algo como `git@github.com:seu-username/meu-projeto-academy.git`).

    Execute o comando `git remote add` com esse URL:

    ```bash
    git remote add origin git@github.com:seu-username/meu-projeto-academy.git
    ```

      * `origin` é apenas um apelido padrão para o seu repositório remoto.

6.  **Verificar o Remoto:** (Opcional) Verifique se o remoto foi adicionado corretamente.

    ```bash
    git remote -v
    ```

    Você deve ver seu URL de `fetch` (busca) e `push` (envio).

### Parte 6: Fazer seu Primeiro Commit e Push

Finalmente, vamos empacotar seu código e enviá-lo para o GitHub.

1.  **Adicionar os arquivos:** Adicione *todos* os arquivos do seu projeto ao "stage" (área de preparação) do Git. O `.` significa "tudo no diretório atual".
    ```bash
    git add .
    ```
2.  **Fazer o Commit:** Crie um "snapshot" (um ponto de salvamento) dos seus arquivos com uma mensagem descritiva.
    ```bash
    git commit -m "Commit inicial do projeto"
    ```
3.  **Enviar para o GitHub (Push):** Envie seu commit local (da branch `main`) para o repositório remoto (o `origin`).
    O comando `-u` (ou `--set-upstream`) é usado na primeira vez para vincular sua branch local `main` à branch remota `main`.
    ```bash
    git push -u origin main
    ```

### Parte 7: Verificar no GitHub

1.  Volte para a página do seu repositório no GitHub.
2.  **Atualize a página (F5).**
3.  Seus arquivos, que antes estavam apenas no Cloud9, agora devem estar todos listados no GitHub\!

Parabéns\! Seu ambiente Cloud9 está conectado ao GitHub via SSH, e você enviou seu primeiro projeto. A partir de agora, o fluxo de trabalho será mais simples:

1.  Fazer alterações no código.
2.  `git add .`
3.  `git commit -m "O que eu mudei"`
4.  `git push` (você não precisa mais do `-u origin main`)

---

## Parabéns! 

Seu ambiente Cloud9 está pronto pra uso!
