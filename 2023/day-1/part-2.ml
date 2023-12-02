let is_digit c = c >= '0' && c <= '9'
(*
   - over each line, we need to do a sliding window from left to end
   - we make that a new seq/list of digits
   - get the head and tail
   - then just same thing as before
*)

let get_digit s =
  match s with
  | "one" ->
      Some 1
  | "two" ->
      Some 2
  | "three" ->
      Some 3
  | "four" ->
      Some 4
  | "five" ->
      Some 5
  | "six" ->
      Some 6
  | "seven" ->
      Some 7
  | "eight" ->
      Some 8
  | "nine" ->
      Some 9
  | _ ->
      None

let join seq = Seq.fold_left (fun acc curr -> acc ^ String.make 1 curr) "" seq

let slice_it i j seq = Seq.(seq |> drop i |> take (j - i + 1))

let read_file filename =
  let in_channel = open_in filename in
  let sum = ref 0 in
  try
    while true do
      let line = in_channel |> input_line |> String.to_seq in
      (* get_digit line  *)
      let left = ref 0 in
      let right = ref 0 in
      let acc = ref [] in
      while !left < Seq.length line do
        let curr = slice_it !left !right line |> join |> get_digit in
        Option.iter (fun inside -> acc := List.append [inside] !acc) curr ;
        (* right := !right + 1 *)
        if Seq.length line - 1 >= !right then left := !left + 1 ;
        right := !left ;
        ()
      done
    done
  with End_of_file ->
    (* End_of_file exception is raised when we reach the end of the file *)
    print_int !sum ; print_newline () ; close_in in_channel
(* Close the file when we're done *)
;;

read_file "day-1-input.txt"
