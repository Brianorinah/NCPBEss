<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubPlogIndicators.aspx.cs" Inherits="HRPortal.SubPlogIndicators" %>

<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>Performance Log Sub Activities
        </h1>
        <ol class="breadcrumb" style="background-color: antiquewhite">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Plog</a></li>
            <li><a href="imprest.aspx">Sub Plog lines</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Sub Activities
            </div>
            <div class="panel-body">
                <div runat="server" id="FeedBack"></div>
                <table id="example5" class="table table-bordered table-striped PlogSubIndicatorTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Description</th>
                            <th>Due Date</th>
                            <th>Unit of Measure</th>
                            <th>Target Qty</th>
                            <th>Weight</th>
                            <th>Add/Edit Details</th>
                            <th>Save Status</th>

                        </tr>
                    </thead>

                    <tbody>
                        <%
                            var PlogNo = Request.QueryString["PlogNo"];
                            var InitiativeNo = Request.QueryString["InitiativeNo"];
                            var PCID = Request.QueryString["PCID"];
                            int counter = 0;
                            var nav = new Config().ReturnNav();
                            var performancelogs = nav.SubPlogLines.Where(r => r.Personal_Scorecard_ID == PCID && r.PLog_No == PlogNo && r.Initiative_No == InitiativeNo);
                            foreach (var performancelog in performancelogs)
                            {
                                counter++;
                        %>
                        <tr>
                            <td><% =counter %></td>
                            <td><% =performancelog.Description %></td>
                            <td><% = Convert.ToDateTime(performancelog.Planned_Date).ToString("dd/MM/yyyy")%></td>
                            <td><% =performancelog.Unit_of_Measure %></td>
                            <td><% =performancelog.Target_Qty %></td>
                            <td><% =performancelog.Weight %></td>
                            <%
                                if (performancelog.Achieved_Target > 0 || performancelog.Comments.Length > 0)
                                {
                            %>
                            <td>
                                <label class="btn btn-warning" onclick="moredetails('<%=performancelog.EntryNo %>','<%=performancelog.Description %>','<%=performancelog.Achieved_Date %>'
                                     ,'<%=performancelog.Unit_of_Measure %>','<%=performancelog.Target_Qty %>','<%=performancelog.Achieved_Target %>','<%=performancelog.Comments %>'
                                     ,'<%=performancelog.Variances %>');">
                                    <i class="fa fa-edit"></i>Edit Details</label>
                            </td>
                            <%
                                }
                                else
                                {
                            %>
                            <td>
                                <label class="btn btn-info" onclick="moredetails('<%=performancelog.EntryNo %>','<%=performancelog.Description %>','<%=performancelog.Achieved_Date %>'
                                     ,'<%=performancelog.Unit_of_Measure %>','<%=performancelog.Target_Qty %>','<%=performancelog.Achieved_Target %>','<%=performancelog.Comments %>'
                                     ,'<%=performancelog.Variances %>');">
                                    <i class="fa fa-plus"></i>Add Details</label>
                            </td>
                            <%
                                }
                            %>
                            <%
                                if (performancelog.Achieved_Target > 0 || performancelog.Comments.Length > 0)
                                {
                            %>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-check"></i>Details Saved</label>
                            </td>
                            <%
                                }
                                else
                                {
                            %>
                            <td>
                                <label class="btn btn-danger"><i class="fa fa-times"></i>Details Not Saved</label>
                            </td>
                            <%
                                }
                            %>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </section>
<script>
    function moredetails(entryNo, desc, achieveddate, uom, targetqty, achievedqty, achdesc, rsnvar) {
        document.getElementById("descName").innerText = desc;
        document.getElementById("ContentPlaceHolder1_txtdescName").value = desc;
        document.getElementById("ContentPlaceHolder1_pentryNo").value = entryNo;
      //  var nowstartdate = achieveddate.split(' ')[0];
     //   $('#ContentPlaceHolder1_editcompletiondate').datepicker({ dateFormat: 'd/M/yyyy' }, "update").val(nowstartdate);
        document.getElementById("ContentPlaceHolder1_puom").value = uom;
        //document.getElementById("ContentPlaceHolder1_startDate").value = achieveddate;
        document.getElementById("ContentPlaceHolder1_ptargetqty").value = targetqty;
        document.getElementById("ContentPlaceHolder1_pachievedqty").value = achievedqty;
        document.getElementById("ContentPlaceHolder1_pachdesc").value = achdesc;
        document.getElementById("ContentPlaceHolder1_prsnvar").value = rsnvar;
        $("#moredetailsmodal").modal();
    }
</script>
    <div id="moredetailsmodal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><strong id="descName"></strong></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="pentryNo" type="hidden"/>
                    <asp:TextBox runat="server" ID="txtdescName" type="hidden"/>
                    <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Unit of Measure</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="puom" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Target Quantity</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ReadOnly="true" ID="ptargetqty" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achieved Target</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="pachievedqty" />
                        </div>
                    </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Achieved Date</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="prof_startDate"  placeholder="Select Achieved Date"/>
                            </div>
                        </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Achievement Description</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="pachdesc" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Reason for Variances</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="prsnvar" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload Evidence</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="txtfileupload" />
                        </div>
                    </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save / Update " ID="savesubPlogLine" OnClick="savesubPlogLine_Click"/>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
