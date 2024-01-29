<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StaffCreditSales.aspx.cs" Inherits="HRPortal.StaffCreditSales" %>
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
                <li class="breadcrumb-item active">Staff Credit Sales Application</li>
            </ol>
        </div>
    </div>
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"].Trim());
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
            Staff Credit Sales Application
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
                        <asp:Label runat="server" ID="empname" class="form-control"  readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
                 <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Document Date<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="DocumentDate" TextMode="Date" CssClass="form-control" placeholder="Document Date"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="DocumentDate" ErrorMessage="Please enter Document Date, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Current Balance<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="currentBalance" CssClass="form-control" placeholder="0.00" ReadOnly="true" />
                  
                </div>
            </div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                      <strong>Total<span style="color: red">*</span></strong>
                      <asp:TextBox runat="server" ID="total" CssClass="form-control" placeholder="0.00" ReadOnly="true" />
                      
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                      <strong>Region<span style="color: red">*</span></strong>
                      <asp:TextBox runat="server" ID="region" CssClass="form-control" placeholder="Region" ReadOnly="true" />
                      
                </div>
            </div>
                 <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                      <strong>Budget Center<span style="color: red">*</span></strong>
                      <asp:TextBox runat="server" ID="budget" CssClass="form-control" placeholder="budget" ReadOnly="true" />
                      
                </div>
            </div>
                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Recovery Period <span style="color: red">*</span></strong>
                         <asp:DropDownList runat="server" ID="RecoveryCode" CssClass="form-control select2">                        
                    </asp:DropDownList>
                    </div>
                </div>
                   <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Depot Code <span style="color: red">*</span></strong>
                         <asp:DropDownList runat="server" ID="DepotCode" CssClass="form-control select2" OnSelectedIndexChanged="depot_SelectedIndexChanged" AutoPostBack="true">                        
                    </asp:DropDownList>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="DepotCode" InitialValue="--Select--" ErrorMessage="Please select Depot Code, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                 <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <strong>Location Code <span style="color: red">*</span></strong>
                         <asp:DropDownList runat="server" ID="LocationCode" CssClass="form-control select2" >                                                     
                    </asp:DropDownList>
                         <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="LocationCode" InitialValue="--Select--" ErrorMessage="Please select Location Code, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                   </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" ID="apply" CssClass="btn btn-success pull-right" Text="Next" OnClick="apply_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% 
        }
        else if (step == 2)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
           Staff Credit Sales Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>

            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Product Code<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="ProductCode" CssClass="form-control select2" OnSelectedIndexChanged="product_SelectedIndexChanged" AutoPostBack="true">                        
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="ProductCode" InitialValue="--Select--" ErrorMessage="Please select Product Code, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Product Description</strong>
                    <asp:TextBox runat="server" ID="ProductDescription" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
              <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Unit Of Measure</strong>
                    <asp:TextBox runat="server" ID="measure" CssClass="form-control" ReadOnly="true"/>                  
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Unit Price</strong>
                    <asp:TextBox runat="server" ID="UnitPrice" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
             <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Quantity<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="quantity" CssClass="form-control" TextMode="Number" AutoPostBack="true"/>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="quantity" InitialValue="--Select--" ErrorMessage="Please Enter Quantity, it cannot be empty!" ForeColor="Red" AutoPostBack="true" />
                </div>
            </div>
             <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Total Price</strong>
                    <asp:TextBox runat="server" ID="TotalPrice" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Item" ID="addItem" OnClick="addItem_Click" />
                </div>
            </div>
            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Product Code</th>
                        <th>Product Description</th>
                        <th>Unit of Measure</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Price </th>
                        <th>Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String documentNo = Request.QueryString["documentNo"];
                        String employeeNo = Convert.ToString(Session["employeeNo"]);
                        var nav = Config.ObjNav1;
                        var result = nav.fnGetStaffCreditSalesLines(documentNo);
                        String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info.Count() > 0)
                        {
                            if (info != null)
                            {
                                foreach (var allinfo in info)
                                {
                                    String[] arr = allinfo.Split('*');

                    %>
                    <tr>                        
                        <td><% =arr[0] %></td>
                        <td><% =arr[1] %></td>
                        <td><% = arr[2] %></td>
                         <td><% =arr[3] %></td>   
                        <td><% = arr[4] %></td>
                        <td><% = arr[5] %></td> 
                          

                        <td>
                            <label class="btn btn-danger" onclick="removeLine(documentNo,'<%=arr[4] %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% 
                            }
                        }
                    }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />

            <div class="clearfix"></div>
        </div>
    </div>
   <% 
        }
        else if (step == 3)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
           Staff Credit Sales 
              <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="documentsfeedback"></div>
                 </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed2_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send Approval Request" OnClick="sendApproval_Click" ID="sendApproval" />
            
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
    %>
  <script>
    function removeRow(button) {
        var row = button.closest('tr');
        row.remove();
    }
</script>
</asp:Content>

