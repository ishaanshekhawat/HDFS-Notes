# --------------------------------------------------------
# Inspecting JAR files
# --------------------------------------------------------
jar -tf file.jar
# Lists contents of a JAR file (packages, classes, resources)
# Useful to verify the compiled driver class path before running on YARN.


# --------------------------------------------------------
# Running MapReduce jobs on YARN using a JAR
# --------------------------------------------------------
yarn jar file.jar package.class
# Runs the specified driver class from file.jar
# package.class must contain the 'public static void main' method.


yarn jar my-jar.jar mypkg.myDriverClass input-file output-file -D mapreduce.job.reduces=10
# Full example:
# - mypkg.myDriverClass: fully qualified driver class
# - input-file / output-file: HDFS paths
# - -D mapreduce.job.reduces=10: sets number of reducers at runtime


# --------------------------------------------------------
# Fetching logs for a YARN application
# --------------------------------------------------------
yarn logs -applicationId application_123_12
# Retrieve stdout, stderr, syslogs for all containers of a specific application
# Great for debugging mapper/reducer issues.


# --------------------------------------------------------
# Running a standalone Java program with Hadoop + MySQL dependencies
# --------------------------------------------------------
java -cp "../build/project1.jar:/usr/lib/hadoop/client/*:../mysql-connector-java-5.1.48.jar" hdfs-DataLoad
# Classpath includes:
#   - your compiled project JAR
#   - Hadoop client libraries
#   - MySQL JDBC driver
# hdfs-DataLoad is the main class to execute (no .class extension)


# --------------------------------------------------------
# Compiling Java source files for Hadoop
# --------------------------------------------------------
javac -cp "/usr/lib/hadoop/client/*" -d . /src/hdfs/*.java
# -cp adds Hadoop libraries required for compilation (Mapper, Reducer classes, etc.)
# -d . writes the compiled classes into the current directory while preserving package structure


# --------------------------------------------------------
# Building a JAR from compiled classes
# --------------------------------------------------------
jar -cvf /build/project2.jar /hdfs
# Packages all compiled classes under /hdfs into project2.jar
# -c create new jar
# -v verbose output
# -f output file name
