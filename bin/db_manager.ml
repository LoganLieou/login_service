open Sqlite3
open Types

(* Database connection to the tf_db database *)
let conn: db = db_open "tf_db"

(* Create user function creates a user in the database *)
let create_user (u: user): unit =
  let sql: string = 
    Printf.sprintf "insert into users user with values (%s, %s, %d);\n" 
    u.username
    u.password
    u.high_score
  in
  let rc = exec conn sql in
  match rc with
  | Rc.OK -> print_endline "Success, created user"
  | _ -> print_endline "Error, failed to create user"

let get_user (username: string): user option =
  (* Create information for query *)
  let sql: string = Printf.sprintf "select * from users where username='%s';\n"
    username
  in

  (* TODO how do I handle this better *)
  let u: user option ref = ref None in

  (* Execute statement in database and handle response *)
  let res = exec_no_headers conn sql ~cb:(fun (row: string option array) -> 
    let usr: string = Option.get @@ Array.get row 0 in
    let pas: string = Option.get @@ Array.get row 1 in
    let hsr: int = int_of_string @@ Option.get @@ Array.get row 2 in
    u := Some {
      username = usr;
      password = pas;
      high_score = hsr;
    };
  ) in
  match res with
  | Rc.OK -> !u
  | _ -> None
  