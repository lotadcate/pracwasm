const fs =  require('fs');
const bytes = fs.readFileSync(__dirname + '/SumSquared.wasm');
const v1 = parseInt(process.argv[2]);
const v2 = parseInt(process.argv[3]);

(async () => {
  const obj = await WebAssembly.instantiate(new Uint8Array(bytes));
  let sum_sq = obj.instance.exports.SumSquared(v1, v2);
  console.log(`(${v1} + ${v2}) * (${v1} + ${v2}) = ${sum_sq}`);
})();
