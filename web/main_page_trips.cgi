#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')

print('<html>')
print('<head>')

print('<title>Project</title>')

print('''
<style>
      body {
        background-image: url("https://i.pinimg.com/originals/db/a8/d8/dba8d87bfdc9d8c88669da7f2a066524.gif");
        
        background-size: cover;
        background-repeat: repeat;
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
print('<h2>Trip Main Page</h2>')
print('</header>')
print('</center>')

### Links will lead to the correct page to produce the action

# Lists all sailors
print('<a href="list_trips.cgi"><button>List Trips</button></a><br><br>')

# Creates a specific sailor
print('<a href="create_trip.cgi"><button>Create Trip</button><br><br></a>')

# Deletes a specific sailor
print('<a href="delete_trip.cgi"><button>Delete Trip</button><br><br></a>')

# Link will lead back to main page

print('<a href="main_page_project.cgi"><button> <-Back to Project Main Page</button></a> ')

print('</body>')
print('</html>')