/*
      CS471 - Programming Languages
        Assignment #3 due: 2/17/2015
        Author: Morris, David (dmorris4@binghamton.edu)
        Date: 2/16/2015
 */

/* 
 * You should submit only one file named
 *           as3S15.pl
 * to Blackboard.
 *
 * Name all predicates as specified in each problem.
 * 
 */

/* Purpose:
 * to practice writing relations in Prolog

   This assignment is not intended to be hard, however many will need
   time to absorb how easy it really is. One problem requires only one line,
   most require only two lines and none require more than 3 lines.
 */

/*1: Read 3.1.3 Example 3: Successor from "Learn Prolog Now!"

http://cs.union.edu/~striegnk/learn-prolog-now/html/node27.html#subsec.l3.ex3

    Define a predicate convertToDecimal(Succ, Decimal), which converts the
    succ representation for numbers to decimal representation.
i.e.
  ?- convertToDecimal(succ(succ(succ(succ(succ(0))))),N).
  N = 5.
  ?- convertToDecimal(S,4).
  S = succ(succ(succ(succ(0)))) .

*/
% numeral/1 can be used to verified the argument is in the correct form to represent
%           a number.

numeral(0).
numeral(succ(X)) :- numeral(X).

convertToDecimal(0,0).
convertToDecimal(succ(0),1).
convertToDecimal(X,Y) :- succ(N) = X, convertToDecimal(N,Z), Y is Z+1.

/*2: Define a predicate minus(Succ1, Succ2, MinusSucc), which subtracts Succ2 
     in succ notations from Succ1  in succ notations
     and the result is in succ notation.  
     
     DO NOT convert succ notation to decimal.  You may assume
     only succ notation is used by the query.
     ie.
      ?- minus(succ(succ(succ(succ(succ(0))))), succ(succ(0)), Diff).
      Diff = succ(succ(succ(0))).
      ?- minus(succ(succ(succ(0))), OP, succ(succ(0)) ).
      OP = succ(0) .
      ?- minus(succ(0), succ(0), Diff ).
      Diff = 0.
     
  */
  
minus(0,0,C) :- C = 0.
minus(0,succ(B),succ(C)) :- minus(0,B,C).  
minus(succ(A),0,succ(C)) :- minus(A,0,C).
minus(succ(A),succ(B),C) :- minus(A,B,C).
  

/* 3: Using solution from problem 2 define add(Succ1, Succ2, Diff).
      You may assume the Succ1 is larger than Succ2.
      ie. 
      ?- add(succ(succ(succ(succ(succ(0))))), succ(succ(0)), Sum).
       Sum = succ(succ(succ(succ(succ(succ(succ(0))))))).

      ?- add(succ(succ(0)), succ(succ(succ(0))), Sum).
      Sum = succ(succ(succ(succ(succ(0))))).

     ?- add(succ(succ(0)), OP, succ(succ(succ(0)))).
     OP = succ(0)
*/

add(0,0,C)                         :- C = 0.
add(0,succ(B),succ(C))             :- add(0,B,C).
add(succ(A),0,succ(C))             :- add(A,0,C).
add(succ(A),succ(B),succ(succ(C))) :- add(A,B,C).
     

/*4: Define a predicate equLst(Lst1, Lst2), such that it succeeds if lists
     Lst1 and Lst2 have the same length and each corresponding element can be unified.  

     ?- equLen([1,3],[1,3]).
     true.
     
     ?- equLen([1,3],[1,3,4]).
     false.

     ?- equLen([1,3],[1,3|[]]).
     true.

     ?- equLen([1,3],[1|T]).
     T = [3].
     
     ?- equLen(a,a).
     false.
    
  */

equLen([],[]).
equLen([A|C],[A|C]) :- equLen(C,C).



/* 5: point(X,Y) is the structure which represents a point.  Write a fact
     "origin" which succeeds if both X and Y are zero.
    e.g. 
      ?- origin(P).
    succeeds if P is a point with x = 0 and y = 0.
 */

origin(point(0,0)).

/* 6: The ternary relation "collinear(p1,p2,p3)", is true if and only if
      p1, p2, and p3 lie on a straight line.  One definition is as follows:
      collinear(point(x1,y1), point(x2,y2), point(x3, y3))
        if and only if
             (x1-x2)(y2-y3) equals (y1-y2)(x2-x3)

      ?- collinear(point(1,1), point(2,2),point(3,3)).
      true.

      ?- collinear(point(1,0), point(2,0),point(3,0)).
      true.

      ?- collinear(point(1,0), point(2,0),point(3,3)).
      false.
*/

collinear(point(X1,Y1),point(X2,Y2),point(X3,Y3)) :- A = B , A is (X1-X2)*(Y2-Y3), B is (Y1-Y2)*(X2-X3).

/* 7: Define the "prefix" predicate so that "prefix(X,Y)" says that 
      X is a list that is a prefix of Y.  That is, each element of X 
      unifies with the corresponding element of Y, but Y may contain 
      additional elements after that.  Check that your predicate works 
      when X is uninstantiated: given a query like "prefix(X,[1,2,3]), it 
      should find all the prefixes of the list [1,2,3] (after each result
      use ";" instead of return).
      e.g.
       ?- prefix(X,[a,b,c]).
       X = [] ;
       X = [a] ;
       X = [a, b] ;
       X = [a, b, c] ;
       No
*/

prefix([],_).
prefix([A|T],[A|V]) :- prefix(T,V).

/* 8: Define a predicate hasSubseq(L,S), such that it succeeds if the list L 
      contains the list S as a sub-sequence of equivalent items. 
      Use a recursive definition.
      e.g. 
      ?-hasSubseq([a,g,b,d],[g,b]). 
      true .
      ?- hasSubseq([a,g,b,d],[g,d]). 
      true .
      ?- hasSubseq([a,g,b,d],[b,g]).
      false.
      
      (This can be done with 3 clauses.)
      
   */

hasSubseq(_,[]).
hasSubseq([A|T],[A|V]) :- hasSubseq(T,V).
hasSubseq([_|T],[B|V]) :- hasSubseq(T,[B|V]).


/* 9: For this problem we define a binary tree as:
      empty
        or
      node(V, LT, RT) where V is a value and LT is the left tree and
      RT is the right the right tree.

      Define a predicate 'isTree(Tree)' which succeeds if Tree is 
      matches this tree definition.
      
      ?- tree1(T), isTree(T).
      T = node(4, node(a, empty, node(b, empty, empty)), empty).
      ?- tree2(T), isTree(T).
      T = node(5, empty, empty).
      ?- tree4(T), isTree(T).
      false.
      
      Below are test cases.  This can be done with 2 clauses.

*/

tree1(Tree1):- Tree1 = node(4, node(a, empty, node(b, empty, empty)), empty).
tree2(Tree2):- Tree2 = node(5, empty, empty).
tree3(Tree3):- Tree3 = node(a, node(b, node(c,empty,empty), node(d,empty,empty)), empty).
tree4(NotTree):- NotTree= node(a, empty, node(x ,node(b, node(c,empty,empty), node(d,empty,empty)))).
tree5(NotTree):-NotTree= node(a, empty, node(x, node(b, node(c, empty, empty), node(d, empty, empty))), empty).
tree6(Tree6):- Tree6 = node(a, node(b, empty,empty), node(c, node(d,empty,empty),node(e,empty,empty) )).

isTree(empty).
isTree(node(_,A,B)) :- isTree(A),isTree(B).



/* 10: Here is a recursive mathematical definition of gcd (Greatest Common Divisors)

      a) if m <= n and mod(n, m) = 0 then gcd(n,m) = m.
      b) if n < m then gcd(n,m) = gcd(m,n).
      c) if n >= m then gcd(n,m) = gcd(m,mod(n,m)).
   
      (In Britain, the greatest common divisor is often called the highest common factor.)


       e.g.
       ?- gcd(120,222, GCD).
       GCD = 6 ;
       false.

       ?- gcd(120,0, GCD).
       GCD = 120 .

       ?- gcd(120,60, GCD).
       GCD = 60 .

*/

gcd(A,0,A).
%gcd(A,B,GCD) :- A >= B , 0 is mod(A,B), GCD = B.
gcd(A,B,GCD) :- A < B, gcd(B,A,G), GCD = G.
gcd(A,B,GCD) :- A >= B ,Z is mod(A,B), gcd(B,Z,X), GCD = X.


/* 11: Using the definition of Ackermann's functions as defined homework 1 (problem 6),
 *     write a Prolog predicate ack(M, N, A).  Note A will unify with the 
 *     Ackermann's value for M and N.   
*/

ack(0,N,A) :- A is N*2.
ack(M,0,A) :- M > 0, A is 0.
ack(M,1,A) :- M > 0, A is 2.
ack(M,N,A) :- X is M-1, Y is N-1, ack(M,Y,Z), ack(X,Z,A).



