<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameDog.aspx.cs" Inherits="VirtualPetSimulator.Game" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Virtual Pet</title>
    <link href="Content/styles.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f9f9f9;
            transition: background-color 0.4s ease;
        }
        body.night-mode {
            background-color: #1a1a1a;
            color: white;
        }

        .container {
            text-align: center;
            margin-top: 40px;
            font-family: 'Segoe UI', sans-serif;
            padding: 30px;
            border-radius: 12px;
            background-color: white;
            color: black;
            transition: all 0.4s ease;
        }

        body.night-mode .container {
            background-color: black;
            color: white;
        }

        .pet-area {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #skyEffectContainer {
            position: absolute;
            top: 0;
            left: 10px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 5;
        }

        .sky-effect {
            font-size: 50px;
            pointer-events: none;
        }

        .sun {
            color: gold;
            text-shadow: 0 0 12px gold;
            animation: sunSpin 6s linear infinite, sunGlow 3s ease-in-out infinite;
        }

        .moon {
            color: #ccc;
            text-shadow: 0 0 10px white;
            animation: moonFloat 4s ease-in-out infinite;
        }

        .star {
            color: white;
            font-size: 32px;
            animation: starTwinkle 2s ease-in-out infinite;
        }

        @keyframes sunSpin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        @keyframes sunGlow { 0%,100% { text-shadow: 0 0 5px gold; } 50% { text-shadow: 0 0 20px orange; } }
        @keyframes moonFloat { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-6px); } }
        @keyframes starTwinkle { 0%,100% { opacity: 0.2; transform: scale(0.8); } 50% { opacity: 1; transform: scale(1.2); } }

        .pet-img {
            width: 150px;
            height: 150px;
            transition: transform 0.3s ease;
        }

        .pet-look-day { transform: rotate(-10deg) scale(1.05); }
        .pet-look-night { transform: rotate(10deg) scale(1.05); }

        .status-bars {
            width: 60%;
            margin: 20px auto;
        }

        .status label { display: block; margin: 8px 0 2px; }

        progress {
            width: 100%;
            height: 20px;
            border-radius: 10px;
            background-color: #eee;
        }

        .bar-red::-webkit-progress-value { background-color: #e53935; }
        .bar-yellow::-webkit-progress-value { background-color: #fdd835; }
        .bar-green::-webkit-progress-value { background-color: #43a047; }
        .bar-red::-moz-progress-bar { background-color: #e53935; }
        .bar-yellow::-moz-progress-bar { background-color: #fdd835; }
        .bar-green::-moz-progress-bar { background-color: #43a047; }

        .controls { margin-top: 30px; }

        .controls button {
            margin: 8px;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            background-color: #4caf50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .controls button:hover { background-color: #388e3c; }

        .mood {
            font-size: 22px;
            margin-top: 10px;
        }

        #xpLevel {
            display: block;
            margin-top: 5px;
            font-weight: bold;
        }

        .achievements {
            margin-top: 30px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            background: #f0f0f0;
            padding: 15px;
            border-radius: 10px;
            text-align: left;
        }

        body.night-mode .achievements {
            background-color: #222;
            color: white;
        }

        .achievements li::before {
            content: "🏆 ";
            margin-right: 6px;
        }
        .unlocked {
    color: green;
    font-weight: bold;
}

    </style>
  <script type="module" src="Scripts/FirebaseAutht.js" defer> </script>
    <script>
        window.onload = function () {
            const storedName = localStorage.getItem("userName");
            if (storedName) {
                fetch("SetSession.aspx?user=" + encodeURIComponent(storedName));
            }
        };
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <audio id="bgMusic" autoplay loop>
    <source src="Assets/Sounds/1_sound.mp3" type="audio/mpeg" />
    Your browser does not support the audio element.
</audio>

<button type="button" onclick="toggleMusic()" id="musicBtn">🔊 Mute</button>

        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container">
            <h1>Hello <%= Session["UserName"] %>! Meet your <%= Session["PetName"] %> named <%= Session["CustomPetName"] %> 🐾</h1>
            <button type="button" onclick="toggleTheme()" id="themeToggle">🌞 Day Mode</button>

            <div class="pet-area">
                <asp:Image ID="petImage" runat="server" CssClass="pet-img" />
                <div id="skyEffectContainer"></div>
                <p class="mood"><%= Session["PetMood"] %></p>
            </div>

            <div class="status-bars">
                <div class="status"><label>Hunger</label><progress id="hungerBar" value="0" max="100"></progress></div>
                <div class="status"><label>Happiness</label><progress id="happinessBar" value="0" max="100"></progress></div>
                <div class="status"><label>Energy</label><progress id="energyBar" value="0" max="100"></progress></div>
                <div class="status" id="xpStatus">
    <label>XP</label>
    <progress id="xpBar" value="0" max="100" class="bar-green"></progress>
    <span id="xpLevel">Level 1</span>
</div>

            </div>

            <asp:HiddenField ID="hdnHunger" runat="server" />
            <asp:HiddenField ID="hdnHappiness" runat="server" />
            <asp:HiddenField ID="hdnEnergy" runat="server" />
            <asp:HiddenField ID="hdnXP" runat="server" />

            <div class="controls">
               <asp:Button ID="btnFeed" runat="server" Text="🍎 Feed" OnClick="btnFeed_Click" OnClientClick="playFeedAnimation();" />
<asp:Button ID="btnPlay" runat="server" Text="⚽ Play" OnClick="btnPlay_Click" OnClientClick="playPlayAnimation();" />
<asp:Button ID="btnSleep" runat="server" Text="💤 Sleep" OnClick="btnSleep_Click" OnClientClick="playSleepAnimation();" />

            </div>

          <div class="achievements">
    <h3>Achievements</h3>
    <ul id="achievementList">
        <li data-key="fed10">🍎 Fed 10 times!</li>
        <li data-key="play10">⚽ Played 10 times!</li>
        <li data-key="sleep10">💤 Slept 10 times!</li>
        <li data-key="level5">🎯 Reached Level 5!</li>
        <li data-key="level10">🎯 Reached Level 10!</li>
        <li data-key="xp100">📈 XP Maxed Out (100 XP)!</li>
        <li data-key="perfectMood">😊 Perfect Mood Maintained for 5 Rounds</li>
        <li data-key="noHunger80">🍽 Never Let Hunger Exceed 80!</li>
        <li data-key="highEnergy3">⚡ Kept Energy Above 70 for 3 Games</li>
        <li data-key="nightUsed">🌙 Used Night Mode!</li>
        <li data-key="theme10">🌓 Used Day/Night Mode 10 Times!</li>
        <li data-key="allButtons">🕹 Used All 3 Buttons (Feed, Play, Sleep)</li>
        <li data-key="play5min">⏱ Played for 5 minutes!</li>
        <li data-key="theme5">🌗 Switched Theme 5 times!</li>
    </ul>
</div>

</div>

        </div>
    </form>

    <script>
        let xp = 0, level = 1, isNight = false;
        let playCount = 0, feedCount = 0, sleepCount = 0;
        let themeSwitches = 0;
        let minutesPlayed = 0;
        let perfectMoodCount = 0;
        let highEnergyRounds = 0;
        let maxHungerNeverExceeded = true;
        let usedAllButtons = { feed: false, play: false, sleep: false };

        // Timer to track time played
        setInterval(() => {
            minutesPlayed++;
            checkAchievements();
        }, 60000);

        let decayInterval = setInterval(() => {
            decayStats();
        }, 30000); // every 30 seconds


        function toggleTheme() {
            isNight = !isNight;
            themeSwitches++;

            document.body.classList.toggle("night-mode", isNight);
            document.getElementById("themeToggle").innerText = isNight ? "🌙 Night Mode" : "🌞 Day Mode";

            const sky = document.getElementById("skyEffectContainer");
            const petImg = document.getElementById('<%= petImage.ClientID %>');
            sky.innerHTML = "";
            petImg.classList.remove("pet-look-day", "pet-look-night");

            if (isNight) {
                petImg.classList.add("pet-look-night");
                const moon = document.createElement("span");
                moon.className = "sky-effect moon";
                moon.innerText = "🌙";
                sky.appendChild(moon);
                setTimeout(() => {
                    const star = document.createElement("span");
                    star.className = "sky-effect star";
                    star.innerText = "⭐";
                    sky.appendChild(star);
                }, 3000);
            } else {
                petImg.classList.add("pet-look-day");
                const sun = document.createElement("span");
                sun.className = "sky-effect sun";
                sun.innerText = "🌞";
                sky.appendChild(sun);
            }

            checkAchievements();
        }

        function addXP(points) {
            xp += points;
            if (xp >= 100) {
                xp = 0;
                level++;
                alert("🎉 Leveled up to Level " + level + "!");
            }

            document.getElementById("xpBar").value = xp;
            document.getElementById("xpLevel").innerText = "Level " + level;
            checkAchievements();
        }

        function animateProgressBar(id, targetValue) {
            const bar = document.getElementById(id);
            const current = parseInt(bar.value) || 0;
            const step = (targetValue - current) / 20;
            let value = current;

            clearClass(bar);
            bar.classList.add(getBarColorClass(targetValue));

            const interval = setInterval(() => {
                value += step;
                if ((step > 0 && value >= targetValue) || (step < 0 && value <= targetValue)) {
                    value = targetValue;
                    clearInterval(interval);
                }
                bar.value = Math.round(value);
            }, 20);
        }

        function clearClass(bar) {
            bar.classList.remove("bar-red", "bar-yellow", "bar-green");
        }

        function getBarColorClass(val) {
            if (val < 40) return "bar-red";
            if (val < 70) return "bar-yellow";
            return "bar-green";
        }

        function updateBarsFromHidden() {
            const hunger = parseInt(document.getElementById("<%= hdnHunger.ClientID %>").value) || 0;
            const happiness = parseInt(document.getElementById("<%= hdnHappiness.ClientID %>").value) || 0;
    const energy = parseInt(document.getElementById("<%= hdnEnergy.ClientID %>").value) || 0;
            const xpVal = parseInt(document.getElementById("<%= hdnXP.ClientID %>").value) || 0;

            animateProgressBar("hungerBar", hunger);
            animateProgressBar("happinessBar", happiness);
            animateProgressBar("energyBar", energy);
            animateProgressBar("xpBar", xpVal);

            xp = xpVal;
            level = Math.floor(xp / 100) + 1;

            // 🔧 Ensure XP and level display updates!
            const levelElem = document.getElementById("xpLevel");
            if (levelElem) {
                levelElem.innerText = "Level " + level;
            }

            const xpBarElem = document.getElementById("xpBar");
            if (xpBarElem) {
                xpBarElem.value = xp;
            }

            // Mood & achievements tracking
            const mood = document.querySelector(".mood").innerText;
            if (mood.includes("😊")) perfectMoodCount++;

            if (hunger > 80) maxHungerNeverExceeded = false;
            if (energy > 70) highEnergyRounds++;

            checkAchievements();
        }


        function playFeedAnimation() {
            const pet = '<%= Session["PetName"] %>';
            const img = document.getElementById('<%= petImage.ClientID %>');

            // 🛠 Remove tilt during animation
            img.classList.remove("pet-look-day", "pet-look-night");
            img.src = `Images/pets/${pet}/eat/dog_eat.gif`;

            setTimeout(() => {
                img.src = `Images/pets/${pet}/idle_1.png`;

                // 💡 Restore tilt based on theme
                if (isNight) img.classList.add("pet-look-night");
                else img.classList.add("pet-look-day");

                __doPostBack('<%= btnFeed.UniqueID %>', '');
    }, 3500);
        }

        function playPlayAnimation() {
            const pet = '<%= Session["PetName"] %>';
    const img = document.getElementById('<%= petImage.ClientID %>');

    // 🛠 Remove tilt during animation
    img.classList.remove("pet-look-day", "pet-look-night");
    img.src = `Images/pets/${pet}/play/dog_play.gif`;

    setTimeout(() => {
        img.src = `Images/pets/${pet}/idle_1.png`;

        // 💡 Restore tilt based on theme
        if (isNight) img.classList.add("pet-look-night");
        else img.classList.add("pet-look-day");

        __doPostBack('<%= btnPlay.UniqueID %>', '');
    }, 3500);
}

function playSleepAnimation() {
    const pet = '<%= Session["PetName"] %>';
    const img = document.getElementById('<%= petImage.ClientID %>');

    // 🛠 Remove tilt during animation
    img.classList.remove("pet-look-day", "pet-look-night");
    img.src = `Images/pets/${pet}/sleep/dog_sleep.gif`;

    setTimeout(() => {
        img.src = `Images/pets/${pet}/idle_1.png`;

        // 💡 Restore tilt based on theme
        if (isNight) img.classList.add("pet-look-night");
        else img.classList.add("pet-look-day");

        __doPostBack('<%= btnSleep.UniqueID %>', '');
    }, 3500);
        }

        function checkAllButtonsUsed() {
            if (usedAllButtons.feed && usedAllButtons.play && usedAllButtons.sleep) {
                unlockAchievement("🏆 Used All 3 Buttons (Feed, Play, Sleep)");
            }
        }

        function checkAchievements() {
            if (feedCount >= 10) unlockAchievement("fed10");
            if (playCount >= 10) unlockAchievement("play10");
            if (sleepCount >= 10) unlockAchievement("sleep10");
            if (level >= 5) unlockAchievement("level5");
            if (level >= 10) unlockAchievement("level10");
            if (xp >= 100) unlockAchievement("xp100");
            if (perfectMoodCount >= 5) unlockAchievement("perfectMood");
            if (maxHungerNeverExceeded) unlockAchievement("noHunger80");
            if (highEnergyRounds >= 3) unlockAchievement("highEnergy3");
            if (themeSwitches >= 1) unlockAchievement("nightUsed");
            if (themeSwitches >= 10) unlockAchievement("theme10");
            if (themeSwitches >= 5) unlockAchievement("theme5");
            if (usedAllButtons.feed && usedAllButtons.play && usedAllButtons.sleep)
                unlockAchievement("allButtons");
            if (minutesPlayed >= 5) unlockAchievement("play5min");
        }


        function unlockAchievement(key) {
            const item = document.querySelector(`li[data-key="${key}"]`);
            if (item && !item.classList.contains("unlocked")) {
                item.classList.add("unlocked");
                item.innerHTML += " ✅"; // or use ✔ Completed
            }
        }

        function toggleMusic() {
            const audio = document.getElementById("bgMusic");
            const btn = document.getElementById("musicBtn");
            if (audio.paused) {
                audio.play();
                btn.innerText = "🔊 Mute";
            } else {
                audio.pause();
                btn.innerText = "🔇 Unmute";
            }
        }

        function decayStats() {
            let hunger = parseInt(document.getElementById("hungerBar").value);
            let happiness = parseInt(document.getElementById("happinessBar").value);
            let energy = parseInt(document.getElementById("energyBar").value);

            // Decrease stats slightly
            hunger = Math.max(0, hunger - 2);
            happiness = Math.max(0, happiness - 3);
            energy = Math.max(0, energy - 2);

            // Update progress bars
            animateProgressBar("hungerBar", hunger);
            animateProgressBar("happinessBar", happiness);
            animateProgressBar("energyBar", energy);

            // Also sync back to hidden fields to persist across server actions
            document.getElementById("<%= hdnHunger.ClientID %>").value = hunger;
            document.getElementById("<%= hdnHappiness.ClientID %>").value = happiness;
            document.getElementById("<%= hdnEnergy.ClientID %>").value = energy;

            // Update mood indicator if needed
            updateMoodFromStats(hunger, happiness, energy);
        }

        function updateMoodFromStats(hunger, happiness, energy) {
            let moodText = "😊 Happy";
            if (hunger > 80) moodText = "😡 Hungry";
            else if (happiness < 40) moodText = "😢 Sad";
            else if (energy < 30) moodText = "😴 Tired";

            document.querySelector(".mood").innerText = moodText;
        }



        window.onload = updateBarsFromHidden;
    </script>
   
</body>
</html>
