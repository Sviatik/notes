
	$ echo Hello ; echo World                           # ; розділяє 2 команди, виконуються навіть коли перша з помилкою
	Hello
	World

	$ echo первая команда && echo вторая команда        # && Розділяє 2 команди, Друга виконається тільки при успішному завершенні першої
	первая команда
	вторая команда

	$ sleep 20 &                                        # & запустити прогу в фоні
	[1] 7925

	$ touch file1
	$ echo $?                                           # $? Повертає код (0-успішно виконана, 1-виконана з помилкою) успішності команди
	0

	$ echo первая команда || echo вторая команда ; echo третья команда      # || Логічне 'Або', виконає другу команду тільки при помилковому виконанні 1ої команди.
	первая команда
	третья команда

	$ rm file1 && echo Команда сработала! || echo Исполнение команды завершилось неудачей!      # && || Комбінація 2ох логічних "І" та "Або"
	rm: невозможно удалить "file1": Нет такого файла или каталога
	Исполнение команды завершилось неудачей!

	$ echo hello \; world                               # \ Символ екранування, ігнорить значення символа в командій строці і виводить просто символ. 
	hello ; world

	cat > hello.py                                      # Створить файл з командою одразу в cli
	print('hello')

	$ username=uusser
	$ echo $username
	uusser
	$export username                                    # Експортує змінну в загальну env.
	$env | grep username
	username=uusser

	cat $logfile | sort -M -k 2			    # Sort по даті

	LANG=C df -h                                        # Змінює локалізацію на період виконання команди df

	name=sviat
	lastname=stets
	fullname=$name\ $lastname                           # Екранує пробіл і в змінну fullname записує значення двох змінних
	echo fullname         
	sviat stets                       

	gpasswd -a user admin                               # добавити user в групу admin

	Фонові процеси

	Ctrl+z                                              # Призупинити процес
	$ jobs                                              # Список призупинених процесів
	$ fg                                                # Відновити призупинений процес на передній план (foreground)
	$ bg  %2                                            # Перемістити 2ий процес (по списку jobs) в фон (Background)
	$ %                                                 # Відновити останній призупинений процес на передній план (foreground)


	$ last                                              # Виводть список термінальних сесій


	$ find . -iname qwert.txt                           # ключ і пошук без регістру

	$ wc [що рахуємо] <шлях>                            # Порахувати щось в файлі                    
	$ wc -l file.txt                                    # -l - кількість строк; -w - кількість слів; -c - кількість символів

	$ diff [-q -r] <шлях1> <шлях2>                      # Порівняти файл або папку
	$ diff file1.txt file2.txt | less                   # Виведе всі строки які не співпадають
	$ diff -qr dir1/ dir2/                              # Скаже які файли не є в двох папках

	$ cp /etc/services .
	$ vim services                                      # Видалив 2 строки з 80 портом
	$ diff /etc/services services                       # перше значення (оргінал) 

	57,58d56                                                            57,58 строка були видален, Зміни почались з 56 строки, d - delete
	< http      80/tcp      www     # WorldWideWeb HTTP                 < - означає що в лівому файлі строка є а в правому немає
	< http      80/udp              # HyperText Transfer Protocol





	du [--max-depth <Глибина> -h] <Шлях>                # Покаже скільки місця що займає в хюман одиницях
	du -h ~/                                            # Пройде рекурсивно по всьому дом каталогу.
	du --max-depth 1 -h .                               # Пройде тільки в глибину 1 (найвищий рівень) в поточному каталозі

	head [-n <кількість строк>] <шлях>                  # Покаже першу n-кількість строк файла

	tail [-n <кількість строк>] <шлях>                  # Покаже останню n-кількість строк файла
	tail -n +595 /etc/services                          # Виведе 5 строк починаючи з 595
	tail -n0 -f /var/log/syslog                         # Виводить нові строчки в реальному часі. 

	cat -n /etc/services | tail -n 400 | head -n 3      # Виводить від 200 до 202 строки

	head -15 /etc/passwd | cut -f 1,7 -d :              # Виводить ім'я юзера і дефолтний шел. -f (field), -d (delimiter)

	head -15 /etc/passwd | sort -k7 -t:                 # Сортує файл по алфавіту по 7му полі (по шелі).
	head -15 /etc/passwd | sort -k3 -t: -n              # Сортує файл по номеру по 3му полі (по UID)
	sort -u hosts                                       # Сортує та видаляю доблюючі строки
	sort -R                                             # Рендомно перемішує файл.


	mkdir ./{dir1,dir2,dir3}                            # Cтворить 3 папки в поточній папці з відповідними іменами
	mkdir ./dir{1,2,3} 

	touch ~/{file1,file2}.txt                           # 2 файла в домашньому каталозі з відповіними іменами

	ls --sort=[вид сортировки] -l <Шлях>
	ls --sort=size -l ~/

	cp <path to first file> <path to second file> <destination dir path>  # Копіювання декількох файлів у каталог.

	seq 10                                              # Виводить 10 чисел з 1 до 10 в стовбець
	seq 7 10                                            # Виводить 4 чисел з 7 до 10 в стовбець
	seq 7 2 10                                          # Виводить 2 чисел з 7 до 10 в стовбець з кроком 2 (7,9)




	Екранування \
	touch \*                    Створиться файл з іменем *
	touch program\ філес        Екранує пробіл

	lsblk					# Прінт примонтовані стореджі

	Команда tr

	tr -d \\n < /etc/hosts              # Видалили символ переходу строки \n
	tr -d \\n\  < /etc/hosts            # Видалили символ переходу строки \n, пробіл "\ "
	tr -d \\n\ \\t < /etc/hosts         # Видалили символ переходу строки \n, пробіл "\ ", табуляцію "\\t"

	echo mama | tr adcd ABCD            # Бере перший сивол який подали на stdin звіряє з першим нaбором (abcd), якщо є то перетворює в символ відповідної позиції 2го набору (ABCD)
	mAmA
	head -n15 /etc/passwd | tr a-z A-Z  # Перетворить все в ВЕЛИКІ букви
	head -n15 /etc/passwd | cut -f 1,7 -d: | tr : \\t  # Буде нормально виведене з табуляцією між значеннями

	head -n15 /etc/passwd | tr -s a-z0-9                # Буде видалено всі повторюючі символи
	head -n15 /etc/passwd | tr -d '0-9 /:-'             # Буде видалено всі символи які знаходяться в апострофах
	head -n15 /etc/passwd | tr -d '0-9 /:-' | tr a-z A-Z | tr -s A-Z    # 


	df / | tail -n1 | tr -s ' ' | cut -f 5 -d ' ' | tr -d '%' - # Залишає тільки число процент використаного місця 


	cat -A /etc/hosts                      # Виводить невидимі символи (табуляція та перехід на нову строку)


	ссилки



	Файлові дескриптори - перші 3 значення (0,1,2) оприділені по стандарту ()
	0 - STDIN - при натисненні Ctrl+d ми якраз закриваєм ось цей ФД
	1 - STDOUT - канонічний вигляд по суті (1>)
	2 - STDERR - канонічний вигляд по суті (2>)

	Можна Перенаправити stdout в будь якому місці команди
	> list.txt ls -l /home/user

	< /etc/hosts more - програма more не получає ніяких параметрів томущо шел перед цим перенаправив файл в stdin програми more

	Перенаправлення 2 потоки (stdout, stderr) в один файл &> або &>>
	$ ./program &>> both.txt

	Перенаправлення одного потоку в інший 
	2>&1                stderr в stdout
	1>&2                stdout в stderr

	Перенаправлення в никуда з нівідкуди)
	/dev/null                                       # Чорна дира))
	program 2> /dev/null                            # Перенаправить всі помилкові нотифікації в нул і нічо на екран не виведиться
	cat /dev/null > file.txt                        # Файл буде перезаписаний нічим


	контейнера

	$ du -s /usr/share/man/* | sort -nr | head -n4 | cut -f2   # Виводить перші 4 найоб'ємніші папки.й


	Автентифікація (впізнання) - процес встановлення істинності клієнта
	Авторизація - процес вияснення чи має субєкт права на виконання тої чи іншої операції

	MAGIC NUMBER - Магічні числа (Сигнатури). за допомогою яких Linux розрізняє типи файлів.

	file /bin/bash   - Звертається до MAGIC і визначає тип файлу. 




	inode - індексний вузол. Обєкт файлової системи який містить в собі таку інформацію (META informations) про обєкт (blocks, access right, owner, group, *time, size)
	Жостка ссилка це номер inode

	hot keys

	Ctrl+a - Вказівник на початок строки
	Ctrl+e - Вказівник в кінець строки
	Ctrl+u - Взяти в буфер всю строку з кінця до початку
	Ctrl+k - Взяти в буфер всю строку з початку до кінця
	Ctrl+w - Взяти в буфер одне слово
	Ctrl+b - Перемістити курсор на символ назад (Back)
	Ctrl+f - Перемістити курсор на символ вперед 
	Ctrl+y - Вставити все що є в буфері в поточну позицію курсору
	Ctrl+d = del - Видаляє одну букву справа
	Ctrl+h = backspace - - Видаляє одну букву зліва 
	Ctrl+_ (UNDO) - Відміняє останню дію
	Ctrl+l - Очистити термінал
	Ctrl+Shift+t - Добавити вкладку терміналу 
	Ctrl+t - Поміняти 2 сивола перед курсором
	Ctrl+p - Переміститись по історії назад
	Ctrl+т - Переміститись по історії вперед

	Key META
	M-a == Alt+a === Esc,a
	M-b, M-a - Перемістити курсор на 1 слово назад та вперед
	M-backspace - Видалити слово зліва
	M-d - Видалити слово справа
	M-c (Capitalize) - Перетворює першу букву слоава у велику.
	M-u (UPPER) - Перетворює всі букви у великі
	M-l (lower) - Перетворює всі букви у маленькі


	попробувати розбити файл на частини та потім склеїти
	команди
	split -s 4 /etc/hosts /home/user/split

	cat /home/user/split/* > ./hosts_v1.1               # Працює навіть на картинці. Після склеювання навіть однакомі хеш суми.


	###############################FTP-SERVER################################################

	# Создаем нового пользователя test c паролем test:
	adduser -m test
	passwd test 


	#Для установки ProFTPd и OpenSSL запустите
	apt-get install proftpd openssl

	#Вам будет задан вопрос:
	Запуск proftpd: <­­ Самостоятельно

	#Из соображений безопасности вам необходимо добавить эти строки в /etc/proftpd/proftpd.conf
	$ vim /etc/proftpd/proftpd.conf
	DefaultRoot ~                             # Юзер ftp не вийде вище домашнього каталогу
	IdentLookups off                          # 
	ServerIdent on "FTP Server ready."        # Напис при підключенні слієнта до ftp servera

	#Создаем каталог /etc/proftpd/ssl
	$ mkdir /etc/proftpd/ssl

	# Генерируем і зразу підписуємо SSL сертификат, -nodes значить не шифрувати сертификат. Буде питати різну інфу - Це не важливо.
	openssl req -new -x509 -days 365 -nodes -out
	/etc/proftpd/ssl/proftpd.cert.pem -keyout \
	/etc/proftpd/ssl/proftpd.key.pem

	Для того, чтобы включить TLS для ProFTPd необходимо открыть файл конфигурации
	$ vim /etc/proftpd/proftpd.conf
	Include /etc/proftpd/tls.conf

	Теперь откройте /etc/proftpd/tls.conf
	$ vim /etc/proftpd/tls.conf

	TLSEngine on                                                  # Запускає шифрування
	TLSLog /var/log/proftpd/tls.log                               # Шлях для запису логу
	TLSProtocol SSLv23                                            # Використовує SSL версії 2 та 3
	TLSOptions NoCertRequest AllowClientRenegotiations            # Не питає клієнта сертифікат і ше якасб хуйня
	TLSRSACertificateFile /etc/proftpd/ssl/proftpd.cert.pem       # Шлях для сертифікату
	TLSRSACertificateKeyFile /etc/proftpd/ssl/proftpd.key.pem     # Шлях для ключа
	TLSVerifyClient off                                           # Виключена верифікація клієнта 
	TLSRequired off                                               # Дозволяє конектитись без поставленого ftp-ssl clienta

	#Перезапускаем ваш ProFTPd
	$ /etc/init.d/proftpd restart

	#В силу того, что мы настроили ftp-сервер для работы через ssl, то следует установить ftp-
	#клиент поддерживающий ssl.
	# Це вже на стороні клєнта, 

	$ apt-get install ftp-ssl



	###############################End FTP-SERVER################################################




	###############################DNS-SERVER################################################

	$ cat /etc/hosts                                # Файл з доменними іменами і їх відповідними іп адресами
	127.0.0.1       localhost

	$ cat /etc/resolv.conf                          # Файл з настройками до яких dns serveriv буде звертатись RESOLVER
	nameserver      127.0.1.1
	domain          d0.class.un                     # Суфікс. Підставляється в 

	$ cat /etc/nsswitch.conf                                        # Файл що містить налаштування куди перше звертатись до файлу чи зразу до днс сервера
	hosts:          files mdns4_minimal [NOTFOUND=return] dns       # Тут поміняти місцями files i dns




	###############################___grep___################################################

	grep -l <строка> <файл>     Список файлів з такою строкою
	grep -L <строка> <файл>     Список файлів де такої строки немає

	grep -n <строка> <файл>     Вивести також номер строки де є ця строка
	grep -m <число> <строка> <файл>     Не шукати дальше після заданого числа входжень

	grep -A <число> <строка> <файл>     Виводить число строк після входження
	grep -B <число> <строка> <файл>     Виводить число строк до входження
	grep -C <число> <строка> <файл>     Виводить число строк навколо входження

	grep -E <шаблон> <файл>             Найти вказаний шаблон в файлі
	grep -E <^go> <файл>                Нати строки які починаються на go
	grep -E <go$> <файл>                Нати строки які закінчуються на go


	grep -E "[a-z]+right" <файл>                + значить не менше 1ої (в даному випадку) букви// слова з 5 і більше букв закінчуючих на right
	grep -E "[a-z]?right" <файл>                ? - знаичть або 0 або 1 буква// слова із 4-5 букв, закінчуючих на right
	grep -E "[a-zA-Z]*ight" <файл>              тут використовуємо 2 діапазони + * - значить будь яку кількість букв//слова закінчуючих на ight (включаючи великі букви)

	grep - Ril шаблон										 Шукає в поточній папці рекурсивно файл по шаблоні. 
	
	grep -v '^some text ' file.txt 		# виведе з файлу все крім 								стрічок які починаються на some text. ^ - 								значить з початоку стрічки, це регулярний вираз 

	###############################___end_grep___################################################


	###############################___sed___################################################

	cat <file> | sed 'instruction'  

	sed 'instruction' <file>


	sed -i 'instruction' <file>                     -i перезаписати поточний файл

	sed 's/John/Nick/g' somefile.txt > new.txt      Замінити всі John на Nick (s-substitute, g-global)
	sed -r 's/J[a-z]*n/Nick/g' somefile.txt > new.txt   Замінити всі слова які починаються на J і закінчуючих на n на Nick// -r - регульрні вирази

	sed -n '2,4p' file.txt              виведе всі строки з 2 по 4
	sed '2,4d' file.txt                 виведе всі строки крім 2-4

	sed -n '/[0-9]\{2\}/p' file.txt     виведе строки з двома цифрами підряд
	sed '2,/[Rr]ight/d' file.txt        2 - значить що буде роглядати строки починаючи з 2ої, і до строчки яка містить слово [R]ight. d - значить не виводити їх.




	###############################___end_sed___################################################









	###############################___bash___################################################

	Зарезервоані змінні

	$DIRSTACK - содержимое вершины стека каталогов
	$EDITOR - текстовый редактор по умолчанию
	$EUID - Эффективный UID. Если вы использовали программу su для выполнения команд от другого пользователя, то эта переменная содержит UID этого пользователя, в то время как...
	$UID - ...содержит реальный идентификатор, который устанавливается только при логине.
	$FUNCNAME - имя текущей функции в скрипте.
	$GROUPS - массив групп к которым принадлежит текущий пользователь
	$HOME - домашний каталог пользователя
	$HOSTNAME - ваш hostname
	$HOSTTYPE - архитектура машины.
	$LC_CTYPE - внутренняя переменная, котороя определяет кодировку символов
	$OLDPWD - прежний рабочий каталог
	$OSTYPE - тип ОС
	$PATH - путь поиска программ
	$PPID - идентификатор родительского процесса
	$SECONDS - время работы скрипта(в сек.)
	$# - общее количество параметров переданных скрипту
	$* - все аргументы переданыне скрипту(выводятся в строку)
	$@ - тоже самое, что и предыдущий, но параметры выводятся в столбик
	$! - PID последнего запущенного в фоне процесса
	$$ - PID самого скрипта


	список логических операторв, которые используются для конструкции if-then-else-fi:
	-z # строка пуста
	-n # строка не пуста
	=, (==) # строки равны
	!= # строки неравны
	-eq # равно
	-ne # неравно
	-lt,(< ) # меньше
	-le,(<=) # меньше или равно
	-gt,(>) #больше
	-ge,(>=) #больше или равно
	! #отрицание логического выражения
	-a,(&&) #логическое «И»
	-o,(||) # логическое «ИЛИ»

	Умови(файл)
	-e <шлях> 		# Шлях існує
	-f <шлях> 		# Це файл
	-d <шлях> 		# Це папка
	-s <шлях> 		# Розмір файла = 0
	-x <шлях> 		# Файл Виконавчий
	-N <шлях>       # Был изменен со времени последнего прочтения
	-w <шлях>       # Доступный вам для записи
	-nt <шлях>      # Проверяет, является ли file1 более новым, чем file 2. Для этого и для следующего сравнения используется дата последнего изменения.
	-ot <шлях>      # Проверяет, является ли file1 более старым, чем file 2.




	a = `echo "qwerty"`
	echo $a
	Результат работы: qwerty

	#!/bin/bash

	dir_pass=/home/sviat/
	file_path=${dir_pass}test_file.txt						#підставляє змінну dir_pass

	echo "Creating file $file_path"
	touch $file_path
	echo "Checking content of dir $dir_pass"
	ls -la $dir_pass | grep test




	var1="Hello world!"
	var2="var1 is $var1"

	echo '$var2'			## Різниця між одинарними та двойними кавичками. Одинарні в любому випадку виводять строку не підставляючи змінні.
	echo "$var2"			## Підставляє значення змінної 	

	$var2
	var1 is Hello world!



	$exit 0						# Завершує роботу скріпта з кодом 0 (Удачне завершення) 
	$exit 1						# Завершує роботу скріпта з кодом 1 (завершення скріпта з помилкою)

	# Передача аргументів скрипту прямо в cli.

	./script.sh arg1 arg2 arg3 arg4 
	# Обробка всередині:
	$1 Перший аргумиента = arg1
	$2 Другий аргумиента = arg2
	...

	$0 Імя скріпта = script.sh
	$# Кількість аргументів = 4


	./arguments.sh 1 2												# Якщо передані не всі аргументи то всі відсутні замінються пустою строкою.
	Script is ./argument.sh, arguments are 1 and 2 (total 2)		


	Розгалуження



	if [[Умова]]
	then
		# дія
	fi

	Опциї умови
	-z <строка> # Перевірка чи пуста строка
	-n <строка> # Перевірка чи не пуста строка

	<str1> == <str2> # перевірка на рівність строки
	<str1> != <str2> # перевірка на не рівність строки


	Структуры «И» / «ИЛИ»

	-a логическое И (and)
	-o логическое ИЛИ (or)
	Например



	if [ "$a" = "$b" -a "$c" = "$d" ]; then
	    echo "Оба выражения истинны"
	fi





	set -x                              Виводить відладочну інформацію



	Приклад if-fi

	if [[ -z $1 ]]
	then
		echo "Перший аргумент пустий!"
	fi

	if [[ $var1 == $var2 ]]
	then
		echo "змінні рівні"
	fi

	_______________________________________________________________

	#!/bin/bash

	if [[ -f $1 ]]
	then
	  echo "Removing file"
	  rm $1
	elif [[ -d $1 ]]
	then
	  echo "Removing dir"
	  rm -r $1
	else
	  echo "Can't remove $1"  
	fi

	__________________________________________


	#!/bin/bash

	if [[ $1 -eq 0 ]]; then 
	    echo "No students"

	elif [[ $1 -eq 1 ]]; then 
	    echo "$1 student"

	elif [[ $1 -lt 5 ]]; then 
	    echo "$1 students"

	elif [[ $1 -ge 5 ]]; then 
	    echo "A lot of students"
	fi



	__________________________________________


	Приклад case-esac

	#!/bin/bash
	printf 'Какой Linux дистрибутив Вы знаете? '
	read DISTR

	case $DISTR in
	     ubuntu)
		  echo "Я тоже знаю Ubuntu! Эта система основана на Debian."
		  ;;
	     centos|rhel)
		  echo "Эй! Это мой любимый серверный дистрибутив!"
		  ;;
	     windows)
		  echo "Очень смешно..."
		  ;; 
	     *)
		  echo "Хмм, кажется я никогда не использовал этот дистрибутив."
		  ;;
	esac

	________________________________________________________


	#!/bin/bash

	if [[ $# -ne 2 ]] 
	then
	  echo "You should specify exactly two arguments!"
	else  
	  case $1 in
	    1)
	      echo "Creating file $2"
	      touch $2
	      ;;
	    2)
	      echo "Creating dir $2"
	      mkdir $2
	      ;;
	    *)
	      echo "Wrong value!"
	  esac
	fi

	________________________________________________________________


	Приклад while

	#!/bin/bash


	exst=$?

	while [[ $exst -eq 0 ]]; do

	echo "enter your name:"
	read name
	if [[ -z $name ]]; then
	  echo "bye"
	  exit 0
	fi
	echo "enter your age:"
	read age
	if [[ $age == 0 ]]; then
	  echo "bye"
	  exit 0
	fi

	if [[ $age -le 16 ]]; then
	  echo "$name, your group is child"

	elif [[ $age -le 25 ]]; then
	  echo "$name, your group is youth"

	elif [[ $age -gt 25 ]]; then
	  echo "$name, your group is adult"
	fi

	done


	________________________________________________________________

	Приклад код повернення, status code, exit status, exst

	#!/bin/bash

	# First argument -- dir with files
	# Second argument -- backup dir for these files

	return_code=0
	for file in `ls $1`
	do
	  echo "Found $file"
	  if `rm $2/${file} 2>>$2/err.txt`             # Перенапралення стандартного виводу помилок в файл, буде дописаний файл.
	  then
	    echo "Backup removed!"
	  else
	    echo "Can't remove backup!"
	    return_code=1
	  fi
	done

	exit $return_code


	________________________________________________________________


	Приклад функції (збиває права доступу до папки та видаляє файл)

	#!/bin/bash

	function reset_permission {
		if [[ -f dir/qwe.txt ]]; then
			rm dir/qwe.txt
		fi
		chown root:root dir
		chmod 755 dir
		exit 0
	}

	reset_permission


















	LIFE HACK

	1. Потеря истории команд
	$ vim ~/.bashrc

	shopt -s histappend
	PROMPT_COMMAND='history -a'

	
	
	sudo find /tmp/ -name '*' | xargs chmod 777
	or
	chmod 444 $(sudo find /tmp/ -name '*')
	_______________

	Монутування FS через ssh.
	sudo apt-get install sshfs
	sshfs sviat@xx.xx.xx.xx:/home/user/ /mnt/sshfs_shara/   
	fusermount -u /mnt/sshfs_shara


	locale -a  - всі локалізування прінтить









	file_name.so                  - спільно використовуючі бібліотеки share object
	file_name.a                   - статичні бібліотеки 


	Іерархія файлової системи

	/bin              - Виконувані файли
	/sbim             - Виконувані файли
	/lib              - Системні бібліотеки
	/etc              - Файли конфігурації
	/dev              - Фай 
	/home             - Домашній каталог юзера
	/root             - Домашній каталог рута
	/usr              - каталог для программ які ставить вже сам юзер
	/var              - Данні програм 
	/tmp              - Тимчасові файли
	/proc             - Файловий інтерфейс до параметрів ядра
	/opt              - Аналог "Program Files", Там знаходиться (Teamviewer, google-chrome, vivaldi, viber) (Проги які не входять в дистрибутив)
	/mnt              - Монутування мережевих ФС
	/media            - Монутування зйомних ФС
	/boot             - Загрузчик и ядро системи
	/sys              - 
	/srv              - 


