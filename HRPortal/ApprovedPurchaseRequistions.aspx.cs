using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ApprovedPurchaseRequistions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void createImprest_Click(object sender, EventArgs e)
        {
            try
            {
                String docNumber = documentNumber.Text.Trim();
                string userName = Convert.ToString(Session["username"]);
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                var nav = Config.ObjNav2;
                String result = nav.createImprestFromPurchase(docNumber, userName, employeeNo);
                String[] safari = result.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + safari[0] + "'>" + safari[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                if (safari[0] == "success")
                {
                    if (safari[0] == "success")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "HideDiv();", true);

                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 2000);", true);
                    }
                }


            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
    }
}