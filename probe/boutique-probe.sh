#!/bin/bash

ipaddress="172.31.36.217"
iterations=6
#users=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300)
users=(25 50 100 200 300 400 600 800 1000)
spawn=(50 50 50 50 100 100 100 100 200)

stress=(0 20 40 60 80 100)
ns=(3125 6250 9375 12500 50000)
periods=(0.032 0.016 0.012 0.008 0.002)

cpu1=(20 30 40 50 60)
cpu2=(10 20 30 40 50)

curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=0&spawn_rate=0&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm
curl http://172.31.3.56:8089/stop

for ((iter=0;iter<$iterations;iter++))
do
        for idx in "${!users[@]}"
        do
                u=${users[$idx]}
                sr=${spawn[$idx]}

                for idc in "${!cpu1[@]}"
                        do
                                c=${cpu1[$idc]}
                        	c2=${cpu2[$idc]}
                                curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=$u&spawn_rate=$sr&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm

				curl --header "Content-Type: application/json" --request POST --data "{\"cpu\": \"${c}\", \"memory\": \"4096B\", \"time\": \"100\"}"  http://172.31.43.164:3000/resource/cpu
                       		curl --header "Content-Type: application/json" --request POST --data "{\"cpu\": \"${c2}\", \"memory\": \"4096B\", \"time\": \"100\"}"  http://172.31.25.29:3000/resource/cpu

                                sleep 100
				curl http://172.31.3.56:8089/stop

                                sleep 1
                                curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=0&spawn_rate=0&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm
                                curl http://172.31.3.56:8089/stop

                                sleep 30
                done
        done
done

