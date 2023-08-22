## Задание 1  
В программе, создать функцию для уничтожение файла путем перезаписи всех
его байт элементами псевдослучайной байтовой последовательности, полученной по формуле  

	`x_(i+1) = (7 ∗ x_(i )+ 17) mod 256`  

Пусть первый элемент последовательности x_0 = 195.  

## Задание 2  
В программе, создать функцию для сложения двух упакованных BCD-чисел с
использованием команды DAA. Программа должна корректно вычислять как
сумму двузначных чисел, так и сумму со слагаемыми из одной цифры.
Например, пользователь вводит 98 8. Результат работы программы: Sum = 106  

## Задание 3  
Написать программу, выводящую на экран размер файла, имя которого передается как параметр при запуске.

## Задание 4  
В программе считать из терминала строку (от 20 до 100 символов) и вывести
на экран, наложив на нее 4-байтную гамму. Гамма должна представлять собой
случайные 4 байта, которые могут быть заданы как константные значения.
Наложение байтов гаммы на байты строки происходит с помощью операции
исключающего или (XOR).

## Задание 5
Написать программу, выводящую на экран вторую строку текстового файла,
название которого передается как параметр при запуске.