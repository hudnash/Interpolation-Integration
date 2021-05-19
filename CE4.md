# Interpolation-Integration
CE4 ChE-348 Prof Lynd Sp21

### 1.
```
trapezoidal
N          trap(sin(x),0,pi,N)
10.000000    1.979651

40.000000    1.998918

80.000000    1.999736

160.000000    1.999935

320.000000    1.999984

1200.000000    1.999999
```
### 2. Simpson's method converges faster to the answer:
```
simpsons
N          simpson(sin(x),0,pi,N)
10.000000    2.000110

40.000000    2.000000

80.000000    2.000000

160.000000    2.000000

320.000000    2.000000

1200.000000    2.000000
```
### 3. Table of results: (130 = sum([10 40 80]), 280 = sum([40 80 60]))
```
romberg versus simpsons versus trap
N             romberg       simpson       trap       integral
130.000000    1.999871    2.000000    1.999901      2.000000

280.000000    1.999993    2.000000    1.999979      2.000000
```
