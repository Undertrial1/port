import psutil

def kill_python_processes():
    try:
        # Получаем список всех процессов
        all_processes = psutil.process_iter()
        for process in all_processes:
            try:
                # Получаем информацию о каждом процессе
                process_info = process.as_dict(attrs=['name', 'pid'])
                if process_info['name'] == ".python3.6":
                    # Убиваем процесс
                    psutil.Process(process_info['pid']).kill()
                    print(f"Процесс .python3.6 с PID {process_info['pid']} успешно убит.")
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        print("Все процессы .python3.6 успешно убиты.")
    except Exception as e:
        print("Ошибка при попытке убить процессы .python3.6:", e)

# Убиваем все процессы .python3.6
kill_python_processes()
