echo "### Configurando ambiente não interativo ###"
export DEBIAN_FRONTEND=noninteractive

# 1. Informa ao debconf para não fazer perguntas
export DEBIAN_FRONTEND=noninteractive

# 2. Configura o needrestart para não ser interativo
# 'a' significa automático (reinicia serviços sem perguntar)
# kernelhints = 0 desativa o aviso de kernel pendente que você recebeu
sudo sed -i 's/#$nrconf{restart} = .*/$nrconf{restart} = "a";/' /etc/needrestart/needrestart.conf
sudo sed -i 's/#$nrconf{kernelhints} = .*/$nrconf{kernelhints} = 0;/' /etc/needrestart/needrestart.conf
sudo sed -i 's/#$nrconf{ucodehints} = .*/$nrconf{ucodehints} = 0;/' /etc/needrestart/needrestart.conf

echo "### Atualizando o sistema ###"
# O prefixo DEBIAN_FRONTEND garante que o apt ignore os prompts
sudo -E apt update -y
sudo -E apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

echo "### Instalando o pacote boto3  ###"
pip install boto3

echo "### Instalando dependências necessárias para o laboratório  ###"
sudo -E apt install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" jq tree openjdk-17-jdk

echo "### Atualizando o NPM para a última versão ###"
sudo npm install -g npm@latest

echo "### Redimensionando o disco ###"
echo "### O tamanho desejado em GiB ###"
export CLOUD9_DISK_NEW_SIZE=150

echo "### O ID da instância EC2 do ambiente Cloud9 ###"
export CLOUD9_EC2_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data//instance-id)

echo "### O ID do disco EBS associado a essa instância ###"
export CLOUD9_EC2_VOLUME_ID=$(aws ec2 describe-instances --instance-id $CLOUD9_EC2_INSTANCE_ID | jq -r .Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId)

echo "### Redimensionamento do volume EBS ###"
aws ec2 modify-volume --volume-id $CLOUD9_EC2_VOLUME_ID --size $CLOUD9_DISK_NEW_SIZE

echo "### Aguardando a finalização do redimensionamento. ###"
while [ "$(aws ec2 describe-volumes-modifications --volume-id $CLOUD9_EC2_VOLUME_ID --filters Name=modification-state,Values="optimizing","completed" | jq '.VolumesModifications | length')" != "1" ]; do
	echo "waiting volume..."
	sleep 1
done

echo "### Executando lsblk para verificar o nome do disco. ###"
lsblk

export DISK_NAME=$(sudo lsblk -o NAME -n | grep '\<nvme0n1\>')
echo "### O nome do disco é: $DISK_NAME ###"

if [ -z "$DISK_NAME" ]
then
	export DISK_NAME=$(sudo lsblk -o NAME -n | grep '\<xvda\>')

	if [ -z "$DISK_NAME" ]
	then
		echo "### Não foi possível encontrar o nome do disco. O redimensionamento não terá efeito. ###"
		exit 1
	else
		echo "### O nome do disco é: $DISK_NAME ###"
		echo "### Reescrevendo a tabela de partição para uso full do espaço solicitado. ###"
		sudo growpart /dev/xvda 1

		echo "### Expandindo o tamanho da particao sistema de arquivos. ###"
		sudo resize2fs /dev/xvda1
	fi
else
	echo "### Reescrevendo a tabela de partição para uso full do espaço solicitado. ###"
	sudo growpart /dev/nvme0n1 1

	echo "### Expandindo o tamanho do sistema de arquivos. ###"
	sudo resize2fs /dev/nvme0n1p1
fi

