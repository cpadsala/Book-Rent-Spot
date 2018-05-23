<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EPRS.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content-wrap">
        <br />
        <br />
        <div class="row">
            <center><asp:Label ID="lblMessage" Text="" Visible="false" CssClass="h1 popup-msg dismis-alert" runat="server"></asp:Label></center>
            <br />
        </div>
        <div class="row">
            <div class="col-md-2">
            </div>
            <div class="col-md-8">
                <div class="widget widget-danger widget-padding-sm">
                    <div class="widget-big-int plugin-clock">00:00</div>
                    <div class="widget-subtitle plugin-date">Loading...</div>
                    <div class="widget-buttons widget-c3">
                        <h2 class="text-warning">Welcome to Electronic Parking Rental System</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-4">
                <div class="widget widget-default widget-item-icon">
                    <div class="widget-item-left">
                        <span class="fa fa-map-marker"></span>
                    </div>
                    <div class="widget-data">
                        <div class="widget-int num-count">
                            <asp:FormView ID="fmv1" runat="server" DataSourceID="dsAvailableSpots">
                                <ItemTemplate>
                                    <asp:Label ID="lblAvilableSpots" runat="server" Text='<%# Eval("Count") %>' />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource runat="server" ID="dsAvailableSpots" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Count(*) as Count from tblParkingHours where Status_Id='1' and Booked = '0'" SelectCommandType="Text"></asp:SqlDataSource>
                        </div>
                        <span class="help-block">&nbsp;</span>
                        <div class="widget-title">Available Spots</div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
            <div class="col-md-4">
                <div class="widget widget-default widget-item-icon">
                    <div class="widget-item-left">
                        <span class="fa fa-check"></span>
                    </div>
                    <div class="widget-data">
                        <div class="widget-int num-count">
                            <asp:FormView ID="fmv2" runat="server" DataSourceID="dsSpotsSold">
                                <ItemTemplate>
                                    <asp:Label ID="lblSpotsSold" runat="server" Text='<%# Eval("Count") %>' />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource runat="server" ID="dsSpotsSold" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Count(*) as Count from tblParkingHours where Booked='1'" SelectCommandType="Text"></asp:SqlDataSource>
                        </div>
                        <span class="help-block">&nbsp;</span>
                        <div class="widget-title">Spots Sold</div>
                    </div>
                </div>
            </div>
            <div class="col-md-1">
            </div>
        </div>
        <div class="row">
            <div class="col-md-1">
            </div>
            <div class="col-md-4">
                <div class="widget widget-default widget-item-icon">
                    <div class="widget-item-left">
                        <span class="fa fa-car"></span>
                    </div>
                    <div class="widget-data">
                        <div class="widget-int num-count">
                            <asp:FormView ID="fmv3" runat="server" DataSourceID="dsTotalSpots">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalSpots" runat="server" Text='<%# Eval("Count") %>' />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource runat="server" ID="dsTotalSpots" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Count(*) as Count from tblParkingHours" SelectCommandType="Text"></asp:SqlDataSource>
                        </div>
                        <span class="help-block">&nbsp;</span>
                        <div class="widget-title">Spots Rented</div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
            <div class="col-md-4">
                <div class="widget widget-default widget-item-icon">
                    <div class="widget-item-left">
                        <span class="fa fa-user"></span>
                    </div>
                    <div class="widget-data">
                        <div class="widget-int num-count">
                            <asp:FormView ID="fmv4" runat="server" DataSourceID="dsRegisteredUsers">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegisteredUsers" runat="server" Text='<%# Eval("Count") %>' />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource runat="server" ID="dsRegisteredUsers" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="select Count(*) as Count from tblCustomer" SelectCommandType="Text"></asp:SqlDataSource>
                        </div>
                        <div class="widget-title">Registered Users</div>
                    </div>
                </div>
            </div>
            <div class="col-md-1">
            </div>
        </div>
    </div>
</asp:Content>
