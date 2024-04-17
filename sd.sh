import psutil

def get_multi_core_processes():
    multi_core_processes = []
    for proc in psutil.process_iter(['pid', 'name', 'cpu_affinity', 'exe']):
        cpu_affinity = proc.info['cpu_affinity']
        if cpu_affinity and len(cpu_affinity) > 2:
            multi_core_processes.append(proc)
    return multi_core_processes

if __name__ == "__main__":
    multi_core_procs = get_multi_core_processes()
    if multi_core_procs:
        print("Processes using more than 2 cores:")
        for proc in multi_core_procs:
            print(f"PID: {proc.info['pid']}, Name: {proc.info['name']}, CPU Affinity: {proc.info['cpu_affinity']}, Location: {proc.info['exe']}")
    else:
        print("No processes found using more than 2 cores.")
