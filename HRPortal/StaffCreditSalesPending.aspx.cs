using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class StaffCreditSalesPending : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void generateReport(object sender, EventArgs e, string documentNo)
        {
            //try
            //{
            //    String status = Config.ObjNav2.fnGenerateReport(documentNo);
            //    String[] info = status.Split('*');
            //    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
            //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
            //}
            //catch (Exception t)
            //{
            //    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
        }
    }
}