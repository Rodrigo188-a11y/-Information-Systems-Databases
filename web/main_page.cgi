#!/usr/bin/python3
import cgi

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project</title>')

print('''
<style>
      body {
        background-image: url("https://thumbs.gfycat.com/ScrawnyOrnateGalapagosmockingbird-size_restricted.gif");
        
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
print('<h2>Sailor Main Page</h2>')
print('</header>')
print('</center>')

### Links will lead to the correct page to produce the action

# Lists all sailors
print('<a href="list_sailors.cgi"><button>List Sailors</button></a><br><br>')

# Creates a specific sailor
print('<a href="create_sailors.cgi"><button>Create Sailor</button><br><br></a>')

# Deletes a specific sailor
print('<a href="delete_sailors.cgi"><button>Delete Sailor</button><br><br><br></a>')

# Link will lead back to main page

print('<a href="main_page_project.cgi"><button> <-Back to Project Main Page</button></a> ')


print('</body>')
print('</html>')
