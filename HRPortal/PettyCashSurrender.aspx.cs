using HRPortal.Models;
using HRPortal.Nav;
//using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PettyCashSurrender : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {

                if (Request.QueryString["pettyCashNo"] != null)
                {
                    var pettyCashNo = Request.QueryString["pettyCashNo"].ToString();
                    //pettyCash.SelectedValue = pettyCashNo;
                }
                //loadSurrender();
                //loadRecepts();
            }
            Session["active"] = 8;

        }
        /*
        //protected void loadRecepts1()
        //{
        //    string pettyCashNo = "";
        //    if (Request.QueryString["pettyCashNo"] != null)
        //    {
        //        pettyCashNo =Request.QueryString["pettyCashNo"].ToString();
        //        pettyCashNo.Replace('_', ':');
        //    }
        //    var nav = new Config().ReturnNav();
        //    txtreciptno.DataSource = nav.PettyCashSurrenderLines.Where(x => x.No == pettyCashNo).ToList();
        //    txtreciptno.DataValueField = "Receipt_No.";
        //   txtreciptno.DataTextField = "Receipt_No.";
        //   txtreciptno.DataBind();
        //}
        protected void next_Click(object sender, EventArgs e)
        {
            //string str = "";
            //str = Request.QueryString["pettyCashNo"];
            //bool flag = false;
            //string surrenderNo;
            //try
            //{
            //    surrenderNo = Request.QueryString["pettyCashNo"];
            //    if (string.IsNullOrEmpty(surrenderNo))
            //    {
            //        surrenderNo = "";
            //        flag = true;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    flag = true;
            //    surrenderNo = "";
            //}
            bool flag = false;
            string surrenderNo = pettyCash.SelectedValue.Trim();
            string imprestNo = pettyCash.SelectedValue.Trim();
            string status = Config.ObjNav.PopulatePettyCashSurrender(Convert.ToString(Session["employeeNo"]), imprestNo, surrenderNo);
            var res = status.Split('*');
            if (res[0] == "success")
            {
                if (flag)
                    surrenderNo = res[1];
                Response.Redirect("PettyCashSurrender.aspx?step=2&&pettyCashNo=" + surrenderNo);
            }
            else
            { 
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + res[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }




        //protected void save_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        var pettyCashNo = "";
        //        if (Request.QueryString["pettyCashNo"] != null)
        //        {
        //            pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

        //        }

        //        foreach (GridViewRow row in grd_PettyCashSurrender.Rows)
        //        {
        //            string message = "Amount cannot be equal to zero";
        //            string empNo = Session["employeeNo"].ToString();
        //            int Id = Convert.ToInt32( row.Cells[0].Text);
        //            decimal amt =Convert.ToDecimal( ((TextBox)row.FindControl("txtamount")).Text);
        //            string receiptNo = ((DropDownList)row.FindControl("receiptNo")).Text;

        //            if(amt > 0)
        //            {
        //                String status = Config.ObjNav.UpdatePettyCashSurrenderLine(Convert.ToString(Session["employeeNo"]),
        //              pettyCashNo, Id, amt, receiptNo);
        //                String[] info = status.Split('*');
        //                if (info[0] != "danger")
        //                {
        //                    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] +
        //                                              " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                }
        //                else
        //                {
        //                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
        //                                              " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //               }
        //            }
        //            else
        //            {
        //                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message +
        //                                               " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //            }


        //        }



        //    }
        //    catch (Exception r)
        //    {
        //        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + r.Message +
        //                                  " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }


        //    //if (SaveLines())
        //    //{
        //    //    linesFeedback.InnerHtml = "<div class='alert alert-success'>Your Petty cash surrender was successfully saved <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    //}

        //}
        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                string pettyCashNo = "";
                if (Request.QueryString["pettyCashNo"] != null)
                {
                    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();
                }
                string str = "Amount cannot be equal to zero";
                Session["employeeNo"].ToString();
                int int32 = Convert.ToInt32(txtitemnumber.Text);
                Decimal amountSpent = Convert.ToDecimal(txtamountspent.Text);
                string receipt = txtreciptno.SelectedValue.Trim();
                if (amountSpent > 0M)
                {
                    string status = Config.ObjNav.UpdatePettyCashSurrenderLine(Convert.ToString(this.Session["employeeNo"]), pettyCashNo, int32, amountSpent, receipt);
                    var res = status.Split('*');
                    if (res[0] != "danger")
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>" + res[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + res[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + str + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        public Boolean SaveLines()
        {
            //Boolean error = false;
            //String message = "";
            //List<SurrenderLine> allValues = new List<SurrenderLine>();
            //HtmlTableRowCollection allRows = linesTable.Rows;
            //// int size = allRows.Count
            //foreach (HtmlTableRow row in allRows)
            //{
            //    SurrenderLine myLine = new SurrenderLine();
            //    //DropDownList
            //    Decimal mAmountSpent = 0;
            //    String receiptNo = "";
            //    int tLineNo = 0;
            //    HtmlTableCellCollection allCells = row.Cells;
            //    foreach (HtmlTableCell myCell in allCells)
            //    {
            //        ControlCollection myControls = myCell.Controls;
            //        foreach (Control control in myControls)
            //        {
            //            String controlType = control.GetType().ToString().Trim();

            //            if (controlType == "System.Web.UI.WebControls.DropDownList")
            //            {
            //                DropDownList tReceipt = (DropDownList)control;
            //                receiptNo = tReceipt.SelectedValue;
            //                myLine.receiptNo = receiptNo;
            //            }
            //            else if (controlType == "System.Web.UI.WebControls.TextBox")
            //            {

            //                TextBox tAmountSpent = (TextBox)control;
            //                String tSpentAmount = tAmountSpent.Text;
            //                String textBoxId = tAmountSpent.ID;
            //                String lineNo = textBoxId.Replace("amountSpent", "");

            //                try
            //                {
            //                    int mLineNo = Convert.ToInt32(lineNo);
            //                    tLineNo = mLineNo;
            //                    myLine.lineNo = tLineNo;
            //                    try
            //                    {
            //                        Decimal sAmount = Convert.ToDecimal(tSpentAmount);
            //                        myLine.amount = sAmount;
            //                    }
            //                    catch (Exception)
            //                    {
            //                        error = true;
            //                        message =
            //                            "Invalid Amount*Some values you have entered for spent amount are wrong. Please try again*error";
            //                        break;
            //                    }
            //                }
            //                catch (Exception)
            //                {
            //                    error = true;
            //                    message = "Wrong Line No*The line number you have entered is wrong*error";
            //                    break;
            //                }




            //            }

            //        }

            //    }
            //    allValues.Add(myLine);

            //}
            //if (error)
            //{

            //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            //else
            //{
            //    foreach (SurrenderLine value in allValues)
            //    {
            //        if (value.lineNo > 0)
            //        {


            //            try
            //            {
            //                var pettyCashNo = "";
            //                if (Request.QueryString["pettyCashNo"] != null)
            //                {
            //                    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

            //                }
            //                int myLineNo = value.lineNo;
            //                String status =
            //                    Config.ObjNav.UpdatePettyCashSurrenderLine(Convert.ToString(Session["employeeNo"]),
            //                        pettyCashNo, value.lineNo, value.amount, value.receiptNo);
            //                String[] info = status.Split('*');
            //                if (info[0] == "danger")
            //                {
            //                    error = true;
            //                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
            //                                              " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    break;

            //                }
            //            }
            //            catch (Exception r)
            //            {
            //                error = true;
            //                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + r.Message +
            //                                          " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }
            //        }
            //    }
            //}
            //return !error;
            return false;
        }
        protected void loadSurrender()
        {
            var nav = new Config().ReturnNav();
            List<Employee> pettyCashSurrenderlist = new List<Employee>();
            var PettyCashSurrender = nav.Payments.Where(r => r.Payment_Type == "Petty Cash Surrender" && r.Status== "Released" && r.Surrendered == false && r.Posted == true && r.Account_No == Session["employeeNo"].ToString());
            foreach (var item in PettyCashSurrender)
            {
                Employee itemlist = new Employee();
                itemlist.EmployeeNo = item.No;
                itemlist.EmployeeName = item.No + " Of Amount " + item.Petty_Cash_Amount;
                pettyCashSurrenderlist.Add(itemlist);
            }
            pettyCash.DataSource = pettyCashSurrenderlist;
            pettyCash.DataValueField = "EmployeeNo";
            pettyCash.DataTextField = "EmployeeName";
            pettyCash.DataBind();
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            //bool fileuploadSuccess = false;
            //string sUrl = ConfigurationManager.AppSettings["S_URL"];
            //string defaultlibraryname = "ERP%20Documents/";
            //string customlibraryname = "KeRRA/Petty Cash Surrender";
            //string sharepointLibrary = defaultlibraryname + customlibraryname;
            //String leaveNo = Request.QueryString["pettyCashNo"];

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
            //        string uploadfilename = leaveNo + "_" + document.FileName;
            //        Stream uploadfileContent = document.FileContent;

            //        var sDocName = UploadPettyCashSurrender(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

            //        string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

            //        if (!string.IsNullOrEmpty(sDocName))
            //        {
            //            var status = Config.ObjNav.AddPettyCashSurrenderSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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
            //        else
            //        {
            //            documentsfeedback.InnerHtml =
            //                   "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //        }


            //    }
            //    else
            //    {
            //        documentsfeedback.InnerHtml =
            //                   "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //catch (Exception ex)
            //{

            //    throw;
            //}
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Surrender/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            var pettyCashNo = "";
                            if (Request.QueryString["pettyCashNo"] != null)
                            {
                                pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

                            }

                            String documentDirectory = filesFolder + pettyCashNo + "/";
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
                                        Config.navExtender.AddLinkToRecord("Petty Cash Surrender", pettyCashNo, filename, "");
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
        //public string UploadPettyCashSurrender(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        //{
        //    string sDocName = string.Empty;
        //    leaveNo = Request.QueryString["pettyCashNo"];

        //    string parent_folderName = "KeRRA/Petty Cash Surrender";
        //    string subFolderName = leaveNo;
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
        protected void previous_Click(object sender, EventArgs e)
        {
            var pettyCashNo = "";
            if (Request.QueryString["pettyCashNo"] != null)
            {
                pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

            }
            //pettyCash.SelectedValue = pettyCashNo;
            Response.Redirect("PettyCashSurrender.aspx?pettyCashNo=" + pettyCashNo);

        }


        protected void GoBackStep2_Click(object sender, EventArgs e)
        {
            var pettyCashNo = "";
            if (Request.QueryString["pettyCashNo"] != null)
            {
                pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

            }
            Response.Redirect("PettyCashSurrender.aspx?step=2&&pettyCashNo=" + pettyCashNo);


        }

        protected void sendForApproval_Click(object sender, EventArgs e)
        {

            try
            {
                var pettyCashNo = "";
                if (Request.QueryString["pettyCashNo"] != null)
                {
                    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

                }
                String status = Config.ObjNav.SendPettyCashSurrenderApproval(Convert.ToString(Session["employeeNo"]), pettyCashNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }


        //protected void loadRecepts()
        //{
        //    var pettyCashNo = "";
        //    if (Request.QueryString["pettyCashNo"] != null)
        //    {
        //        pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

        //    }
        //    var nav = new Config().ReturnNav();

        //    var query = nav.PettyCashSurrenderLines.Where(x => x.No == pettyCashNo).ToList();

        //    grd_PettyCashSurrender.DataSource = query;
        //    grd_PettyCashSurrender.DataBind();


        //}

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
            //        var parentFolderName = @"ERP%20Documents/KeRRA/Petty Cash Surrender/";
            //        var leaveNo = Request.QueryString["pettyCashNo"];

            //        foreach (char c in password)
            //        { secret.AppendChar(c); }
            //        try
            //        {
            //            ctx.Credentials = new NetworkCredential(account, secret, domainname);
            //            ctx.Load(ctx.Web);
            //            ctx.ExecuteQuery();

            //            Uri uri = new Uri(sharepointUrl);
            //            string sSpSiteRelativeUrl = uri.AbsolutePath;

            //            string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName.Text;

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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Surrender/";
                var pettyCashNo = "";
                if (Request.QueryString["pettyCashNo"] != null)
                {
                    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

                }
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

        protected void step3_Click(object sender, EventArgs e)
        {
            var pettyCashNo = "";
            if (Request.QueryString["pettyCashNo"] != null)
            {
                pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

            }

            Response.Redirect("PettyCashSurrender.aspx?step=3&&pettyCashNo=" + pettyCashNo);

            //try
            //{
            //    //var pettyCashNo = "";
            //    //if (Request.QueryString["pettyCashNo"] != null)
            //    //{
            //    //    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

            //    //}

            //    foreach (GridViewRow row in grd_PettyCashSurrender.Rows)
            //    {
            //        string message = "Amount cannot be equal to zero";
            //        string empNo = Session["employeeNo"].ToString();
            //        int Id = Convert.ToInt32(row.Cells[0].Text);
            //        decimal amt = Convert.ToDecimal(((TextBox)row.FindControl("txtamount")).Text);
            //        string receiptNo = ((DropDownList)row.FindControl("receiptNo")).Text;

            //        if (amt > 0)
            //        {
            //            String status = Config.ObjNav.UpdatePettyCashSurrenderLine(Convert.ToString(Session["employeeNo"]),
            //          pettyCashNo, Id, amt, receiptNo);
            //            String[] info = status.Split('*');
            //            if (info[0] != "danger")
            //            {
            //                linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] +
            //                                          " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }
            //            else
            //            {
            //                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
            //                                          " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //            }
            //        }
            //        else
            //        {
            //            linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message +
            //                                           " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //        }


            //    }



            //}
            //catch (Exception r)
            //{
            //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + r.Message +
            //                              " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}


        }

        protected void grd_PettyCashSurrender_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList receiptNo = (e.Row.FindControl("receiptNo") as DropDownList);



                var pettyCashNo = "";
                if (Request.QueryString["pettyCashNo"] != null)
                {
                    pettyCashNo = Request.QueryString["pettyCashNo"].ToString();

                }
                List<String> list = new List<String>();
                var nav = new Config().ReturnNav();
                var query = nav.receipts.Where(
                            r => r.Fully_Allocated_Imprest == false && r.Posted == true && r.Fully_Allocated == false);
                Item itm = new Item();
                list.Add("");
                foreach (var item in query)
                {

                    list.Add(item.No);
                }


                receiptNo.DataSource = list;
                // receiptNo.DataTextField = "No";
                //receiptNo.DataValueField = "No";
                receiptNo.DataBind();


            }

        }*/
    }


}