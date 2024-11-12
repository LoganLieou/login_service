let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/" (fun _ ->
      Dream.html "<h1>Hello World!</h1>"
    );

    Dream.get "/auth" (fun _ ->
      let r = User.validate_user "testuser1" "password" in
      Dream.html (Printf.sprintf "<h1>Hello</h1>\n<p>User is valid %b</p>\n"
        r
      )
    );
  ]