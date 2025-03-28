#!/bin/bash

# Lista de grupos
groups=("GRP_ADM" "GRP_VEN" "GRP_SEC")

# Lista de diretórios e seus grupos
directories=("/publico:" "/adm:GRP_ADM" "/ven:GRP_VEN" "/sec:GRP_SEC")

# Lista de usuários e seus grupos
users=("carlos:GRP_ADM" "maria:GRP_ADM" "joao:GRP_ADM" "debora:GRP_VEN" "sebastiana:GRP_VEN" "roberto:GRP_VEN" "josefina:GRP_SEC" "amanda:GRP_SEC" "rogerio:GRP_SEC")

echo "Iniciando limpeza do ambiente"

echo "##################################"

echo "Iniciando remoção dos diretórios..."

for directory in ${directories[@]} ; do
  directory_name=$(echo $directory | cut -d ":" -f 1)
  rm -rf $directory_name
done

echo "Diretórios removidos"

echo "##################################"

echo "Iniciando remoção dos usuários..."

for user in ${users[@]} ; do
  name=$(echo $user | cut -d ":" -f 1)
  userdel -r -f $name
done

echo "Usuários removidos"

echo "##################################"

echo "Iniciando remoção dos grupos..."

for group in ${groups[@]} ; do
  groupdel -f $group
done

echo "Grupos removidos"

echo "##################################"

echo "Limpeza concluída!"

echo "##################################"

echo "Iniciando criação dos grupos..."

for group in ${groups[@]} ; do
  echo "Criando grupo: $group"
  groupadd -f $group
done

echo "Grupos criados"

echo "##################################"

echo "Iniciando criação dos diretórios..."

for directory in ${directories[@]} ; do
  directory_name=$(echo $directory | cut -d ":" -f 1)
  group_name=$(echo $directory | cut -d ":" -f 2)

  echo "Criando diretório: $directory_name"

  mkdir $directory_name

  if [ -z $group_name ]; then
    echo "Definindo grupo padrão (root) para diretório $directory_name."
    chown root:root $directory_name
    echo "Definindo permissões totais a todos os usuários."
    chmod 777 $directory_name
  else
    echo "Definindo $group_name como grupo do diretório $directory_name."
    chown root:$group_name $directory_name
    echo "Definindo permissões do grupo."
    chmod 770 $directory_name
  fi
done

echo "Diretórios criados"

echo "##################################"

echo "Iniciando criação dos usuários..."

create_users_with_group() {
  local name="$1"
  local group="$2"

  if [ -z $name ]; then
    echo "Nenhum nome foi definido!"
  else
    echo "Criando usuário: $name"

    useradd $name -m -s /bin/bash -p $(openssl passwd -6 12345)

    echo "Redefinindo a senha"

    passwd $name -e

    if [ -z $group ]; then
      echo "Usuário $name, não foi adicionado a um grupo"
    else
      echo "Adicionando $name ao grupo $group"

      gpasswd -a $name $group
    fi
  fi
}

for user in ${users[@]} ; do
  name=$(echo $user | cut -d ":" -f 1)
  group=$(echo $user | cut -d ":" -f 2)

  create_users_with_group $name $group
done

echo "Diretórios criados"

echo "##################################"

echo "Pronto!"
