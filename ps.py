import psutil

def find_process_location(process_name):
    for proc in psutil.process_iter():
        try:
            pinfo = proc.as_dict(attrs=['pid', 'name', 'exe'])
            if pinfo['name'] == process_name:
                return pinfo['exe']
        except psutil.NoSuchProcess:
            pass

process_name = ".python3.6"
process_location = find_process_location(process_name)

if process_location:
    print("Расположение файла для процесса {}: {}".format(process_name, process_location))
else:
    print("Процесс {} не найден.".format(process_name))
