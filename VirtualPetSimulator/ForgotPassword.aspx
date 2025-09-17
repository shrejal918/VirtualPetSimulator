<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="VirtualPetSimulator.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>🐾 Virtual Pet Simulator - Forgot Password</title>
    <link rel="stylesheet" href="style.css" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
            height: 100vh;
            margin: 0;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Background Pets */
        .pet-bg {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .pet {
            position: absolute;
            width: 80px;
            animation-timing-function: linear;
            opacity: 0.8;
        }

        .pet-run { bottom: 15%; animation: runRight 8s infinite; }
        .pet-run-reverse { bottom: 30%; animation: runLeft 10s infinite; }

        @keyframes runRight {
            0% { left: -100px; }
            100% { left: 110%; }
        }
        @keyframes runLeft {
            0% { right: -100px; transform: scaleX(-1); }
            100% { right: 110%; transform: scaleX(-1); }
        }

        /* Container */
        .forgot-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            width: 350px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        .forgot-container h1 {
            margin-bottom: 10px;
            font-size: 24px;
            color: #333;
        }

        .forgot-container p {
            color: #666;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: border 0.3s ease;
        }

        .input-group input:focus {
            border-color: #ff7e5f;
        }

        .btn {
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            border: none;
            padding: 12px;
            width: 100%;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .btn:hover { transform: scale(1.03); }

        .links {
            margin-top: 15px;
            font-size: 14px;
        }
        .links a {
            color: #ff7e5f;
            font-weight: bold;
            text-decoration: none;
        }

        .pet-emoji {
            font-size: 40px;
            animation: bounce 1.5s infinite;
            margin-bottom: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }
    </style>
</head>
<body>
    <!-- Background Pets -->
    <div class="pet-bg">
        <img src="images/dog-run.gif" class="pet pet-run" style="animation-delay: 0s;" />
        <img src="images/cat-run.gif" class="pet pet-run-reverse" style="animation-delay: 2s;" />
    </div>

    <form id="form1" runat="server">
        <div class="forgot-container">
            <div class="pet-emoji">🔑</div>
            <h1>Forgot Password</h1>
            <p>Enter your email to reset your password</p>

            <div class="input-group">
                <input type="email" id="resetEmail" placeholder="Your Email" required />
                <i class="fas fa-envelope"></i>
            </div>

            <button type="button" class="btn" id="btnSendReset">Send Reset Link</button>

            <div class="links">
                <p><a href="Login.aspx">⬅ Back to Login</a></p>
            </div>
        </div>
    </form>

    <!-- Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
    <script type="module" src="firebaseauth.js"></script>
</body>
</html>