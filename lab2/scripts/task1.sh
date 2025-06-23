
#!/bin/bash

read -p "Введите размер доски (например, 8): " size
if ! [[ $size =~ ^[0-9]+$ ]] || [ "$size" -le 0 ]; then
    echo "Ошибка! Введите положительное целое число."
    exit 1
fi

WHITE_BG="\033[47m  \033[0m"
BLACK_BG="\033[40m  \033[0m"

for ((i=0; i < size; i++)); do
    for ((j=0; j < size; j++)); do
        if (( (i + j) % 2 == 0 )); then
            echo -ne "$WHITE_BG"
        else
            echo -ne "$BLACK_BG"
        fi
    done
    echo
done
