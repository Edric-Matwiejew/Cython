#!/bin/bash

mkdir -p compiled_modules
mkdir -p reports
mkdir -p c_code

for cython_file in grep *.pyx;
do
	cythonize -i -a $cython_file
done

mv *.so compiled_modules
mv *.html reports
mv *.c c_code


