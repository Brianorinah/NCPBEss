<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ICTHelpDesk.aspx.cs" Inherits="HRPortal.ICTHelpDesk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">

        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="#">Help Desk </a></li>
                <li class="breadcrumb-item active">Help Desk Request</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Send Request to ICT Help Desk
        <span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="ictFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>ICT Issue Category<span style="color:red">*</span></strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="category" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="category_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="category" InitialValue="--Select--" ErrorMessage="Please select issue category, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>ICT Issue Sub Category<span style="color:red">*</span></strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="subcategory" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="subcategory" InitialValue="--Select--" ErrorMessage="Please select isssue sub category, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Asset Type</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="assettype" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="assettype_SelectedIndexChanged">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem>Assigned</asp:ListItem>
                            <asp:ListItem>General</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Asset Involved</strong>
                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="assetinvolved" />
                    </div>
                </div>
            </div>   
            <div class="row">
                 <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <strong>Description<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="Description" CssClass="form-control" placeholder="Description" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter description, it cannot be empty!" ForeColor="Red" />
                    </div>

                </div>
            </div>            
                    <div class="row">        
                   <div class="col-md-6 col-lg-6">
                       <div class="form-group">
                        <strong>Attach supporting files (where applicable)</strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                    </div>
                </div>
                    <div class="col-md-4 col-lg-4">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success"  Text="Upload Screenshot" ID="uploadDocument" OnClick="attachFileClick" />
                        </div>
                    </div>
                </div>              
            </div>

      
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Send Request"
                ID="addICTHelpDeskRequest" OnClick="addICTHelpDeskRequest_Click" />
            <span class="clearfix"></span>
        </div>
    </div>

</asp:Content>
