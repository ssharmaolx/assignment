##### Assignment 2
#run like ./assignement2.sh wrk-01,wrk-02,wrk-03 
#!/bin/bash
read -p "Enter Your Command: "  CMD
for host in $(echo $1 | sed "s/,/ /g")
do
echo $host ;ssh $host "$CMD"
done
