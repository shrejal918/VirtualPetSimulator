import { initializeApp } from "https://www.gstatic.com/firebasejs/10.5.0/firebase-app.js";
import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } from "https://www.gstatic.com/firebasejs/10.5.0/firebase-auth.js";
import { getFirestore, setDoc, doc } from "https://www.gstatic.com/firebasejs/10.5.0/firebase-firestore.js"
import { sendPasswordResetEmail } from "https://www.gstatic.com/firebasejs/10.5.1/firebase-auth.js";

// Firebase config
const firebaseConfig = {
    apiKey: "AIzaSyAnhIfNKDd8ntss6nSvOHzsUpI1b2cGs9U",
    authDomain: "virtual-pet-simulator-a76d1.firebaseapp.com",
    projectId: "virtual-pet-simulator-a76d1",
    storageBucket: "virtual-pet-simulator-a76d1.appspot.com",
    messagingSenderId: "183913703757",
    appId: "1:183913703757:web:403f1866134add37ffaf04"
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);

// ==========================
// SIGN UP LOGIC
// ==========================
document.getElementById("submitSignUp")?.addEventListener("click", async () => {
    const fName = document.getElementById("fName").value.trim();
    const lName = document.getElementById("lName").value.trim();
    const email = document.getElementById("rEmail").value.trim();
    const password = document.getElementById("rPassword").value.trim();

    if (!firstName || !lastName || !email || !password) {
        alert("⚠️ Please fill in all fields.");
        return;
    }

    try {
        const userCredential = await createUserWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;

        // Store user in Firestore with default pet data
        await setDoc(doc(db, "users", user.uid), {
            firstName: fName,
            lastName: lName,
            email: email,
            xp: 0,
            hunger: 50,
            happiness: 70,
            energy: 80,
            achievements: [],
            createdAt: new Date(),
            pets: [] // empty array for now, you can store pet data later
        });

        alert("✅ Signup successful! Redirecting...");
        // Redirect to your game page
        window.location.href = "GameDog.aspx";

    } catch (error) {
        console.error("Signup Error:", error.message);
        alert("❌ " + error.message);
    }
});

// ==========================
// LOGIN LOGIC
// ==========================
document.getElementById("submitSignIn")?.addEventListener("click", async () => {
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value.trim();

    if (!email || !password) {
        alert("⚠️ Please enter email and password.");
        return;
    }

    try {
        // Sign in with Firebase Authentication
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;

        alert("✅ Login successful! Redirecting...");
        window.location.href = "GameDog.aspx";

    } catch (error) {
        console.error("Login Error:", error.message);
        alert("❌ " + error.message);
    }
});

// Forgot Password Page
document.getElementById("btnSendReset")?.addEventListener("click", async () => {
    const email = document.getElementById("resetEmail").value.trim();

    if (!email) {
        alert("⚠️ Please enter your email.");
        return;
    }

    try {
        await sendPasswordResetEmail(auth, email);
        alert("📩 Reset email sent! Please check your inbox.");
        window.location.href = "Login.aspx";
    } catch (error) {
        console.error("Reset Error:", error.message);
        alert("❌ " + error.message);
    }
});