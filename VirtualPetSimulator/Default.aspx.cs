using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VirtualPetSimulator
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && !string.IsNullOrEmpty(txtName.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showGame", "showGamePanel();", true);
            }
        }
        protected void btnContinue_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtName.Text))
            {
                Session["UserName"] = txtName.Text.Trim();
                Response.Redirect("Pets.aspx");
            }
        }
    }
}