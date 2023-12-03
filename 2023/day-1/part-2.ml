type digit_item = {value: int; index: int}
type digit_item = {value: int; index: int}

type temp_char = {value: char; index: int}
let is_digit c = c >= '0' && c <= '9'
(*
  - over each line, we need to do a sliding window from left to end
  - we make that a new seq/list of digits
  - get the head and tail
  - then just same thing as before
*)



let digit_of_head_and_last list =
  match list with
  | [] -> 0  (* Empty list case *)
  | [x] -> (int_of_string (String.make 1 x.value ^ String.make 1 x.value))
  | head :: _ as full_list -> 
      let rec find_last = function
        | [] -> failwith "wadu"
        | [last] -> last
        | _ :: tail -> find_last tail
      in
      let last = find_last full_list in
    int_of_string ((String.make 1 head.value) ^ (String.make 1 last.value))
let get_digit s =
  match s with
  | "one" ->
      Some '1'
  | "two" ->
      Some '2'
  | "three" ->
      Some '3'
  | "four" ->
      Some '4'
  | "five" ->
      Some '5'
  | "six" ->
      Some '6'
  | "seven" ->
      Some '7'
  | "eight" ->
      Some '8'
  | "nine" ->
      Some '9'
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
      let mapped_line =
        List.mapi (fun idx el -> {value= el; index= idx}) (List.of_seq line)
      in
      let filtered_line = List.filter (fun x -> is_digit x.value) mapped_line in
      acc := List.append filtered_line !acc ;
      while !left < Seq.length line do
        let curr = slice_it !left !right line |> join |> get_digit in
        Option.iter
          (fun inside -> acc := List.append [{value= inside; index= !left}] !acc)
          curr ;
        
        if !right >= Seq.length line - 1 then (
          left := !left + 1 ;
          right := !left )
        else right := !right + 1
      done;
      sum:= !sum + digit_of_head_and_last (List.sort (fun a b -> a.index - b.index) !acc)
      
      
    done
  with End_of_file ->
    print_int !sum ; print_newline () ; close_in in_channel
;;

read_file "day-1-input.txt"
