﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeSurveyQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void backtosection_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            Response.Redirect("EmployeeSurveySection.aspx?docNo=" + docNo);
        }

        protected void home_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}