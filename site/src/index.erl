%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "My Web Links".

%% *********************************************
%% Initial State 
%% User choice: transition to “add new” form
%% or enter search words and initiate a search
%% ********************************************* 

%% Horizontal rule

%% *********************************************
%% State 3
%% System displays search results
%% ********************************************* 
