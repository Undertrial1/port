import psutil

def kill_processes(process_names):
    try:
        # Получаем список всех процессов
        all_processes = psutil.process_iter()
        for process in all_processes:
            try:
                # Получаем информацию о каждом процессе
                process_info = process.as_dict(attrs=['name', 'pid'])
                if process_info['name'] in process_names:
                    # Убиваем процесс
                    psutil.Process(process_info['pid']).kill()
                    print(f"Процесс {process_info['name']} с PID {process_info['pid']} успешно убит.")
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        print("Все указанные процессы успешно убиты.")
    except Exception as e:
        print("Ошибка при попытке убить процессы:", e)

# Имена процессов, которые нужно убить
process_names = ["xmrig", "miner.sh"]

# Убиваем все указанные процессы
kill_processes(process_names)
