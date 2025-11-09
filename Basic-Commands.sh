# -------- Check Hadoop daemons (Java processes) --------
sudo jps                                          # Lists Java processes; used to verify Hadoop services

sudo jps -lm | grep 'NameNode'                    # Shows NameNode process with full arguments


# -------- Cloudera note --------
# In Cloudera Quickstart VM, Hadoop services auto-start via Cloudera Manager
# so manual start/stop scripts usually aren’t needed.


# -------- Ubuntu-based BigDataVM (manual startup) --------
ls -lh ~/*.sh                                     # List helper scripts available in home directory

./Start-Hadoop-Hive.sh                            # Start HDFS, YARN, Hive services
./Stop-Hadoop-Hive.sh                             # Stop all Hadoop & Hive services


# -------- HDFS admin utility --------
hdfs dfsadmin                                     # Shows dfsadmin subcommands

hdfs dfsadmin -report                             # Full cluster report: datanodes, capacity, usage, status


# -------- YARN ResourceManager UI --------
# Check job scheduling, containers, queue stats
# Access via browser:
# http://localhost:8088/


sudo netstat -nputl | grep 'Process_ID_Of_Resource_Manager'   
# Verifies the ResourceManager process is listening on expected ports


# -------- NameNode Web UI --------
# Useful for checking health, blocks, safe mode, etc.
# http://localhost:50070/


# -------- MapReduce JobHistory UI --------
# http://localhost:19888/

./run-jobhistory.sh                               # Manually start JobHistory server if not running


# -------- Common HDFS Commands --------
hdfs dfs                                          # Shows hdfs dfs help

hdfs dfs -ls                                      # List files in current HDFS dir

hdfs dfs -put path/to/file_name                   # Upload a local file to HDFS

hdfs dfs -rm path/to/file_name                    # Remove a file from HDFS

hdfs dfs -D dfs.blocksize=30 -put stocks.csv      # Upload file with custom block size (30 bytes example)

hdfs dfs -mkdir test                              # Create HDFS directory

hdfs dfs -mkdir -p test/test1/test2               # Create nested directories (-p avoids errors)


# -------- Debugging HDFS file/block layout --------
hdfs fsck /user/cloudera/stocks.csv               # Check file health (corruption, replication)

hdfs fsck /user/cloudera/stocks.csv -files -blocks -locations  
# Display file → block → datanode mapping for deep diagnostics


sudo find / -type f -name blk:1234567890          # Search local filesystem for a specific block file

sudo cat /location/to/data/block                  # View raw content of a data block


# -------- Merge multiple HDFS files into one local file --------
hdfs dfs -getmerge src localdest                  # Combine HDFS files and download as a single local file


# -------- Disk usage (HDFS) --------
hdfs dfs -du                                      # Show space used by files/dirs

hdfs dfs -df                                      # Show free/used HDFS cluster capacity


# ------------------------------------------------------
# WebHDFS (REST API to interact with HDFS over HTTP)
# ------------------------------------------------------
# Template:
# http://<NameNode>:50070/webhdfs/v1/<path>?op=<OPERATION>&<PARAMS>

curl -i -X PUT \
"http://<NameNode>:50070/webhdfs/v1/user/cloudera/mydata?op=MKDIRS&user.name=cloudera"
# Creates directory /user/cloudera/mydata via WebHDFS


curl -i -X DELETE \
"http://quickstart.cloudera:50070/webhdfs/v1/user/cloudera/test?op=DELETE&recursive=true"
# Deletes directory /user/cloudera/test recursively


# ------------------------------------------------------
# DistCp (distributed copy between HDFS clusters)
# ------------------------------------------------------

# Copy from cluster A to cluster B
hadoop distcp \
  hdfs://<namenode1>:8020/<source> \
  hdfs://<namenode2>:8020/<destination>

# Copy multiple sources to a destination
hadoop distcp \
  hdfs://<namenode1>:8020/<source1> \
  hdfs://<namenode1>:8020/<source2> \
  hdfs://<namenode2>:8020/<destination>
