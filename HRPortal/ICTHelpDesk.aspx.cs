using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ICTHelpDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCategories();

                var nav = new Config().ReturnNav();
                string docNo = "";
                try
                {
                    docNo = Request.QueryString["jobNo"].ToString();
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
                    //var query = nav.ICTHelpdesk.Where(x => x.Job_No == docNo).ToList();
                    //foreach (var item in query)
                    //{
                    //    try
                    //    {
                    //        category.SelectedValue = item.HelpDesk_Category;
                    //        LoadSubcategories();
                    //    }
                    //    catch (Exception)
                    //    {

                    //    }
                    //    try
                    //    {
                    //        subcategory.Text = item.Sub_Category;
                    //    }
                    //    catch (Exception)
                    //    {

                    //    }
                    //    try
                    //    {
                    //        assettype.SelectedValue = item.Asset_Type;
                    //        LoadAssetInvolved();
                    //    }
                    //    catch (Exception)
                    //    {

                    //    }
                    //    try
                    //    {
                    //        assetinvolved.SelectedValue = item.ICT_Inventory;
                    //    }
                    //    catch (Exception)
                    //    {

                    //    }                                                
                    //}
                    //Description.Text = Config.ObjNav.GetIctDescription(docNo);
                }
            }
        }
        protected void addICTHelpDeskRequest_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string ictCategories = category.SelectedValue.Trim();
            string desc = Description.Text.ToString();
            if (string.IsNullOrEmpty(desc))
            {
                error = true;
                message = "Please enter description ";

            }
            string txtsubcategory = subcategory.SelectedValue;
            string nassettype = assettype.SelectedValue;
            int txtassettype = 0;
            if(nassettype == "Assigned")
            {
                txtassettype = 0;
            }
            if (nassettype == "General")
            {
                txtassettype = 1;
            }
            string txtassetinvolved = assetinvolved.SelectedValue;
            if (error == true)
            {
                ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                try
                {                   

                    string empNo = Convert.ToString(Session["employeeNo"].ToString());
                    string docNo = "";
                    //var status = Config.ObjNav.CreateIctRequest(docNo, empNo, desc, ictCategories, txtsubcategory, txtassettype, txtassetinvolved);

                    //string[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    ictFeedback.InnerHtml = "<div class='alert alert-info'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                    //}
                    //else
                    //{
                    //    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
                catch (Exception ex)
                {
                    ictFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        public void getCategories()
        {
            //var nav = new Config().ReturnNav();
            //var categories = nav.ICTHelpDeskCategory.Where(x=> x.Applies_to_Internal == true).ToList();
            //category.DataSource = categories;
            //category.DataValueField = "Code";
            //category.DataTextField = "Description";
            //category.DataBind();
        }

        protected void category_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadCategories();
        }
        private void loadCategories()
        {
            //var nav = new Config().ReturnNav();
            //string ct = category.SelectedValue;
            //var categories = nav.ICTHelpdeskSubCategory.Where(x => x.Category_Code == ct).ToList();          
            //subcategory.DataSource = categories;
            //subcategory.DataValueField = "Code";
            //subcategory.DataTextField = "Description";
            //subcategory.DataBind();
            //subcategory.Items.Insert(0, new ListItem("--Select--", ""));
        }

        private void LoadSubcategories()
        {
            //var nav = new Config().ReturnNav();
            //string ct = category.SelectedValue;
            //var categories = nav.ICTHelpdeskSubCategory.Where(x => x.Category_Code == ct).ToList();
            //subcategory.DataSource = categories;
            //subcategory.DataValueField = "Code";
            //subcategory.DataTextField = "Description";
            //subcategory.DataBind();
            //subcategory.Items.Insert(0, new ListItem("--Select--", ""));
        }

        protected void assettype_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadAssetInvolved();
        }

        private void LoadAssetInvolved()
        {
            var nav = new Config().ReturnNav();
            string at = assettype.SelectedValue;
            if (at == "Assigned")
            {
                //string empNo = Convert.ToString(Session["employeeNo"]);
                //var Data = nav.ICTInventory.Where(x => x.Blocked == false && x.Current_Assigned_Employee == empNo).ToList();
                //assetinvolved.DataSource = Data;
                //assetinvolved.DataValueField = "Code";
                //assetinvolved.DataTextField = "Description";
                //assetinvolved.DataBind();
                //assetinvolved.Items.Insert(0, new ListItem("--Select--", ""));
            }
            if (at == "General")
            {
                //var Data = nav.ICTInventory.Where(x => x.Blocked == false).ToList();
                //assetinvolved.DataSource = Data;
                //assetinvolved.DataValueField = "Code";
                //assetinvolved.DataTextField = "Description";
                //assetinvolved.DataBind();
                //assetinvolved.Items.Insert(0, new ListItem("--Select--", ""));
            }
        }
        protected void attachFileClick(object sender, EventArgs e)
        {

           try
            {
                //bool documentUploaded = false;
                string path1 = Config.FilesLocation() + "/ICTHelpDesk/";
                string employeeNumber = Convert.ToString(Session["employeeNo"]);
                string folderName = path1 + employeeNumber + "/";
                try
                {
                    if (document.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(document.FileName);
                        if(extension == ".pdf" || extension == ".PDF" || extension == "Pdf")
                        {
                            string fileName = "Evidence" + extension;
                            if (!Directory.Exists(folderName)){
                                Directory.CreateDirectory(folderName);
                            }
                            if(File.Exists(folderName + fileName))
                            {
                                File.Delete(folderName + fileName);
                            }
                            document.SaveAs(folderName + fileName);
                            ictFeedback.InnerHtml = "<div><p>File uploaded successfully</p></div>";
                        }
                        else
                        {
                            ictFeedback.InnerHtml = "<div><p>The file extension is not supported</p></div>";
                        }

                    }
                    else
                    {
                        ictFeedback.InnerHtml = "<div><p>No file has been attached</p></div>";
                    }
                }
                catch(Exception ex)
                {
                  
                }
            }
            catch(Exception)
            {

            }

        }
    }
}