#!/bin/bash

print_separator() {
	echo "========================================"
}

print_all_info() {
	local output_file="$1"
	if [ -n "$output_file" ]; then
		exec > "$output_file"
	fi

	print_separator
	echo "Текущий рабочий каталог:"
	pwd
	print_separator

	echo "Текущий запущенный каталог:"
	ps -p $$ -o pid,comm
	print_separator

	echo "Домашний каталог:"
	echo "$HOME"
	print_separator

	echo "Название и версия операционной системы:"
	uname -a
	print_separator

	echo "Все доступные оболочки в системе:"
	cat /etc/shells
	print_separator

	echo "Текущие пользователи, вошедшие в систему:"
	who
	print_separator

	echo "Количество пользователей, вошедших в систему:"
	who | wc -l
	print_separator

	echo "Информация о жестких дисках:"
	df -h
	print_separator

	echo "Информация о процессоре:"
	cat /proc/cpuinfo | grep "model name" | uniq
	print_separator

	echo "Информация о памяти:"
	free -h
	print_separator

	echo "Информация о файловой системе:"
	df -hT
	print_separator

	echo "Информация об установленных пакетах ПО:"
	dpkg -l | tail -n +6 | wc -l
	print_separator

	if [ -n "$output_file" ]; then
		exec > /dev/tty
		echo "Информация записана в файл: $output_file"
	fi
}

if [ "$1" == "--tofile" ]; then
	if [ -z "$2" ]; then
		echo "Ошибка: укажите имя файла после --tofile"
		exit 1
	fi
	print_all_info "$2"
	exit 0
fi

while true; do
	clear
	echo "Меню информации о системе:"
	echo "1. Текущий рабочий каталог"
	echo "2. Текущий запущенный процесс"
	echo "3. Домашний каталог"
	echo "4. Название и версия операционной системы"
	echo "5. Показать все доступные оболочки"
	echo "6. Текущие пользователи, вошедшие в систему"
	echo "7. Количество пользоваателей, вошедших в систему"
	echo "8. Информация о жестком диске"
	echo "9. Информация о процессоре"
	echo "10. Информация о памяти"
	echo "11. Информация о файловов системе"
	echo "12. Информация об установленных пакетах ПО"
	echo "13. Вывести всю информацию"
	echo "14. Выход"
	echo -n "Выберите пункт меню:"
	read choice

	case $choice in
		1)
			echo "Текущий рабочий каталог:"
			pwd
			;;
		2)
			echo "Текущий запущенный процесс:"
			ps -p $$ -o pid,comm
			;;
		3)
			echo "Домашний каталог:"
			echo "$HOME"
			;;
		4)
			echo "Название и версия операционной системы:"
			uname -a
			;;
		5)
			echo "Все доступные оболочки в системе:"
			cat /etc/shells
			;;
		6)
			echo "Текущие пользователи, вошедшие в систему:"
			who
			;;
		7)
			echo "Количество пользователей, вошедших в систему:"
			who | wc -l
			;;
		8)
			echo "Информация о жестких дисках:"
			df -h
			;;
		9)
			echo "Информация о процессоре:"
			cat /proc/cpuinfo | grep "model name" | uniq
			;;
		10)
			echo "Информация о памяти:"
			free -h
			;;
		11)
			echo "Информация о файловой системе:"
			df -hT
			;;
		12)
			echo "Информация об установленных пакетах ПО:"
			dpkg -l | tail -n +6 | wc -l
			;;
		13)
			print_all_info
			;;
		14)
			echo "Выход из программы"
			exit 0
			;;
		*)
			echo "Неверный выбор, попробуйте снова"
	esac

	echo -n "Для продолжения нажмите Enter:"
	read -r
done
