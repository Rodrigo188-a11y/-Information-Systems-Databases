#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')
print('</head>')

print('<body>')

print('<h3>Create New Reservation</h3>')

#SHOW BOATS AVAILABLES

# The form will send the info needed for the SQL query
print('<form action="update_reservation.cgi" method="post">')
print('<p><input type="hidden" name="method" value="create"/></p>')
print('<p>Start Date: <input type="text" name="start_date" required/></p>')
print('<p>End Date: <input type="text" name="end_date" required/></p>')
print('<p>Country: <input type="text" name="country" required/></p>')
print('<p>CNI Identifier: <input type="text" name="cni" required/></p>')
print('<p>Responsible email: <input type="text" name="responsible" required/></p>')

print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

# Link will lead back to main page
print('<a href="main_page_reservation.cgi"><button>Back to Main Page</button></a> ')

print('</body>')
print('</html>')
