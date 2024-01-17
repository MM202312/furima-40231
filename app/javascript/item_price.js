window.addEventListener('turbo:load', () => {
  // 金額を入力した数値をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = parseFloat(priceInput.value) || 0; // 数値以外が入力された場合に備えて parseFloat を使って変換

    // 10%の販売手数料を計算
    const commissionFee = Math.floor(inputValue * 0.1);

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = commissionFee.toLocaleString(); // 3桁ごとにカンマを挿入

    // 利益を計算（item-price から add-tax-price を引く）
    const profit = inputValue - commissionFee;
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = profit.toLocaleString(); // 3桁ごとにカンマを挿入

    console.log(inputValue);
  })
});