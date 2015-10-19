%% Migration: persons

UpSQL = "
  CREATE TABLE people(
    id serial unique,
    first_name text not null,
    last_name text not null,
    bio text not null,
    age integer not null
  );
".

DownSQL = "DROP TABLE people;".

{create_persons,
  fun(up)   –> boss_db:execute(UpSQL);
     (down) –> boss_db:execute(DownSQL)
  end}.
