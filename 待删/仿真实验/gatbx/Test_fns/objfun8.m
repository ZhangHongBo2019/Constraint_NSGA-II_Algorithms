% OBJFUN8.M      (OBJective function for griewangk's FUNction)
%
% This function implements the GRIEWANGK function 8.
%
% Syntax:  ObjVal = objfun8(Chrom,rtn_type)
%
% Input parameters:
%    Chrom     - Matrix containing the chromosomes of the current
%                population. Each row corresponds to one individual's
%                string representation.
%                if Chrom == [], then special values will be returned
%    rtn_type  - if Chrom == [] and
%                rtn_type == 1 (or []) return boundaries
%                rtn_type == 2 return title
%                rtn_type == 3 return value of global minimum
%
% Output parameters:
%    ObjVal    - Column vector containing the objective values of the
%                individuals in the current population.
%                if called with Chrom == [], then ObjVal contains
%                rtn_type == 1, matrix with the boundaries of the function
%                rtn_type == 2, text for the title of the graphic output
%                rtn_type == 3, value of global minimum
%                
%
% Author:     Hartmut Pohlheim
% History:    12.12.93     file created (copy of valfun7.m)
%             16.12.93     rtn_type == 3, return value of global minimum
%             27.01.94     20* in formula, correction ??
%             01.03.94     name changed in obj*
%             14.01.03     updated for MATLAB v6 by Alex Shenfield

function ObjVal = objfun8(Chrom,rtn_type);

% Dimension of objective function
   Dim = 10;
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if rtn_type == 2
         ObjVal = ['GRIEWANGKs function 8-' int2str(Dim)];
      % return value of global minimum
      elseif rtn_type == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = [-600; 600];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      % function 8, sum(xi^2/4000) - 20*prod(cos(xi/sqrt(i))) + 1 for i = 1:Dim (Dim=10)
      % n = Dim, -600 <= xi <= 600
      % global minimum at (xi)=(0) ; fmin=0
      % nummer = 1:Dim;
      nummer = rep(1:Dim,[Nind 1]);
      ObjVal = sum(((Chrom.^2) / 4000)')' - prod(cos(Chrom ./ sqrt(nummer))')' + 1;
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function