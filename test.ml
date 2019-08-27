open Command
open State
open OUnit2

let command_tests =
  [

    "Empty error 1" >::(fun _ -> 
        let err_fun = fun () -> parse "" in 
        assert_raises (Empty) err_fun);

    "Empty error 2" >::(fun _ -> 
        let err_fun = fun () -> parse " " in 
        assert_raises (Empty) err_fun);

    "Empty error 3" >::(fun _ -> 
        let err_fun = fun () -> parse "          " in 
        assert_raises (Empty) err_fun);

    "Malformed error 1" >::(fun _ -> 
        let err_fun = fun () -> parse "asdfasdf" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 2" >::(fun _ -> 
        let err_fun = fun () -> parse "asdfasdf af adf asdf " in 
        assert_raises (Malformed) err_fun);

    "Malformed error 3" >::(fun _ -> 
        let err_fun = fun () -> parse "    asdfasdf  d" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 4" >::(fun _ -> 
        let err_fun = fun () -> parse "quit not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 5" >::(fun _ -> 
        let err_fun = fun () -> parse "    quit not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 6" >::(fun _ -> 
        let err_fun = fun () -> parse "roll not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 7" >::(fun _ -> 
        let err_fun = fun () -> parse "    roll not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 8" >::(fun _ -> 
        let err_fun = fun () -> parse "    guess not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 9" >::(fun _ -> 
        let err_fun = fun () -> parse "    question not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 10" >::(fun _ -> 
        let err_fun = fun () -> parse "    score not empty" in 
        assert_raises (Malformed) err_fun);

    "Malformed error 11" >::(fun _ -> 
        let err_fun = fun () -> parse "    inventory not empty" in 
        assert_raises (Malformed) err_fun);

    "quit test 1" >::(fun _ -> assert_equal Quit (parse "quit"));

    "quit test 2" >::(fun _ -> assert_equal Quit (parse " quit"));

    "quit test 3" >::(fun _ -> assert_equal Quit (parse "quit "));

    "quit test 4" >::(fun _ -> assert_equal Quit (parse " quit "));

    "quit test 5" >::(fun _ -> assert_equal Quit (parse "     quit    "));

    "score test 1" >::(fun _ -> assert_equal Score (parse "score"));

    "score test 2" >::(fun _ -> assert_equal Score (parse " score"));

    "score test 3" >::(fun _ -> assert_equal Score (parse "score "));

    "score test 4" >::(fun _ -> assert_equal Score (parse " score "));

    "score test 5" >::(fun _ -> assert_equal Score (parse "     score    "));

    "question test" >::(fun _ -> assert_equal Question (parse "question"));

    "guess test" >::(fun _ -> assert_equal Guess (parse "guess"));

    "roll test" >::(fun _ -> assert_equal Roll (parse "roll"));

    "inventory test" >::(fun _ -> assert_equal Inventory (parse "inventory"));

    "buy test" >::(fun _ -> assert_equal (Buy) (parse "buy"));
  ]

let string_list = ["Hi"; "Bye"]
let state_tests = [
  "make_order_test" >::(fun _ -> assert_equal ([1;2;3;4;5])(make_order 5 []));
]

let tests =
  "test suite for A5"  >::: List.flatten [
    command_tests;
    state_tests;
  ]

let _ = run_test_tt_main tests