#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')
print('</head>')

print('<body>')


print('<h3>Delete Trip</h3>')

# The form will send the info needed for the SQL query
print('<form action="update_trip.cgi" method="post">')
print('<p><input type="hidden" name="method" value="delete"/></p>')
print('<p>Take Off Date: <input type="text" name="takeoff" required/></p>')
print('<p>Reservation Start Date: <input type="text" name="reservation_start_date" required/></p>')
print('<p>Reservation End Date: <input type="text" name="reservation_end_date" required/></p>')
print('<p>Boat Country: <input type="text" name="boat_country" required/></p>')
print('<p>CNI Identifier: <input type="text" name="cni" required/></p>')


print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

# Link will lead back to main page
print('<a href="main_page_trips.cgi"><button>Back to Main Page</button></a> ')

print('</body>')
print('</html>')

