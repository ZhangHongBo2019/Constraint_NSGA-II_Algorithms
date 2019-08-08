% OBJPUSH.M      (OBJective function for PUSH-cart problem)
%
% This function implements the PUSH-CART PROBLEM.
%
% Syntax:  ObjVal = objpush(Chrom,rtn_type)
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
% History:    19.02.94     file created (copy of valharv.m)
%             01.03.94     name changed in obj*
%             15.01.03     updated for MATLAB v6 by Alex Shenfield

function ObjVal = objpush(Chrom,rtn_type);

% Dimension of objective function
   Dim = 20;

% values from MICHALEWICZ
   x0 = [0 0];
   
% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if rtn_type == 2
         ObjVal = ['PUSH-CART PROBLEM-' int2str(Dim)];
      % return value of global minimum
      elseif rtn_type == 3
         ObjVal = -(1/3 - ((3*Dim-1)/(6*Dim^2)) - (1/(2*Dim^3))*sum((1:Dim-1).^2));
      % define size of boundary-matrix and values
      else   
         % lower and upper bound, identical for all n variables        
         ObjVal = [0; 5];
         ObjVal = rep(ObjVal,[1 Dim]);
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      ObjVal = zeros(Nind,1);
      X = rep(x0,[Nind 1]);
      for irun = 1:Nvar,
         Xsave = X;
         X(:,1) = Xsave(:,2);
         X(:,2) = 2 * X(:,2) - Xsave(:,1) + (1/Dim^2) * Chrom(:,irun);
      end
      X;
      ObjVal = -(X(:,1) - (1/(2*Dim)) * sum((Chrom.^2)')');
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function