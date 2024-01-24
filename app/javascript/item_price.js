// 販売手数料や販売利益を計算して表示する関数
const updatePrices = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");
 
  if (!priceInput || !addTaxDom || !profitDom) {
   return; // 要素が存在しない場合は処理を中断
  }
 
  const inputValue = parseFloat(priceInput.value) || 0;
 
  const commissionFee = Math.floor(inputValue * 0.1);
  const profit = inputValue - commissionFee;
 
  addTaxDom.innerHTML = commissionFee.toLocaleString();
  profitDom.innerHTML = profit.toLocaleString();
 };
 
 // turbo:load イベント発生時に実行
 window.addEventListener('turbo:load', () => {
  // 販売手数料や販売利益を計算して表示
  updatePrices();
 
  // item-price の入力が変更された場合も再計算して表示
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
   priceInput.addEventListener("input", updatePrices);
  }
 });
 
 // turbo:render イベント発生時にも実行
 window.addEventListener('turbo:render', () => {
  // 販売手数料や販売利益を計算して表示
  updatePrices();
 });
 
 // turbo:submit イベント発生時にも実行
 window.addEventListener('turbo:submit', () => {
  // 販売手数料や販売利益を計算して表示
  updatePrices();
 });
 
 // turbo:error イベント発生時にも実行
 window.addEventListener('turbo:error', () => {
  // 販売手数料や販売利益を計算して表示
  updatePrices();
 });
 
 // 一定間隔で updatePrices() 関数を実行
 setInterval(updatePrices, 100);