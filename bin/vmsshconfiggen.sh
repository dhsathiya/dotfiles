vms="$(ssh li5 'cd ~/vmac; for vmac in $(ls); do echo -en $vmac; grep -I --color "private_network" ./$vmac/Vagrantfile; done' | awk '{print $1 "," $5}')"
echo "" > /home/devarshi/.ssh/vm.config

for vm in $(echo "$vms"); do
	vm=$(echo $vm | sed "s/\"//g" | column -t -s,)
echo """
Host $(echo $vm | awk '{print $1}')
	HostName $(echo $vm | awk '{print $2}')
	User root
	ProxyJump li5""" >> /home/devarshi/.ssh/vm.config
done
