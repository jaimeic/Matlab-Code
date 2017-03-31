function d = bayesgauss(X, CA, MA, P)
%BAYESGAUSS Bayes classifier for Gaussian patterns.
%   D = BAYESGAUSS(X, CA, MA, P) computes the Bayes decision
%   functions of the patterns in the rows of array X usisng the
%   covariance matrices and mean vectors provided in the arrays
%   CA and MA. CA is an array of size n-by-n-by-W, where n is the
%   dimensionality of the patterns and and W is the number of the classes. 
%   Array MA is of dimension n-by-W (i.e., the columns of MA are the
%   individual mean vectors). The locations of the covariance matrices and
%   the mean vectors in their respective arrays must correspond. There must
%   be a covariance matrix and a mean vector for each pattern class, even
%   if some of the covariance matrices and/or mean vectors are equal. X is
%   an array of size K-byn, where K is the total number of pattersn to be
%   classified (i.e., containing the probabilities of occurence of each
%   class. If P is not included in the argument list, the classes are
%   assumed to be equally likely. 
%
%   The output, D, is a column vector of length K. Its Ith element is the
%   class number assigned to the Ith vector in X during Bayes
%   classification. 

d = [];                     % Initialize d.
narginchk(3,4);             % Verify correct number of inputs. 
n = size(CA,1);             % Dimension of patterns.

% Protect agains the possibility that the class number is 
% included as an (n+1)th element of the vectors.
X = double(X(:, 1:n));
W = size(CA, 3);            % Number of pattern classes.
K = size(X, 1);             % Number of patters to classify.
if nargin == 3
    P(1:W) = 1/W            % Classes assumed equally likely.
else 
    if sum(P) ~= 1
        error('Elements of P must sum to 1.');
    end
end

% Compute the determinants.
for J = 1:W
    DM(J) = det(CA(:, :, J));
end

% Compute inverses, using right division (IM/CA), where
% IM = eye(size(CA,1)) is the n-by-n identity matrix. Reuse CA to conserve
% memory.
IM = eye(size(CA, 1));
for J = 1:W
    CA(:, :, J) = IM/CA(:, :, J);
end

% Evaluate the decisions functions. 
MA = MA';               % Organize the mean vectors as rows.
for I = 1:K
    for J = 1:W
        m = MA(J, :);
        Y = X - m(ones(size(X, 1), 1), :); 
        if P(J) == 0
            D(I, J) = -Inf;
        else
            D(I, J) = log(P(J)) - 0.5*log(DM(J)) - ...
                                - 0.5*sum(Y(I, :)*(CA(:, :, J)*Y(I, :)'));
        end
    end
end

% Find the maximum in each row of D. These maxima give the class of 
% each pattern:
for I = 1:K
    J = find(D(I, :) == max(D(I, :)));
    d(I, :) = J(:);
end

% EWhen there are multiple maxima the decision is arbitrary. Pick first
% one.
d = d(:, 1);

end

                        
        