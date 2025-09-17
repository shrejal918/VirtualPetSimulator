<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pets.aspx.cs" Inherits="VirtualPetSimulator.Pets" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Your Pet</title>
    <link rel="stylesheet" href="Content/styles.css" />
    <script>
        function selectPet(petName) {
            window.location.href = 'Game.aspx?pet=' + petName;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pet-options">
    <a href="Pets.aspx?pet=cat" class="pet-card">
        <img src="Images/pets/cat/idle_1.png" alt="Cat" />
        <p>Cat</p>
    </a>
    <a href="Pets.aspx?pet=dog" class="pet-card">
        <img src="Images/pets/dog/idle_1.png" alt="Dog" />
        <p>Dog</p>
    </a>
    <a href="Pets.aspx?pet=dragon" class="pet-card">
        <img src="Images/pets/dragon/idle_1.png" alt="Dragon" />
        <p>Dragon</p>
    </a>
    <a href="Pets.aspx?pet=penguin" class="pet-card">
        <img src="Images/pets/penguin/idle_1.png" alt="Penguin" />
        <p>Penguin</p>
    </a>
</div>
    </form>
</body>
</html>


