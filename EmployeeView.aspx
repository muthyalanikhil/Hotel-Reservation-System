<%@ Page Title="" Language="C#" EnableEventValidation="true" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EmployeeView.aspx.cs" Inherits="EmployeeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style type="text/css">
        .hiddencol {
            display: none;
        }

        .modal {
            position: relative;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1040;
            display: none;
            overflow: auto;
            overflow-y: hidden;
        }
    </style>
    <br />
    <br />
    <div style="background: #ffffffe6; margin-top: 30px;padding:30px;">
        <div class="row">
            <div class="col-md-6">
                <div>
                    <asp:Label runat="server" AssociatedControlID="searchBox" CssClass="control-label">Search Customer:</asp:Label>
                    <asp:TextBox runat="server" ID="searchBox" ToolTip="Type customer name"></asp:TextBox>
                    <asp:Button runat="server" ID="searchButton" OnClick="searchButton_Click"
                        Text="Search Customer" CssClass="btn btn-success" />
                </div>
            </div>
            <div class="col-md-6 float-right">
                <div class="clearfix">
                    <button type="button" class="btn btn-success float-right" data-toggle="modal" data-target=".myModal"><i class="fa fa-plus"></i>Add Customer</button>
                </div>
            </div>
        </div>
        <br />
        <asp:PlaceHolder runat="server" ID="customerDetailsPH" Visible="false">
            <h3 style="text-align: center;">Customer Profile</h3>
            <br />
            <div class="container">
                <div class="row">
                    <div class="col-md-6" style="padding: 10px; border-right: solid 1px #80808047;">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="uName" CssClass="col-md-2 control-label">Name: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="uName" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="customerEmail" CssClass="col-md-2 control-label">Email: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="customerEmail" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="addressLINE" CssClass="col-md-2 control-label">Address: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="addressLINE" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="customerPhone" CssClass="col-md-2 control-label">Phone: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="customerPhone" CssClass="form-control" />
                            </div>
                        </div>
                        <asp:HiddenField runat="server" ID="customerID" Value="" />
                        <br />
                        <br />
                        <div class="clearfix" style="padding-left: 20px;">
                            <asp:Button runat="server" ID="bookRoomFor" OnClick="bookRoomFor_Click"
                                Text="Book Room" CssClass="btn btn-success" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h4 style="text-align: center;">Previous Bookings</h4>
                        <asp:GridView ID="customerIndividualBookingGV" runat="server" AutoGenerateColumns="False" Style="color: #333333; width: 98%; margin-left: 10px;">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                                    <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                    <ItemStyle CssClass="hiddencol"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="userId" HeaderText="User ID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                                    <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                                    <ItemStyle CssClass="hiddencol"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="roomType" HeaderText="Room Type" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="numberOfPeople" HeaderText="Number" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="fromDate" HeaderText="From Date" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="toDate" HeaderText="To Date" ApplyFormatInEditMode="True" />
                                <asp:BoundField DataField="airportPickUp" HeaderText="Pick Up" ApplyFormatInEditMode="True" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#4b4b50" Font-Bold="True" ForeColor="White" Height="35px" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#eeeeee" ForeColor="#333333" Height="35px" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <asp:PlaceHolder ID="bookRoomPH" runat="server" Visible="false">
                <hr />
                <div class="panel panel-default">
                    <div class="panel-heading" style="align-content: center; font-weight: bold">Reserve a room</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="roomTypeDD" CssClass="control-label">Room Type:</asp:Label>
                                    <div>
                                        <asp:DropDownList ID="roomTypeDD" runat="server">
                                            <asp:ListItem>Single</asp:ListItem>
                                            <asp:ListItem>Double</asp:ListItem>
                                            <asp:ListItem>Triple</asp:ListItem>
                                            <asp:ListItem>Suite</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="totalNumber" CssClass="control-label">Number of People:</asp:Label>
                                    <div>
                                        <asp:TextBox TextMode="Number" ID="totalNumber" runat="server" Text="0" min="0" max="20" step="1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="fromDate" CssClass="control-label">From: </asp:Label>
                                    <div>
                                        <asp:TextBox type="date" ID="fromDate" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <asp:Label runat="server" AssociatedControlID="toDate" CssClass="control-label">To: </asp:Label>
                                <div>
                                    <asp:TextBox type="date" ID="toDate" runat="server" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div>
                                    <asp:CheckBox Text="&nbsp;&nbsp;&nbsp;Please check the box if you need Airport Pickup" ID="airportPickup" runat="server"></asp:CheckBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div style="width: 50%; display: inline;">
                        <asp:Button runat="server" ID="bookRoom" OnClick="bookRoom_Click"
                            Text="Confirm Booking" CssClass="btn btn-success" />
                    </div>
                    <div style="width: 50%; display: inline;">
                        <asp:Button runat="server" ID="Cancel" OnClick="Cancel_Click"
                            Text="Cancel" CssClass="btn btn-danger" />
                    </div>
                </div>
                <br />
            </asp:PlaceHolder>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="currentBookingPH">
            <asp:GridView ID="bookingsGV" runat="server" AutoGenerateColumns="False" Style="color: #333333; width: 98%; margin-left: 10px;" OnRowDataBound="bookingsGV_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                        <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                        <ItemStyle CssClass="hiddencol"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="userId" HeaderText="User ID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                        <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                        <ItemStyle CssClass="hiddencol"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="username" HeaderText="Customer Name" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="numberOfPeople" HeaderText="Number of People" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="roomType" HeaderText="Type" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="fromDate" HeaderText="From Date" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="toDate" HeaderText="To Date" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="airportPickUp" HeaderText="Pick Up" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="bookedBy" HeaderText="Booked By" ApplyFormatInEditMode="True" />
                    <asp:BoundField DataField="status" HeaderText="Status" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                        <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                        <ItemStyle CssClass="hiddencol"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="cancelReservation" CssClass="btn btn-danger" runat="server" Text="Cancel Reservation" OnClick="cancelReservation_Click"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#4b4b50" Font-Bold="True" ForeColor="White" Height="35px" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#eeeeee" ForeColor="#333333" Height="35px" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:PlaceHolder runat="server" ID="allBookinigsPH">
                <h3 style="text-align: center;">
                    <asp:Label runat="server" Text="" ID="previousBookingsLBL"></asp:Label></h3>
            </asp:PlaceHolder>
        </asp:PlaceHolder>

        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 modal fade myModal" style="position: fixed; margin-top: 100px; margin-left: 400px; display: none;">
                <div class="modal-content">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="userName" CssClass="col-md-2 control-label">Name: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="userName" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="address" CssClass="col-md-2 control-label">Address: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="address" CssClass="form-control" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="phone" CssClass="col-md-2 control-label">Phone: </asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="phone" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <asp:Button ID="addCustomer" class="btn btn-success" runat="server" Text="Add" OnClick="addCustomer_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</asp:Content>

