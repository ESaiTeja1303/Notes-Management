#pip install mysql-connector-python


import mysql.connector

try:
    db = mysql.connector.connect(
        host='caboose.proxy.rlwy.net',
        user='root',
        password='tVbIlktMYggpKzqpSgvoUSXsFAQhkvoJ',
        database='railway',
        port=57996
    )
    print("✅ Connection successful")
    cursor = db.cursor()

except mysql.connector.Error as err:
    print("❌ Connection failed:", err)
