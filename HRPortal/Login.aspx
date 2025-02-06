<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HRPortal.Login" %>

<%@ Import Namespace="System.Globalization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - NCPB</title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="LoginAssets/images/ncpb.png" rel="shortcut icon" type="image/x-icon" />

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet" />


    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="bower_components/select2/dist/css/select2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">

    <!-- jvectormap -->
    <link rel="stylesheet" href="bower_components/jvectormap/jquery-jvectormap.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="plugins/timepicker/bootstrap-timepicker.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="bower_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="CustomCss/CustomCss.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="fullcalendar/fullcalendar.css">
    <script src="fullcalendar/lib/moment.min.js"></script>
    <script src="fullcalendar/lib/jquery-ui.custom.min.js"></script>
    <script src="fullcalendar/fullcalendar.min.js"></script>

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">


</head>
<body>
    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">

            <div class="col-md-6 col-lg-6 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-3 col-sm-offset-3">

                <div class="panel" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px;">
                    <div class="text-center">
                        <img src="LoginAssets/images/ncpb.png" width="200" height="200" />
                    </div>

                    <h3 style="width: 100%; text-align: center; color: black">Employee Self Service Portal</h3>
                    <hr />
                    <div style="padding: 20px;">
                        <div id="feedback" runat="server"></div>
                        <div class="form-group">
                            <label>Username<span style="color: red">*</span></label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="username" Placeholder="Enter Your Username" Style="height: 42px;" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="username" ErrorMessage="Please Enter Your Employee Number, it cannot be empty!" ForeColor="Red" />
                        </div>
                        <div class="form-group">
                            <label>Password<span style="color: red">*</span></label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="password" Placeholder="Enter Account Password" type="password" Style="height: 42px;" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="password" ErrorMessage="Please Enter Account Password, it cannot be empty!" ForeColor="Red" />
                        </div>
                        <hr />
                        <p style="color: black">Forgot Your Password/First Time Use?<a href="ForgotPass.aspx" style="color: blue"> Click Here To Reset/Get Password</a></p>
                        <br />
                    </div>

                    <div style="background-color: #ececec; padding: 10px;">
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="login" Text="Login" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;" OnClick="login_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-sm-8 col-xs-12 col-md-offset-2 col-sm-offset-2" style="text-align: center;">
                <hr />
                &copy; <%: DateTime.Now.Year %> -Design by  <a href="http://www.dynasoft.co.ke" runat="server" target="blank">Dynasoft Business Solutions</a>
            </div>
        </div>
        <script type="text/javascript">
            $('#<%= OTPInput.ClientID %>').val('');
            function openModal() {
                $('#removeLineModal').modal();
            }
        </script>
        <div id="removeLineModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div id="generalFeedback" runat="server"></div>
                    <div class="modal-header">
                        <h4 class="modal-title" id="modalfeedback" runat="server"></h4>
                    </div>
                    <div id="account" runat="server">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="email address">OTP</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="OTPInput" TextMode="Number"></asp:TextBox>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm" ID="Confirm" OnClick="Confirm_Click" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="bower_components/jquery-ui/jquery-ui.min.js"></script>
        <script>
            $.widget.bridge('uibutton', $.ui.button);
        </script>
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
        <script src="bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
        <script src="bower_components/moment/min/moment.min.js"></script>
        <script src="bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script src="bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
        <!-- Slimscroll -->
        <script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <!-- FastClick -->
        <script src="bower_components/fastclick/lib/fastclick.js"></script>
        <script src="bower_components/select2/dist/js/select2.full.min.js"></script>
        <!-- AdminLTE App -->
        <script src="dist/js/adminlte.min.js"></script>
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="dist/js/pages/dashboard.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="dist/js/demo.js"></script>
        <script src="MeScripts/StaffPerformanceContract.js"></script>
        <script src="MeScripts/PCadditionalActivities.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!-- DataTables -->
        <script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
        
    </form>

</body>
</html>
