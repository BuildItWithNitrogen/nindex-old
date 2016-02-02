-module(ni_joedb).

%% Expected API exports
-export([init_db/0, 
         get_all/0
        ]).

%% --------------------------------------------- 
%% @doc joeDB
%% ---------------------------------------------

create_id() ->
    crypto:rand_uniform(1, 999999999999). 

seed() ->
    [[{id, create_id()},
      {topic,"Erlang"},
      {descriptor,"Erlang Programming Language"},
      {url,"http://www.erlang.org"}],
     [{id, create_id()},
      {topic,"Nitrogen"}, 
      {descriptor,"Nitrogen Home Page"}, 
      {url,"http://nitrogenproject.com/"}]].

get_all() ->
    {ok, Bin} = file:read_file("joedb"),
    binary_to_term(Bin). 

put_all(Data) ->    
    Bin = term_to_binary(Data),    
    file:write_file("joedb", Bin). 

init_db() -> 
    put_all(seed()).

