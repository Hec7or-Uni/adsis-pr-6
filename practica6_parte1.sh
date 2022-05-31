#!/bin/bash
echo "#PROCESOS: $(ps -e | wc -l)" | logger -p local0.info
echo "#PUERTOS_ABIERTOS: $(($(netstat -l | wc -l) - 4))" | logger -p local0.info
echo "#CONEXIONES: $(($(netstat -a | wc -l) - 4))" | logger -p local0.info
echo "#USUARIOS_CONECTADOS: $(uptime | cut -d',' -f2)" | logger -p local0.info
echo "#CARGA_MEDIA: $(uptime | cut -d',' -f3)" | logger -p local0.info

info="$(df -h --output='source','used','avail' | grep -Ev '(tmpfs|udev)'| sed 's/$/;/g;1d')"
IFS=';\n'
for l in $info
do
ll=$(echo $l | sed -r 's/[ \t]+/_/g')
dis=$(echo $ll | cut -d'_' -f 1 | tr -d [\\n])
O=$(echo $ll | cut -d'_' -f 2 | tr -d [\\n])
T=$(echo $ll | cut -d'_' -f 3 | tr -d [\\n])
echo "#DISCO: ${dis}, ESPACIO_USADO/ESPACIO_DISPONIBLE: ${O}/${T}" | logger -p local0.info
done




#######
## REVISAR LA SALIDA