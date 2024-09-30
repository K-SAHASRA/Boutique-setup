#!/bin/bash
#http://a5edf86f050274f469dda23c4b0640b7-532705407.us-east-1.elb.amazonaws.com:8089/

#!/bin/bash
#http://a5edf86f050274f469dda23c4b0640b7-532705407.us-east-1.elb.amazonaws.com:8089/


iterations=6
#users=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300)
#use frontend-external loadbalancer ingress
users=(25 50 100 200 300 400 600 800 1000)
for ((iter=0;iter<$iterations;iter++))
do
        for idx in "${!users[@]}"
        do
                u=${users[$idx]}
                curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=$u&spawn_rate=50&host=https://acad01e3cd6e14ea6bea968763d0e203-1125906535.us-east-2.elb.amazonaws.com " http://172.31.23.251:8089/swarm
                sleep 100
                curl http://172.31.23.251:8089/stop
                sleep 1 
                curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=1&spawn_rate=1&host=https://acad01e3cd6e14ea6bea968763d0e203-1125906535.us-east-2.elb.amazonaws.com .us-east-2.elb.amazonaws.com:80" http://172.31.23.251:8089/swarm
                curl http://172.31.23.251:8089/stop
                sleep 30
        done
done
