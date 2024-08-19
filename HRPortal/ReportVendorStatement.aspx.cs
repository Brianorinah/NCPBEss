using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPortal.Models;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Text;
using System.Configuration;
using System.Threading;

namespace HRPortal
{
    public partial class ReportVendorStatement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    //BindVendorData();

                    var jobs1 = Config.ObjNav1.fnGetVendorPostingGroup();
                    List<ItemList> itms1 = new List<ItemList>();
                    string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz1.Count() > 0)
                    {
                        foreach (var allInfo in infoz1)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            itms1.Add(mdl);
                        }
                    }

                    vendorPostingGroup.DataSource = itms1;
                    vendorPostingGroup.DataTextField = "description";
                    vendorPostingGroup.DataValueField = "code";
                    vendorPostingGroup.DataBind();
                    vendorPostingGroup.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                   
                    //var items = Config.ObjNav1.fnGetVendors();
                    //List<ItemList> itms = new List<ItemList>();
                    //string[] infoItems = items.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    //if (infoItems.Count() > 0)
                    //{
                    //    foreach (var allInfo in infoItems)
                    //    {
                    //        String[] arr = allInfo.Split('*');

                    //        ItemList mdl = new ItemList();
                    //        mdl.code = arr[0];
                    //        mdl.description = arr[0] + "-" + arr[1];
                    //        itms.Add(mdl);
                    //    }
                    //}

                    //accNo.DataSource = itms;
                    //accNo.DataTextField = "description";
                    //accNo.DataValueField = "code";
                    //accNo.DataBind();
                    //accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                }
                catch (Exception ex)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
        }
       

        protected void generate_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = (String)Session["employeeNo"];              
                string taccNo = accNo.SelectedValue.Trim();                
                string tvendorPostingGroup = vendorPostingGroup.SelectedValue.Trim();
                DateTime tdateFilter = new DateTime();
                DateTime tdateFilterEnd = new DateTime();

                if (!string.IsNullOrEmpty(dateFilter.Text.Trim()))
                {
                    tdateFilter = Convert.ToDateTime(dateFilter.Text.Trim());
                }
                if (!string.IsNullOrEmpty(endDate.Text.Trim()))
                {
                    tdateFilterEnd = Convert.ToDateTime(endDate.Text.Trim());
                }
                if (string.IsNullOrEmpty(taccNo))
                {
                    taccNo = "";
                }
                if (string.IsNullOrEmpty(tvendorPostingGroup))
                {
                    tvendorPostingGroup = "";
                }
                

                string status = Config.ObjNav2.VendorStatementReport(taccNo, tvendorPostingGroup, tdateFilter, tdateFilterEnd);
                if (status != "danger" && !string.IsNullOrEmpty(status))
                {
                    bool downloaded = ConvertAndDownloadToLocal(status);
                    if (downloaded)
                    {
                        reportViewFrame.Attributes.Add("src", ResolveUrl("~/Downloads/" + string.Format("{0}.pdf", empNo)));
                    }
                    else if (status == "danger")
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Document could not be found.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while generating your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error ocuured while pulling your document.The provided filter does not have ant data.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        public bool ConvertAndDownloadToLocal(string base64String)
        {
            Boolean uploaded = false;
            try
            {

                string employeeNumber = (String)Session["employeeNo"];

                string filesFolder = Server.MapPath("~/Downloads/");
                string fileName = employeeNumber + ".pdf";
                string documentDirectory = filesFolder + "/";
                string filePath = documentDirectory + fileName;

                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }

                byte[] fileBytes = Convert.FromBase64String(base64String);


                using (StreamWriter writer = new StreamWriter(filePath, false))
                {
                    writer.BaseStream.Write(fileBytes, 0, fileBytes.Length);
                }

                return true;


            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., invalid base64 string)
                //TempData["error"] = ex.Message;
                return false;
            }
        }
        private async void BindVendorData()
        {
            
            List<Vendor> vendors = await FetchVendorData();

            accNo.DataSource = vendors;
            accNo.DataTextField = "Name";
            accNo.DataValueField = "No";
            accNo.DataBind();

            // Add a default item if needed
            accNo.Items.Insert(0, new ListItem("Select a Vendor", ""));
        }
       
        private async Task<List<Vendor>> FetchVendorData()
        {
            try
            {
                string username = ConfigurationManager.AppSettings["W_USER"];
                string password = ConfigurationManager.AppSettings["W_PWD"];
                string domain = ConfigurationManager.AppSettings["DOMAIN"];
                //string APICall_url = ConfigurationManager.AppSettings["API_URL"];

                string apiUrl = "http://dynamics.cereals:7048/BC220/ODataV4/Company('NCPB')/VendorQuery";                

                var handler = new HttpClientHandler
                {
                    Credentials = new NetworkCredential(username, password, domain)
                };


                using (var client = new HttpClient(handler) { Timeout = TimeSpan.FromSeconds(30) })
                {
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    HttpResponseMessage response = await client.GetAsync(apiUrl);

                    response.EnsureSuccessStatusCode();

                    string responseBody = await response.Content.ReadAsStringAsync();
                    ODataResponse odataResponse = JsonConvert.DeserializeObject<ODataResponse>(responseBody);

                    return odataResponse.Value;
                }
            }
            catch(Exception ex)
            {
                string error = ex.Message;
                return new List<Vendor>();
            }
        }
        protected void searchBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tsearchBy = searchBy.SelectedValue.Trim();
            string tcustSearch = custSearch.Text.Trim();

            if (tsearchBy == "0")
            {
                var items = Config.ObjNav1.fnGetVendorsId(tcustSearch);
                List<ItemList> itms = new List<ItemList>();
                string[] infoItems = items.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoItems.Count() > 0)
                {
                    foreach (var allInfo in infoItems)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        itms.Add(mdl);
                    }
                }
                accNo.DataSource = itms;
                accNo.DataTextField = "description";
                accNo.DataValueField = "code";
                accNo.DataBind();
                accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

            }
            else
            {
                var items = Config.ObjNav1.fnGetVendorsName(tcustSearch);
                List<ItemList> itms = new List<ItemList>();
                string[] infoItems = items.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoItems.Count() > 0)
                {
                    foreach (var allInfo in infoItems)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        itms.Add(mdl);
                    }
                }
                accNo.DataSource = itms;
                accNo.DataTextField = "description";
                accNo.DataValueField = "code";
                accNo.DataBind();
                accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
            }
        }
    }
    
}