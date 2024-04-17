import psutil

def get_linux_processes():
    try:
        # Получаем список всех процессов
        all_processes = psutil.process_iter()
        process_list = []
        for process in all_processes:
            try:
                # Получаем информацию о каждом процессе и добавляем в список
                process_info = process.as_dict(attrs=['pid', 'name', 'username', 'cpu_percent', 'memory_percent'])
                process_list.append(process_info)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        return process_list
    except Exception as e:
        print("Ошибка при получении списка процессов:", e)
        return None

# Получаем список процессов
process_list = get_linux_processes()

# Выводим список процессов
if process_list:
    for process in process_list:
        print(process)
else:
    print("Не удалось получить список процессов.")
