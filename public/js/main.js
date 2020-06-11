alert('asd');
console.log('sad')
let element_button = document.getElementById('convert-button');
element_button.addEventListener("click", function(e) {
  alert('something');
}, false);



//	Данные для передачи на сервер например	id товаров и его количество
let id_product = 321;
let qty_product = 2;

// принцип	тот же самый что и у обычного POST	запроса
const request = new XMLHttpRequest();
const url = "/convert";
const params = "id_product=" + id_product+ "&qty_product=" + qty_product;

//	Здесь нужно указать в каком формате мы будем принимать данные вот и все	отличие
request.responseType =	"json";
request.open("POST", url, true);
request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

request.addEventListener("readystatechange", () => {

  if (request.readyState === 4 && request.status === 200) {
    let obj = request.response;

    console.log(obj);
    // Здесь мы можем обращаться к свойству объекта и получать	его значение
    console.log(obj.id_product);
    console.log(obj.qty_product);
  }
});

request.send(params);