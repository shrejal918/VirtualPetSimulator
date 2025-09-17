using System;
using System.Web.UI;

namespace VirtualPetSimulator
{
    public partial class Game : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session validation
            if (Session["UserName"] == null)
            {
                string userName = Request.QueryString["user"] ?? "";
                if (!string.IsNullOrEmpty(userName))
                {
                    Session["UserName"] = userName;
                }
                else
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
            }

            // Still check pet selection after login
            if (Session["PetName"] == null || Session["CustomPetName"] == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Initialize stats if null
                if (Session["Hunger"] == null) Session["Hunger"] = 50;
                if (Session["Happiness"] == null) Session["Happiness"] = 70;
                if (Session["Energy"] == null) Session["Energy"] = 80;
                if (Session["XP"] == null) Session["XP"] = 0;

                SetPetImage();
            }

            // Update progress bars and mood
            UpdatePetState();
        }

        protected void btnFeed_Click(object sender, EventArgs e)
        {
            Session["Hunger"] = 80;
            Session["Happiness"] = 60;
            Session["Energy"] = 40;
            Session["XP"] = (int)Session["XP"] + 10;

            UpdatePetState();
        }

        protected void btnPlay_Click(object sender, EventArgs e)
        {
            Session["Hunger"] = 40;
            Session["Happiness"] = 80;
            Session["Energy"] = 60;
            Session["XP"] = (int)Session["XP"] + 10;

            UpdatePetState();
        }

        protected void btnSleep_Click(object sender, EventArgs e)
        {
            Session["Hunger"] = 60;
            Session["Happiness"] = 50;
            Session["Energy"] = 90;
            Session["XP"] = (int)Session["XP"] + 10;

            UpdatePetState();
        }

        private void UpdatePetState()
        {
            // Update hidden fields to reflect server-side values
            hdnHunger.Value = Session["Hunger"].ToString();
            hdnHappiness.Value = Session["Happiness"].ToString();
            hdnEnergy.Value = Session["Energy"].ToString();
            hdnXP.Value = Session["XP"].ToString();

            // Determine pet mood
            int hunger = (int)Session["Hunger"];
            int happiness = (int)Session["Happiness"];
            int energy = (int)Session["Energy"];

            string mood = "😊 Happy";
            if (hunger > 80)
                mood = "😡 Hungry";
            else if (happiness < 40)
                mood = "😢 Sad";
            else if (energy < 30)
                mood = "😴 Tired";

            Session["PetMood"] = mood;

            // Trigger JavaScript update after postback
            ScriptManager.RegisterStartupScript(this, GetType(), "updateBars", "updateBarsFromHidden();", true);
        }

        private void SetPetImage()
        {
            string pet = Session["PetName"].ToString().ToLower();
            petImage.ImageUrl = $"Images/pets/{pet}/idle_1.png";
        }
    }
}
