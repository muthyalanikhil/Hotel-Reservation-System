<%@ Page Title="" Language="C#" EnableViewState="true" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AdminView.aspx.cs" Inherits="AdminView" %>

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
    <div style="padding: 30px; background: #fffffff5; margin-top: 50px;">
        <div class="clearfix">
            <button type="button" class="btn btn-success float-right" data-toggle="modal" data-target=".myModal"><i class="fa fa-plus"></i>Add Room</button>
        </div>
        <hr>
        <asp:GridView ID="roomGridView" runat="server" AutoGenerateColumns="False" Style="color: #333333; width: 98%; margin-left: 10px;">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                    <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                    <ItemStyle CssClass="hiddencol"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="roomNumber" HeaderText="Room Number" ApplyFormatInEditMode="True" />
                <asp:BoundField DataField="roomType" HeaderText="Type" ApplyFormatInEditMode="True" />
                <asp:BoundField DataField="description" HeaderText="Description" ApplyFormatInEditMode="True" />
                <asp:BoundField DataField="status" HeaderText="status" ApplyFormatInEditMode="True" />
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Button ID="updateInfo" CssClass="btn-success" runat="server" Text="Update Info" OnClick="updateInfo_Click"></asp:Button>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Button ID="delete" CssClass="btn-danger" runat="server" Text="Delete" OnClick="delete_Click"></asp:Button>
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
        <br />

        <asp:PlaceHolder runat="server" ID="updateRoomInfoPH" Visible="false">
            <hr />
            <div class="container">
                <asp:Label ID="roomId" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="Room Number:"></asp:Label>
                <asp:Label ID="numberTB" runat="server" Text=""></asp:Label><br />
                <asp:Label ID="Label3" runat="server" Text="Room Type:"></asp:Label>
                <%-- <asp:Label ID="roomTypeTB" runat="server" Text=""></asp:Label>--%>
                <asp:DropDownList ID="roomType" runat="server">
                    <asp:ListItem>Single</asp:ListItem>
                    <asp:ListItem>Double</asp:ListItem>
                    <asp:ListItem>Triple</asp:ListItem>
                    <asp:ListItem>Suite</asp:ListItem>
                </asp:DropDownList><br />
                <asp:Label ID="Label5" runat="server" Text="Description:"></asp:Label>
                <asp:TextBox ID="descriptionTB" runat="server"></asp:TextBox><br />
                <asp:Label ID="Label2" runat="server" Text="Status:"></asp:Label>
                <asp:DropDownList ID="statusUpdateDD" runat="server">
                    <asp:ListItem>available</asp:ListItem>
                    <asp:ListItem>unavailable</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:TextBox ID="statusTB" runat="server"></asp:TextBox>--%>
                <br />
                <br />
                <asp:Button ID="update" runat="server" CssClass="btn btn-success" Text="Update" OnClick="update_Click" />
                &nbsp;&nbsp;&nbsp;
            <asp:Button ID="closeUpdate" runat="server" CssClass="btn btn-danger" Text="Close" OnClick="closeUpdate_Click" />
            </div>
            <br />
        </asp:PlaceHolder>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 modal fade myModal" style="position: fixed; margin-top: 100px; margin-left: 400px; display: block;">
                <div class="modal-content">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="roomNumber">Room Number:</label>
                            <asp:TextBox ID="roomNumber" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="roomType">Room Type:</label>
                            <br />
                            <asp:DropDownList ID="roomTypeDD" runat="server">
                                <asp:ListItem>Single</asp:ListItem>
                                <asp:ListItem>Double</asp:ListItem>
                                <asp:ListItem>Triple</asp:ListItem>
                                <asp:ListItem>Suite</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <asp:TextBox ID="description" runat="server" class="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <br />
                            <asp:DropDownList ID="statusDD" runat="server">
                                <asp:ListItem>available</asp:ListItem>
                                <asp:ListItem>unavailable</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <asp:Button ID="addRoom" class="btn btn-success" runat="server" Text="Add" OnClick="addRoom_Click" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</asp:Content>

