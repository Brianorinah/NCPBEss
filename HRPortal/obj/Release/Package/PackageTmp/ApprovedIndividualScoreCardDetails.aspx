<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovedIndividualScoreCardDetails.aspx.cs" Inherits="HRPortal.ApprovedIndividualScoreCardDetails" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Approved Staff Annual Workplan Details</li>
            </ol>
        </div>
    </div>
<div class="panel panel-primary">
    <%
       var nav = new Config().ReturnNav();
       var IndividualPCNo = Request.QueryString["IndividualPCNo"];   
    %>

        <div class="panel panel-heading">
            <h3 class="panel-title">Approved Staff Annual Workplan Details</h3>
        </div>  
            <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#coreinitiatives" data-toggle="tab"   <h3 class="panel-title" style="color:black">Core Initiatives</h3></a>
                        </li>
<%--                        <li style="background-color:#D3D3D3">
                            <a href="#additional" data-toggle="tab"><h3 class="panel-title" style="color:black">Additional Initiatives</h3></a>
                        </li>--%>
                      <li style="background-color:#D3D3D3">
                            <a href="#jd" data-toggle="tab"><h3 class="panel-title" style="color:black">Job Description </h3></a>
                        </li>
                    </ul>
               </ul>
            <div class="tab-content">
                <div id="coreinitiatives" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">Core Initiatives</h3>
                        </div>
                            <table class="table table-bordered table-striped datatable" id="example6">
                                <thead>
                                    <tr>
                                        <th>Objective/Initiative</th>
                                        <th>Start Date</th>
                                        <th>Due Date</th>
                                        <th>Agreed Target</th>
                                        <th>Assigned Weight</th>
                                        <th>Comments</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%     
                                              
                                        var coreInitiatives = nav.PCObjective.Where(x => x.Workplan_No == IndividualPCNo).ToList();
                                        foreach (var initative in coreInitiatives)
                                        {
                                    %>
                                    <tr>
                                        <td><% =initative.Objective_Initiative%> </td>                         
                                        <td><%=Convert.ToDateTime(initative.Due_Date).ToString("dd/MM/yyyy") %></td>
                                        <td><%=Convert.ToDateTime(initative.Due_Date).ToString("dd/MM/yyyy") %></td>
                                        <td><%=initative.Imported_Annual_Target_Qty %></td>
                                        <td><%=initative.Assigned_Weight %></td>
                                        <td><%=initative.Additional_Comments %></td>
                                        <%
                                            }

                                        %>
                                </tbody>
                          </table>
                    </div>
                  </div>
         
<%--                    <div id="additional" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Additional Initiatives</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example1">
                                    <thead>
                                        <tr>
                                            <th>Objective/Initiative</th>
                                            <th>Start Date</th>
                                            <th>Due Date</th>
                                            <th>Agreed Target</th>
                                            <th>Assigned Weight</th>
                                            <th>Comments</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <% 
                                        var additionalInitiatives = nav.SecondaryPCObjective.Where(x => x.Workplan_No == IndividualPCNo).ToList();
                                        foreach (var item in additionalInitiatives)
                                        {
                                        %>
                                        <tr>
                                            <td><% =item.Objective_Initiative%> </td>                      
                                            <td><%= Convert.ToDateTime(item.Start_Date).ToString("d/MM/yyyy") %></td>
                                            <td><%= Convert.ToDateTime(item.Due_Date).ToString("d/MM/yyyy") %></td>
                                            <td><%=item.Imported_Annual_Target_Qty %></td>
                                            <td><%=item.Assigned_Weight %></td>
                                            <td><%=item.Comments %></td>
                                            <%
                                            }

                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>--%>
                    <div id="jd" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Job Description</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example4">
                                    <thead>
                                        <tr>
                                            <th>Job Description </th>
                                            <th>Annual Target</th>
                                            <th>Assigned Weight</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var JD = nav.PCJobDescription.Where(x => x.Workplan_No == IndividualPCNo).ToList();
                                            foreach (var item in JD)
                                            {
                                        %>
                                        <tr>
                                            <td><% =item.Description%> </td>
                                            <td><%=item.Imported_Annual_Target_Qty %></td>
                                            <td><%=item.Assigned_Weight %></td>
                                            <%
                                                }

                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                  </div>
            </div>
</asp:Content>
