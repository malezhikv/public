# Linux template preparation & setup scripts

## Ubuntu 18.04-24.04 LTS / CentOS 7/9 Stream minimal
1. _ubuntu-prepare-template.sh_ / _centos-prepare-template.sh_ - запускаем для обновления и подготовки шаблона Убунты/Центос.
   
   Выполняется поиск и установки обновлений, удаляются сгенерированные ключи , очищаются логи и история команд
   
2. _ubuntu-initial-setup.sh_ / _centos-initial-setup.sh_    - запускается при provisioning новой ВМ.
   
   Создается новый пользователь, добавляется в sudo, копируются authorized_keys из root, для root сбрасывается пароль и блокируется вход по ссш по паролю
