using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class MyHelpDeskRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();

            if (!IsPostBack)
            {
                var categories = nav.ICTHelpDeskCategory.ToList();
                txtcategory.DataSource = categories;
                txtcategory.DataValueField = "Code";
                txtcategory.DataTextField = "Description";
                txtcategory.DataBind();

            }
      }


        protected void edit_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string tjobNo = lineNo1.Text.ToString();
            string ictCategories = txtcategory.SelectedValue.Trim();
            string desc = txtdescription.Text.ToString();
            if (string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description ";

            }
            if (error == true)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    string empNo = Session["employeeNo"].ToString();

                    //var status = Config.ObjNav.EditHelpDeskRequest(tjobNo, empNo, ictCategories, desc);

                    //string[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    ictFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    //}

                }
                catch (Exception ex)
                {

                    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }



            }
        }

    }
}