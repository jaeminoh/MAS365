# First Homework

Each problem is worth 10 points.

## 1.1

Refer to "1_1.pdf." The absolute error is increasing rapidly, while the relative error is decreasing.

## 1.2

See `1_3_3.jl`. If you used functions that directly return information about floating-point numbers, you will receive only partial credit.

Note: Many scientific computing languages default to Float64 format. However, some machine learning libraries use different default formats: Torch uses Float32, while JAX uses TFloat16 for matrix multiplication.

## 1.14

Refer to "1_14.pdf." The discrepancies may arise from round-off errors due to varying scales (e.g., 1 and $x^6$).

## 1.3.3

The purpose of this example is to demonstrate the effect of cancellation error. We will compare the formulas $\sin(x) - x$ and the truncated Taylor series. The **true value** should provide a more accurate reference. To achieve this, compute $\sin(x) - x$ using double precision and then evaluate both formulas using single precision for comparison. The results show that the truncated Taylor series performs better. 