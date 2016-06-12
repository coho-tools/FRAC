
% function val = rac_info(field)
%   This function returns read-only information for RAC, including: 
%     rac_home:  root path of CAR software 
%     rac_dirs:  all RAC dirs to be added in Matlab
%     user:      current user
%     has_cplex: CPLEX LP solver is available or not in the system 
%     version:   RAC version
%     license:   RAC license
%  Ex: 
%     info = rac_info;  // return the structure
%     has_cplex = rac_info('has_cplex'); // has the value
function val = rac_info(field)
  % NOTE: I use global vars because of the Matlab bug. 
	%       (When the code is in linked dir, persistent vars are re-inited 
	%        when firstly changing to a new directory). 
  %       Please don't modify the value by other functions. 
  %persistent  RAC_INFO;
  global RAC_INFO;
  if(isempty(RAC_INFO)) 
    RAC_INFO = rac_info_init; % evaluate once
  end
  if(nargin<1||isempty(field))
    val = RAC_INFO;
  else
    val = RAC_INFO.(field);
  end; 
end
function  info = rac_info_init
  % RAC root path
  rac_home='/ubc/cs/home/c/chaoyan/FRAC'; 

  % RAC directories 
  rac_dirs = {
    'ConvexPh',
    'LinearProgramming',
    'LinearProgramming/Project',
    'LinearProgramming/Solver',
    'Polygon',
    'Polygon/SAGA',
    'Integrator',
    'JANS',
    'Utils',
    'Utils/Logger'};

  % cplex is avail in the system
  has_cplex = 0; 
  
  % current user
  [~,user] = unix('whoami');
  user = user(1:end-1);

	% path to save RAC system data or files
  sys_path = ['/var/tmp/',user,'/coho/rac/sys']; 

  version = 1.1;
  license = 'bsd';
  
  info = struct('version',version, 'license',license, ...
                'rac_dirs',{rac_dirs}, 'rac_home',rac_home, ...
                'user',user, 'has_cplex', has_cplex, ...
                'sys_path', sys_path); 
end % rac_info

