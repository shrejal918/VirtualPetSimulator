let hunger = 50;
let happiness = 70;
let energy = 80;

function updateBars() {
    document.getElementById("hungerBar").value = hunger;
    document.getElementById("happinessBar").value = happiness;
    document.getElementById("energyBar").value = energy;

    let mood = "😊 Happy";
    let petImg = "Assets/pet_happy.png";

    if (hunger > 80) {
        mood = "😡 Hungry";
        petImg = "Assets/pet_hungry.png";
    } else if (energy < 30) {
        mood = "😴 Tired";
        petImg = "Assets/pet_sleepy.png";
    } else if (happiness < 40) {
        mood = "😢 Sad";
        petImg = "Assets/pet_sad.png";
    }

    document.getElementById("petMood").textContent = mood;
    document.getElementById("petImage").src = petImg;
}

function feedPet() {
    hunger = Math.max(hunger - 20, 0);
    happiness = Math.min(happiness + 5, 100);
    updateBars();
}

function playWithPet() {
    happiness = Math.min(happiness + 15, 100);
    energy = Math.max(energy - 10, 0);
    updateBars();
}

function putToSleep() {
    energy = Math.min(energy + 30, 100);
    hunger = Math.min(hunger + 10, 100);
    updateBars();
}

setInterval(() => {
    hunger = Math.min(hunger + 2, 100);
    energy = Math.max(energy - 1, 0);
    happiness = Math.max(happiness - 1, 0);
    updateBars();
}, 5000);

window.onload = updateBars;
