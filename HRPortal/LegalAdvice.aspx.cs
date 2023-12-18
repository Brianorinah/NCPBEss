using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class LegalAdvice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                datecreated.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");
                List<Employee> allJobs = new List<Employee>();
                //string allData = Config.ObjNav.FnLegalAdviceCategories();
                //String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                //if (info != null)
                //{
                //    foreach (var data in info)
                //    {
                //        String[] arr = data.Split('*');
                //        Employee employee = new Employee();
                //        employee.EmployeeNo = arr[0];
                //        employee.EmployeeName = arr[1];
                //        allJobs.Add(employee);
                //    }
                //}
                category.DataSource = allJobs;
                category.DataValueField = "EmployeeNo";
                category.DataTextField = "EmployeeName";
                category.DataBind();

                String docNo = "";
                try
                {
                    docNo = Request.QueryString["docNo"];
                    if (string.IsNullOrEmpty(docNo))
                    {
                        docNo = "";
                    }
                }
                catch
                {
                    docNo = "";
                }
                if (!string.IsNullOrEmpty(docNo))
                {
                    //string empNo = Convert.ToString(Session["employeeNo"]);
                    //string allData3 = Config.ObjNav.FngetSingleConflict(empNo, docNo);
                    //String[] info3 = allData3.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                    //if (info3 != null)
                    //{
                    //    foreach (var data in info3)
                    //    {
                    //        String[] arr = data.Split('*');
                    //        category.SelectedValue = arr[3];
                    //        description.Text = arr[1];
                    //    }
                    //}
                }
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = Convert.ToString(Session["employeeNo"]);
                string txtdescription = description.Text.Trim();
                string txtcategory = category.SelectedValue;
                if(txtcategory == "OTHER")
                {
                    txtcategory = sCategory.Text.Trim();
                }
                if (txtcategory == "--Select--")
                {
                    txtcategory = "";
                }
                String docNo = "";
                try
                {
                    docNo = Request.QueryString["docNo"];
                    if (String.IsNullOrEmpty(docNo))
                    {
                        docNo = "";
                    }
                }
                catch (Exception)
                {
                    docNo = "";
                }
                //String status = Config.ObjNav.FnCreateLegalAdvice(docNo, empNo, txtcategory, txtdescription);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                //}
                //else
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch(Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void backtodashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }

        protected void category_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ncategory = category.SelectedValue;
            if(ncategory == "OTHER")
            {
                divsCategory.Visible = true;
            }
            else
            {
                divsCategory.Visible = false;
            }
        }
    }
}