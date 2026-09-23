# rm so that we know when compilation fails
rehash &&
clang -o hello hello.s &&
./hello

# TODO
# fix the script, it runs the previous executable
# terminate previous
# close previous terminal
