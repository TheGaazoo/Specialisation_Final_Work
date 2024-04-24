<h1>Задание</h1> 

Операционные системы и виртуализация (Linux)

<h2>1. Используя команду cat в терминале операционной системы Linux, создать
два файла Домашние животные (заполнив файл собаками, кошками,
хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и
ослы, а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).</h2>
<image src="Linux_task.png" alt="Task 1">
<h3>Команды:</h3>
<p>cat > 'Домашние животные'</p>
<p>cat > 'Вьючные животные'</p>
<p>cat "Домашние животные" "Вьючные животные" > Animals</p>
<p>cat Animals</p>
<p>mv "Animals" "Друзья человека"</p>
<h2>2. Создать директорию, переместить файл туда.</h2>
<image src="mkdir and mv.png" alt="Task 2">
Создаем папку и перемещаем файл:
<p>mkdir Attestation</p>
<p>mv 'Друзья человека' Attestation/</p>
<h3>3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.</h3>
<image src="mysql_installed.png" alt="Task 3">
MySQL в системе уже установлен.

<h3>4. Установить и удалить deb-пакет с помощью dpkg.</h3>
<image src="wget file dpkg -i dpkg -r.png" alt="Task 4">
<p>sudo wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hut/hut_0.3.0-2build1_amd64.deb</p>
<p>sudo dpkg -i hut_0.3.0-2build1_amd64.deb</p>
<p>sudo dpkg -r hut</p>
<h3>5. Выложить историю команд в терминале ubuntu</h3>
<image src="History.png" alt="Task 5">
<p>history</p>
<h3>6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы.</h3>
<image src="human_friends.drawio.png" alt="Task 6">
<h3>7. В подключенном MySQL репозитории создать базу данных “Друзья
человека”</h3>
<image src="create_database.png" alt="Task 7">
<h3>Решение заданий с 8 по 12 находятся в прикрепленном файле SQL.sql</h3>
<p>Убрали верблюдов и объединили лошадей и ослов</p>
<image src="Remove camels unions horses and donkeys.png" alt="Task 10">
<p>Выбрали молодых животных (от 1 года до 3 лет)</p>
<image src="young_animals.png" alt="Task 11">
<p>Объединили все таблицы</p>
<image src="Union all tables.png" alt="Task 12">