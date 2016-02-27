function [A B] = MyFuncTest()
% this is a test

out = input('Type a number you want: ')
x = -out:.01:out;
% x = -IN:.01:IN;
y = x;
surf(x,y,sin(x)'*cos(y));
% A = x;
% B = y;