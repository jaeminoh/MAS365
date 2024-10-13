# Homework 2

## Chapter 2 Problem 8
When the base of a scaling factor is two, scaling is merely an operation on the exponent. However, if the base differs, scaling involves modifications to the mantissa, which can introduce rounding errors.

I generated a random matrix $A \in \mathbb{R}^{100 \times 100}$ and set the exact solution to be a vector of ones, resulting in $b = A \cdot x$. To increase the condition number, I defined the diagonal scaling matrix as $\mathrm{diag}(10^{-50}, 10^{-49}, \ldots, 10^{49})$, leading to a condition number of $3 \times 10^{50}$. Despite this, the solution to the scaled linear system retains a high degree of accuracy, with only one to two digits of loss. The relative $L^2$ error is approximately $10^{-13}$, and the relative residual is around $10^{-16}$.

## Chapter 2 Problem 11

Refer to `2_11.jl`.

## Chapter 2 Problem 17

### a
The more structure we exploit, the faster the computation becomes. All results are consistent with one another.

### b
Direct computation confirms that $A = RR^T$. For $n = 1000$, the solutions do not align. To assess accuracy, we can evaluate the bound:

$$
\frac{\| \hat{x} \|}{\| x \|} \le \mathrm{cond}(A) \frac{\| r \|}{\| A \| \cdot \| \hat{x} \|}.
$$

It appears that the UL factorization yields a smaller bound, suggesting it is more accurate. In fact, applying two-step iterative refinement on $A$ and $b$ results in a slightly reduced relative error.

## Chapter 2 Example 3.13
As $n$ increases, the relative error grows rapidly (due to ill-conditioning), leading to inaccurate solutions. Please see "2_3_13.pdf".