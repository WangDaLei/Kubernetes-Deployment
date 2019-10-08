FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN adduser elk

RUN cd ~ && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.3.2-linux-x86_64.tar.gz && tar xvf elasticsearch-7.3.2-linux-x86_64.tar.gz && rm elasticsearch-7.3.2-linux-x86_64.tar.gz && mv elasticsearch-7.3.2 elasticsearch
RUN cd ~ && cd elasticsearch && mkdir data && echo "cluster.name: elk-test\nnode.name: node-1\ncluster.initial_master_nodes: ["node-1"]\npath.data: ./data\npath.logs: ./logs\nnetwork.host: 0.0.0.0\nhttp.port: 9200" >> ./config/elasticsearch.yml
RUN cd ~ && mv elasticsearch /home/elk/ && chown -R elk:elk /home/elk/elasticsearch

RUN cd ~ && wget https://artifacts.elastic.co/downloads/kibana/kibana-7.3.2-linux-x86_64.tar.gz && tar xvf kibana-7.3.2-linux-x86_64.tar.gz && mv kibana-7.3.2-linux-x86_64 kibana && rm kibana-7.3.2-linux-x86_64.tar.gz

RUN cd ~ && wget https://artifacts.elastic.co/downloads/logstash/logstash-7.3.2.tar.gz && tar xvf logstash-7.3.2.tar.gz && mv logstash-7.3.2 logstash && rm logstash-7.3.2.tar.gz && export JAVA_HOME=/home/elk/elasticsearch/jdk && /root/logstash/bin/logstash-plugin install logstash-input-beats

ADD entrypoint.sh /
ADD logstash.conf /root/logstash/config/
ADD kibana.yml /root/kibana/config/
EXPOSE 5601
EXPOSE 5044

CMD []
ENTRYPOINT ["/entrypoint.sh"]
