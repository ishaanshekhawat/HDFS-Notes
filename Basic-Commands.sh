sudo jps

sudo jps -lm | grep 'NameNode'

# In cloudera, Hadoop processes are bootstrapped

# For Ubuntu (BigDataVM) - 

ls -lh ~/*.sh

./Start-Hadoop-Hive.sh

./Stop-Hadoop-Hive.sh

hdfs dfsadmin

hdfs dfsadmin -report

# Check Resource Manager UI - http://localhost:8088/

sudo netstat -nputl | grep 'Process_ID_Of_Resource_Manager'

# Check NameNode Status - http://localhost:50070/

# Check JobHistory UI - http://localhost:19888/

./run-jobhistory.sh

hdfs dfs

hdfs dfs -ls

hdfs dfs -put path/to/file_name

hdfs dfs -rm path/to/file_name

hdfs dfs -D dfs.blocksize=30 -put stocks.csv

hdfs dfs -mkdir test

hdfs dfs -mkdir -p test/test1/test2

hdfs fsck /user/cloudera/stocks.csv

hdfs fsck /user/cloudera/stocks.csv -files -blocks -locations

sudo find / -type f -name blk:1234567890

sudo cat /location/to/data/block

hdfs dfs -getmerge src localdest

hdfs dfs -du

hdfs dfs -df

# Web HDFS  - 

# http://<NameNode>:50070/webhdfs/v1/<path>?op=<operation_and_arguments>

curl -i -x PUT "http://<NameNode>:50070/webhdfs/v1/user/cloudera/mydata?op=MKDIRS&user.name=cloudera"

curl -i -x DELETE "http://quickstart.cloudera:50070/webhdfs/v1/user/cloudera/test?op=DELETE&recursive=true"

# DistCP

hadoop distcp hdfs://<namenode1>:8020/<source> hdfs://<namenode2>:8020/<destination>

hadoop distcp hdfs://<namenode1>:8020/<source1> hdfs://<namenode1>:8020/<source2> hdfs://<namenode2>:8020/<destination>

