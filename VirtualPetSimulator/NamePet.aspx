<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NamePet.aspx.cs" Inherits="VirtualPetSimulator.NamePet" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Name Your Pet</title>
    <link href="Content/styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="home-container">
            <h1>Hello <%= Session["UserName"] %>!</h1>
            <h2>You chose a <%= Session["PetName"] %> 🐾</h2>
            <p>What would you like to name your pet?</p>
            <asp:TextBox ID="txtPetName" runat="server" CssClass="textbox" placeholder="Pet name..." /><br /><br />
            <asp:Button ID="btnStartGame" runat="server" Text="Start Game" CssClass="button" OnClick="btnStartGame_Click" />
        </div>
    </form>
</body>
</html>

