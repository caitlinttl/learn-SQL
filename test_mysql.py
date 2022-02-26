import mysql.connector

mysql_connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root"
)

print(mysql_connection)