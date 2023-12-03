let read_lines filename =
    let in_channel = open_in filename in
    let rec read_acc acc =
    try
        let line = input_line in_channel in
        read_acc (line :: acc)
    with
        | End_of_file -> List.rev acc
    in
    let lines = read_acc [] in
    close_in in_channel;
    lines



(* let lines = read_lines "input.txt" in 
let _ = 2; 
 *)

type game = {id: int; blue: int; red:int;green:int}

let parse_line line = List.fold_left  (fun acc element-> match acc with 
| head :: tail -> {id=head.id;
                red=head.red + element.red; 
                blue=head.blue + element.blue;
                green=head.green + element.green
                } :: tail
| _ -> [];                
                ) [] line;





let problem_2 = 
    let lines = read_lines "input.txt" in 
    print_endline "";
;;

problem_2