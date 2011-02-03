Crayon
======

**VERSION 0.0.1**

Crayon is a small, easy-to-use programming language and environment for creating drawings and animations that run on the Adobe Flash Player. Great for beginners and experts alike, its goal is to make sketching out ideas in Flash easy and fun. How easy? Here's a sample Crayon program that draws a circle:

    draw "circle" with color as "red", radius as 50, center as (100, 100)

The same program can also be written in multiline format:

    draw "circle" with
      color as "red"
      radius as 50
      center as (100, 100)
    end

Drawing 100 randomly placed circles requires only a little more work:

    repeat 100 times
      set x to random with min as 0, max as width of canvas
      set y to random with min as 0, max as height of canvas
      draw "circle" with 
        color as "red"
        radius as 10
        center as (x, y)
      end
    end

Language Features
-----------------

* English-like syntax similar to HyperTalk or AppleScript, but less verbose than its predecessors
* Named function parameters (no need to remember the order of parameters required by functions)
* Dynamic typing
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

How It Works
------------

### The Compiler

The Crayon compiler is actually a source-to-source translator written in the Ruby programming language. Crayon source code is translated into ActionScript 3, which is in turn compiled using traditional ActionScript compilation tools (mxmlc or asc). This means that the focus of Crayon is on language ease and simplicity, not necessarily producing optimized AVM2 bytecode. Nevertheless, the goal of the translator/compiler is to produce as optimal AS3 output as possible given the constraints of the features of the Crayon language - named parameters, dynamic typing, etc.
