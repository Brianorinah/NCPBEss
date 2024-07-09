using System;
using System.Collections.Generic;
using System.DirectoryServices;
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
                String tusername = username.Text.Trim();
                String tpassword = password.Text.Trim();

                // sanitize the request, just incase a user a username and preappends the domain, eg CUEHQ\Administrator
                String sanitizedUsername = tusername.Split('\\').LastOrDefault();

                bool authenticated = AuthenticateUser(sanitizedUsername, tpassword);

                if (authenticated)
                {
                    // preappend CUEHQ to the sanitizeed username
                    sanitizedUsername = "CEREALS\\" + sanitizedUsername;
                    Boolean exists = false;
                    String job = Config.ObjNav1.fnGetUser(sanitizedUsername);
                    String[] info = job.Split('*');

                    if (info[0] == "success")
                    {
                        String employee = Config.ObjNav1.fnGetEmployees(info[2]);

                        String[] allInfo = employee.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (allInfo != null)
                        {
                            foreach (var oneItem in allInfo)
                            {
                                String[] arr = oneItem.Split('*');

                                Session["name"] = arr[1];
                                Session["employeeNo"] = arr[0];
                                Session["idNo"] = arr[3];
                                Session["Department"] = arr[5];
                                Session["username"] = info[3];
                            }
                            Response.Redirect("Dashboard.aspx");
                        }

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    feedback.InnerHtml =
                            "<div class='alert alert-danger'>A user with the entered credentials does not exist. Ensure you enter the correct credentials. Contact your system administrator if this error persists.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'</div>";
            }
        }

        protected bool AuthenticateUser(String UserName, String Password)
        {
            string ldapPath = "LDAP://servergamma.cereals";
            //string fullUserId = "administrator";
            bool isAuthenticated = false;

            try
            {

                DirectoryEntry de = new DirectoryEntry(ldapPath, UserName, Password,

                     AuthenticationTypes.Secure | AuthenticationTypes.Sealing | AuthenticationTypes.ServerBind);

                DirectorySearcher dsearch = new DirectorySearcher(de);

                //    DirectoryEntry de = new DirectoryEntry(ldapPath, fullUserId, "Ncpb**Admin",
                //AuthenticationTypes.Secure);

                //DirectorySearcher dsearch = new DirectorySearcher(de);

                SearchResult results = null;
                results = dsearch.FindOne();

                if (results != null)
                {
                    isAuthenticated = true;
                }
            }
            //catch (DirectoryServicesCOMException ex)
            //{
            //    string message = ex.Message;
            //    isAuthenticated = false;
            //}
            catch (Exception ex)
            {
                string message = ex.Message;
                isAuthenticated = false;
            }

            return isAuthenticated;
        }
    }
}