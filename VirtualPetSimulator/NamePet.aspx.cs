using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VirtualPetSimulator
{
    public partial class NamePet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] == null || Session["PetName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnStartGame_Click(object sender, EventArgs e)
        {
            string customName = txtPetName.Text.Trim();

            if (!string.IsNullOrEmpty(customName))
            {
                Session["CustomPetName"] = customName;
                Response.Redirect("GameDog.aspx");
            }
        }
    }
}