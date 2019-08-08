% OBJGOLD.M      (OBJective function for GOLDstein-price function)
%
% This function implements the GOLDSTEIN-PRICE function.
%
% Syntax:  ObjVal = objgold(Chrom,rtn_type)
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
% History:    25.11.93     file created
%             27.11.93     text of title and rtn_type added
%             16.12.93     rtn_type == 3, return value of global minimum
%             01.03.94     name changed in obj*
%             14.01.03     updated for MATLAB v6 by Alex Shenfield

function ObjVal = objgold(Chrom,rtn_type);

% Compute population parameters
   [Nind,Nvar] = size(Chrom);

% Check size of Chrom and do the appropriate thing
   % if Chrom is [], then define size of boundary-matrix and values
   if Nind == 0
      % return text of title for graphic output
      if rtn_type == 2
         ObjVal = 'GOLDSTEIN-PRICE function';
      % return value of global minimum
      elseif rtn_type == 3
         ObjVal = 3;
      % define size of boundary-matrix and values
      else   
         brd = 3;
         %         x1 x2
         ObjVal = [-brd -brd;  % lower bounds
                    brd  brd]; % upper bounds
      end
   % if two variables, compute values of function
   elseif Nvar == 2
      % GOLDSTEIN-PRICE function
      % -2 <= x1 <= 2 ; -2 <= x2 <= 2 (or -10 <= xi <= 10)
      % global minimum at (x1,x2)=(0,-1) ; fmin=3
      x1 = Chrom(:,1);
      x2 = Chrom(:,2);
      ObjVal = ((1+(x1+x2+1).^2.*(19-14*x1+3*x1.^2-14*x2+6*x1.*x2+3*x2.^2))...
               .*(30+(2*x1-3*x2).^2.*(18-32*x1+12*x1.^2+48*x2-36*x1.*x2+27*x2.^2)));
   % otherwise error, wrong format of Chrom
   else
      error('size of matrix Chrom is not correct for function evaluation');
   end   


% End of function