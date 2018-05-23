<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="EPRS.AdminReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <br />
                <br />
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="col-md-2 control-label h3" style="padding-top:7px;">Date:</label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="txtDate" type="text" class="form-control datepicker" placeholder="Search booking by date" EnableViewState="true" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnSearch" Text="Search" runat="server" class="btn btn-primary"/>
                </div>
                <div class="col-md-4">
                </div>
            </div>
            <br /><br />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Device History Reports</h3>
                    <ul class="panel-controls">
                        <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                        </li>
                    </ul>
                </div>
                <div class="panel-body panel-body-table">
                    <div class="table-responsive">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="table table-bordered table-striped table-actions">
                                    <asp:GridView ID="gvBookingList" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBookingList" SkinID="GridViewSkin" AllowSorting="True" EmptyDataText="There are no booking for the selected date." Width="100%" CellPadding="5" BorderStyle="None" BorderColor="White" CellSpacing="5"
                                        GridLines="None" Font-Size="Small">
                                        <Columns>
                                            <asp:BoundField DataField="Booking_Customer_Id" HeaderText="Cust Id" HeaderStyle-CssClass="text-center"  />
                                            <asp:BoundField DataField="Customer_Name" HeaderText="Customer Name" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="Owner_Customer_Id" HeaderText="Owner Id" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="Owner_Name" HeaderText="Owner Name" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="Street_Name" HeaderText="Booked Street Name" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="Apt_No" HeaderText="Apt No" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="City" HeaderText="City" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="State" HeaderText="State" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="ZipCode" HeaderText="Zip Code" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            <asp:BoundField DataField="Booking_Date" HeaderText="Booking Date" DataFormatString="{0:d}" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                            
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsBookingList" runat="server" ConnectionString="<%$ ConnectionStrings:constr %>" SelectCommand="spx_Admin_GetReport" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtDate" Name="Date" PropertyName="Text" Type="DateTime" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
