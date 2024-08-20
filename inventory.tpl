${vm1_name} ansible_host=${vm1_ip} ansible_user=${vm1_user} ansible_port=22
${vm2_name} ansible_host=${vm2_ip} ansible_user=${vm2_user} ansible_port=22
${vm3_name} ansible_host=${vm3_ip} ansible_user=${vm3_user} ansible_port=22

[kube_master]
${vm1_name}

[kube_node]
${vm2_name}
${vm3_name}

[kube:children]
kube_master
kube_node
