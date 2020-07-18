function [H,c] = optmization_matrix_generation(rv,alpha,f,NP)
%This function generate coefficient matrix and RHS for each image data

N = length(f);%N=n+1
W = 1./sin(alpha);%weight function
H = zeros(NP,NP);
c = zeros(NP,1);
for i = 1:NP
    for j = 1:NP
        for k = 1:N
            H(i,j)= H(i,j)+W(k)./(i+j-1).*(rv(1,k+1).^(i+j-1)-rv(1,k).^(i+j-1));       
        end
    end
    for k = 1:N
            c(i)= c(i)+f(k).*W(k)./(i).*(rv(1,k+1).^(i)-rv(1,k).^(i));        
    end
end
