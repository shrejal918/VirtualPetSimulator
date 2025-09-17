using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VirtualPetSimulator
{
    public partial class SetSession : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string user = Request.QueryString["user"];
            if (!string.IsNullOrEmpty(user))
            {
                Session["UserName"] = user;
            }
            Response.End();
        }
    }
}