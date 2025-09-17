<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VirtualPetSimulator.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome - Virtual Pet Simulator</title>
    <link href="Content/styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="home-container">
            <h1>🐾 Welcome to Virtual Pet Simulator 🐾</h1>
            <p>Please enter your name to begin:</p>
            <asp:TextBox ID="txtName" runat="server" CssClass="textbox" placeholder="Your name..."></asp:TextBox><br /><br />
            <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="button" OnClick="btnContinue_Click" />
        </div>
    </form>

    <!-- 🔄 Set Session["UserName"] from localStorage (after login/signup) -->
    <script>
        const storedName = localStorage.getItem("userName") || "Guest";
        if (storedName && storedName !== "Guest") {
            fetch("SetSession.aspx?user=" + encodeURIComponent(storedName));
        }
    </script>
</body>
</html>

