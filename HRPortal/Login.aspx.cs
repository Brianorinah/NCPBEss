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
                if (tPassword == "0000")
                {
                    Session["employeeNo"] = tUsername;
                    Response.Redirect("ChangePassword.aspx");
                }
                else
                {
                    bool error = false;
                    var nav = new Config().ReturnNav();
                    string allData = Config.ObjNav1.fnGetHrPortalUser(tUsername, tPassword);
                    String[] allInfo = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (allInfo != null)
                    {
                        foreach (var item in allInfo)
                        {

                            String[] oneItem = item.Split(new string[] { "**Z" }, StringSplitOptions.None);
                            //String[] oneItem = item.Split('*');

                            if (oneItem[0] == "danger")
                            {
                                error = true;
                                feedback.InnerHtml = "<div class='alert alert-" + oneItem[0] + "'>" + oneItem[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            else
                            {
                                Session["name"] = oneItem[0] + " " + oneItem[1] + " " + oneItem[2];
                                Session["employeeNo"] = oneItem[3];
                                Session["idNo"] = oneItem[4];
                                //Session["admin"] = oneItem[0];
                                //Session["region"] = oneItem[0];
                                //Session["FundCode"] = oneItem[0];
                                //Session["Directorate"] = oneItem[0];
                                Session["Department"] = oneItem[5];
                                if (oneItem[5] == "No")
                                {
                                    Response.Redirect("ChangePassword.aspx");
                                }
                                else
                                {
                                    Response.Redirect("Dashboard.aspx");
                                }





                            }
                        }
                    }
                }
                //        var users = Config.ObjNav1.fnGetHrPortalUser(tUsername, tPassword);
                //Boolean exists = false;
                //foreach (var user in users)
                //{
                //    exists = true;
                //    Session["name"] = user.First_Name + " " + user.Middle_Name + " " + user.Last_Name;
                //    Session["employeeNo"] = user.employeeNo;
                //    Session["idNo"] = user.ID_Number;
                //    Session["admin"] = user.ICT_Help_Desk_Admin;
                //    Session["region"] = user.Region;
                //    Session["FundCode"] = user.Global_Dimension_2_Code;
                //    Session["Directorate"] = user.Directorate_Code;
                //    Session["Department"] = user.Department_Code;
                //   // Session["gender"] = user.Gender;

                //if (user.changedPassword == false)
                //    {
                //        Response.Redirect("ChangePassword.aspx");
                //    }

                //}
                //if (!exists)
                //{
                //    feedback.InnerHtml =
                //        "<div class='alert alert-danger'>A user with the entered credentials does not exist<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    Response.Redirect("Dashboard.aspx");
                //}
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'</div>";

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
                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'</div>";
                //No internet connection to verify capcha code
            }
            return false;
        }
    }
}