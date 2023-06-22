(module
  (func $even_check (param $n i32) (result i32)
    local.get $n
    i32.const 2
    i32.rem_u      ;; $n%2
    i32.const 0
    i32.eq         ;; compare $n%2 and 0 
  )

  (func $eq_2 (param $n i32) (result i32)
    local.get $n
    i32.const 2
    i32.eq         ;; if $n==2 return 1  
  )

  (func $multiple_check (param $n i32) (param $m i32) (result i32)
    local.get $n
    local.get $m
    i32.rem_u      ;; $n%$m
    i32.const 0
    i32.eq
  )

  (func $is_prime (export "is_prime") (param $n i32) (result i32)
    (local $i i32) ;; counter 
  
    (if (i32.eq (local.get $n) (i32.const 1))
      (then 
        i32.const 0 ;; false
        return
      ) 
    ) 

    (if (call $eq_2 (local.get $n))
      (then
        i32.const 1 ;; return true because 2 is a prime number
        return
      )
    )
  
    (block $not_prime (call $even_check (local.get $n))
      br_if $not_prime
      (local.set $i (i32.const 1))
      (loop $prime_test_loop
        (local.tee $i (i32.add (local.get $i) (i32.const 2))) ;; inc counter by 2
        local.get $n ;; push to stack

        i32.ge_u
        if 
          i32.const 1
          return
        end

        (call $multiple_check (local.get $n) (local.get $i))

        br_if $not_prime ;; if top of stack is 1, 
        br $prime_test_loop
      )
    )
    
    i32.const 0 ;; false 
  )
)
