/**onAppear() - adds a fade in effect to the element provided.
//Arguments:
//el - the element to apply the fadein to.
i - the duration of the effect.**/
function onAppear(el, i) {
    setTimeout(() => {
        el.classList.add("fadeIn");
        setTimeout(() => {
            el.style.opacity = 1;
            el.classList.remove("fadeIn");
        }, 500);
    }, i * 50);
}
/**onAppear() - adds a fade out effect to the element provided.
Arguments:
el - the element to apply the fadein to.
i - the duration of the effect.
removeElement - the remove function to perform**/
function onExit(el, i, removeElement) {
    setTimeout(() => {
        el.classList.add("fadeOut");
        setTimeout(removeElement, 500);
    }, i * 50);
}