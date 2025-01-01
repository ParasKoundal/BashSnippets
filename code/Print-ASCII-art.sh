# Define ASCII art
function print_ascii_art {
  cat << "EOF"
===================================================
           _____
       ___/_____\\___
      |( |  O O  | )|
      |__|___-___|__|
     /    \\___//    \
    / /|  |  ❤️  |  |\ \
   / / |__|______|__| \ \
  / /    | |  | |      \ \
 uuU     | |  | |       Uuu
  Welcome to the machine!
===================================================
EOF
}
# Print ASCII art on terminal startup
print_ascii_art