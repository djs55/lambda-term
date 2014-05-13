(*
 * radiobuttons.ml
 *)

open Lwt
open LTerm_widget

lwt () =
  let waiter, wakener = wait () in

  let vbox = new vbox in
  let result_int = (new label "1") in
  let result_string = (new label "foo") in
  let group_int = new radiogroup in
  let group_string = new radiogroup in
  let callback_int = function
    | Some n -> result_int#set_text (string_of_int n)
    | None -> ()
  in
  let callback_string = function
    | Some s -> result_string#set_text s
    | None -> ()
  in
  group_int#on_state_change callback_int;
  group_string#on_state_change callback_string;

  let button = new button "exit" in
  button#on_click (wakeup wakener);
  vbox#add ~expand:false button;
  vbox#add ~expand:false (new hline);

  let hbox = new hbox in
  hbox#add (new radiobutton group_int "Number 1" 1);
  hbox#add ~expand:false (new vline);
  hbox#add (new radiobutton group_string "String 'foo'" "foo");
  hbox#add ~expand:false (new vline);
  vbox#add ~expand:false hbox;


  let hbox = new hbox in
  hbox#add (new radiobutton group_int "Number 2" 2);
  hbox#add ~expand:false (new vline);
  hbox#add (new radiobutton group_string "String 'bar'" "bar");
  hbox#add ~expand:false (new vline);
  vbox#add ~expand:false hbox;


  let hbox = new hbox in
  hbox#add (new radiobutton group_int "Number 3" 3);
  hbox#add ~expand:false (new vline);
  hbox#add (new radiobutton group_string "String 'baz'" "baz");
  hbox#add ~expand:false (new vline);
  vbox#add ~expand:false hbox;

  vbox#add ~expand:false (new hline);
  vbox#add ~expand:false result_int;
  vbox#add ~expand:false result_string;

  vbox#add (new t "glue") ;

  let frame = new frame in
  frame#set vbox;

  lwt term = Lazy.force LTerm.stdout in
  run term frame waiter
