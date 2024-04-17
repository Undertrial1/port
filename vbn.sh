#!/bin/bash

# Получаем количество ядер в системе
core_count=$(grep -c ^processor /proc/cpuinfo)

# Получаем список всех процессов
processes=$(ps -eo pid,comm)

echo "Processes using more than 2 cores:"

# Проходим по каждому процессу
while IFS= read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    cmd=$(echo "$line" | awk '{$1=""; print $0}')

    # Получаем количество ядер, используемых процессом
    cores_used=$(taskset -cp "$pid" | grep -o 'cpuset:[0-9\-]*' | awk -F: '{print NF-1}')

    # Если количество ядер больше двух, выводим информацию о процессе
    if [ "$cores_used" -gt 2 ]; then
        echo "PID: $pid, Command: $cmd"
    fi
done <<< "$processes"
