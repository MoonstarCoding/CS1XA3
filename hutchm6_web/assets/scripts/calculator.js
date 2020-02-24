function insert(input) {
  document.form.textview.value = document.form.textview.value + input;
}

function del() {
  document.form.textview.value = document.form.textview.value.substring(0, document.form.textview.value.length - 1);
}

function clearScreen() {
  document.form.textview.value = "";
}

function equals() {
  if (document.form.textview.value) {
    document.form.textview.value = eval(document.form.textview.value);
  }

}