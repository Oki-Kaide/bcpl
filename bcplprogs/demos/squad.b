GET "libhdr"

MANIFEST { upb = 1000 }
 
LET start() = VALOF
{ LET v = VEC upb
  AND n = 12
  LET argv = VEC 20

  UNLESS rdargs("N", argv, 20) DO
  { writes("Bad arguments for SQUAD*n")
    RESULTIS 20
  }
  IF argv!0 DO n := str2numb(argv!0)

  UNLESS 2<=n<=upb DO
  { writef("The number of soldiers must be between 2 and %n*n", upb)
    RESULTIS 0
  }

  writef("*nFiring squad solution for %i2 soldiers*n*n", n)
  squad(v, n)
  RESULTIS 0
}
 
AND squad(v, n) BE
{ v!1 := 'S'
  FOR i = 2 TO n-1 DO v!i := '-'
  v!n := '|'
  v!(n+1) := 0
 
  { LET p, a, b, c = 0, 0, 0, v!1
    FOR i = 1 TO n DO writef(" %c", v!i)
    newline()
    IF c='F' BREAK
    UNTIL p=n DO
    { p := p+1
      a := b
      b := c
      c := v!(p+1)
      v!p := func(a, b, c)
    }
  } REPEAT
 
  newline()
}
 
AND func(a, b, c) = VALOF SWITCHON b INTO
{ DEFAULT:  RESULTIS 'F'
 
  CASE 'S': RESULTIS a='|' -> 'F',
                     c='|' -> 'F',
                     '.'
 
  CASE '.': RESULTIS '+'
 
  CASE '+': RESULTIS '|'
 
  CASE '(': RESULTIS a='>' -> 'S',
                     '['
 
  CASE '[': RESULTIS a='>' -> 'S',
                     '/'
 
  CASE '/': RESULTIS '-'
 
  CASE ')': RESULTIS c='<' -> 'S',
                     ']'
 
  CASE ']': RESULTIS c='<' -> 'S',
                     '\'
 
  CASE '\': RESULTIS '-'
 
  CASE '-': RESULTIS a='S' -> '>',
                     a='>' -> '>',
                     a='\' -> ')',
                     a='+' -> ')',
                     c='S' -> '<',
                     c='<' -> '<',
                     c='/' -> '(',
                     c='+' -> '(',
                     '-'
 
  CASE '<': RESULTIS a='|' -> '>',
                     a='+' -> 'S',
                     a=')' -> 'S',
                     a='\' -> 'S',
                     '-'
 
  CASE '>': RESULTIS c='|' -> '<',
                     c='+' -> 'S',
                     c='(' -> 'S',
                     c='/' -> 'S',
                     '-'
 
  CASE '|': RESULTIS a='S' -> 'F',
                     c='S' -> 'F',
                     '|'
}

/*
0> squad 31

Firing squad solution for 31 soldiers

 S - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
 . > - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
 + - > - - - - - - - - - - - - - - - - - - - - - - - - - - - |
 | ) - > - - - - - - - - - - - - - - - - - - - - - - - - - - |
 | ] - - > - - - - - - - - - - - - - - - - - - - - - - - - - |
 | \ - - - > - - - - - - - - - - - - - - - - - - - - - - - - |
 | - ) - - - > - - - - - - - - - - - - - - - - - - - - - - - |
 | - ] - - - - > - - - - - - - - - - - - - - - - - - - - - - |
 | - \ - - - - - > - - - - - - - - - - - - - - - - - - - - - |
 | - - ) - - - - - > - - - - - - - - - - - - - - - - - - - - |
 | - - ] - - - - - - > - - - - - - - - - - - - - - - - - - - |
 | - - \ - - - - - - - > - - - - - - - - - - - - - - - - - - |
 | - - - ) - - - - - - - > - - - - - - - - - - - - - - - - - |
 | - - - ] - - - - - - - - > - - - - - - - - - - - - - - - - |
 | - - - \ - - - - - - - - - > - - - - - - - - - - - - - - - |
 | - - - - ) - - - - - - - - - > - - - - - - - - - - - - - - |
 | - - - - ] - - - - - - - - - - > - - - - - - - - - - - - - |
 | - - - - \ - - - - - - - - - - - > - - - - - - - - - - - - |
 | - - - - - ) - - - - - - - - - - - > - - - - - - - - - - - |
 | - - - - - ] - - - - - - - - - - - - > - - - - - - - - - - |
 | - - - - - \ - - - - - - - - - - - - - > - - - - - - - - - |
 | - - - - - - ) - - - - - - - - - - - - - > - - - - - - - - |
 | - - - - - - ] - - - - - - - - - - - - - - > - - - - - - - |
 | - - - - - - \ - - - - - - - - - - - - - - - > - - - - - - |
 | - - - - - - - ) - - - - - - - - - - - - - - - > - - - - - |
 | - - - - - - - ] - - - - - - - - - - - - - - - - > - - - - |
 | - - - - - - - \ - - - - - - - - - - - - - - - - - > - - - |
 | - - - - - - - - ) - - - - - - - - - - - - - - - - - > - - |
 | - - - - - - - - ] - - - - - - - - - - - - - - - - - - > - |
 | - - - - - - - - \ - - - - - - - - - - - - - - - - - - - > |
 | - - - - - - - - - ) - - - - - - - - - - - - - - - - - - < |
 | - - - - - - - - - ] - - - - - - - - - - - - - - - - - < - |
 | - - - - - - - - - \ - - - - - - - - - - - - - - - - < - - |
 | - - - - - - - - - - ) - - - - - - - - - - - - - - < - - - |
 | - - - - - - - - - - ] - - - - - - - - - - - - - < - - - - |
 | - - - - - - - - - - \ - - - - - - - - - - - - < - - - - - |
 | - - - - - - - - - - - ) - - - - - - - - - - < - - - - - - |
 | - - - - - - - - - - - ] - - - - - - - - - < - - - - - - - |
 | - - - - - - - - - - - \ - - - - - - - - < - - - - - - - - |
 | - - - - - - - - - - - - ) - - - - - - < - - - - - - - - - |
 | - - - - - - - - - - - - ] - - - - - < - - - - - - - - - - |
 | - - - - - - - - - - - - \ - - - - < - - - - - - - - - - - |
 | - - - - - - - - - - - - - ) - - < - - - - - - - - - - - - |
 | - - - - - - - - - - - - - ] - < - - - - - - - - - - - - - |
 | - - - - - - - - - - - - - \ < - - - - - - - - - - - - - - |
 | - - - - - - - - - - - - - - S - - - - - - - - - - - - - - |
 | - - - - - - - - - - - - - < . > - - - - - - - - - - - - - |
 | - - - - - - - - - - - - < - + - > - - - - - - - - - - - - |
 | - - - - - - - - - - - < - ( | ) - > - - - - - - - - - - - |
 | - - - - - - - - - - < - - [ | ] - - > - - - - - - - - - - |
 | - - - - - - - - - < - - - / | \ - - - > - - - - - - - - - |
 | - - - - - - - - < - - - ( - | - ) - - - > - - - - - - - - |
 | - - - - - - - < - - - - [ - | - ] - - - - > - - - - - - - |
 | - - - - - - < - - - - - / - | - \ - - - - - > - - - - - - |
 | - - - - - < - - - - - ( - - | - - ) - - - - - > - - - - - |
 | - - - - < - - - - - - [ - - | - - ] - - - - - - > - - - - |
 | - - - < - - - - - - - / - - | - - \ - - - - - - - > - - - |
 | - - < - - - - - - - ( - - - | - - - ) - - - - - - - > - - |
 | - < - - - - - - - - [ - - - | - - - ] - - - - - - - - > - |
 | < - - - - - - - - - / - - - | - - - \ - - - - - - - - - > |
 | > - - - - - - - - ( - - - - | - - - - ) - - - - - - - - < |
 | - > - - - - - - - [ - - - - | - - - - ] - - - - - - - < - |
 | - - > - - - - - - / - - - - | - - - - \ - - - - - - < - - |
 | - - - > - - - - ( - - - - - | - - - - - ) - - - - < - - - |
 | - - - - > - - - [ - - - - - | - - - - - ] - - - < - - - - |
 | - - - - - > - - / - - - - - | - - - - - \ - - < - - - - - |
 | - - - - - - > ( - - - - - - | - - - - - - ) < - - - - - - |
 | - - - - - - S S - - - - - - | - - - - - - S S - - - - - - |
 | - - - - - < . . > - - - - - | - - - - - < . . > - - - - - |
 | - - - - < - + + - > - - - - | - - - - < - + + - > - - - - |
 | - - - < - ( | | ) - > - - - | - - - < - ( | | ) - > - - - |
 | - - < - - [ | | ] - - > - - | - - < - - [ | | ] - - > - - |
 | - < - - - / | | \ - - - > - | - < - - - / | | \ - - - > - |
 | < - - - ( - | | - ) - - - > | < - - - ( - | | - ) - - - > |
 | > - - - [ - | | - ] - - - < | > - - - [ - | | - ] - - - < |
 | - > - - / - | | - \ - - < - | - > - - / - | | - \ - - < - |
 | - - > ( - - | | - - ) < - - | - - > ( - - | | - - ) < - - |
 | - - S S - - | | - - S S - - | - - S S - - | | - - S S - - |
 | - < . . > - | | - < . . > - | - < . . > - | | - < . . > - |
 | < - + + - > | | < - + + - > | < - + + - > | | < - + + - > |
 | > ( | | ) < | | > ( | | ) < | > ( | | ) < | | > ( | | ) < |
 | S S | | S S | | S S | | S S | S S | | S S | | S S | | S S |
 F F F F F F F F F F F F F F F F F F F F F F F F F F F F F F F

30> 
*/
 
