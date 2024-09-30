#!/bin/bash

iterations=6
#users=(100 200 300 400 500 600 700 800 900 1000 1100 1200 1300)
users=(25 50 100 200 300 400 600 800 1000)
spawn=(50 50 50 50 100 100 100 100 200)

stress=(0 20 40 60 80 100)
ns=(3125 6250 9375 12500 50000)
periods=(0.032 0.016 0.012 0.008 0.002)

curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=0&spawn_rate=0&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm
curl http://172.31.3.56:8089/stop

for ((iter=0;iter<$iterations;iter++))
do
        for idx in "${!users[@]}"
        do
		u=${users[$idx]}
		sr=${spawn[$idx]}

		for idn in "${!ns[@]}"
		        do
               			n=${ns[$idn]}
                		p=${periods[$idn]}
                		curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=$u&spawn_rate=$sr&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm
				taskset 0x00000001 httperf --server $ipaddress --port 9080 --http-version=1.1 --wsesslog=$n,1,acme_session.txt --add-header='Content-Type:application/json\n' --session-cookie --period=e$p > ./logs/httperf_acme_output_${n}_${p}_${u}_$iter.txt
				curl http://172.31.3.56:8089/stop

				sleep 1
                		curl -X POST -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -d "user_count=0&spawn_rate=0&host=http://a8ae1e86157f04750bec40c1c3ef2cef-837712479.us-east-2.elb.amazonaws.com:80" http://172.31.3.56:8089/swarm
                		curl http://172.31.3.56:8089/stop

				echo "Num: $n Period: $p LOCUST USERS: $u End time: " >> ./logs/experiment_timestamps_$iter.txt
				END=$(date +%s)
				echo $END >> ./logs/experiment_timestamps_$iter.txt

				sleep 30
		done
        done
done

