# Annotation

Як працює ансібл:
припустимо є ось така структура папок

    site.yml                    // основний файл який запускає всі потрібно ролі
    inventory.yml               // Файл де лежть ip віддалених хостів
    group_vars/                 // змінні для груп хостів
       all/                     // назва папки каже що ці змінні будуть доступні для всіх груп
          site.yml              // Файл зі змінними          
    roles/
       tomcat/
         files/                 //Файли які можуть використовувати для копі пасту на ремоут машину
         templates/             // Файли конфігів nginix.conf.j2
         tasks/                 // Основна папка в якій описано що за чим буде запускатись
         handlers/              // В основному там лежать плейбуки які рестартують сервіс (які використовуються паро раз)
         vars/                  // Описані змінні в цій папці
         defaults/              // Всі змінні по дефолту - менш пріорітетна папка ніж всі інші
         meta/                  // плейбук який виконається перед поточним таском
       java/
         ...
       mysql/
         ...

    $ ansible-playbook site.yml

При запуску цієї команди перш за все считається файли конфігурації ансібл в такій послідовності
    1) ANSIBLE_CONFIG - environment var
    2) ./ansible.cfg - in current folder
    3) ~/.ansible.cfg - in home folder
    4) /etc/ansible/ansible.cfg - main conf file
Норма створити в поточній папці файл конфіг.
Далі считає файл inventory де знайде ip віддалених машин
- inventory - 2 слова по inventory: там лежить іп віддалених машин. Їх можна групувати таким синтаксисом [db] або [app]. 
після цього в головному файлі site.yml можна буде задавати в строці hosts: цілу групу хостів. 
Також можна групувати групи в загальні групи


Запустить основний плейбул site.yml і з самого початку збере мета інформацію про віддалені хости якщо він не задісейблений в конфізі.
і далі буде йти по ролях послідовно.
по цій схемі перш за все считає файл main.yml який лежить в папці /tomcat/meta. це як прилюдія) якщо шось потрібно 
зробити перед виконанням основного таска. далі считає файл main.yml який лежить в папці tasks. В цьому файлі 
може використовувати складові які лежать в папках поруч (file, templates, handlers, vars, defaults), 
без вказування абсолютного шляху. Імена папок строго повинні бути такими. 

- files - Наприклад якщо потрібно скинути на віддалену машину файл відповідно він має лежати в папці  і тоді 
звертатись до нього можна просто по імені.

- tamplates - Там лежать шаблони. наприклад якийсь конфіг. він має називтись будь як але в кінці має бути розширення .j2 
В цей шаблон можна вставляти змінні або глобальні (файл group_vars/all/site.yml) або ті які лежать в папці vars поточної ролі за 
допомогою {{ some_var }}. Також можна використати змінні які підхопить gather_facts - це мета данні які збираються з віддаленого хоста 
перед початком плейбука. Такі наприклад як ip address.

- handlers - папка в якій лежить файл з тасками такими як restart service, це звичайно якщо воно використовується багато раз. 
Наприклад після передання на віддалену машину нового конфігу потрібно рестартнути сервіс. Ось для цього потрібно hendlers.

- vars - Там зберігаються змінні для конкретної ролі. ЇЇ можна викинути її як в глобальну змінну за допомогою 
set_facts: name_new_var={{ var_in_local_folder }}, і потім звернутись до неї з іншої ролі ось так {{ хз як }}
але я так і не зміг то зробити.....)

- default - папка в якій лежать дефолтні змінні. Має найнищий пріорітет

може шось неправильно. але наскільки я поняв воно так працює)


# Example config and playbook for ansible
## Ierarhie folder
    site.yml                    // основний файл який запускає всі потрібно ролі
    inventory.yml               // Файл де лежть ip віддалених хостів
    group_vars/                 // змінні для груп хостів
       all/                     // назва папки каже що ці змінні будуть доступні для всіх груп
          site.yml              // Файл зі змінними          
    roles/
       tomcat/
         files/                 //Файли які можуть використовувати для копі пасту на ремоут машину
         templates/             // Файли конфігів nginix.conf.j2
         tasks/                 // Основна папка в якій описано що за чим буде запускатись
         handlers/              // В основному там лежать плейбуки які рестартують сервіс (які використовуються паро раз)
         vars/                  // Описані змінні в цій папці
         defaults/              // Всі змінні по дефолту - менш пріорітетна папка ніж всі інші
         meta/                  //
       java/
         ...
       mysql/
         ...

    Также для каждой роли будут применяться следующие правила:

 - если существует roles/.../tasks/main.yml, то задачи из этого файла будут добавлены в набор инструкций;
 - если существует roles/.../handlers/main.yml, то обработчики из этого файла будут добавлены в набор инструкций;
 - если существует roles/.../vars/main.yml, то переменные из этого файла будут добавлены в набор инструкций;
 - если существует roles/.../meta/main.yml, то любые роли-зависимости будут добавлены в список ролей;
 - задача копирования может ссылаться на файл в roles/.../files без указания абсолютного или относительного пути;
 - скриптовая задача может ссылаться на скрипт в roles/.../files без указания абсолютного или относительного пути;
 - задача шаблонизации может ссылаться на roles/.../templates без указания абсолютного или относительного пути;
 - импортируемые задачи могут ссылаться на файлы в roles/.../tasks без указания абсолютного или относительного пути.

## Playbook
### Master site.yml

    ---
    - name: main conf yml
      hosts: all
      remote_user: root
      //become: yes
      //become_method: sudo
      //gather_facts: True / False          // Збирає мета інфу в змінні про віддалений хост

      roles:
         - firewall
         - generic
         - upgrade
         - java
         - tomcat
         __________________________________
         must be this folders tree
         
        .
        ├── ansible.cfg
        ├── inventory
        ├── README.md
        ├── roles
        │   ├── firewall
        │   │   └── tasks
        │   │       └── main.yml
        │   ├── generic
        │   │   └── tasks
        │   │       └── main.yml
        │   ├── java
        │   │   └── tasks
        │   │       └── main.yml
        │   ├── maven
        │   │   └── tasks
        │   ├── tomcat
        │   │   └── tasks
        │   │       └── main.yml
        │   └── upgrade
        │       └── tasks
        │           └── main.yml
        └── site.yml


### playbook with firewall

    - name: 8080 port | open
      firewalld:
        zone: public 
        port: 8080/tcp
        permanent: True
        state: enabled
        immediate: True           // Одразу примінить правило
    
#### Another way add ruls 
    - name: Enable firewalld
      service: name=firewalld state=started enabled=yes
    
    - name: Set dmz as default policy
      command: firewall-cmd --set-default-zone=dmz

    - name: Allow http/https
      command: firewall-cmd --zone=dmz --permanent --add-service=http --add-service=https
    
### playbook with mysql (mariadb)

    - name: MariaDB and dependens | install
      yum: state=latest name={{ item }}         // Whether to install (present or installed, latest), or remove (absent or removed) a package.
      with_items:                               // По черзі ставиться всі пакети які перераховані нище
        - mariadb-server
        - MySQL-python  

    - name: MariaDB | start
      service: 
        name: mariadb 
        state: started
        enabled: True


    - name: MySQL | Add new user
      mysql_user: 
        name: '{{ mysql_user }}'
        password: '{{ mysql_pass }}'
        host: '%'                                 // Вказує що через цього юзера можна достукатись з віддаленої машини
        priv: '*.*:ALL,GRANT'                     // Привілегії
        state: present

    - name: MySQL | Add new DB
      mysql_db:
        name: _055_DB
        state: present

    - name: Restore database                       
      mysql_db:
        name: _055_DB                            // Заливає дамп DB в вказану DB
        state: import
        target: /tmp/addData.sql                 // цей дамп має бути на віддаленому компі


## ansible-vault
### Використовується в креденшилах наприклад до DB 
    ansible-vault create foo.yml                // Створить зашифрований файл
    ansible-vault edit foo.yml                  // Відредагує існуючий зашифрований файл
    ansible-vault encrypt foo.yml               // Зашифрує існуючий файл 
    ansible-vault decrypt foo.yml               // Розшифрує існуючий файл
    ansible-playbook site.yml --ask-vault-pass  // Запустити playbook з зашифрованим файлом

## Config files
### Sequence read conf files
    1) ANSIBLE_CONFIG - environment var
    2) ./ansible.cfg - in current folder
    3) ~/.ansible.cfg - in home folder
    4) /etc/ansible/ansible.cfg - main conf file



### ansible.cfg
    [defaults]
    hostfile = ~/ansible/inventory
    sudo_user = root
    log_path = /var/log/ansible.log
    
    
    
## Life-hack for debug ansible

### Use --syntax-check
    
    ansible-playbook deploy.yml --syntax-check
    
### Use «Dry Run» or "Check Mode" - doesn't change remote machine but playbook run to end.
    
    ansible-playbook deploy.yml -C (--check)
    
### Use --diff (-D) with Check Mode - You will see different.
     ansible-playbook deploy.yml -CD (--check --diff) 
     
### in playbook use 

    - name: Debug
        debug: msg={{ ansible_distribution }}   // msg - виводить повідомлення зі змінною 
        
    ansible-playbook debug.yml --start-at-task="Debug"           //запустить тільки певну таску

    ansible-playbook debug.yml --step                            //запустить playbook покроково. буде питати що виконувати що ні
