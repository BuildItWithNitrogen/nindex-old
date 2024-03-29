-module(ni_dets).
-behaviour(gen_server).
-export([start/0,
         start_link/0,
         init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3
        ]).

%% Expected API exports
-export([init_db/0, 
         get_all/0,
         get_link/1,
         save_link/1,
         delete_link/1,
         new/3,
         id/1, id/2,
         topic/1, topic/2,
         descriptor/1, descriptor/2,
         url/1, url/2
        ]).

-record(weblink, {id, topic, descriptor, url}).
-define(SERVER, ?MODULE).

start() ->
    gen_server:start({local, ?SERVER}, ?MODULE, [], []).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init(_) ->
    open_db(),
    {ok, []}.

terminate(_Reason, _State) ->
    close_db(),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

handle_call(get_all, _From, State) ->
    Links = dets:match_object(dets_nindex, '_'),
    {reply, Links, State};
handle_call({get_link, ID}, _From, State) ->
    Link = case dets:lookup(dets_nindex, ID) of
        [L|_] -> L;
        _ -> undefined
    end,
    {reply, Link, State};
handle_call({save_link, Link}, _From, State) ->
    ok = dets:insert(dets_nindex, Link),
    {reply, ok, State};
handle_call({delete_link, ID}, _From, State) ->
    dets:delete(dets_nindex, ID),
    {reply, ok, State}.

init_db() -> 
    ni_dets_sup:start().

open_db() ->
    DB = dets_nindex,
    Opts = [{type, set}, {keypos, #weblink.id}],
    {ok, DB} = dets:open_file(DB, Opts).

close_db() ->
    dets:close(dets_nindex).

get_all() ->
    gen_server:call(?SERVER, get_all).

get_link(ID) ->
    gen_server:call(?SERVER, {get_link, ID}).

save_link(Link = #weblink{id=undefined}) ->
    save_link(Link#weblink{id=create_id()});
save_link(Link) ->
    gen_server:call(?SERVER, {save_link, Link}).

create_id() ->
    crypto:rand_uniform(1, 999999999999). 

delete_link(ID) ->
    gen_server:call(?SERVER, {delete_link, ID}).

%% API functions

new(Topic, Descriptor, Url) ->
    #weblink{
        topic=Topic,
        descriptor=Descriptor,
        url=Url
    }.

id(#weblink{id=ID}) -> ID.
id(W, ID) -> W#weblink{id=ID}.

descriptor(#weblink{descriptor=Desc}) -> Desc.
descriptor(W, Desc) -> W#weblink{descriptor=Desc}.

topic(#weblink{topic=Topic}) -> Topic.
topic(W, Topic) -> W#weblink{topic=Topic}.

url(#weblink{url=Url}) -> Url.
url(W, Url) -> W#weblink{url=Url}.
