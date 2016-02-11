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

body() ->
  [
    #p {text = "Initial State: Add new weblink button;
                  initiate search"},
    #button{text="Add new weblink", click=
            #redirect{url="/add_edit/new"}},
    #br{}, 
    #textbox {id=search_words},
    #button {id=retrieve, text="Search for weblinks", 
             postback=search },
    #button {text="Show All", postback=show_all},
    #hr {}, 

%% *********************************************
%% State 3
%% System displays search results
%% ********************************************* 
    #panel {id=search_results}
  ]. 

%% *********************************************
%% State 4
%% System displays record
%% User selects view, edit, or delete
%% If view, display web page
%% If edit, transition to edit_add.erl state 6
%% If delete, delete record; transition to 
%% state 1
%% ********************************************* 
