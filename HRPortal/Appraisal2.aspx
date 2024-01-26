<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Appraisal2.aspx.cs" Inherits="HRPortal.Appraisal2" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Appraisal</li>
            </ol>
        </div>
    </div>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Appraisal General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

             <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
            </div>
             <div class="row">
                <div class="col-md-6 col-lg-6">
                     <div class="form-group">
                    <strong>Job title:</strong>
                    <asp:TextBox runat="server" ID="jobtitle" CssClass="form-control" />
                </div>
                </div>
                <div class="col-md-6 col-lg-6">
                     <div class="form-group">
                    <strong>Appraisal Period:</strong>
                    <asp:TextBox runat="server" ID="appraisalperiod" CssClass="form-control" ReadOnly />
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Appraisal Start Date</label>
                        <asp:TextBox runat="server" ID="appraisalstartdate" CssClass="form-control" ReadOnly/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Goal Setting Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="goalsettingstartdate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Goal Setting End Date</label>
                        <asp:TextBox runat="server" ID="goalsettingenddate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">MY Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="mystartdate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">MY End Date</label>
                        <asp:TextBox runat="server" ID="myenddate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">EY Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="eystartdate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">EY End Date</label>
                        <asp:TextBox runat="server" ID="eyenddate" CssClass="form-control" ReadOnly />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                    <strong>Supervisor name:</strong>
                    <asp:TextBox runat="server" ID="supervisor" CssClass="form-control" />
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                    <strong>Overview manager name:</strong>
                    <asp:TextBox runat="server" ID="overviewmanager" CssClass="form-control" />
                </div>
                </div>
            </div>
              
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
        </div>
    </div>
    <%
        }

        if (step == 2)
        {
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Employee Appraisal KRAs
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Perspective</th>
                        <th>KRA</th>
                        <th>Objective</th>
                        <th>Agreed Rating</th>
                        <th>Maximum Weight</th>
                        <th>Total Weight</th>
                        <th>Mid Year Overall Rating</th>
                        <th>#</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String appNo = Request.QueryString["applicationNo"];
                        

                        String job = Config.ObjNav1.fnGetEmployeeAppraisalKRAs(appNo);
                        String[] allInfo = job.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (allInfo != null)
                        {
                            foreach(var item in allInfo)
                            {
                                String[] arr = item.Split('*');
                                %>
                    <tr>
                    <td><%=arr[1] %></td>
                    <td><%=arr[2] %></td>
                    <td><%=arr[3] %></td>
                    <td><%=arr[4] %></td>
                    <td><%=arr[5] %></td>
                    <td><%=arr[6] %></td>
                    <td><%=arr[7] %></td>
                    <td><a href="EmployeeAppraisalKPIs.aspx?applicationNo=<%=appNo %>&&KRA=<%=arr[1] %>&&kraLineNo=<%= arr[8] %>" class="btn btn-success"><i class="fa fa-edit"></i></a></td>
                    </tr>
                        <%
                            }
                        }
                         %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <%
    String appNo1 = Request.QueryString["applicationNo"];
    if (!string.IsNullOrEmpty(appNo))
    {
        String job1 = Config.ObjNav1.fnGetAppraisalApplicationDetails(appNo1);
        String[] arr1 = job1.Split('*');

        if (arr1[11] == "New" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
        {
                        %>
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send To Line Manager"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
    }
    else if (arr1[11] == "Supervisor Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
    {
                    %>
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Send Back To Appraisee" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send To Overview Manager"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
                    }
                    else if (arr1[11] == "Overview Manager" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                    {
                        %>
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" OnClick="sendBack_Click" Text="Send Back To Line Manager" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Approve"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
                    }//MY Appraisee Level
                    else if (arr1[15] == "Appraisee Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                    {
                                %>
                         <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
                         <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Nex"  OnClick="competence_Click" /><div class="clearfix"></div>
            <%
                    }// MY Supervisor level
                    else if(arr1[15] == "Appraisee Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                    {
                        %>
                         <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
                         <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Nex"  OnClick="competence_Click" /><div class="clearfix"></div>
            <%
                    }
                }
                 %>
            
        </div>
    </div>
    <%
        }
        else if (step == 3)
        {
            %>
        <div class="panel panel-primary">
        <div class="panel-heading">
            Employee Appraisal Competence
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="Div1" runat="server"></div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Maximum Weight</th>
                        <th>Overall Rating</th>
                        <th>Total Weight</th>
                        <th>Mid Year Overall Rating</th>
                        <th>#</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String appNo = Request.QueryString["applicationNo"];
                        

                        String job = Config.ObjNav1.fnGetEmployeeAppraisalCompetence(appNo);
                        String[] allInfo = job.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (allInfo != null)
                        {
                            foreach(var item in allInfo)
                            {
                                String[] arr = item.Split('*');
                                %>
                    <tr>
                    <td><%=arr[1] %></td>
                    <td><%=arr[2] %></td>
                    <td><%=arr[3] %></td>
                    <td><%=arr[4] %></td>
                    <td><%=arr[5] %></td>
                    <td><a href="EmployeeAppraisalCompetence.aspx?applicationNo=<%=appNo %>&&CategoryLineNo=<%=arr[6] %>" class="btn btn-success"><i class="fa fa-edit"></i></a></td>
                    </tr>
                        <%
                            }
                        }
                         %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <%
    String appNo1 = Request.QueryString["applicationNo"];
    if (!string.IsNullOrEmpty(appNo))
    {
        String job1 = Config.ObjNav1.fnGetAppraisalApplicationDetails(appNo1);
        String[] arr1 = job1.Split('*');

        if (arr1[11] == "New" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
        {
                        %>
             <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send To Line Manager"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
    }
    else if (arr1[11] == "Supervisor Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
    {
                    %>
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Send Back To Appraisee" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send To Overview Manager"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
                    }
                    else if (arr1[11] == "Overview Manager" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                    {
                        %>
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" OnClick="sendBack_Click" Text="Send Back To Line Manager" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Approve"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
                    }//MY Appraisee Level
                    else if (arr1[15] == "Appraisee Level" && arr1[12] == "No" && arr1[13] == "No" && arr1[14] == "No")
                    {
                                %>
                         <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" />
                         <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send To Line Manager"  OnClick="submit_Click" /><div class="clearfix"></div>
            <%
                    }
                }
                 %>
            
        </div>
    </div>
    <%

        }
         %>
   
</asp:Content>
