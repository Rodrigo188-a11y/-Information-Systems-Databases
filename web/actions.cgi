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
  
  # Making query
  sql = 'SELECT * FROM authorised Order by sailor;'
  cursor.execute(sql)
  result = cursor.fetchall()
  num = len(result)
 
# Displaying results
  print('<p>{} records retrieved:</p>'.format(num))
  print('<table border="5">')
  print('<tr><td>Start Date</td><td>End Date</td><td>Country</td><td>CNI</td><td>Responsible</td></tr>')
  for row in result:
    print('<tr>')
    for value in row:
		# The string has the {}, the variables inside format() will replace the {}
      print('<td>{}</td>'.format(value))
    print('</tr>')
  print('</table>')
  
  print('<p><a href="authorise.cgi"><button>Authorise New Sailor</button></a></td></p>'.format(row[0]))
  print('<p><a href="deauthorise.cgi"><button>De-authorise New Sailor</button></a></td></p></p>'.format(row[0]))
  
  # Link will lead back to main page
  print('<a href="main_page_project.cgi"><button>Back to Main Page</button></a> ')
#Closing connection
  cursor.close()
except Exception as e:
  print('<h1>An error occurred.</h1>')
  print('<p>{}</p>'.format(e))
finally:
  if connection is not None:
    connection.close()
print('</body>')
print('</html>')

