function [a,b,d] = linefrompoints(P1,P2)
    % ax + by = d
    a = - P2(2) + P1(2);
    b = P2(1) - P1(1);
    d = P1(2)*P2(1) - P1(1)*P2(2);
end