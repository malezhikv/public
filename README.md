# Linux template preparation & setup scripts

## Ubuntu 18.04 LTS
1. _ubuntu-prepare-template.sh_ - запускаем для обновления и подготовки шаблона Убунты.
   
   Выполняется поиск и установки обновлений, удаляются сгенерированные ключи , очищаются логи и история команд
   
2. _ubuntu-initial-setup.sh_    - запускается при provisioning новой ВМ с Убунтой.
   
   Создается новый пользователь, добавляется в sudo, копируются authorized_keys из root, для root сбрасывается пароль и блокируется вход по ссш
