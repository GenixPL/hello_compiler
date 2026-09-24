# rm so that we know when compilation fails
rehash &&
mkdir -p build/ &&
clang lib/hello.s -o build/hello &&
./build/hello

# TODO
# fix the script, it runs the previous executable
