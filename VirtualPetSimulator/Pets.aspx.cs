using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VirtualPetSimulator
{
    public partial class Pets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["pet"] != null)
            {
                string selectedPet = Request.QueryString["pet"];
                Session["PetName"] = selectedPet;
                Response.Redirect("NamePet.aspx");
            }

            if (Session["UserName"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

    }
}