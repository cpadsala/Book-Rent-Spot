<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ViewRentList.aspx.cs" Inherits="EPRS.ViewRentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="panel panel-default" id="divUpdate" runat="server" visible="false">
                        <div class="panel-heading">
                            <asp:Label class="panel-title" ID="lblHead" runat="server" Text=""></asp:Label>
                            <ul class="panel-controls">
                                <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                                </li>
                            </ul>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Label runat="server" class="col-md-3 control-label" ID="lblId" Text=""></asp:Label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtParkingId" runat="server" class="form-control text-primary" disabled></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Status:</label>
                                        <div class="col-md-9">
                                            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" DataTextField="Status_Type" DataValueField="Status_Id" class="dropdown btn dropdown-toggle selectpicker btn-default">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="dsStatus" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Status_Type, Status_Id from tblStatus where Status_Id in (2,1)" SelectCommandType="Text"></asp:SqlDataSource>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Date Available:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtDate" runat="server" class="form-control text-primary datepicker" disabled></asp:TextBox>
                                            <span class="help-block">&nbsp;</span>
                                        </div>
                                    </div>
                                    <div runat="server" id="divDdls" visible="false">
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Open Time:</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList ID="ddlStartTime" runat="server" DataTextField="Time_AMPM" DataValueField="Time" DataSourceID="dsTime" OnDataBinding="ddlStartTime_DataBinding" CssClass="dropdown btn dropdown-toggle selectpicker btn-default">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource runat="server" ID="dsTime" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select * from tblTime" SelectCommandType="Text"></asp:SqlDataSource>
                                                <span class="help-block">&nbsp;</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Close Time:</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList ID="ddlCloseTime" DataSourceID="dsTime" runat="server" DataTextField="Time_AMPM" DataValueField="Time" OnDataBinding="ddlCloseTime_DataBinding" CssClass="dropdown btn dropdown-toggle selectpicker btn-default">
                                                </asp:DropDownList>
                                                <span class="help-block">&nbsp;</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Price:</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtPrice" runat="server" class="form-control"></asp:TextBox>
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
                        <h3 class="panel-title">List of spots rented</h3>
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
                                    <div class="table table-bordered table-striped table-actions">
                                        <asp:GridView ID="gvRentList" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" AllowSorting="True" Width="100%" CellPadding="5" BorderStyle="None" BorderColor="White" CellSpacing="5" GridLines="None" Font-Size="Small" OnRowCommand="gvRentList_RowCommand" EmptyDataText="No Spot Rented Yet." EnableViewState="false">
                                            <RowStyle CssClass="RowStyle" />
                                            <HeaderStyle CssClass="HeaderStyle" />
                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Rent Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvRentId" runat="server" Text='<%#Eval("Rent_Id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Parking Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvParkingName" runat="server" Text='<%#Eval("Parking_Name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Street Name & Apt No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvStreet" runat="server" Text='<%#Eval("Street_Name")+ " " + Eval("Apt_No") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="City & State">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvCity" runat="server" Text='<%#Eval("City") + " " + Eval("State") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date Available">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvDate" runat="server" Text='<%#Eval("Date_Available","{0:dd/MM/yyyy}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvStatus" runat="server" Text='<%#Eval("Status_Type")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Open Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvOpen" runat="server" Text='<%#Eval("OpenTime")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Close Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvClose" runat="server" Text='<%#Eval("CloseTime")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Change Status">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btn_edit" class="btn btn-default btn-rounded btn-condensed btn-sm" CommandName="EditRentSpot" CommandArgument='<%#Eval("Rent_Id") %>' ToolTip='<%#Eval("Rent_Id") %>' runat="server" OnCommand="btn_edit_Command"><span class="fa fa-pencil"></span></asp:LinkButton>
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

            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">List of your spots</h3>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        <ul class="panel-controls">
                            <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                            </li>
                        </ul>
                    </div>
                    <div class="panel-body panel-body-table">
                        <div class="table-responsive">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="table table-bordered table-striped table-actions">
                                        <asp:GridView ID="gvSpotList" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" AllowSorting="True" Width="100%" CellPadding="5" BorderStyle="None" BorderColor="White" CellSpacing="5" GridLines="None" Font-Size="Small" OnRowCommand="gvSpotList_RowCommand" EmptyDataText="No Spot Added Yet." EnableViewState="false">
                                            <RowStyle CssClass="RowStyle" />
                                            <HeaderStyle CssClass="HeaderStyle" />
                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Parking Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvParkingId" runat="server" Text='<%#Eval("Parking_Id")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Parking Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvParkingName" runat="server" Text='<%#Eval("Parking_Name")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Street Name & Apt No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvStreet" runat="server" Text='<%#Eval("Street_Name")+ " " + Eval("Apt_No") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="City & State">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgvCity" runat="server" Text='<%#Eval("City") + " " + Eval("State") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rent">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btn_edit" class="btn btn-default btn-rounded btn-condensed btn-sm" CommandName="EditSpot" CommandArgument='<%#Eval("Parking_Id") %>' ToolTip='<%#Eval("Parking_Id") %>'
                                                            runat="server" OnCommand="btn_edit_Command"><span class="fa fa-car"></span></asp:LinkButton>
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
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
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
    <script type="text/javascript" lang="javascript">
        function CheckForm() {
            var status = document.getElementById('<%=ddlStatus.ClientID%>').value;
            var date = document.getElementById('<%=txtDate.ClientID%>').value;
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
