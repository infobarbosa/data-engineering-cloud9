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

Com certeza. Essa é uma observação crucial. Enviar a pasta `venv` para o GitHub não só desperdiça espaço e banda, mas também pode conter segredos ou configurações específicas do seu sistema operacional, causando problemas para outros desenvolvedores (ou para você mesmo em outra máquina).

Ajustei o tutorial para incluir a criação de um arquivo `.gitignore` *antes* do primeiro `git add`.

-----

## Tutorial: Conectando seu Projeto do AWS Cloud9 ao GitHub com SSH

Este guia mostrará como pegar um projeto Python existente (que usa `venv`) no Cloud9 e enviá-lo para um **novo repositório** no GitHub usando autenticação por chave SSH, garantindo que o ambiente virtual seja ignorado.

### Parte 1: Gerar sua Chave SSH no AWS Cloud9

Precisamos de um par de chaves (pública e privada) para que o GitHub "reconheça" seu ambiente Cloud9 sem que você precise digitar usuário e senha a cada `push`.

1.  Abra um novo terminal no seu ambiente AWS Cloud9.

2.  Execute o comando a seguir para gerar uma nova chave SSH (use o algoritmo `ed25519`, que é moderno e seguro). **Substitua pelo seu e-mail do GitHub.**

    ```bash
    ssh-keygen -t ed25519 -C "seu_email@exemplo.com"
    ```

3.  O terminal fará algumas perguntas:

      * `Enter file in which to save the key...`: Pressione **Enter** para aceitar o local padrão (`/home/ubuntu/.ssh/id_ed25519`).
      * `Enter passphrase (empty for no passphrase):`: Para este exercício, é mais simples **pressionar Enter** (deixando a senha em branco).
      * `Enter same passphrase again:`: Pressione **Enter** novamente.

4.  Sua chave foi criada. Agora, precisamos exibir o conteúdo da sua **chave pública** para copiá-la. Use o comando `cat`:

    ```bash
    cat ~/.ssh/id_ed25519.pub
    ```

5.  O terminal exibirá sua chave pública (começa com `ssh-ed25519...`). **Selecione e copie o texto inteiro**, com cuidado para não copiar espaços extras.

---
### Parte 2: Adicionar sua Chave SSH Pública ao GitHub

Agora, vamos informar ao GitHub sobre sua chave pública.

1.  Abra o [GitHub](https://github.com/) e faça login.
2.  Clique na sua **foto de perfil** (canto superior direito) e selecione **Settings** (Configurações).
3.  No menu à esquerda, clique em **SSH and GPG keys** (Chaves SSH e GPG).
4.  Clique no botão verde **New SSH key** (Nova chave SSH).
5.  Preencha os campos:
      * **Title (Título):** Dê um nome descritivo. Ex: `AWS Cloud9 Aula`.
      * **Key type (Tipo de chave):** Deixe como `Authentication Key`.
      * **Key (Chave):** **Cole** a chave pública inteira que você copiou do terminal do Cloud9.
6.  Clique em **Add SSH key** (Adicionar chave SSH).

---
### Parte 3: Testar a Conexão SSH

Vamos verificar se o Cloud9 e o GitHub conseguem se comunicar.

1.  Volte ao seu terminal do Cloud9.

2.  Digite o seguinte comando:

    ```bash
    ssh -T git@github.com
    ```

3.  Você verá uma mensagem de autenticidade (é a primeira vez):
    `Are you sure you want to continue connecting (yes/no/[fingerprint])?`
    Digite **yes** e pressione **Enter**.

4.  Se tudo deu certo, você verá:
    `Hi seu-username! You've successfully authenticated, but GitHub does not provide shell access.`
    Isso é um **sucesso**\! A autenticação funcionou.

---
### Parte 4: Criar o Repositório no GitHub

Vamos criar o "contêiner" vazio no GitHub que receberá seus arquivos.

1.  No GitHub, clique no ícone de **+** (mais) no canto superior direito e selecione **New repository** (Novo repositório).
2.  **Repository name (Nome do repositório):** Dê um nome ao seu projeto (ex: `meu-projeto-python`).
3.  **IMPORTANTE:** *Não* marque nenhuma das caixas de inicialização (`Add a README file`, `Add .gitignore`, `Choose a license`). Seu repositório precisa estar **completamente vazio**.
4.  Clique em **Create repository** (Criar repositório).

---
### Parte 5: Preparar seu Repositório Local no Cloud9

Agora, vamos configurar o Git dentro da pasta do seu projeto no Cloud9.

1.  Volte ao seu terminal do **AWS Cloud9**.

2.  Use o comando `cd` para navegar até a pasta raiz do seu projeto (a pasta que contém seu código e sua pasta `venv`).

    ```bash
    # Exemplo:
    cd ~/environment/meu-projeto-python
    ```

3.  **Configurar seu nome e e-mail no Git:** (Se os alunos nunca usaram o Git antes, este passo é crucial\!)

    ```bash
    git config --global user.name "Seu Nome Completo"
    git config --global user.email "seu_email@exemplo.com"
    ```

4.  **Inicializar o Git:** Transforme sua pasta de projeto em um repositório Git local. O comando `-b main` já define `main` como o nome da branch principal.

    ```bash
    git init -b main
    ```

5.  **Conectar ao Remoto:** Copie o URL SSH da página do seu repositório no GitHub (algo como `git@github.com:seu-username/meu-projeto-python.git`).

    Execute o comando `git remote add` com esse URL:

    ```bash
    git remote add origin git@github.com:seu-username/meu-projeto-python.git
    ```

      * `origin` é o apelido padrão para o seu repositório remoto.

---
### Parte 6: Criar o `.gitignore` (O Passo Crucial)

**Antes** de adicionar qualquer arquivo, vamos dizer ao Git o que ele deve *ignorar* usando a interface gráfica do Cloud9.

1.  Na **árvore de arquivos** do Cloud9 (painel à esquerda, chamado "Environment"), localize a pasta raiz do seu projeto.

2.  Clique com o **botão direito** no nome da sua pasta de projeto.

3.  Selecione **New File**.

4.  O Cloud9 criará um arquivo "Untitled". Renomeie-o imediatamente para:
    `.gitignore`
    (É muito importante que comece com um **ponto**). Pressione **Enter**.

5.  O arquivo `.gitignore` vazio abrirá automaticamente no editor.

6.  **Copie e cole** o conteúdo abaixo para dentro deste arquivo:

    ```text
    # Ambiente Virtual do Python
    # Substitua "venv/" se seu ambiente tiver outro nome
    venv/
    .venv/

    # Arquivos de cache do Python
    __pycache__/
    *.pyc

    # Arquivos de ambiente (que podem conter senhas)
    .env
    .env.*

    # Metadados de IDEs (Cloud9/VSCode)
    .vscode/
    .c9/
    ```

7.  **Salve o arquivo.** Você pode usar o atalho `Ctrl + S` (que funciona no editor) ou ir ao menu `File > Save`. Feche a aba do arquivo.

---

### Parte 7: Fazer seu Primeiro Commit e Push

Agora que o Git sabe o que ignorar, podemos adicionar e enviar nossos arquivos com segurança.

1.  **Adicionar os arquivos:** Adicione *todos* os arquivos ao "stage" (área de preparação). O `.` significa "tudo no diretório atual". O Git lerá o `.gitignore` e *automaticamente excluirá* a pasta `venv/` e os outros itens da lista.

    ```bash
    git add .
    ```

2.  **(Opcional) Verificar o Status:** Execute `git status` para ver o que será "commitado". Você deve ver seus arquivos (`.py`, `requirements.txt`, etc.) e o próprio `.gitignore` listados em verde. Você **não** deve ver a pasta `venv/` ou nenhum arquivo dentro dela.

    ```bash
    git status
    ```

3.  **Fazer o Commit:** Crie um "snapshot" (um ponto de salvamento) dos seus arquivos com uma mensagem descritiva.

    ```bash
    git commit -m "Commit inicial do projeto com .gitignore"
    ```

4.  **Enviar para o GitHub (Push):** Envie seu commit local (da branch `main`) para o repositório remoto (`origin`). O `-u` vincula sua branch local à remota.

    ```bash
    git push -u origin main
    ```

---
### Parte 8: Verificar no GitHub

1.  Volte para a página do seu repositório no GitHub.
2.  **Atualize a página (F5).**
3.  Seus arquivos de projeto devem estar todos lá. Se você clicar no arquivo `.gitignore`, verá as regras que acabou de criar. O mais importante: a pasta `venv` **não** estará lá\!

Parabéns\! Seu projeto Python está conectado corretamente ao GitHub, ignorando o ambiente virtual.

**Próximos passos (fluxo de trabalho normal):**

1.  Fazer alterações no código.
2.  `git add .`
3.  `git commit -m "Descreva suas mudanças"`
4.  `git push`

-----

## Parabéns! 

Seu ambiente Cloud9 está pronto pra uso!
