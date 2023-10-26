#!/usr/bin/python3
import cgi
form = cgi.FieldStorage()

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')
print('</head>')
print('<body>')
# The string has the {}, the variables inside format() will replace the {}
print('<h3>Add Responsible for Reservation </h3>')
# The form will send the info needed for the SQL query
print('<form action="update_actions.cgi" method="post">')
print('<p><input type="hidden" name="method" value="authorise"/></p>')
print('<p>Start Date: <input type="text" name="start_date"/></p>')
print('<p>End Date: <input type="text" name="end_date"/></p>')
print('<p>Country: <input type="text" name="country"/></p>')
print('<p>CNI: <input type="text" name="cni"/></p>')
print('<p>Add Responsible: <input type="text" name="responsible"/></p>')
print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

# Link will lead back to main page
print('<a href="actions.cgi"><button>Back to Authorise/De-authorise Main Page</button></a> ')

print('</body>')
print('</html>')
