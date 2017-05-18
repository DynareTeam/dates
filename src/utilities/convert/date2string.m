function s = date2string(varargin) % --*-- Unitary tests --*--

% Returns date as a string.
%
% INPUTS
%  o varargin{1}     + dates object with one element, if nargin==1.
%                    + 1*2 vector of integers (first element is the year, second element is the subperiod), if nargin==2.
%  o varargin{2}     integer scalar equal to 1, 4, 12 or 52 (frequency).
%
% OUTPUTS
%  o s               string.

% Copyright (C) 2013 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

if isequal(nargin,1)
    if ~(isa(varargin{1},'dates') && isequal(length(varargin{1}),1))
        error(['dates::format: Input argument ' inputname(1) ' has to be a dates object with one element!'])
    else
        time = varargin{1}.time;
        freq = varargin{1}.freq;
    end
end

if isequal(nargin,2)
    if ~(isvector(varargin{1}) && isequal(length(varargin{1}),2) && all(isint(varargin{1})) && isscalar(varargin{2} && ismember(varargin{2},[1 4 12 52])))
        error(['dates::format: First input must be a 1*2 vector of integers and second input must be a scalar integer (1, 4, 12 or 52)!'])
    else
        if varargin{1}(2)>varargin{2} || varargin{1}(2)<1
            error('dates::format: Second element of the first input be between 1 and %s!',num2str(varargin{2}))
        end
        time = varargin{1};
        freq = varargin{2};
    end
end

s = [num2str(time(1)) freq2string(freq)];
if freq>1
    s = strcat(s, num2str(time(2)));
end

%@test:1
%$ try
%$     str = date2string(dates('1938Q4'));
%$     t(1) = true;
%$ catch
%$     t(1) = false;
%$ end
%$
%$ if t(1)
%$     t(2) = dassert(str, '1938Q4');
%$ end
%$
%$ T = all(t);
%@eof:1

%@test:2
%$ try
%$     str = date2string(dates('1938Q4','1945Q3'));
%$     t(1) = false;
%$ catch
%$     t(1) = true;
%$ end
%$
%$ T = all(t);
%@eof:2

%@test:3
%$ try
%$     str = date2string([1938, 11], 12);
%$     t(1) = true;
%$ catch
%$     t(1) = false;
%$ end
%$
%$ if t(1)
%$     t(2) = dassert(str, '1938M11');
%$ end
%$
%$ T = all(t);
%@eof:3

%@test:4
%$ try
%$     str = date2string([1938; 11], 12);
%$     t(1) = true;
%$ catch
%$     t(1) = false;
%$ end
%$
%$ if t(1)
%$     t(2) = dassert(str, '1938M11');
%$ end
%$
%$ T = all(t);
%@eof:4

%@test:5
%$ try
%$     str = date2string([1938; 11], 4);
%$     t(1) = false;
%$ catch
%$     t(1) = true;
%$ end
%$
%$ T = all(t);
%@eof:5
