using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PettyCashHeader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        
        protected void cancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String docNo = cancelPettyCashNo.Text;


                String status = Config.ObjNav.CancelPettyCashRequestApproval(Convert.ToString(Session["employeeNo"]), docNo);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String docNo = PettyCashNoToApprove.Text;




                String status = Config.ObjNav.SendPettyCashRequestApproval(Convert.ToString(Session["employeeNo"]), docNo);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}