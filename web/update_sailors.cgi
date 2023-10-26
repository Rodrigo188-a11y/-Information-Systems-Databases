#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()
method = form.getvalue('method')

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
    
    #getvalue uses the names from the form in previous page
    email = form.getvalue('email')
    
    # Making query to see if line is added or removed succesfully
    sql ='''
    SELECT * FROM sailor;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
      
    # Making query
      
      
    cursor.execute('START TRANSACTION;')
    cursor.execute('SET CONSTRAINTS ALL DEFERRED;')
    cursor.execute('DELETE FROM authorised where sailor = %(email)s',{'email': email});
    cursor.execute('DELETE FROM trip where skipper = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM reservation where responsible = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM valid_for where sailor = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM sailing_certificate where sailor = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM junior where email = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM senior where email = %(email)s ',{'email': email});
    cursor.execute('DELETE FROM sailor where email = %(email)s ',{'email': email});
    cursor.execute('COMMIT;')
    
    # Commit the update (without this step the database will not change)
    connection.commit()
      
    # Making query
    sql ='''
    SELECT * 
    FROM sailor;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 != num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Successful delete of sailor with email: {}.</p>'.format(email))
    else:
      print('<p>No sailor EXISTS with that email.</p>')
      
      
  elif method == 'create':
  
    #getvalue uses the names from the form in previous page
    email = form.getvalue('email')
    firstname = form.getvalue('firstname')
    surname = form.getvalue('surname')
    specialization = form.getvalue('specialization')
    
    # Making query to see if line is added or removed succesfully
    sql ='''
    SELECT * 
    FROM sailor;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
  
    if specialization == 'junior':
      # Making query
      
      cursor.execute("START TRANSACTION;")
      cursor.execute("SET CONSTRAINTS ALL DEFERRED;")
      cursor.execute("INSERT INTO sailor (firstname, surname, email) VALUES (%(firstname)s,%(surname)s,%(email)s )", {'firstname':	firstname,'surname':	surname,'email':	email});
      cursor.execute("INSERT INTO junior VALUES (%(email)s)",{'email': email});
      cursor.execute("COMMIT;")      
      
      # Commit the update (without this step the database will not change)
      connection.commit()
      
    else:
    
      # Making query
      cursor.execute("START TRANSACTION;")
      cursor.execute("SET CONSTRAINTS ALL DEFERRED;")
      cursor.execute("INSERT INTO sailor(firstname, surname,email) VALUES(%(firstname)s, %(surname)s,%(email)s)",{'firstname': firstname, 'surname': surname, 'email': email});
      cursor.execute("INSERT INTO senior VALUES (%(email)s)",{'email': email});
      cursor.execute("COMMIT;")      

      # Commit the update (without this step the database will not change)
      connection.commit()
          
        
    # Making query
    sql =''' 
    SELECT * FROM sailor;
    '''
    cursor.execute(sql)
    result = cursor.fetchall()
    num1= len(result)
      
    if num1 != num:
      # The string has the {}, the variables inside format() will replace the {}
      print('<p>Successful created of sailor with email: {}.</p>'.format(email))
    else:
      print('<p>No sailor EXISTS with that email.</p>')
  else:
    print('<p>Wrong Method chosen.</p>')
    
  # Link will lead back to main page
  print('<a href="main_page.cgi"><button>Back to Main Page</button></a> ')
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
