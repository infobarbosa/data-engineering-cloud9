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

## Parabéns! 

Seu ambiente Cloud9 está pronto pra uso!
