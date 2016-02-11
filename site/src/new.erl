-module(add_edit).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template{file="./site/templates/bare.html"}.

title() -> "Add New/Edit Web Link". 

%% **********************************************
%% State 2:
%% User enters new link info;
%% clicks save
%% System saves new link info;
%% transistions back to initial state
%% **********************************************


