# -------- Sqoop import from MySQL to HDFS (text files) --------
sqoop import \
  --connect jdbc:mysql://host/nyse \        # JDBC URL: host (or host:port)/database
  --table StockPrices \                      # Source table to import
  --target-dir /hdfs/output/path \           # HDFS output directory (created if missing)
  --as-textfile                              # Store as plain text (delimited). This is Sqoop’s default.

# Optional/commonly used flags (uncomment and fill as needed):
# --username <db_user>                       # DB username (prefer --password-file over --password)
# --password <db_pass>                       # DB password (avoid in scripts; consider --P or --password-file)
# --password-file hdfs:///path/to/.pwd       # Safer: HDFS file with the password (600 perms)
# --num-mappers 2                            # Parallelism. Increase for faster imports (watch DB load)
# --split-by id                              # Column used to split work across mappers; must be indexed, non-null, well-distributed
# --fields-terminated-by ','                 # Custom field delimiter (default: tab)
# --lines-terminated-by '\n'                 # Custom line delimiter
# --driver com.mysql.jdbc.Driver             # MySQL 5.x driver; for newer use com.mysql.cj.jdbc.Driver

# -------- Example 1: Basic table import (fixed line breaks) --------
sqoop import \
  --connect jdbc:mysql://quickstart.cloudera:3306/test \   # DB: test
  --driver com.mysql.jdbc.Driver \                          # MySQL legacy driver
  --username root \                                         # Credentials (use safer alternatives in prod)
  --password password \                                     # (consider --P or --password-file)
  --table test                                              # Import full 'test' table


# -------- Example 2: Import using a query with filter + parallelism --------
# NOTE: When using --query, you MUST include the token $CONDITIONS in the WHERE clause.
# In bash, escape the $ so the shell doesn’t expand it (i.e., use \$CONDITIONS).
# Also, --split-by is mandatory with --query (unless you set --num-mappers 1).

sqoop import \
  --connect jdbc:mysql://quickstart.cloudera:3306/test \    # DB connection
  --driver com.mysql.jdbc.Driver \                           # JDBC driver
  --username root \                                          # DB user
  --password password \                                      # DB password
  --query "SELECT * FROM test s WHERE s.salary > 90000 AND \$CONDITIONS" \  # Filtered query + required token
  --split-by gender \                                        # Split column for parallel mappers (ensure decent cardinality & distribution)
  -m 2 \                                                     # Same as --num-mappers 2 (parallel import)
  --target-dir salaries3                                     # HDFS output directory

# -------- MySQL: load data from a local file into a table --------
# Requires client/server to allow LOCAL INFILE (e.g., --local-infile=1 on client;
# and 'local_infile=1' in server config if disabled). Ensure the table schema matches file columns.

mysql -u root -p                                            # Enter password interactively for safety
# Inside the mysql shell, run:
# LOAD DATA LOCAL INFILE '/tmp/data.txt'
# INTO TABLE data
# FIELDS TERMINATED BY ','                                  # Correct clause spelling and quotes
# LINES TERMINATED BY '\n'                                  # Optional: set if lines end with newline
# IGNORE 1 LINES;                                           # Optional: skip header row
