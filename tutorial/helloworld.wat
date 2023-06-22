(module
  (;
    env is a object imported from the built-in environment
    import print_string, this is a function
    import buffer from env and this is a One-page linear memory
  ;)
  (import "env" "print_string" (func $print_string(param i32)))
  (import "env" "buffer" (memory 1))
  
  ;; add global variables
  (global $start_string (import "env" "start_string") i32)
  (global $string_len i32 (i32.const 12)) 
  
  ;; define a string which is in a linear memory
  (data (global.get $start_string) "hello world!")

  ;; define func helloworld(s: string)
  (func (export "helloworld")
    (call $print_string (global.get $string_len))
  )
)

