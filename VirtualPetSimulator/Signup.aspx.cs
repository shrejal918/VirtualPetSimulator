using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VirtualPetSimulator
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }
        protected void btnGoLogin_Click(object sender, EventArgs e)
        {
            // Redirect user to Login page when they click "Login" button
            Response.Redirect("Login.aspx");
        }
    }
}