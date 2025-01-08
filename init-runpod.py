import runpod

runpod.api_key = '1WD030TPD0WW71AKO7SMAB0Q2WIQSYWWUK9T2JVI'

instances = runpod.get_pods()

running_instances = [instance for instance in instances if instance['name'].startswith('runpod-cuda-12.6')]
print(running_instances)
idx = len(running_instances)

print(runpod.get_gpus())

# Create a new instance
instance = runpod.create_pod(
    name=f'manav-{idx}',
    image_name='runpod-cuda-12.6',
    gpu_type_id='NVIDIA A40',
    # data_center_id='EU-SE-1',
    # template_id='oqfjo3fqxu',
    # network_volume_id='w668p2cosp',
    # min_memory_in_gb=16,
)

# Print the instance details
print(instance)
