dart compiler/main.dart test_compile/main.dupa test_compile/build/
cp -r compiler/assembly/. test_compile/build/
clang test_compile/build/*.s -o test_compile/build/main

echo "\n\nExecute:"
./test_compile/build/main
