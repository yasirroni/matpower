function opt = mpoption_info_glpk(selector)
% mpoption_info_glpk - Returns |MATPOWER| option info for GLPK.
% ::
%
%   DEFAULT_OPTS = MPOPTION_INFO_GLPK('D')
%   VALID_OPTS   = MPOPTION_INFO_GLPK('V')
%   EXCEPTIONS   = MPOPTION_INFO_GLPK('E')
%
%   Returns a structure for GLPK options for MATPOWER containing ...
%   (1) default options,
%   (2) valid options, or
%   (3) NESTED_STRUCT_COPY exceptions for setting options
%   ... depending on the value of the input argument.
%
%   This function is used by MPOPTION to set default options, check validity
%   of option names or modify option setting/copying behavior for this
%   subset of optional MATPOWER options.
%
% See also mpoption.

%   MATPOWER
%   Copyright (c) 2014-2024, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%
%   This file is part of MATPOWER.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See https://matpower.org for more info.

if nargin < 1
    selector = 'D';
end
if have_feature('glpk')
    switch upper(selector)
        case {'D', 'V'}     %% default and valid options
            opt = struct(...
                'glpk',           struct(...
                    'opts',            [], ...
                    'opt_fname',       '' ...
                ) ...
            );
        case 'E'            %% exceptions used by nested_struct_copy() for applying
            opt = struct(...
                'name',         { 'glpk.opts' }, ...
                'check',        0 ...
                );
%                 'copy_mode',    { @glpk_options } ...
        otherwise
            error('mpoption_info_glpk: ''%s'' is not a valid input argument', selector);
    end
else
    opt = struct([]);       %% GLPK is not available
end
