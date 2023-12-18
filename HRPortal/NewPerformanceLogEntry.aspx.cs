using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewPerformanceLogEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                LoadContracts();
                string PerformanceLogNo = "";
                try
                {                  
                    if (!string.IsNullOrEmpty(Request.QueryString["PerformanceLogNo"]))
                    {
                        PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                        var plog = nav.PerformanceDiaryLog.Where(x => x.No == PerformanceLogNo).ToList();
                        foreach (var item in plog)
                        {
                            startDate.Text = Convert.ToDateTime(item.Activity_Start_Date).ToString("d/MM/yyyy");
                            endDate.Text = Convert.ToDateTime(item.Activity_End_Date).ToString("d/MM/yyyy");
                            awp.Text = item.AWP_ID;
                            csp.Text = item.CSP_ID;
                            description.Text = item.Description;
                            yr.Text = item.Year_Reporting_Code;
                            personalscorecardno.SelectedValue = item.Personal_Scorecard_ID;
                        }
                    }
                    else
                    {
                        PerformanceLogNo = "";
                    }
                }
                catch
                {
                    PerformanceLogNo = "";
                }
            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                string tpersonalscorecardno = personalscorecardno.SelectedValue.Trim();
                string tdescription = description.Text.Trim();
                string tplogtype = Request.QueryString["type"];
                int nplogtype = 0;
                if (tplogtype == "PC")
                {
                    nplogtype = 1;
                }
                if (tplogtype == "AWP")
                {
                    nplogtype = 2;
                }
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                //String status = Config.ObjNav.FnNewPerformanceLogEntry(PerformanceLogNo, Convert.ToString(Session["employeeNo"]), tpersonalscorecardno, tdescription, nplogtype);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    Session["ScoreCard"] = tpersonalscorecardno;
                //    Session["PerformanceLogNo"] = info[2];
                //    Session["CSPNo"] = info[3];
                //    Session["ScoreCardNo"] = info[4];
                //    generalfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    Response.Redirect("NewPerformanceLogEntry.aspx?step=2&&PerformanceLogNo=" + info[2] + "&&CSPNo=" + info[3] + "&&ScoreCardNo=" + info[4] + "&&type=" + tplogtype);
                //}
                //else
                //{
                //    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void personalscorecardno_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                string tpersonalscorecardno = personalscorecardno.SelectedValue.Trim();
                string PerformanceLogNo = "";
                string tplogtype = Request.QueryString["type"];
                int nplogtype = 0;
                if (tplogtype == "PC")
                {
                    nplogtype = 1;
                }
                if (tplogtype == "AWP")
                {
                    nplogtype =2;
                }
                string tdescription = description.Text.Trim();
                //String status = Config.ObjNav.FnNewPerformanceLogEntry(PerformanceLogNo, Convert.ToString(Session["employeeNo"]), tpersonalscorecardno, tdescription, nplogtype);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                    
                //    var nav = new Config().ReturnNav();
                //    var plog = nav.PerformanceDiaryLog.Where(x => x.No == info[2]).ToList();
                //    foreach (var item in plog)
                //    {
                //        startDate.Text = Convert.ToDateTime(item.Activity_Start_Date).ToString("d/MM/yyyy");
                //        endDate.Text = Convert.ToDateTime(item.Activity_End_Date).ToString("d/MM/yyyy");
                //        awp.Text = item.AWP_ID;
                //        csp.Text = item.CSP_ID;
                //        description.Text = item.Description;
                //        yr.Text = item.Year_Reporting_Code;
                //    }
                //    Response.Redirect("NewPerformanceLogEntry.aspx?PerformanceLogNo=" + info[2] + "&&type=" + tplogtype);
                //}
                //else
                //{
                //    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        private void LoadContracts()
        {
            string ptype = Request.QueryString["type"];
            if (ptype == "AWP")
            {
                var nav = new Config().ReturnNav();
                var workplans = nav.PerfomanceContractHeader.Where(x => x.Approval_Status == "Released" && x.Responsible_Employee_No == Convert.ToString(Session["employeeNo"]) && x.Score_Card_Type == "Staff").ToList();
                List<Item> list = new List<Item>();
                foreach (var item in workplans)
                {
                    Item itm = new Item();
                    itm.Description = item.No + " :" + item.Description;
                    itm.No = item.No;
                    list.Add(itm);
                }
                personalscorecardno.DataSource = list;
                personalscorecardno.DataValueField = "No";
                personalscorecardno.DataTextField = "Description";
                personalscorecardno.DataBind();
                personalscorecardno.Items.Insert(0, new ListItem("--Select--", ""));
            }
            if (ptype == "PC")
            {
                var nav = new Config().ReturnNav();
                var workplans = nav.PerfomanceContractHeader.Where(x => x.Approval_Status == "Released" && x.Responsible_Employee_No == Convert.ToString(Session["employeeNo"]) && x.Score_Card_Type == "Departmental").ToList();
                List<Item> list = new List<Item>();
                foreach (var item in workplans)
                {
                    Item itm = new Item();
                    itm.Description = item.No + " :" + item.Description;
                    itm.No = item.No;
                    list.Add(itm);
                }
                personalscorecardno.DataSource = list;
                personalscorecardno.DataValueField = "No";
                personalscorecardno.DataTextField = "Description";
                personalscorecardno.DataBind();
                personalscorecardno.Items.Insert(0, new ListItem("--Select--", ""));
            }
        }

        protected void BackToStep1_Click1(object sender, EventArgs e)
        {
            string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
            string type = Request.QueryString["type"];
            Response.Redirect("NewPerformanceLogEntry.aspx?PerformanceLogNo="+ PerformanceLogNo +"&&type="+type);
        }

        protected void SubmitPlog_Click(object sender, EventArgs e)
        {
            try
            {
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                String status = Config.ObjNav.FnSendPlogApproval(PerformanceLogNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void savePlogLine_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string message = "";
                string PerformanceLogNo = Request.QueryString["PerformanceLogNo"];
                int tpentryNo = Convert.ToInt32(pentryNo.Text.Trim());
                decimal txtpachievedqty = Convert.ToDecimal(pachievedqty.Text.Trim());
                string tpachdesc = pachdesc.Text.Trim();
                string tprsnvar = prsnvar.Text.Trim();
                if(txtfileupload.HasFile)
                {
                    string accreditationNo = PerformanceLogNo;
                    accreditationNo = accreditationNo.Replace('/', '_');
                    accreditationNo = accreditationNo.Replace(':', '_');
                    string path1 = Config.FilesLocation() + "Performance Logs Card/";
                    string str1 = Convert.ToString(accreditationNo);

                    string desc = txtdescName.Text.Trim();
                    desc = desc.Replace('/', '_');
                    desc = desc.Replace(':', '_');
                    string folderName = path1 + str1 + "/";                    
                    string extension = System.IO.Path.GetExtension(txtfileupload.FileName);
                    if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                    {
                        string filename = desc + extension;
                        if (!Directory.Exists(folderName))
                        {
                            Directory.CreateDirectory(folderName);
                        }
                        if (File.Exists(folderName + filename))
                        {
                            File.Delete(folderName + filename);
                        }
                        txtfileupload.SaveAs(folderName + filename);
                        if (File.Exists(folderName + filename))
                        {
                            Config.navExtender.AddLinkToRecord("Performance Logs Card", accreditationNo, filename, "");
                        }
                    }
                    else
                    {
                        error = true;
                        message = "The file extension of the document is not allowed,Kindly upload pdf files only";
                    }
                }
                if(error)
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //String status = Config.ObjNav.FnUpdatePerformanceTargetLinesDetails(PerformanceLogNo, tpentryNo, txtpachievedqty, tpachdesc, tprsnvar);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    linesfeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                    //else
                    //{
                    //    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
            }
            catch (Exception m)
            {
                linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}