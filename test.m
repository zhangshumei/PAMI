function [A B] = MyFuncTest(IN)
% this is a test


x = -IN:.01:IN;
y = x;
surf(x,y,sin(x)'*cos(y));
A = x;
B = y;