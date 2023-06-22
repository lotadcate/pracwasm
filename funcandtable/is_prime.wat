(module
  (func $even_check (param $n i32) (result i32)
    local.get $n
    i32.const 2
    i32.rem_u     ;; $n%2
    i32.const 0
    i32.eq        ;; compare $n%2 and 0 
  )

  (func $eq_2 (param $n i32) (result $i32)
    local.get $n
    i32.const 2
    i32.eq        ;; if $n==2 return 1  
  )

  (func $is_prime (export "is_prime") (param $n i32) (result i32)
    i32.const 0
)
