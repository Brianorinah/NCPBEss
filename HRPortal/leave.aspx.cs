using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class leave : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
          var nav = new Config().ReturnNav();

            if (!IsPostBack)
            {
               
            }
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tLeaveNo = leavNoToApprove.Text.Trim();
                String status = Config.ObjNav2.sendLeaveApplicationApproval(tLeaveNo);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void cancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tLeaveNo = cancelLeaveNo.Text.Trim();
                //String status = Config.ObjNav.CanceLeaveApproval((String)Session["employeeNo"], tLeaveNo);
                //String[] info = status.Split('*');
                //feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                //                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                        "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

    }
}