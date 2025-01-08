import time
import requests
import json
import os

# Set your API key and Pod ID
API_KEY = "1WD030TPD0WW71AKO7SMAB0Q2WIQSYWWUK9T2JVI"
POD_ID = "bs8jyvfzklc0tk"

URL = f"https://api.runpod.io/graphql?api_key={API_KEY}"
print(URL)
HEADERS = {
    'Content-Type': 'application/json',
}

# GraphQL query to get all running pods with their IP address and port
def get_all_running_pods():
    query = '''
    query Pods { myself { pods { id name runtime { uptimeInSeconds ports { ip isIpPublic privatePort publicPort type } gpus { id gpuUtilPercent memoryUtilPercent } container { cpuPercent memoryPercent } } } } }
    '''

    response = requests.post(
        URL,
        json={'query': query},
        headers=HEADERS
    )
    print(response.json())
    if response.status_code == 200:
        pods = response.json()['data']['myself']['pods']
        for pod in pods:
            if 'manav' not in pod['name']:
                continue
            ip = None
            port = None
            try:
                ports = pod['runtime']['ports']
                for p in ports:
                    if p['isIpPublic']:
                        ip = p['ip']
                        port = p['publicPort']
                        break
                yield (pod['id'], (ip, port))
            except TypeError:
                pass
    else:
        print(f"Failed to get running pods: {response.status_code}")
    

# Fetch and print all running pods with their IP address and port
pods = dict(get_all_running_pods())

config = """Host %s
  HostName %s
  Port %s
  User root
  IdentitiesOnly yes
  IdentityFile /Users/manav/.ssh/run_pod
  ForwardX11 yes
"""

configs = []
i = 1
for pod, (ip, port) in pods.items():
    if ip is not None:
        print(f"{pod} - pod{i} - {ip}:{port}")
        configs.append(config % (f"pod{i}", ip, port))
        i += 1

with open('/Users/manav/.ssh/config', 'w') as f:
    f.write('\n'.join(configs))
    