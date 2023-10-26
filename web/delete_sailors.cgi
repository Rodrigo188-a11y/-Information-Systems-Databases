#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')
print('</head>')

print('<body>')


print('<h3>Delete Sailor Account</h3>')

# The form will send the info needed for the SQL query
print('<form action="update_sailors.cgi" method="post">')
print('<p><input type="hidden" name="method" value="delete"/></p>')
print('<p>Sailor email: <input type="text" name="email" required/></p>')

#print('<p><label for="specialization">Choose a specialization:</label>')
#print('<select name="specialization" id="specialization"></p>')
#print('<p><option value="junior">Junior</option></p>')
#print('<p><option value="senior">Senior</option></p>')
#print('<p></select></p>')

print('<p><input type="submit" value="Submit"/></p>')
print('</form>')

# Link will lead back to main page
print('<a href="main_page.cgi"><button>Back to Main Page</button></a> ')

print('</body>')
print('</html>')
