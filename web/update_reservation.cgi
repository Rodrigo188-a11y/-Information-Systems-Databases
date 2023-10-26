#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

#getvalue uses the names from the form in previous page
method = form.getvalue('method')
start_date = form.getvalue('start_date')
end_date = form.getvalue('end_date')
country = form.getvalue('country')
cni = form.getvalue('cni')
responsible = form.getvalue('responsible')


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
  if method == 'delete':  
    
    # Making query to see if line is added or removed succesfully
    sql ='''
    SELECT * 
    FROM reservation;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
      
    # Making query
   
    cursor.execute("DELETE FROM trip WHERE reservation_start_date = %(start_date)s AND reservation_end_date = %(end_date)s AND boat_country=%(country)s AND cni=%(cni)s",{'start_date':start_date,'end_date':end_date,'country':country, 'cni':cni})
    
    cursor.execute("DELETE FROM authorised WHERE start_date = %(start_date)s AND end_date=%(end_date)s AND boat_country=%(country)s AND cni=%(cni)s AND sailor = %(responsible)s",{'start_date':start_date,'end_date': end_date,'country':country,'cni':cni, 'responsible':responsible}) 
        
    cursor.execute("DELETE FROM reservation WHERE start_date = %(start_date)s AND end_date=%(end_date)s AND country=%(country)s AND cni=%(cni)s", {'start_date':start_date,'end_date':end_date, 'country':country,'cni':cni})
    
    # Commit the update (without this step the database will not change)
    connection.commit()
      
    # Making query
    sql = '''
    SELECT * 
    FROM reservation;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 !=  num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Successful delete of reservation</p>')
    else:
      print('<p>That reservation doesnt EXISTS .</p>')
      
      
  elif method == 'create':
      
    # Making query to see if line is added or removed succesfully
    sql ='''
    SELECT * FROM reservation;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
  
    #APRESENTAR BARCOS DISPONIVEIS PARA RESERVA
    # Making query
     
    cursor.execute("START TRANSACTION;")
    cursor.execute("SET CONSTRAINTS ALL DEFERRED;")
    cursor.execute("INSERT INTO date_interval (start_date, end_date) VALUES (%(start_date)s, %(end_date)s)",{'start_date':start_date, 'end_date':end_date}); 
    cursor.execute("INSERT INTO reservation (start_date, end_date, country, cni, responsible) VALUES (%(start_date)s,%(end_date)s,%(country)s,%(cni)s,%(responsible)s)", {'start_date':	start_date,'end_date':	end_date,'country':	country,'cni':	cni,'responsible':	responsible});
    cursor.execute("COMMIT;")      
    # Commit the update (without this step the database will not change)
    connection.commit()
                
        
    # Making query
    sql = ''' 
    SELECT * FROM reservation;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 != num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Reservation successfully created</p>')
    else:
      print('<p>Somethong went wrong</p>')
  else:
    print('<p>Wrong Method chosen.</p>')
    
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
