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
