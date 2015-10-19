-module(cbdemo_person_controller, [Request]).
-compile(export_all).

index('GET', []) ->
  Persons = boss_db:find(person, []),
  {ok, [{persons, Persons}]}.

show('GET', [Id]) ->
  fetch_person(Id).

edit('GET', [Id]) ->
  fetch_person(Id).

creating('POST', []) ->
  create_person(),
  {output, "created"}.

updating('POST', []) ->
  update_person(),
  {output, "updated"}.

destroy('GET', [Id]) ->
  boss_db:delete(Id),
  {output, "destroyed"}.

fetch_person(Id) ->
  Person = boss_db:find(Id),
  {ok, [{person, Person}]}.

create_person() ->
  FirstName = Request:param("first_name"),
  LastName = Request:param("last_name"),
  {Age, _} = string:to_integer(Request:param("age")),
  Bio = Request:param("bio"),

  Person = person:new(id, FirstName, LastName, Age, Bio),
  Person:save().

update_person() ->
  {Age, _} = string:to_integer(Request:param("age")),

  Person = boss_db:find(Request:param("id")),
  New = Person:set([{first_name, Request:param("first_name")},
    {last_name, Request:param("last_name")},
    {age, Age},
    {bio, Request:param("bio")}]),
  New:save().
