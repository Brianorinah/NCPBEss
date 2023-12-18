using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ConflictofInterest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                //var periods = nav.LegalDeclarationPeriod;
                //period.DataSource = periods;
                //period.DataTextField = "Description";
                //period.DataValueField = "Code";
                //period.DataBind();

                datecreated.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");
                returndate.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");

                String docNo = "";
                try
                {
                    docNo = Request.QueryString["docNo"];
                    if(string.IsNullOrEmpty(docNo))
                    {
                        docNo = "";
                    }
                }
                catch
                {
                    docNo = "";
                }
                if(!string.IsNullOrEmpty(docNo))
                {
                    string empNo = Convert.ToString(Session["employeeNo"]);
                    //string allData = Config.ObjNav.FngetSingleConflict(empNo, docNo);
                    //String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                    //if (info != null)
                    //{
                    //    foreach (var data in info)
                    //    {
                    //        String[] arr = data.Split('*');
                    //        period.SelectedValue = arr[2];
                    //        description.Text = arr[1];
                    //    }
                    //}
                }
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = Convert.ToString(Session["employeeNo"]);
                string txtdescription = description.Text.Trim();
                string txtperiod = period.SelectedValue;
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
                //String status = Config.ObjNav.FnCreateConflictofInterest(docNo, empNo, txtperiod, txtdescription);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    Response.Redirect("ConflictofInterest.aspx?step=2&&docNo=" + info[2]);
                //}
                //else
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void safeconflict_Click(object sender, EventArgs e)
        {
            try
            {
                string txtnature = nature.Text.Trim();
                string txtreturndate = returndate.Text.Trim();
                DateTime myTravelDate = new DateTime();

                try
                {
                    myTravelDate = DateTime.ParseExact(txtreturndate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }

                String docNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FnInsertConflictLines(docNo, txtnature, myTravelDate);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void backtostepone_Click(object sender, EventArgs e)
        {
            String docNo = Request.QueryString["docNo"];
            Response.Redirect("ConflictofInterest.aspx?step=1&&docNo=" + docNo);
        }

        protected void nexttostepthree_Click(object sender, EventArgs e)
        {
            String docNo = Request.QueryString["docNo"];
            Response.Redirect("ConflictofInterest.aspx?step=3&&docNo=" + docNo);
        }

        protected void backsteptwo_Click(object sender, EventArgs e)
        {
            String docNo = Request.QueryString["docNo"];
            Response.Redirect("ConflictofInterest.aspx?step=2&&docNo=" + docNo);
        }

        protected void submitgift_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = Convert.ToString(Session["employeeNo"]);
                String docNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FnSubmitToCueLegalDetails(empNo, docNo);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                //}
                //else
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteConflictline_Click(object sender, EventArgs e)
        {
            try
            {
                int nlineno = Convert.ToInt32(txtdeleteLineno.Text.Trim());

                String docNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FnDeleteConflictLine(docNo, nlineno);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editconflictofinterest_Click(object sender, EventArgs e)
        {
            try
            {
                int nlineno = Convert.ToInt32(txteditlineNo.Text.Trim());
                string ntxtnature = txtnature.Text.Trim();
                string txtreturndate = prof_endDate1.Text.Trim();
                DateTime myTravelDate = new DateTime();

                try
                {
                    myTravelDate = DateTime.ParseExact(txtreturndate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }

                String docNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FnEditConflictLine(nlineno, docNo, ntxtnature, myTravelDate);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Conflict Of Interest/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["docNo"];
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        //Config.navExtender.AddLinkToRecord("Conflict Of Interest Card", imprestNo, filename, "");
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }
        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";
                String imprestNo = Request.QueryString["docNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
    }
}