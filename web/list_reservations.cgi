#!/usr/bin/python3
import psycopg2

import login

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')
print('</head>')
print('<body>')

connection = None
try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    connection.autocommit	=	'false'
    cursor = connection.cursor()
    
    print('<h3>Reservations</h3>')
    
    # Making query
    sql = 'SELECT * FROM reservation;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    
    # Displaying results
    print('<p>{} records retrieved:</p>'.format(num))
    print('<table border="1" cellspacing="1">')
    print('<tr><td><b>Start Date</b></td><td><b>End Date</b></td><td><b>Country</b></td><td><b>CNI</b></td><td><b>Responsible email</b></td></tr>')
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td>{}</td>'.format(value))
        print('</tr>')
    print('</table>')
    
    # Link will lead back to main page
    print('<a href="main_page_reservation.cgi"><button>Back to Main Page</button></a> ')

    # Closing connection
    cursor.close()
except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
finally:
    if connection is not None:
        connection.close()
print('</body>')
print('</html>')
