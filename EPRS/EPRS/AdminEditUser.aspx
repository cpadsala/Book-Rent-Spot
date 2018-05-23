<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminEditUser.aspx.cs" Inherits="EPRS.AdminEditUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBnNGA0SNjzwDgpwHhgcihu-5jBJvN41iA&callback=initMap"
        type="text/javascript"></script>
    <script language="javascript" type="text/ecmascript">
        function getLocation() {
            var zip = document.getElementById('<%=txtZip.ClientID%>').value;
            getAddressInfoByZip(zip);
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

                                    document.getElementById('<%=txtCity.ClientID%>').value = addr.city;
                                }
                                if (types == "administrative_area_level_1,political") {
                                    addr.state = results[0].address_components[ii].short_name;

                                    document.getElementById('<%=txtState.ClientID%>').value = addr.state;
                                }
                                if (types == "postal_code" || types == "postal_code_prefix,postal_code") {
                                    addr.zipcode = results[0].address_components[ii].long_name;
                                }
                                if (types == "country,political") {
                                    addr.country = results[0].address_components[ii].long_name;

                                    document.getElementById('<%=txtCountry.ClientID%>').value = addr.country;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="panel panel-default" id="divUpdate" runat="server" visible="false">
                        <div class="panel-heading">
                            <asp:Label class="panel-title" ID="lblHead" runat="server" Text="Edit User Info"></asp:Label>
                            <ul class="panel-controls">
                                <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                                </li>
                            </ul>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label runat="server" class="col-md-3 control-label" ID="lblId" Text="First Name:"></asp:Label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtFName" runat="server" class="form-control text-primary"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" class="col-md-3 control-label" ID="Label1" Text="Last Name:"></asp:Label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtLName" runat="server" class="form-control text-primary"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Street Name:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtStreetName" runat="server" class="form-control text-primary"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Apt No:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtApt" runat="server" class="form-control text-primary"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Zip Code:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtZip" runat="server" class="form-control text-primary" onchange="javascript: getLocation();"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">City:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtCity" runat="server" class="form-control"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">State:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtState" runat="server" class="form-control"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Country:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtCountry" runat="server" class="form-control"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-2">
                                            <asp:Button ID="btnUpdate" runat="server" class="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" ClientIDMode="Static" CausesValidation="false" OnClientClick="return CheckForm();"></asp:Button>
                                            <span class="help-block">&nbsp;</span>
                                            <div class="col-md-10"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="col-md-12">
                        <asp:Label ID="lblMessage" runat="server" Text="" CssClass="popup-msg dismis-alert"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>


            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of Users</h3>
                        <asp:Label ID="lblMessage2" runat="server" Text=""></asp:Label>
                        <ul class="panel-controls">
                            <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                            </li>
                        </ul>
                    </div>
                    <div class="panel-body panel-body-table">
                        <div class="table-responsive">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <br />
                                    <br />
                                    <div class="form-group">
                                        <label class="col-md-1 control-label" style="padding-top: 7px;">Username:</label>
                                        <div class="col-md-3">
                                            <asp:TextBox ID="txtUsernametoSearch" runat="server" placeholder="Enter username to search user." class="form-control"></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                        <div class="col-md-3">
                                            <asp:Button ID="btnSearchUser" runat="server" class="btn btn-primary" Text="Search" OnClick="btnSearchUser_Click" ClientIDMode="Static" CausesValidation="false"></asp:Button>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                        <div class="col-md-4"></div>
                                    </div>
                                    <div class="form-group">
                                    </div>
                                    <br />
                                    <div class="table table-bordered table-striped table-actions">
                                        <asp:GridView ID="gvUser" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" AllowSorting="True" Width="100%" CellPadding="5" BorderStyle="None" BorderColor="White" CellSpacing="5" GridLines="None" Font-Size="Small" OnRowCommand="gvUser_RowCommand" EmptyDataText="No user found with that username.">
                                            <RowStyle CssClass="RowStyle" />
                                            <HeaderStyle CssClass="HeaderStyle" />
                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Customer Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvCustId" runat="server" Text='<%#Eval("Customer_Id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Username">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvUsername" runat="server" Text='<%#Eval("Username")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvName" runat="server" Text='<%#Eval("First_Name")+ " " + Eval("Last_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Edit User">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btn_edit" class="btn btn-default btn-rounded btn-condensed btn-sm" CommandName="EditUser" CommandArgument='<%#Eval("Customer_Id") %>' ToolTip='<%#Eval("Customer_Id") %>' runat="server" OnCommand="btn_edit_Command"><span class="fa fa-pencil"></span></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
