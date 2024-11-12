open Types

(* Validate the user's passwords match *)
let validate_user (username: string) (password: string): bool =
  let u: user = (Db_manager.get_user username) |> Option.get in
  u.password = password