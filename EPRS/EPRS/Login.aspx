<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EPRS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="body-full-height">
<head>
    <title>Login - Book or Rent your spot</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script type="text/javascript" src="js/plugins/jquery/jquery.js"></script>
    <script type="text/javascript" src="js/plugins/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
        function openModal(head, message) {
            $(window).load(function () {
                $('#headtxt').html(head);
                $('#bodytxt').html(message);
                $('#myModal').modal('show');
            });
        }
    </script>
    <link rel="icon" href="../favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="css/theme-default.css" />
</head>
<body>
    <div class="login-container">
        <div class="login-box animated fadeInDown">
            <div class="login-logo"></div>
            <div class="login-body">
                <div class="login-title"><strong>Welcome</strong>, Please login</div>
                <form runat="server" class="form-horizontal">
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" ID="txtUsername" type="text" class="form-control" placeholder="Username" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" EnableClientScript="true" Enabled="true" ValidationGroup="r" CssClass="text-danger" Display="Dynamic" ErrorMessage="Cannot be blank"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" ID="txtPassword" type="password" class="form-control" placeholder="Password" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtPassword" EnableClientScript="true" Enabled="true" ValidationGroup="r" CssClass="text-danger" ErrorMessage="Cannot be blank"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-6">
                            <a href="Register.aspx" class="btn btn-link btn-block">New User? Register</a>
                        </div>
                        <div class="col-md-6">
                            <asp:Button runat="server" ID="btnLogin" ValidationGroup="r" class="btn btn-info btn-block" Text="Log In" OnClick="btnLogin_Click"></asp:Button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="headtxt">Error.</h4>
                </div>
                <div class="modal-body">
                    <p id="bodytxt">Sorry we are experiencing some issues, try again in sometime.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
