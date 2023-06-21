const fs = require("fs");
const bytes = fs.readFileSync(__dirname + '/AddInt.wasm');
const v1 = parseInt(process.argv[2]);
const v2 = parseInt(process.argv[3]);

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes));
  let add_value = obj.instance.exports.AddInt(v1, v2);
  console.log(add_value);
  console.log(`${v1} + ${v2} = ${add_value}`);
})();
