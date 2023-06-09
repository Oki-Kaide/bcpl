GET "libhdr"

LET start() = VALOF
{ LET a, b = 0, 1 // a and b will hold two consecutive Fibonacci numbers

  FOR i = 0 TO 50 DO
  { LET c = a+b   // c holds the Fibonacci number after b, namely a+b
    writef("Position %2i  Value %12u  %32b*n", i, a, a)
    a := b
    b := c
  }

  RESULTIS 0
}
