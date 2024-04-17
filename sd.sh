import psutil

def find_process_location(process_name, username):
    try:
        # Получаем список всех процессов
        all_processes = psutil.process_iter()
        for process in all_processes:
            try:
                # Получаем информацию о каждом процессе
                process_info = process.as_dict(attrs=['name', 'pid', 'username', 'memory_percent'])
                if process_info['name'] == process_name and process_info['username'] == username:
                    # Получаем информацию о пути к исполняемому файлу процесса
                    process_exe = psutil.Process(process_info['pid']).exe()
                    return process_exe
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        return None
    except Exception as e:
        print("Ошибка при поиске процесса:", e)
        return None

# Имя процесса и имя пользователя
process_name = ".python3.6"
username = "odoo"

# Поиск расположения файла процесса
process_location = find_process_location(process_name, username)

# Вывод расположения файла процесса
if process_location:
    print("Расположение файла для процесса {} пользователя {}: {}".format(process_name, username, process_location))
else:
    print("Процесс {} пользователя {} не найден или нет прав доступа к информации о нем.".format(process_name, username))
