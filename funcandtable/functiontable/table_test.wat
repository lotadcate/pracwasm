(module
  (import "js" "tbl" (table $table 4 anyfunc)) ;; import from table_export.wat
  (import "js" "increment" (func $increment (result i32)))
  (import "js" "decrement" (func $decrement (result i32)))
  (import "js" "wasm_increment" (func $wasm_increment (result i32)))
  (import "js" "wasm_decrement" (func $wasm_decrement (result i32)))

  (type $returns_i32 (func (result i32))) ;; type is needed for table calling f
 
  ;; indecies for func table
  (global $inc_ptr i32 (i32.const 0))
  (global $dec_ptr i32 (i32.const 0))
  (global $wasm_inc_ptr i32 (i32.const 0))
  (global $wasm_dec_ptr i32 (i32.const 0))

  ;; test codes

  (func (export "js_table_test")
    (loop $inc_cycle
      (call_indirect (type $returns_i32) (global.get $inc_ptr))
      i32.const 4_000_000
      i32.le_u
      br_if $inc_cycle
    )

    (loop $dec_cycle
      (call_indirect (type $returns_i32) (global.get $dec_ptr))
      i32.const 4_000_000
      i32.le_u
      br_if $dec_cycle
    ) 
  )

  (func (export "js_import_test")
    (loop $inc_cycle
      call $increment
      i32.const 4_000_000
      i32.le_u
      br_if $inc_cycle        
    )     
          
    (loop $dec_cycle
      call $decrement
      i32.const 4_000_000
      i32.le_u
      br_if $dec_cycle 
    )
  ) 

  (func (export "wasm_table_test")
    (loop $inc_cycle
      (call_indirect (type $returns_i32) (global.get $wasm_inc_ptr))
      i32.const 4_000_000
      i32.le_u
      br_if $inc_cycle   
    )    

    (loop $dec_cycle
      (call_indirect (type $returns_i32) (global.get $wasm_dec_ptr))
      i32.const 4_000_000
      i32.le_u
      br_if $dec_cycle
    )
  )

  (func (export "wasm_import_test")
    (loop $inc_cycle 
      call $wasm_increment
      i32.const 4_000_000
      i32.le_u
      br_if $inc_cycle
    )     
          
    (loop $dec_cycle
      call $wasm_decrement
      i32.const 4_000_000
      i32.le_u
      br_if $dec_cycle
    )
  )
)
