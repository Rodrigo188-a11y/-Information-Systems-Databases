#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')

print('<html>')
print('<head>')

print('<title>Project</title>')

print('''
<style>
      body {
        background-image: url("https://i.pinimg.com/originals/35/e4/a9/35e4a9c87386a6622fcf84c616757068.gif");
        background-size: cover;
        background-repeat: repeat;
        }
      button {
        display: block;
        margin: 0 auto;
        transition: all 0.5s;
        
        
        }
      button:hover {
        transform: scale(1.2);
        }
      
</style>''')


print('</head>')

print('<body>')

# Main Page of the project where user chooses what to do

print('<center>')
print('<header style="background-color: navy; color: white; margin-bottom: 150px;">')
print('<h2>Project Main Page</h2>')
print('</header>')
print('</center>')
### Links will lead to the correct page to produce the action

# List, create and remove sailors
print('<a href="main_page.cgi"><button style="background-color: white; color: black; width: 275px; height: 50px; font-size: 16px; border-radius: 5px;">List, Create and Remove Sailors</button></a><br><br>')

# List, create and remove reservations
print('<a href="main_page_reservation.cgi"><button style="background-color: white; color: black; width: 275px; height: 50px; font-size: 16px; border-radius: 5px;">List, create and remove reservations</button><br><br></a>')

# Authorise/De-authorise sailors for reservations
print('<a href="actions.cgi"><button style="background-color: white; color: black; width: 275px; height: 50px; font-size: 16px; border-radius: 5px;">Authorise/De-authorise sailors for reservations</button><br><br></a>')

# List, register, and remove trips
print('<a href="main_page_trips.cgi"><button style="background-color: white; color: black; width: 275px; height: 50px; font-size: 16px; border-radius: 5px;">List, register, and remove trips</button></a>')


print('</body>')
print('</html>')
