let is_digit c = c >= '0' && c <= '9'

let read_file filename =
  let in_channel = open_in filename in
  let sum = ref 0 in
  try
    while true do
      let line = input_line in_channel in
      let filtered =
        line |> String.to_seq |> Seq.filter is_digit |> String.of_seq
      in
      (* Convert list back to string *)
      let first_digit = String.get filtered 0 |> String.make 1 in
      let last_digit =
        String.get filtered (String.length filtered - 1) |> String.make 1
      in
      let digit = int_of_string (first_digit ^ last_digit) in
      (* print_int digit; *)
      sum := !sum + digit
      (* print_newline (); *)
    done
  with End_of_file ->
    (* End_of_file exception is raised when we reach the end of the file *)
    print_int !sum ; print_newline () ; close_in in_channel
(* Close the file when we're done *)
;;

read_file "day-1-input.txt"
