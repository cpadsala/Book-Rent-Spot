<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="RentSpot.aspx.cs" Inherits="EPRS.RentSpot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <div class="row">
        <br />
        <div class="col-lg-8">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h3><span class="fa fa-cab"></span>Rent Spot</h3>
                    <p>
                        <b>You can rent your private spot by filling below form.<br />
                            Your spot will be open for anyone using this application to book online.</b>
                    </p>
                </div>
                <div class="panel-body form-group-separated">
                    <div class="form-group">
                        <label class="col-md-3 control-label">Parking Name</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtParkingName" type="text" class="form-control" placeholder="Parking Area Name" />
                            <asp:RequiredFieldValidator ID="rfPname" runat="server" ControlToValidate="txtParkingName" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Street</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtStreet" type="text" class="form-control" placeholder="Street Address" />
                            <asp:RequiredFieldValidator ID="rfStreet" runat="server" ControlToValidate="txtStreet" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Apt No</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtAptNo" type="text" class="form-control" placeholder="Apt Number" />
                            <asp:RequiredFieldValidator ID="rfApt" runat="server" ControlToValidate="txtAptNo" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Zip Code</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtZip" type="text" class="form-control" placeholder="Zip Code" onchange="javascript: getLocation();" />
                            <asp:RequiredFieldValidator ID="rfZip" runat="server" ControlToValidate="txtZip" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">City</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtCity" type="text" class="form-control" placeholder="City" />
                            <asp:RequiredFieldValidator ID="rfCity" runat="server" ControlToValidate="txtCity" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">State</label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="txtState" type="text" class="form-control" placeholder="State" />
                            <asp:RequiredFieldValidator ID="rfState" runat="server" ControlToValidate="txtState" ErrorMessage="Cannot be blank." ValidationGroup="rs"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">Status</label>
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" DataTextField="Status_Type" DataValueField="Status_Id" onchange="showhidediv();" CssClass="dropdown btn dropdown-toggle selectpicker btn-default"></asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="dsStatus" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Status_Type, Status_Id from tblStatus where Status_Id in (2,1)" SelectCommandType="Text"></asp:SqlDataSource>
                            <span class="help-block">&nbsp;</span>
                        </div>
                    </div>
                    <div id="dateTimePicker" runat="server">
                        <div class="form-group">
                            <label class="col-md-3 control-label">Date to Rent</label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtDateAvailable" type="text" class="form-control datepicker" placeholder="Date Available" />
                                <asp:RequiredFieldValidator ID="rfDate" runat="server" ControlToValidate="txtDateAvailable" ErrorMessage="Cannot be blank." ValidationGroup="rrs"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDateAvailable" ErrorMessage="Please enter a valid date." ValidationGroup="rrs">
                                </asp:CompareValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Start Time</label>
                            <div class="col-md-9">
                                <asp:DropDownList ID="ddlStartTime" runat="server" DataTextField="Time_AMPM" DataValueField="Time" DataSourceID="dsTime" OnDataBound="ddlStartTime_DataBound">
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="dsTime" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select * from tblTime" SelectCommandType="Text"></asp:SqlDataSource>
                                <span class="help-block">&nbsp;</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Close Time</label>
                            <div class="col-md-9">
                                <asp:DropDownList ID="ddlCloseTime" DataSourceID="dsTime" runat="server" DataTextField="Time_AMPM" DataValueField="Time" OnDataBound="ddlCloseTime_DataBound">
                                </asp:DropDownList>
                                <span class="help-block">&nbsp;</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Price</label>
                            <div class="col-md-9">
                                <asp:TextBox runat="server" ID="txtPrice" class="form-control" placeholder="Enter Price" />
                                <asp:RequiredFieldValidator ID="rfPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Cannot be blank." ValidationGroup="rrs"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <asp:Button runat="server" ID="btnAdd" class="btn btn-info btn-block" Text="Add" OnClick="btnAdd_Click" OnClientClick="return CheckForm();" ValidationGroup="rs"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4"></div>
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

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBnNGA0SNjzwDgpwHhgcihu-5jBJvN41iA&callback=initMap"
        type="text/javascript"></script>
    <script type="text/javascript" lang="javascript">
        function pageLoad() {
            showhidediv();
        }
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
        function showhidediv() {
            var status = document.getElementById('<%=ddlStatus.ClientID%>').value;
            var divtag = document.getElementById('<%=dateTimePicker.ClientID%>');
            if (status != 1) {
                divtag.style.display = 'none';
                document.getElementById('<%=txtDateAvailable.ClientID%>').disabled;
                document.getElementById('<%=txtPrice.ClientID%>').disabled;

            }
            else {
                divtag.style.display = 'block';
            }
        }
        function CheckForm() {
            var status = document.getElementById('<%=ddlStatus.ClientID%>').value;
            var date = document.getElementById('<%=txtDateAvailable.ClientID%>').value;
            var starttime = document.getElementById('<%=ddlStartTime.ClientID%>').value;
            var closetime = document.getElementById('<%=ddlCloseTime.ClientID%>').value;
            var price = document.getElementById('<%=txtPrice.ClientID%>').value;
            var stime = starttime.substring(0, 2);
            var ctime = closetime.substring(0, 2);
            var varDate = new Date(date); //dd-mm-YYYY
            var today = new Date();
            if ((status == 1 && date == "" && starttime == 1 && closetime == 1) || (status == 1 && stime >= ctime) || (varDate < today)) {
                var message = 'Please select proper date and open-close time.';
                var head = 'Please check the entered values.';
                var note = 'NOTE: End time cannot be before Start time and Date should be future.';
                alert(head + '\n' + message + '\n' + note);
                return false;
            }
            if (!/^[0-9]*$/.test(price)) {
                alert("Please enter numeric value in price.");
                return false;
            }
        }
    </script>
</asp:Content>
