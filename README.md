# Solving the Weighted Nonnegative Elastic Net by two different methods 

## Problems: 

```
X = \arg\min_X 0.5 ||Y - WX||_F^2 + ||Gamma*X||_1 + 0.5*lambda ||X||_2^2
```

Solvers: 
1. ADMM 

2. FISTA 

A. Beck and M. Teboulle,  "A fast iterative shrinkage-thresholding algorithm for linear inverse problems", *SIAM Journal on Imaging Sciences*,
vol. 2, no. 1, pp. 183–202, 2009. [View the paper](http://people.rennes.inria.fr/Cedric.Herzet/Cedric.Herzet/Sparse_Seminar/Entrees/2012/11/12_A_Fast_Iterative_Shrinkage-Thresholding_Algorithmfor_Linear_Inverse_Problems_(A._Beck,_M._Teboulle)_files/Breck_2009.pdf).

## Usage 

Run `demo.m`

## Results: 

```matlab
Test 1: fat dictionary, 1000 signals
ADMM  | time: 22.688457 | cost: 100.335219
FISTA | time: 6.682808 | cost: 98.371655
=====================================
Test 2: tall dictionary, 1000 signals
ADMM  | time: 3.276344 | cost: 130.370372
FISTA | time: 2.204574 | cost: 129.481144
```

In both cases: fat and tall dictionaries, **FISTA performs better than ADMM in terms of both cost and running time.**
