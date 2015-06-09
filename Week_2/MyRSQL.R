
## EXAMPLE: ACCESSING AND READING A REMOTE DATABASE

######## 1

# Open connection to the server and define handler ucscDb
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")

# Obtain a data.frame with the name of all the data bases on the remote server ~202 DBs present
result <- dbGetQuery(ucscDb, "show databases;")

# Close connection
dbDisconnect(ucscDb)


######## 2

# Open connection and access only the DB called "hg19"
my_hg19 <- dbConnect(MySQL(), user="genome", db="hg19" , host="genome-mysql.cse.ucsc.edu")

# Read all tables present in the DB hg19
allTables <- dbListTables(my_hg19)

# Get the names of the fields (=columns) of a specific table
my_Fields <- dbListFields(my_hg19, "affyU133Plus2")

# count the entries (number of rows) in table "affyU133Plus2" of "hg19"
# How to send a generic MYSQL query
NumEntries <- dbGetQuery(my_hg19, "select count(*) from affyU133Plus2")

# Read entire table "affyU133Plus2" of "hg19"
my.data <- dbReadTable(my_hg19, "affyU133Plus2")
head(my.data)

## Read a sub-set of table "affyU133Plus2" of "hg19" where variable "misMatches" is between 1 and 3

# Send a query (whose values stay on the server for now)
my.query <- dbSendQuery(my_hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
# get the data that are chosen by the query
my.subdata <- fetch(my.query)
head(my.subdata)

dbDisconnect(my_hg19)

