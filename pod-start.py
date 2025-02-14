import runpod
import re
import os

API_KEY = os.getenv("RUNPOD_API_KEY")
runpod.api_key = API_KEY

# Replace with the actual template ID
TEMPLATE_ID = "oqfjo3fqxu"

# Fetch running instances
running_pods = runpod.get_pods()
manav_nums = []

# Extract existing numbers from instance names
for pod in running_pods:
    match = re.match(r"manav-(\d+)", pod["name"])
    if match:
        manav_nums.append(int(match.group(1)))

# Determine the next available number
num = max(manav_nums) + 1 if manav_nums else 1
print(f"Starting instance with number: {num}")

pod_config = {
    "name": f"manav-{num}",
    "image_name": "manav",
    "template_id": TEMPLATE_ID,
    "gpu_type_id": "NVIDIA A40",
    "cloud_type": "SECURE",
    # "region": "CA-MTL-1",
    "network_volume_id": "fbrfv5xpc9",  # Attach external disk
    "env": {},  # Add any required environment variables here
    "docker_args": "",  # Any specific Docker arguments
}

pod = runpod.create_pod(**pod_config)
print(pod)
