# Lazarus_QuickLectureTest
Тестирование студентов на лекции (сделано на Free Pascal в Lazarus IDE)
Testing students at lectures (made with Free Pascal in Lazarus IDE) 

Проект QuickLectureTest.lpi компилируется в Lazarus IDE 2.0.6.

1) Перед началом работы программы подключают компьютер к проектору
2) Включают режим отображения на двух мониторах (второй монитор - проектор)
3) Запускают программу QuickLectureTest.exe 

<p align="left">
  <img src="https://user-images.githubusercontent.com/20105840/129618718-92a24a5b-0292-4e06-8e1e-4db11997fff1.png" width="680">
</p>

4) После запуска программы необходимо ввести список студентов, а потом список вопросов. Оба файла должны иметь расширение txt.
Без ввода указанных файлов программа не будет работать дальше.
Пример списка студентов в файле "Студенты ТГР-2013 СП.txt"
Пример списка вопросов в файле "МагниторазведкаВопросы1.txt"

Замечания:

-a) В конце обоих файлов не должно быть пустых строк (в программе нет проверки на пустые строки)
 
-b) Программа использует кодировку UTF-8 (для файлов с кириллическими шрифтами необходимо проверить правильность отображения фамилий и вопросов)
 
5) Потом выполняют пункт меню "Опрос" или нажимают кнопку с зеленым треугольником
6) На экране высвечиваются имя студента и вопрос. Фамилии студентов и вопросы выбираются в случайном порядке из соответсвующих файлов.
Необходимо, чтобы число вопросов было больше или равно числу студентов.
<p align="left">
  <img src="https://user-images.githubusercontent.com/20105840/129618721-2c6fab99-f7e7-4f18-817a-871045bd84ea.png" width="680">
</p>

7) За ответ студент получает оценку по пятибалльной системе путем нажатия соответствующих кнопок на панели задач:

0 - нет ответа или полностью неправильный ответ

1 - ответ на 1/4 правильный

2 - ответ на 2/4 правильный

3 - ответ на 3/4 правильный

4 - ответ на 4/4 (полностью) правильный

8) После нажатия кнопки с числом (отметка в баллах) необходимо нажимать кнопку с зеленым треугольником для перехода к следующей фамилии студента и следующему вопросу

9) В конце тестирования отображаются 
 -a) первое информационное окно с надписью "Тестирование окончено"
<p align="left">
  <img src="https://user-images.githubusercontent.com/20105840/129618725-847f118e-987c-48db-af1f-bbc894571e71.png" width="362">
</p>
 -b) второе информационное окно со списком всех студентов и их баллов 
<p align="left">
  <img src="https://user-images.githubusercontent.com/20105840/129618719-ea12c688-5d57-4e55-9f0f-97e07620a4fd.png" width="435">
</p>
 
10) Результаты сохраняются в файл с именем, которое состоит из имени файла вопросов, имени файла со списком студентов, постфикса res и расширения "dat".
В случае использования примерных списков, указанных выше, имя файла будет "МагниторазведкаВопросы1-Студенты ТГР-2013 СП_res.dat"
