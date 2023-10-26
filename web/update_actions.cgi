#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

#getvalue uses the names from the form in previous page
method = form.getvalue('method')
responsible = form.getvalue('responsible')
start_date = form.getvalue('start_date')
end_date = form.getvalue('end_date')
boat_country = form.getvalue('country')
cni = form.getvalue('cni')


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
  
  # Checks if it's a delete or insertion
  if method == 'deauthorise':  
    
    # Making query to see if line is added or removed succesfully
    sql ='SELECT * FROM authorised;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
      
    # Making query
   
    cursor.execute("DELETE FROM authorised WHERE start_date = %(start_date)s AND end_date = %(end_date)s AND boat_country=%(country)s AND cni=%(cni)s AND sailor=%(sailor)s",{'start_date':start_date,'end_date':end_date,'country':boat_country, 'cni':cni, 'sailor' : responsible})

    
    # Commit the update (without this step the database will not change)
    connection.commit()
      
    # Making query
    sql ='SELECT * FROM authorised;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 !=  num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Removed Successfully authorised sailor</p>')
    else:
      print('<p>Something went wrong</p>')
      
      
  elif method == 'authorise':
      
    # Making query to see if line is added or removed succesfully
    sql ='SELECT * FROM authorised;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
  
    #APRESENTAR BARCOS DISPONIVEIS PARA RESERVA
    # Making query
     

    cursor.execute("INSERT INTO authorised (start_date, end_date, boat_country, cni, sailor) VALUES (%(start_date)s, %(end_date)s, %(country)s,%(cni)s,%(sailor)s)",{'start_date':start_date,'end_date':end_date,'country':boat_country, 'cni':cni, 'sailor' : responsible}); 
     
    # Commit the update (without this step the database will not change)
    connection.commit()
                
        
    # Making query
    sql ='SELECT * FROM authorised;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 != num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>New authorised sailor successfully added</p>')
    else:
      print('<p>Somethong went wrong</p>')
  else:
    print('<p>Wrong Method chosen.</p>')
    
  # Link will lead back to main page
  print('<a href="actions.cgi"><button>Back to Main Page</button></a> ')
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

