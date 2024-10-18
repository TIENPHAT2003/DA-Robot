function updateJointAngle(joint) {
    const inputValue = document.getElementById(`${joint}`).value;
    const sliderValue = document.getElementById(`${joint}-slider`).value;
    document.getElementById(`${joint}-value`).textContent = inputValue;
    document.getElementById(`${joint}-slider`).value = inputValue;
    document.getElementById(`${joint}`).value = sliderValue;
}

function calculateForwardKinematics() {
    const theta1 = parseFloat(document.getElementById('theta1').value);
    const theta2 = parseFloat(document.getElementById('theta2').value);
    const theta3 = parseFloat(document.getElementById('theta3').value);
    const theta4 = parseFloat(document.getElementById('theta4').value);

    // document.getElementById('px').value = px.toFixed(1);
    // document.getElementById('py').value = py.toFixed(1);
    // document.getElementById('pz').value = pz.toFixed(1);
}
document.getElementById('theta1FK').onblur = function(){
    document.getElementById("theta1FK-value").innerHTML = document.getElementById("theta1FK").value;
    updateJointAngle('theta1FK');
}
document.getElementById('theta2FK').onblur = function(){
    document.getElementById("theta2FK-value").innerHTML = document.getElementById("theta2FK").value;
    updateJointAngle('theta2FK');
}
document.getElementById('theta3').onblur = function(){
    document.getElementById("theta3FK-value").innerHTML = document.getElementById("theta3FK").value;
    updateJointAngle('theta3FK');
}
document.getElementById('theta4').onblur = function(){
    document.getElementById("theta4FK-value").innerHTML = document.getElementById("theta4FK").value;
    updateJointAngle('theta4FK');
}