let is_digit c = c >= '0' && c <= '9'

let read_file filename =
  let in_channel = open_in filename in
  try
    while true do
      let line = input_line in_channel in
      let filtered = 
        line
        |> String.to_seq
        |> Seq.filter is_digit
        |> String.of_seq in   (* Convert list back to string *)
      let first_digit = 
      String.get filtered 0 in
      let last_digit = 
      String.get filtered (String.length filtered - 1) in
      print_char last_digit;
      print_char '-';
      print_char first_digit;
      print_newline ();
    done
  with End_of_file ->      (* End_of_file exception is raised when we reach the end of the file *)
    close_in in_channel    (* Close the file when we're done *)
;;
read_file "day-1-input.txt";
