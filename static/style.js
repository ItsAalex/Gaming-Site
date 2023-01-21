
var header = document.getElementById("header");

// Dodaj onscroll funkciju
window.onscroll = function() {
    if(window.pageYOffset > 0) {
        header.classList.add("scrolled");
    }
    else{
        header.classList.remove("scrolled");
    }
};