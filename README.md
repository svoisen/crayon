Crayon
======

Crayon is a small, easy-to-use programming language and environment for creating drawings and animations that run on the Adobe Flash Player. Great for beginners and experts alike, its goal is to make sketching out ideas in Flash easy and fun. How easy? Here's a sample Crayon program that draws a circle:

    draw "circle" with color as "red", radius as 50, center as (100, 100)

The same program can also be written in multiline format:

    draw "circle" with
      color as "red"
      radius as 50
      center as (100, 100)
    end

Language Features
-----------------

* English-like syntax similar to HyperTalk or AppleScript, but less verbose than its predecessors
* Named function parameters (no need to remember the order of parameters required by functions)
* UTF-8 support, including the use of ≤ and ≥ as comparison operators
* Ruby-like blocks; no C-style braces
* Callback event style; no AS3 "addEventListener"
* AS3 intermediate language: All Crayon code is translated to ActionScript 3, then compiled using traditional ActionScript compilation tools

Usage
-----

### Using the Command Line Compiler (crayonc)

Crayon includes a traditional command line compiler for those who wish to forgo using the IDE. Using the compiler is fairly straightforward:

    crayonc my_sketch.crayon

The compiler supports a limited set of advanced options. To get a complete list of the compiler options, use the built-in help:

    crayonc -h
