<h1>Задание</h1> 

Операционные системы и виртуализация (Linux)

<h2>Используя команду cat в терминале операционной системы Linux, создать
два файла Домашние животные (заполнив файл собаками, кошками,
хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и
ослы), а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).</h2>

<h3>Команды:</h3>
<p>cat > 'Домашние животные'</p>
<p>cat > 'Вьючные животные'</p>
<p>cat "Домашние животные" "Вьючные животные" > Animals</p>
<p>cat Animals</p>
<p>mv "Animals" "Друзья человека"</p>
<h2>2. Создать директорию, переместить файл туда.</h2>
Создаем папку и перемещаем файл:
<p>mkdir Attestation</p>
<p>mv 'Друзья человека' Attestation/</p>
<h3>3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.</h3>
MySQL в системе уже установлен.

<h3>4. Установить и удалить deb-пакет с помощью dpkg.</h3>
<p>sudo wget http://archive.ubuntu.com/ubuntu/pool/universe/h/hut/hut_0.3.0-2build1_amd64.deb</p>
<p>sudo dpkg -i hut_0.3.0-2build1_amd64.deb</p>
<p>sudo dpkg -r hut</p>
<h3>5. Выложить историю команд в терминале ubuntu</h3>
<p>history</p>
<h3>6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы).</h3>
![Диаграмма](/images/human_friends.drawio.png)
