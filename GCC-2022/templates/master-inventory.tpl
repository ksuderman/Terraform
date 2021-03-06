# The file is automatically generated by Ansible by running the
# cluster.yml playbook.
[localhost]
127.0.0.1 ansible_connection=local ansible_python_interpreter="/usr/bin/python3"

[nodes]
%{ for i in range(length(ips)) ~}
${basename}-${i + 1}    ansible_ssh_host=${ips[i].address}
%{ endfor ~}

[all:vars]
ansible_ssh_port=22
ansible_user='ubuntu'
ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
ansible_ssh_private_key_file=${key}
ansible_python_interpreter="/usr/bin/python3"

