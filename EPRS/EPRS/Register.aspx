<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="EPRS.Register" %>

<!DOCTYPE html>
<html lang="en" class="body-full-height">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<head>
    <title>Register - Rent or book your spot</title>
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
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBnNGA0SNjzwDgpwHhgcihu-5jBJvN41iA&callback=initMap"
        type="text/javascript"></script>
    <script lang="javascript" type="text/ecmascript">
        function getLocation() {
            getAddressInfoByZip(document.forms[0].txtZipCode.value);
        }

        function response(obj) {
            console.log(obj);
        }
        function getAddressInfoByZip(zip) {
            if (zip.length >= 5 && typeof google != 'undefined') {
                var addr = {};
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': zip }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results.length >= 1) {
                            for (var ii = 0; ii < results[0].address_components.length; ii++) {
                                var street_number = route = street = city = state = zipcode = country = formatted_address = '';
                                var types = results[0].address_components[ii].types.join(",");
                                if (types == "street_number") {
                                    addr.street_number = results[0].address_components[ii].long_name;
                                }
                                if (types == "route" || types == "point_of_interest,establishment") {
                                    addr.route = results[0].address_components[ii].long_name;
                                }
                                if (types == "sublocality,political" || types == "locality,political" || types == "neighborhood,political" || types == "administrative_area_level_3,political") {
                                    addr.city = (city == '' || types == "locality,political") ? results[0].address_components[ii].long_name : city;

                                    document.getElementById("txtCity").value = addr.city;
                                }
                                if (types == "administrative_area_level_1,political") {
                                    addr.state = results[0].address_components[ii].short_name;

                                    document.getElementById("txtState").value = addr.state;
                                }
                                if (types == "postal_code" || types == "postal_code_prefix,postal_code") {
                                    addr.zipcode = results[0].address_components[ii].long_name;
                                }
                                if (types == "country,political") {
                                    addr.country = results[0].address_components[ii].long_name;

                                    document.getElementById("txtCountry").value = addr.country;
                                }
                            }
                            addr.success = true;
                            for (name in addr) {
                                console.log('### google maps api ### ' + name + ': ' + addr[name]);
                            }
                            response(addr);

                        } else {
                            response({ success: false });
                        }
                    } else {
                        response({ success: false });
                    }
                });
            } else {
                response({ success: false });
            }
        }
    </script>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="css/theme-default.css" />
</head>
<body>
    <div class="registration-container">
        <div class="registration-box animated fadeInDown" style="padding-top: 0px;">
            <div class="registration-logo"></div>
            <div class="registration-body">
                <div class="registration-title"><strong>Registration</strong>, use form below</div>
                <div class="registration-subtitle">Enter the infrmation asked below to register.</div>
                <form class="form-horizontal" method="post" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                    </asp:ScriptManager>
                    <div class="form-group">
                        <div class="col-md-6">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtFirstName" ToolTip="Enter your first name." placeholder="First Name"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtLastName" ToolTip="Enter your last name." placeholder="Last Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtUsername" ToolTip="Enter your preffered username." placeholder="Username"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtEmail" ToolTip="Enter your email." placeholder="Email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtPassword" ToolTip="Enter your preffered password." placeholder="Password" TextMode="Password"></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPassword" EnableClientScript="true" CssClass="text-danger" Display="Dynamic" Enabled="true" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$" ValidationGroup="r" ErrorMessage="Please use atleast 1 uppercase ,1 lowercase, 1 numeric and password length between 8 and 15"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtPhone" ToolTip="Enter your phone number." placeholder="Phone Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-8">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtStreetName" ToolTip="Enter your Street Address." placeholder="Street Name"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtAptNo" ToolTip="Enter your Apartment Number." placeholder="Apartment Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtZipCode" ToolTip="Enter your zip code." placeholder="Zip Code" onchange="javascript: getLocation();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-9">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtCity" ToolTip="Enter Zip Code to Auto populate." placeholder="City"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtState" ToolTip="Enter Zip Code to Auto populate." placeholder="State"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtCountry" ToolTip="Enter Zip Code to Auto populate." placeholder="Country"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group push-up-30">
                        <div class="col-md-6">
                        </div>
                        <div class="col-md-6">
                            <asp:Button class="btn btn-danger btn-block" runat="server" ID="btnSubmit" OnClientClick="return validateForm();" OnClick="btnSubmit_Click" Text="Sign Up" ValidationGroup="r"></asp:Button>
                        </div>
                    </div>
                    <div class="form-group push-up-30">
                        <div class="col-md-2">
                        </div>
                        <div class="col-md-8">
                            <a href="Login.aspx" class="btn btn-link btn-block">Already have account?</a>
                        </div>
                        <div class="col-md-2">
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
    <script type="text/javascript">
        function validateForm() {
            var allText = 0;
            $(".form-control").each(function () {
                if ((this.value) == "") {
                    allText += 1;
                }
            });
            if (allText > 0) {
                alert("Please fill in all the details.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
