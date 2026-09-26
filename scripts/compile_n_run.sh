mkdir -p test_assembly/build/ &&
clang test_assembly/lib/*.s -o test_assembly/build/hello &&
./test_assembly/build/hello
