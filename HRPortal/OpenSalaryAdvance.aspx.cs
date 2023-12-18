using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OpenSalaryAdvance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 14;
        }

        protected void SendApproval_Click(object sender, EventArgs e)
        {
            try
            {
            //    String SalaryAdvanceNo = salaryAdvanceToApprove.Text.Trim();
            //    String status = Config.ObjNav.SendSalaryAdvanceApproval(Convert.ToString(Session["employeeNo"]), SalaryAdvanceNo);
            //    String[] info = status.Split('*');
            //    salaryadvancefeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                salaryadvancefeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void CancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = cancelSalaryAdvanceNo.Text.Trim();
                //String status = Config.ObjNav.CancelSalaryAdvanceApproval((String)Session["employeeNo"], tDocumentNo);
                //String[] info = status.Split('*');
                //salaryadvancefeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                //                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                salaryadvancefeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}