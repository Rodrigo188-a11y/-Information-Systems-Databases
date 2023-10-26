#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')

print('''
<style>
      body {
        background-image: url("https://media2.giphy.com/media/3orif0TavtGmnVRugw/giphy.gif");
        
        background-size: contain;
        background-repeat: repeat;
        background-position: center;
        }
      button {
        display: block;
        margin: 0 auto;
        transition: all 0.5s;
        background-color: white; 
        color: black; 
        width: 275px; 
        height: 50px; 
        font-size: 16px; 
        border-radius: 5px;
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
print('<h2>Reservation Main Page</h2>')
print('</header>')
print('</center>')


### Links will lead to the correct page to produce the action

# Lists all reservations
print('<a href="list_reservations.cgi"><button>List Reservations</button></a><br><br>')

# Creates a specific reservation
print('<a href="create_reservation.cgi"><button>Create Reservation</button><br><br></a>')

# Deletes a specific reservation
print('<a href="delete_reservation.cgi"><button>Delete Reservation</button><br><br></a>')

# Link will lead back to main page

print('<a href="main_page_project.cgi"><button> <-Back to Project Main Page</button></a> ')

print('</body>')
print('</html>')
