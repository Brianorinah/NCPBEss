using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Appraisal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"]);
                    if(step > 3 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch(Exception)
                {
                    step = 1;
                }

                if (step == 1)
                {
                    String applicationNumber = Request.QueryString["applicationNo"];

                    var jobs = Config.ObjNav1.fnGetAppraisalApplicationDetails(applicationNumber);

                    String[] arr = jobs.split('*');
                    jobtitle.text = arr[0];
                    appraisalperiod.text = arr[1];
                    appraisalstartdate.text = arr[2];
                    goalsettingstartdate.text = arr[3];
                    goalsettingenddate.text = arr[4];
                    mystartdate.text = arr[5];
                    myenddate.text = arr[7];
                    eystartdate.text = arr[8];
                    eyenddate.text = arr[9];
                    supervisor.text = arr[10];
                    overviewmanager.text = arr[11];

                }
            }

        }
    }
}