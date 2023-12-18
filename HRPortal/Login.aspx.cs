using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                    String tUsername = username.Text.Trim();
                    String tPassword = password.Text.Trim();
                    var nav = new Config().ReturnNav();
                    var users = nav.HRPortalUsers.Where(r => r.employeeNo == tUsername && r.password == tPassword);
                    Boolean exists = false;
                    foreach (var user in users)
                    {
                        exists = true;
                        Session["name"] = user.First_Name + " " + user.Middle_Name + " " + user.Last_Name;
                        Session["employeeNo"] = user.employeeNo;
                        Session["idNo"] = user.ID_Number;
                        Session["admin"] = user.ICT_Help_Desk_Admin;
                        Session["region"] = user.Region;
                        Session["FundCode"] = user.Global_Dimension_2_Code;
                        Session["Directorate"] = user.Directorate_Code;
                        Session["Department"] = user.Department_Code;
                       // Session["gender"] = user.Gender;

                    if (user.changedPassword == false)
                        {
                            Response.Redirect("ChangePassword.aspx");
                        }
                    
                    }
                    if (!exists)
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>A user with the entered credentials does not exist<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        Response.Redirect("Dashboard.aspx");
                    }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'</div>";

            }
        }
        bool IsValidCaptcha()
        {
            try
            {
                string resp = Request["g-recaptcha-response"];
                var req = (HttpWebRequest)WebRequest.Create
                    ("https://www.google.com/recaptcha/api/siteverify?secret=6Ld4LScUAAAAAMFS3LPFmHywnoRFpywiUiMBDS9n&response=" +
                     resp);
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        string jsonResponse = readStream.ReadToEnd();
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        // Deserialize Json
                        CaptchaResult data = js.Deserialize<CaptchaResult>(jsonResponse);
                        if (Convert.ToBoolean(data.success))
                        {
                            return true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'</div>";
                //No internet connection to verify capcha code
            }
            return false;
        }
    }
}