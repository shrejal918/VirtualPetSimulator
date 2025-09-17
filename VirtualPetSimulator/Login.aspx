<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VirtualPetSimulator.Login" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>🐾 Virtual Pet Simulator - Login</title>
    
    <link rel="stylesheet" href="style.css" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #ffecd2, #fcb69f);
            height: 100vh;
            margin: 0;
             overflow: hidden; /* So pets don't scroll bars */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            width: 350px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
            z-index: 10;
            box-sizing: border-box;
            position: relative;
        }

        .login-container h1 {
            margin-bottom: 10px;
            font-size: 26px;
            color: #333;
        }

        .login-container p {
            color: #666;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
             width: 100%;
        box-sizing: border-box; 
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: border 0.3s ease;
             box-sizing: border-box;
        }

        .input-group input:focus {
            border-color: #ff7e5f;
        }

        .input-group i {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            pointer-events: none;
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
             box-sizing: border-box;
        }

        .btn:hover {
            transform: scale(1.03);
        }

        .links {
            margin-top: 15px;
            font-size: 14px;
        }

        .links a {
            color: #ff7e5f;
            text-decoration: none;
            font-weight: bold;
        }

        .pet-emoji {
            font-size: 40px;
            animation: bounce 1.5s infinite;
            margin-bottom: 10px;
        }
        .btn-link {
    background: none;
    border: none;
    color: #ff7e5f;
    font-size: 14px;
    cursor: pointer;
    text-decoration: underline;
    padding: 0;
}

        /* Animations */
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
    
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="pet-emoji">🐶</div>
            <h1>Welcome Back!</h1>
            <p>Log in to continue your pet adventure</p>

            <div class="input-group">
                <input type="email" id="email" placeholder="Email" required />
                <i class="fas fa-envelope"></i>
            </div>

            <div class="input-group">
                <input type="password" id="password" placeholder="Password" required />
                <i class="fas fa-lock"></i>
            </div>

            <button type="button" class="btn" id="submitSignIn">Sign In</button>

           <div class="links">
    <p>Don’t have an account? 
       <a href="Signup.aspx" onclick="event.stopPropagation();">Sign Up</a>
    </p>
    <p>
       <a href="ForgotPassword.aspx" onclick="event.stopPropagation();">Forgot Password?</a>
    </p>
</div>

        </div>
    </form>

    <!-- Font Awesome for icons -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js"></script>
<script type="module" src="firebaseauth.js"></script>

</body>
</html>

