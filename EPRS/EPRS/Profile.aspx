<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="EPRS.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <br />
    <br />
    <div class="page-content-wrap">
        <div class="row">
            <div class="col-md-3 col-sm-4 col-xs-5">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3>
                            <asp:Label ID="lblusername" Text="" runat="server"></asp:Label></h3>
                        <div class="text-center" id="user_image">
                            <asp:Image runat="server" ID="imProfile" ImageUrl="~/images/Profile.jpg" AlternateText="Profile Picture" class="img-thumbnail" />
                        </div>
                    </div>
                    <div class="panel-body form-group-separated">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">#ID</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtID" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">Login</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtUsername" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">E-mail</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtEmail" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-12 col-xs-12">
                                <a href="#" class="btn btn-danger btn-block btn-rounded" data-toggle="modal" data-target="#modal_change_password">Change password</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-9 col-sm-8 col-xs-7">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3><span class="fa fa-pencil"></span>&nbsp;&nbsp;Profile</h3>
                        <p>You can edit the below profile information and click save.</p>
                    </div>
                    <div class="panel-body form-group-separated">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">First Name</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtFirstname" runat="server" class="form-control text-primary"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">Last Name</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtLastName" runat="server" class="form-control text-primary"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">Phone</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtPhone" runat="server" class="form-control text-primary" MaxLength="10"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12 col-xs-5">
                                <asp:Button runat="server" ID="btnUpdate" class="btn btn-primary btn-rounded pull-right" Text="Update" OnClick="btnUpdate_Click"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3><span class="fa fa-pencil"></span>&nbsp;&nbsp;Additional Info</h3>
                        <p>Below is just your information, you cannot change it without contacting admin.</p>
                    </div>
                    <div class="panel-body form-group-separated">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">Street Name & Apt No</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtStreetNApt" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">City</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtCity" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">State</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtState" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-5 control-label">Country & Zip</label>
                            <div class="col-md-9 col-xs-7">
                                <asp:TextBox ID="txtCountryNZip" runat="server" Text="" class="form-control text-primary" disabled></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="modal animated fadeIn" id="modal_change_password" tabindex="-1" role="dialog" aria-labelledby="smallModalHead" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="H1">Change password</h4>
                </div>
                <div class="modal-body form-horizontal form-group-separated">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Old Password</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" type="password" class="form-control" ID="txtOldPswd" ValidationGroup="p" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">New Password</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtNewPswd" type="password" class="form-control" name="new_password" ValidationGroup="p"/>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNewPswd" EnableClientScript="true" CssClass="text-danger" Display="Dynamic" Enabled="true" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$" ErrorMessage="Please use atleast 1 uppercase ,1 lowercase, 1 numeric and password length between 8 and 15" ValidationGroup="p"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnChangePswd" class="btn btn-danger" Text="Process" OnClick="btnChangePswd_Click" ValidationGroup="p"></asp:Button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
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
</asp:Content>
