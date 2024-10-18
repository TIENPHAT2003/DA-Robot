function updatePosition(joint) {
    const inputValue = document.getElementById(`${joint}`).value;
    const sliderValue = document.getElementById(`${joint}-slider`).value;
    document.getElementById(`${joint}-value`).textContent = inputValue;
    document.getElementById(`${joint}-slider`).value = inputValue;
    document.getElementById(`${joint}`).value = sliderValue;
}