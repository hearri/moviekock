
const list = document.querySelectorAll('.list');
const bar = document.querySelector('#progress-bar');
const countText = document.querySelector('.progress-count');
const submitBtn = document.querySelector('.submit-btn');

function handleBar(){

  bar.value += 1;
  if(bar.value === 10){
    bar.value = 10;
    submitBtn.disabled = false;
  }
  let count = bar.value;
  
  progressCount(count);
}

function progressCount(count){
  countText.innerText = `${count}/10`;
  if(count === 10){
    countText.innerText = 'Complete!!';
  }
}

function addEvent(){
  list.forEach(function(box){
    box.addEventListener('click',handleBar);
  });
}

function init(){
  addEvent();
}



init();