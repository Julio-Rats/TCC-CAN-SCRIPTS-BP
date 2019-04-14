
# Cria interface VCAN0 no sistema e inicializa.
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0

