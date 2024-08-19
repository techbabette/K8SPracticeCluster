#!/bin/bash

numberOfWorkerNodes=$1

if [ $# -eq 0 ]
    then
        echo "Number of worker nodes not specified, assuming one"
        numberOfWorkerNodes=1
fi

joinString=$(vagrant ssh main_node -c "kubeadm token create --print-join-command" | tr -d '\n' | tr -d '\r')
workerCommand="sudo $joinString --cri-socket=unix:///var/run/cri-dockerd.sock"
for worker_id in $(seq 1 $numberOfWorkerNodes);
do
    echo "Joining worker node $worker_id";
    vagrant ssh worker_$worker_id -c "$workerCommand" && echo "Joined worker node $worker_id" || echo "Failed joining worker node $worker_id";
done