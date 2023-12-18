<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SecurityIncident.aspx.cs" Inherits="HRPortal.SecurityIncident" %>

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
                <li class="breadcrumb-item active">Security Incident</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Security Incident  Details             
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Employee No.<span style="color: red">*</span></label>
                    <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Employee Name<span style="color: red">*</span></label>
                    <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Date Reported<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="datereported" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Time Reported<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="timereported" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Date Occured<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="tr_StartDate" placeholder="Please enter date occured" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="tr_StartDate" ErrorMessage="Please select date occured, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Time Occured<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="timeoccured" TextMode="Time" placeholder="Please select time occured" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="timeoccured" ErrorMessage="Please enter time occured, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Incident Type<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" class="form-control" ID="incidenttype" AppendDataBoundItems="true" OnSelectedIndexChanged="incidenttype_SelectedIndexChanged">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="incidenttype" InitialValue="--Select--" ErrorMessage="Please Select Incident Type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divsincidenttype" visible="false">
                <div class="form-group">
                    <label class="span2">Specify Incident Type<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="sincidenttype" placeholder="Please specify incident type" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="sincidenttype" ErrorMessage="Please specify incident type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Severity Level<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" class="form-control" ID="severitylevel" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem>Minor</asp:ListItem>
                        <asp:ListItem>Major</asp:ListItem>
                        <asp:ListItem>Critical</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="severitylevel" InitialValue="--Select--" ErrorMessage="Please Select Severity Level, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">Party Involved<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" class="form-control" ID="partyinvolved" AppendDataBoundItems="true" OnSelectedIndexChanged="partyinvolved_SelectedIndexChanged">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="partyinvolved" InitialValue="--Select--" ErrorMessage="Please Select Party Involved, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6" runat="server" id="divspartyinvolved" visible="false">
                <div class="form-group">
                    <label class="span2">Specify Party Involved<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" class="form-control" ID="spartyinvolved" placeholder="Please specify party involved" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="spartyinvolved" ErrorMessage="Please party involved, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <label class="span2">Incident Details<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="description" CssClass="form-control" PlaceHolder="Please Enter Description" TextMode="MultiLine" Height="100px" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Submit Security Incident" ID="submit" OnClick="submit_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
</asp:Content>
