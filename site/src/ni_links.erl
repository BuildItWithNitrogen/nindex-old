-module(ni_links).
-export([ init_db/0, 
          get_all/0, 
          get_link/1, 
          save_link/1,
          delete_link/1,
          new/3,
          id/1,
          topic/1,
          descriptor/1,
          url/1
        ]).

-define(DB, ni_joedb).

init_db() ->
   ?DB:init_db().

get_all() ->
   ?DB:get_all().

get_link(ID) ->
   ?DB:get_link(ID).

save_link(Weblink) ->
   ?DB:save_link(Weblink).

delete_link(ID) ->
   ?DB:delete_link(ID).

new(Topic, Descriptor, Url) ->
   ?DB:new(Topic, Descriptor, Url).

id(Weblink) ->
   ?DB:id(Weblink).

topic(Weblink) ->
   ?DB:topic(Weblink).

descriptor(Weblink) ->
   ?DB:descriptor(Weblink).

url(Weblink) ->
   ?DB:url(Weblink).
