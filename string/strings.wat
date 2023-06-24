(module
 (import "env" "str_pos_len" (func $str_pos_len (param i32 i32)))
 (import "env" "null_str" (func $null_str (param i32)))
 (import "env" "len_prefix" (func $len_prefix (param i32)))

 (import "env" "buffer" (memory 1))

 (data (i32.const 256) "Know the length of this string")
 (data (i32.const 384) "Also know the length of this string")
 (data (i32.const 0) "null-terminating string\00") ;; '\' is escape string
 (data (i32.const 128) "another null-terminating string\00") ;; '\00' is a single-byte that has 0
 (data (i32.const 512) "\16length-prefixed string") ;; 22(16 hex) length
 (data (i32.const 640) "\1eanother length-prefixed string") ;; 30(1e hex) length

 (func $byte_copy (param $source i32) (param $dest i32) (param $len i32)
   (local $last_source_byte i32)
   local.get $source
   local.get $len
   i32.add
   local.set $last_source_byte

   (loop $copy_loop (block $break
     local.get $dest ;; to use i32.store8 calling
     (i32.load8_u (local.get $source)) ;; read 1 byte from $source
     i32.store8 ;; add 1 byte to $dest
     
     local.get $dest
     i32.const 1
     i32.add
     local.set $dest

     local.get $source
     i32.const 1
     i32.add
     local.tee $source

     local.get $last_source_byte
     i32.eq
     br_if $break
     br $copy_loop 
   ))
 )

 (func (export "main")
   (call $null_str (i32.const 0))
   (call $null_str (i32.const 128))

   (call $str_pos_len (i32.const 256) (i32.const 30))
   (call $str_pos_len (i32.const 384) (i32.const 35))
 
   (call $len_prefix (i32.const 512))
   (call $len_prefix (i32.const 640))
 ) 
)
