﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class AppraisalTemplate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    String appNo = Request.QueryString["applicationNo"];
                    String empNo = Convert.ToString(Session["employeeNo"]);

                    String status = Config.ObjNav2.generateAppraisalTemplate(appNo, empNo);

                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        appraisalFrame.Attributes.Add("src", ResolveUrl(info[2]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + ex.Message + "</div>";
                }
            }
        }
    }
}