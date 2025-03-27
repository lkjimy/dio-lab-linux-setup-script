# Script setup de usuários em um sistema Linux

## Objetivo

Criar diretórios, grupos de permissão e usuários usando um script bash   

1. O dono e todos os diretórios deve ser o usuário `root`   
2. Todos os usuários terão permissão total dentro do diretório `/publico`   
3. Os usuários de cada grupo terão permissão total dentro do diretório de seu grupo   
4. Os usuários não deverão ter nenhuma permissão a outros diretórios, que não sejam `/publico` e o directório de seu respectivo grupo   

## Estutura requisitada

### Diretórios
`/public` # Diretório pertencente a todos   
`/adm` # Diretório pertencente ao grupo `GRD_ADM`   
`/ven` # Diretório pertencente ao grupo `GRD_VEN`   
`/sec` # Diretório pertencente ao grupo `GRD_SEC`   

### Grupos de permissões
`GRP_ADM`, `GRP_VEN`, `GRP_SEC`

### Usuários
#### Os seguinte usuários devem ser adicionados ao grupo `GRP_ADM`
`carlos`, `maria`, `joao`

#### Os seguinte usuários devem ser adicionados ao grupo `GRP_VEN`
`debora`, `sebastiana`, `roberto`

#### Os seguinte usuários devem ser adicionados ao grupo `GRP_SEC`
`josefina`, `amanda`, `regerio`   
