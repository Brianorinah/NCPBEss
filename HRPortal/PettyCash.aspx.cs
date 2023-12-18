//using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PettyCash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //int TotalQuantity = 10000;
                ////RangeValidator1.MaximumValue = Convert.ToInt32(TotalQuantity);
                //RangeValidator1.MaximumValue = Convert.ToString(TotalQuantity);

                //var nav = new Config().ReturnNav();
                //var jobs = nav.jobs.Where(x => x.Exchequer_Current == true).ToList().OrderBy(r => r.Description);
                //job.DataSource = jobs;
                //job.DataValueField = "No";
                //job.DataTextField = "Description";
                //job.DataBind();

                //LoadJobTasks();
                //LoadConstituency();
                //PaymentTypes();
                //loadPettyCash();
                //if (Session["regionName"] != null)
                //{
                //    //region.Text = Session["regionName"].ToString();
                //}

                ////PettyCashNo1.Text = Request.QueryString["pNo"];
            }

        }

/*

        protected void GoBackStep1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["pNo"];
            if (Request.QueryString["pNo"] != null)
            {
                requisitionNo = Request.QueryString["pNo"].ToString();
                requisitionNo = requisitionNo.Replace(':', '_');
            }
            Response.Redirect("PettyCash.aspx?step=1&&pNo=" + requisitionNo);
        }

        protected void next_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            String message = "";
            try
            {
                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {

                    requisitionNo = Request.QueryString["pNo"];
                    requisitionNo = requisitionNo.Replace('_', ':');
                    if (String.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                        newRequisition = true;
                    }
                }
                catch (Exception)
                {

                    newRequisition = true;
                    requisitionNo = "";
                }
                DateTime date = new DateTime();

                // String sdate = startDate.Text;
                String tjob = job.SelectedValue;
                String tjobTaskNo = jobTaskNo.SelectedValue;
                String tnarration = narration.Text;
                String tregion = "";
                String tconstituency = constituency.SelectedValue;


                if (Session["region"] != null)
                {
                    tregion = Session["region"].ToString();
                }



                var status = Config.ObjNav.CreatePettyCash(requisitionNo, Convert.ToString(Session["employeeNo"]), tjob, tjobTaskNo, tnarration, tregion, tconstituency);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition == true)
                    {
                        requisitionNo = info[1];
                        requisitionNo = requisitionNo.Replace(':', '_');

                    }

                    requisitionNo = requisitionNo.Replace(':', '_');

                    Response.Redirect("PettyCash.aspx?step=2&&pNo=" + requisitionNo);
                }


            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void addLines_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            String message = "";
            var requisitionNo = Request.QueryString["pNo"];
            requisitionNo = requisitionNo.Replace('_', ':');
            String pType = type.SelectedValue;
            String pAmount = amount.Text;
            if (String.IsNullOrEmpty(pType))
            {
                error = true;
                message = "Please select type";
            }
            if (String.IsNullOrEmpty(pAmount))
            {
                error = true;
                message = "Please enter amount";
            }
            if (error == false)
            {
                try
                {

                    var status = Config.ObjNav.CreatePettyCashLines(requisitionNo, pType, Convert.ToDecimal(pAmount));
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        pLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        pLines.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }

                }
                catch (Exception m)
                {

                    pLines.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                pLines.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }



        }
        //protected void LoadJobs()
        //{
        //    var nav = new Config().ReturnNav();
        //    var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
        //    List<Employee> allJobs = new List<Employee>();
        //    foreach (var myJob in jobs)
        //    {
        //        Employee employee = new Employee();
        //        employee.No = myJob.No;
        //        employee.Description = myJob.No + " - " + myJob.Description;
        //        allJobs.Add(employee);
        //    }
        //    job.DataSource = allJobs;
        //    job.DataValueField = "No";
        //    job.DataTextField = "Description";
        //    job.DataBind();
        //}



        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();

        }
        protected void LoadJobTasks()
        {
            var nav = new Config().ReturnNav();
            var myJob = constituency.SelectedValue;
            //&& r.Global_Dimension_1_Code == Session["region"].ToString()
            var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob);
            jobTaskNo.DataSource = jobTasks;
            jobTaskNo.DataValueField = "Job_Task_No";
            jobTaskNo.DataTextField = "Description";
            jobTaskNo.DataBind();
        }
        protected void LoadConstituency()
        {
            var Reg = "";
            if (Session["regionCode"] != null)
            {
                Reg = Session["regionCode"].ToString();
            }

            var nav = new Config().ReturnNav();
            //.Where(x => x.Region_Code == Reg)
            var fundcodes = nav.FundCode;
            constituency.DataSource = fundcodes;
            constituency.DataTextField = "Name";
            constituency.DataValueField = "Code";
            constituency.DataBind();
        }

        protected void PaymentTypes()
        {
            //var nav = new Config().ReturnNav();
            ////PaymentsTypes
            //var query = nav.PaymentsTypes.Where(x => x.Type == "Payment");
            //type.DataSource = query;
            //type.DataTextField = "Description";
            //type.DataValueField = "Code";
            //type.DataBind();

            //editType.DataSource = query;
            //editType.DataValueField = "Code";
            //editType.DataTextField = "Description";
            //editType.DataBind();

        }

        protected void RemovePettyCash_Click(object sender, EventArgs e)
        {
            var requisitionNo = removedocNo.Text;
            var id = removeLineNo.Text;

            try
            {
                var status = Config.ObjNav.DeletePettyCashLines(Convert.ToInt32(id), requisitionNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    pLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    pLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                pLines.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }


        }

        protected void EditPettyCash_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            String message = "";
            var requisitionNo = Request.QueryString["pNo"];
            requisitionNo = requisitionNo.Replace('_', ':');
            String pType = editType.SelectedValue;
            String pAmount = editAmount.Text;
            String id = lineNo.Text;
            if (String.IsNullOrEmpty(pType))
            {
                error = true;
                message = "Please select type";
            }
            if (String.IsNullOrEmpty(pAmount))
            {
                error = true;
                message = "Please enter amount";
            }
            if (error == false)
            {
                try
                {

                    var status = Config.ObjNav.EditPettyCashLines(pType, Convert.ToDecimal(pAmount), requisitionNo, Convert.ToInt32(id));
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        pLines.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        pLines.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }


                }
                catch (Exception m)
                {

                    pLines.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                pLines.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }

        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            //bool fileuploadSuccess = false;
            //string sUrl = ConfigurationManager.AppSettings["S_URL"];
            //string defaultlibraryname = "ERP%20Documents/";
            //string customlibraryname = "KeRRA/Petty Cash Voucher";
            //string sharepointLibrary = defaultlibraryname + customlibraryname;
            //String leaveNo = Request.QueryString["pNo"];
            //leaveNo = leaveNo.Replace('_', ':');
            //var leaveNo1 = leaveNo.Replace('/', '_');
            //var leaveNo2 = leaveNo1.Replace(':', '_');
            //string username = ConfigurationManager.AppSettings["S_USERNAME"];
            //string password = ConfigurationManager.AppSettings["S_PWD"];
            //string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

            //bool bbConnected = Config.Connect(sUrl, username, password, domainname);

            //try
            //{
            //    if (bbConnected)
            //    {
            //        Uri uri = new Uri(sUrl);
            //        string sSpSiteRelativeUrl = uri.AbsolutePath;
            //        string uploadfilename = leaveNo2 + "_" + document.FileName;
            //        Stream uploadfileContent = document.FileContent;

            //        var sDocName = UploadPettyCash(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

            //        string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo2 + "/" + uploadfilename;

            //        if (!string.IsNullOrEmpty(sDocName))
            //        {
            //            var status = Config.ObjNav.AddPettyCashSharepointLinks(leaveNo, uploadfilename, sharepointlink);
            //            string[] info = status.Split('*');
            //            if (info[0] == "success")
            //            {
            //                documentsfeedback.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }
            //            else
            //            {
            //                documentsfeedback.InnerHtml =
            //                    "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }


            //    }
            //}
            //catch (Exception ex)
            //{

            //    throw;
            //}
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String pettyCashNo = Request.QueryString["pettyCashNo"].ToString();
                            //  String trainingNo = Request.QueryString["trainingNo"].ToString();

                            String documentDirectory = filesFolder + pettyCashNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //We could not create a directory for your documents
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

                                        //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
                                        Config.navExtender.AddLinkToRecord("Petty Cash Voucher", pettyCashNo, filename, "");
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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //The document could not be uploaded
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }

        }
        //public string UploadPettyCash(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        //{
        //    string sDocName = string.Empty;
        //    leaveNo = Request.QueryString["pNo"];
        //    var leaveNo1 = leaveNo.Replace('/', '_');
        //    var leaveNo2 = leaveNo1.Replace(':', '_');
        //    string parent_folderName = "KeRRA/Petty Cash Voucher";
        //    string subFolderName = leaveNo2;
        //    string filelocation = sLibraryName + "/" + subFolderName;
        //    try
        //    {
        //        // if a folder doesn't exists, create it
        //        var listTitle = "ERP Documents";
        //        if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
        //            CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

        //        if (Config.SPWeb != null)
        //        {
        //            var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);
        //            Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
        //            Config.SPClientContext.ExecuteQuery();
        //            sDocName = sFileName;
        //        }
        //    }

        //    catch (Exception)
        //    {
        //        sDocName = string.Empty;
        //    }
        //    return sDocName;
        //}


        //public static bool FolderExists(Web web, string listTitle, string folderUrl)
        //{
        //    var list = web.Lists.GetByTitle(listTitle);
        //    var folders = list.GetItems(CamlQuery.CreateAllFoldersQuery());
        //    web.Context.Load(list.RootFolder);
        //    web.Context.Load(folders);
        //    web.Context.ExecuteQuery();
        //    var folderRelativeUrl = string.Format("{0}/{1}", list.RootFolder.ServerRelativeUrl, folderUrl);
        //    return Enumerable.Any(folders, folderItem => (string)folderItem["FileRef"] == folderRelativeUrl);
        //}

        //private static void CreateFolder(Web web, string listTitle, string folderName)
        //{
        //    var list = web.Lists.GetByTitle(listTitle);
        //    var folderCreateInfo = new ListItemCreationInformation
        //    {
        //        UnderlyingObjectType = FileSystemObjectType.Folder,
        //        LeafName = folderName
        //    };
        //    var folderItem = list.AddItem(folderCreateInfo);
        //    folderItem.Update();
        //    web.Context.ExecuteQuery();
        //}
        protected void GoBackStep2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["pNo"];
            if (Request.QueryString["pNo"] != null)
            {
                requisitionNo = Request.QueryString["pNo"].ToString();
                requisitionNo = requisitionNo.Replace(':', '_');
            }

            Response.Redirect("PettyCash.aspx?step=2&&pNo=" + requisitionNo);

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["pNo"];
                requisitionNo = requisitionNo.Replace('_', ':');
                Convert.ToString(Session["employeeNo"]);
                String status = Config.ObjNav.SendPettyCashRequestApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void step3_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["pNo"];
            if (Request.QueryString["pNo"] != null)
            {
                requisitionNo = Request.QueryString["pNo"].ToString();
                requisitionNo = requisitionNo.Replace(':', '_');
            }
            Response.Redirect("PettyCash.aspx?step=3&&pNo=" + requisitionNo);
        }

        protected void loadPettyCash()
        {
            try
            {
                String pettyCashNo = Request.QueryString["pNo"];

                pettyCashNo = pettyCashNo.Replace('_', ':');
                if (!String.IsNullOrEmpty(pettyCashNo))
                {
                    //Boolean exists = false;
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    var nav = new Config().ReturnNav();
                    var PettyCash =
                        nav.Payments.Where(
                            r =>
                                 r.Account_No == employeeNo && r.No == pettyCashNo &&
                                r.Payment_Type == "Petty Cash" && r.Document_Type == "Petty Cash");

                    foreach (var myClaim in PettyCash)
                    {

                        narration.Text = myClaim.Payment_Narration;
                        job.SelectedValue = myClaim.Job;

                        jobTaskNo.SelectedValue = myClaim.Job_Task_No;
                    }

                }
            }
            catch (Exception)
            {

            }
        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            //var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            //{
            //    using (ClientContext ctx = new ClientContext(sharepointUrl))
            //    {

            //        string password = ConfigurationManager.AppSettings["S_PWD"];
            //        string account = ConfigurationManager.AppSettings["S_USERNAME"];
            //        string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
            //        var secret = new SecureString();
            //        var parentFolderName = @"ERP%20Documents/KeRRA/Petty Cash Voucher/";
            //        var leaveNo = Request.QueryString["pNo"];
            //        var leaveNo1 = leaveNo.Replace('/', '_');
            //        var leaveNo2 = leaveNo1.Replace(':', '_');
            //        foreach (char c in password)
            //        { secret.AppendChar(c); }
            //        try
            //        {
            //            ctx.Credentials = new NetworkCredential(account, secret, domainname);
            //            ctx.Load(ctx.Web);
            //            ctx.ExecuteQuery();

            //            Uri uri = new Uri(sharepointUrl);
            //            string sSpSiteRelativeUrl = uri.AbsolutePath;

            //            string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo2 + "/" + fileName.Text;

            //            var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
            //            ctx.Load(file, f => f.Exists);
            //            file.DeleteObject();
            //            ctx.ExecuteQuery();

            //            if (!file.Exists)
            //                throw new FileNotFoundException();
            //            documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //        catch (Exception ex)
            //        {
            //            // ignored
            //            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }

            //}
            //catch (Exception ex)
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    //throw;
            //}




            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";
                String pettyCashNo = Request.QueryString["pNo"];
                String documentDirectory = filesFolder + pettyCashNo + "/";
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

        protected void jobTaskNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            //try
            //{
            //    var nav = new Config().ReturnNav();
            //    var myJob = jobTaskNo.SelectedValue;
            //    var jobTasks = nav.JobTask.Where(r => r.Job_Task_No == myJob && r.Global_Dimension_1_Code == Session["region"].ToString());

            //    foreach (var item in jobTasks)
            //    {
            //        var total = (Convert.ToDecimal(item.Schedule_Total_Cost) - Convert.ToDecimal(item.Usage_Total_Cost)) + Convert.ToDecimal(item.Commitments);

            //        budget.Text = Convert.ToString(total);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //}
        }

        //protected void generate_Click(object sender, EventArgs e)
        //{
        //    try
        //    {

        //        var pettyCashNo = Request.QueryString["pNo"];
        //        pettyCashNo = pettyCashNo.Replace('_', ':');
        //        string employeeNumber = Convert.ToString(Session["employeeNo"]);
        //        String status = Config.ObjNav.GeneratePettyCashVoucher(employeeNumber, pettyCashNo);
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            pettyCashPreview.Attributes.Add("src", ResolveUrl(info[2]));
        //        }
        //        else
        //        {
        //            documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
        //                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception t)
        //    {
        //        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
        //                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        */
    }
}