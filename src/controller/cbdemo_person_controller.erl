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
  Person = person:new(id,
    Request:param("first_name"),
    Request:param("last_name"),
    string:to_integer(Request:param("age")),
    Request:param("bio")),
  Person:save().

update_person() ->
  Person = boss_db:find(Request:param("id")),
  New = Person:set([{first_name, Request:param("first_name")},
    {last_name, Request:param("last_name")},
    {age, string:to_integer(Request:param("age"))},
    {bio, Request:param("bio")}]),
  New:save().
