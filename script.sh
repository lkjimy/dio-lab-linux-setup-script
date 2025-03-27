#!/bin/bash

# Criação de diretórios ['/publico', '/adm', '/ven', '/sec']
#mkdir /publico /adm /ven /sec

# Criar grupos 
#groups=("GRP_ADM" "GRP_VEN" "GRP_SEC")

#groupadd GRP_ADM
#groupadd GRP_VEN
groupadd GRP_SEC

# Criar usuários
#users=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")

create_users() {
  local name=$1
  local group=$2

  if [ -z $name ]; then
    echo "No name has been given!"
  else
    echo "Creating user: $name"

    useradd $name -m -s /bin/bash -p $(openssl passwd -6 123)

    passwd $name -e
  fi

  if [ -z $group ]; then
    echo "Usuário $name, não foi adicionado a um grupo"
  else
    echo "Adicionando $name ao grupo $group"

    gpasswd -a $name $group
  fi
}

delete_users() {
  local name=$1

  if [ -z $name ]; then
    echo "No name has been given!"
  else
    echo "Deleting user: $name"

    userdel $name -r -f
  fi
}

# for user in $users; do
#   create_users $user
# done
