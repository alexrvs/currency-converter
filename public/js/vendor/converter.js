let params = null
let element_button = document.getElementById('convert-button');
let exchange_button = document.getElementById('exchange-button');
let update_rates_button = document.getElementById('update-base-rates');

element_button.addEventListener("click", function(e) {
  params = prepareParams();
  sendRequest(params);
}, false);

exchange_button.addEventListener("click", function(e) {
  toSwapCurrencies()
  params = prepareParams();
  sendRequest(params);
}, false);

update_rates_button.addEventListener("click", function(e) {
  const request = new XMLHttpRequest();
  const url = "/currency/rates/update";

  request.responseType =	"json";
  request.open("GET", url, true);
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  request.addEventListener("readystatechange", () => {
    if (request.readyState === 4 && request.status === 200) {
      let obj = request.response;
      responseModify(obj);
    }
  });
  request.send(params);
}, false);





function prepareParams(){
  let from = null;
  let to = null;
  let sum = null;
  let params = null;
  from = document.getElementById('from_currency').value;
  to = getCurrencySymbol(document.getElementById('to_currency'));
  sum = document.getElementById('input_sum').value;
  params = "from=" + from+ "&to=" + to + "&sum="+ sum;
  return params
}

function sendRequest(params){
  const request = new XMLHttpRequest();
  const url = "/convert";

  request.responseType =	"json";
  request.open("POST", url, true);
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  request.addEventListener("readystatechange", () => {
    if (request.readyState === 4 && request.status === 200) {
      let obj = request.response;
      responseModify(obj);
    }
  });
  request.send(params);
}

function getCurrencySymbol(obj) {
  return obj.options[obj.selectedIndex].getAttribute('data-symbol');
}

function responseModify(obj) {
  document.getElementById('output_sum').value = obj.data.result_sum
}

function toSwapCurrencies(){
  console.log('sad');
  from = document.getElementById('from_currency').value
  to = document.getElementById('to_currency').value
  selectSwapping('from_currency', to)
  selectSwapping('to_currency', from)
}

function selectSwapping(selectId, optionValToSelect){
  var selectElement = document.getElementById(selectId);
  var selectOptions = selectElement.options;
  for (var opt, j = 0; opt = selectOptions[j]; j++) {
    if (opt.value == optionValToSelect) {
      selectElement.selectedIndex = j;
      break;
    }
  }
}