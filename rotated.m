%This file rotates Trunc1, Trunc2, untrunc by minimizing the sum of squared
%distances
function [NewTrunc1, NewTrunc2, untrunc2] = rotated(Trunc1, Trunc2, untrunc)
Trunc2(2, :)=-Trunc2(2, :);
term1 = (sumOfSquares(Trunc1(1, :))+sumOfSquares(Trunc2(1, :)));
term2 = (sum(Trunc1(1, :))+sum(Trunc2(1, :)));
term3 = (sum(Trunc1(1, :).*Trunc1(2, :))+sum(Trunc2(1, :).*Trunc2(2, :)));
term4 = (sumOfSquares(Trunc1(2, :))+sumOfSquares(Trunc2(2, :)));
term5 = (sum(Trunc1(2, :))+sum(Trunc2(2, :)));
% func = @(a, c) (a^2)*(sumOfSquares(Trunc1(1, :))+sumOfSquares(Trunc2(1, :)))+2*a*c*(sum(Trunc1(1, :))+sum(Trunc2(1, :)))+2*a*(sum(Trunc1(1, :).*Trunc1(2, :))+sum(Trunc2(1, :).*Trunc2(2, :)))+2*size(Trunc1, 2)*c^2+(sumOfSquares(Trunc1(2, :))+sumOfSquares(Trunc2(2, :)))+2*c*(sum(Trunc1(2, :))+sum(Trunc2(2, :)));
func = @(x) (x(1)^2)*(sumOfSquares(Trunc1(1, :))+sumOfSquares(Trunc2(1, :)))+2*x(1)*x(2)*(sum(Trunc1(1, :))+sum(Trunc2(1, :)))+2*x(1)*(sum(Trunc1(1, :).*Trunc1(2, :))+sum(Trunc2(1, :).*Trunc2(2, :)))+2*size(Trunc1, 2)*x(2)^2+(sumOfSquares(Trunc1(2, :))+sumOfSquares(Trunc2(2, :)))+2*x(2)*(sum(Trunc1(2, :))+sum(Trunc2(2, :))); 
[x, fval] = fminunc(func, [0, 0]);
Trunc1 = rotateAbtLine(Trunc1, -x(1));
Trunc2 = rotateAbtLine(Trunc2, -x(1));
untrunc2 = rotateAbtLine(untrunc, -x(1));
NewTrunc1=shift(Trunc1);
NewTrunc2=shift(Trunc2);

end