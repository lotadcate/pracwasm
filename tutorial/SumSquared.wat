(module
  (func (export "SumSquared") (param $v1 i32) (param $v2 i32)
   (result i32)
   (local $sum i32)
 
   (i32.add (local.get $v1) (local.get $v2)) ;; push to stack
   local.set $sum ;; pop from stack

   (i32.mul (local.get $sum) (local.get $sum)) 
  )
)
