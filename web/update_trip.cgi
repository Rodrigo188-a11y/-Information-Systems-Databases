#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

#getvalue uses the names from the form in previous page
method = form.getvalue('method')
takeoff = form.getvalue('takeoff')
arrival = form.getvalue('arrival')
insurance = form.getvalue('insurance')
from_latitude = form.getvalue('from_latitude')
from_longitude = form.getvalue('from_longitude')
to_latitude = form.getvalue('to_latitude')
to_longitude = form.getvalue('to_longitude')
skipper = form.getvalue('skipper')
reservation_start_date = form.getvalue('reservation_start_date')
reservation_end_date = form.getvalue('reservation_end_date')
boat_country = form.getvalue('boat_country')
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
  if method == 'delete':  
    
    # Making query to see if line is added or removed succesfully
    sql ='SELECT * FROM trip;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
      
    # Making query
   
    cursor.execute("DELETE FROM trip WHERE takeoff = %(takeoff)s AND reservation_start_date = %(reservation_start_date)s AND reservation_end_date = %(reservation_end_date)s AND boat_country=%(boat_country)s AND cni=%(cni)s",{'takeoff':takeoff,'reservation_start_date':reservation_start_date,'reservation_end_date':reservation_end_date, 'boat_country':boat_country,'cni':cni})   
   
    # Commit the update (without this step the database will not change)
    connection.commit()
      
    # Making query
    sql = 'SELECT * FROM trip;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 !=  num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Successful delete of trip</p>')
    else:
      print('<p>That trip doesnt EXISTS .</p>')
      
 
      
  elif method == 'create':
      
    # Making query to see if line is added or removed succesfully
    sql ='SELECT * FROM trip;'
    
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
  
    
    # Making query
     
    #cursor.execute("START TRANSACTION;")
    #cursor.execute("SET CONSTRAINTS ALL DEFERRED;")
    
    cursor.execute("INSERT INTO date_interval (start_date, end_date) VALUES (%(start_date)s,%(end_date)s)", {'start_date':reservation_start_date, 'end_date':reservation_end_date})
    
    cursor.execute("INSERT INTO reservation (start_date, end_date, country, cni, responsible) VALUES (%(start_date)s,%(end_date)s,%(country)s,%(cni)s, %(responsible)s)", {'start_date': reservation_start_date, 'end_date':reservation_end_date, 'country': boat_country,'cni':cni, 'responsible':skipper})  
    
    cursor.execute("INSERT INTO trip (takeoff, arrival, insurance, from_latitude, from_longitude, to_latitude, to_longitude, skipper, reservation_start_date, reservation_end_date, boat_country, cni) VALUES (%(takeoff)s, %(arrival)s,%(insurance)s,%(from_latitude)s,%(from_longitude)s,%(to_latitude)s,%(to_longitude)s,%(skipper)s,%(reservation_start_date)s,%(reservation_end_date)s,%(boat_country)s,%(cni)s)", {'takeoff':takeoff, 'arrival':arrival,'insurance':insurance,'from_latitude':from_latitude,'from_longitude':from_longitude,'to_latitude':to_latitude,'to_longitude':to_longitude,'skipper':skipper,'reservation_start_date':reservation_start_date,'reservation_end_date':reservation_end_date,'boat_country':boat_country,'cni':cni}) 
    
    
#    cursor.execute("INSERT INTO reservation (start_date, end_date, country, cni, responsible) VALUES (%(start_date)s,%(end_date)s,%(country)s,%(cni)s,%(responsible)s)", {'start_date':	start_date,'end_date':	end_date,'country':	country,'cni':	cni,'responsible':	responsible});
    
    #cursor.execute("COMMIT;")      
    # Commit the update (without this step the database will not change)
    connection.commit()
                
        
    # Making query
    sql = 'SELECT * FROM trip;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 != num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Trip successfully created</p>')
    else:
      print('<p>Something went wrong</p>')
  else:
    print('<p>Wrong Method chosen.</p>')
    
  # Link will lead back to main page
  print('<a href="main_page_trips.cgi"><button>Back to Main Page</button></a> ')
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

