import mysql.connector 

mysql_connection = mysql.connector.connect(user='root', password='root', host='localhost', database='PythonDB')

cursor = mysql_connection.cursor()
cursor.execute('SELECT * FROM Students')
values = cursor.fetchall()
print(values)

mysql_connection.close()