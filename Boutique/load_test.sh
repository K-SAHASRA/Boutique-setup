#!/bin/bash
#http://a5edf86f050274f469dda23c4b0640b7-532705407.us-east-1.elb.amazonaws.com:8089/


iterations=3
#users=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300)
#use frontend-external loadbalancer ingress
users=(150 450 800 1100 1500)
for ((iter=0;iter<$iterations;iter++))
do
        for idx in "${!users[@]}"
        do
		u=${users[$idx]}
		curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=$u&spawn_rate=50&host=http://a4777f99c172b42f4a545f6aa7d29aed-1157778257.us-east-2.elb.amazonaws.com:80" http://172.31.12.143:8089/swarm
		sleep 400
		curl http://172.31.12.143:8089/stop
		sleep 1 
		curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=1&spawn_rate=1&host=http://a4777f99c172b42f4a545f6aa7d29aed-1157778257.us-east-2.elb.amazonaws.com:80" http://172.31.12.143:8089/swarm
		curl http://172.31.12.143:8089/stop
		sleep 200
	done
done

