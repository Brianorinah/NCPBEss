using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class SubPlogIndicators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
            string CSPNo = Request.QueryString["CSPNo"];
            string ScoreCardNo = Request.QueryString["ScoreCardNo"];
            Response.Redirect("NewPerformanceLogEntry.aspx?step=2&&PerformanceLogNo=" + PerformanceLogNo + "&&CSPNo=" + CSPNo + "&&ScoreCardNo=" + ScoreCardNo);
        }

        protected void savesubPlogLine_Click(object sender, EventArgs e)
        {
            try
            {
                string flag = "";
                bool err = false;
                string PlogNo = Request.QueryString["PlogNo"];
                int lineno = Convert.ToInt32(pentryNo.Text);
                decimal nagreedtrgt = Convert.ToDecimal(pachievedqty.Text);
                string nremarks = pachdesc.Text.Trim();
                string nvar = prsnvar.Text.Trim();
                string mduedate = prof_startDate.Text.Trim();
                DateTime cduedate = new DateTime();
                DateTime today = new DateTime();
                try
                {
                    cduedate = DateTime.ParseExact(mduedate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception m)
                {
                    err = true;
                    flag = m.Message;
                }
                string leo = Convert.ToDateTime(DateTime.Now).ToString("d/MM/yyyy");
                try
                {
                    today = DateTime.ParseExact(leo, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception m)
                {
                    err = true;
                    flag = m.Message;
                }
                if (cduedate > today)
                {
                    err = true;
                    flag = "The achieved date should not be greater than today's date, kindly use another date.";
                }
                if (err)
                {
                    FeedBack.InnerHtml = "<div class='alert alert-danger'>" + flag + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //String status = Config.ObjNav.FnInsertPlogSubActivities(lineno, PlogNo, nagreedtrgt, cduedate, nremarks, nvar);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    FeedBack.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                    //else
                    //{
                    //    FeedBack.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
            }
            catch (Exception m)
            {
                FeedBack.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}