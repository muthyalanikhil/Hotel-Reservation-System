<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div style="padding: 30px; background: #fffffff5; margin-top: 50px;">
        <div class="container">
            <div style="align-content: center;">
                <h2>User List</h2>
            </div>
            <div style="align-content: center;">
                <asp:GridView ID="userListGV" runat="server" OnRowDataBound="userListGV_RowDataBound" AutoGenerateColumns="False" Style="color: #333333; width: 98%; margin-left: 10px;">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="user Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                        <asp:BoundField DataField="userName" HeaderText="User Name" />
                        <asp:BoundField DataField="role" HeaderText="Role" />
                        <asp:BoundField DataField="email" HeaderText="Email" />
                        <asp:BoundField DataField="isBlocked" HeaderText="Blocked Status" />
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Button ID="userRole" OnClick="userRole_Click" runat="server" Text="Make Employee" CssClass="btn btn-success"></asp:Button>
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
            </div>
            <hr />
            <div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="align-content: center; font-weight: bold">Block User</div>
                            <div class="panel-body">
                                <div>
                                    <asp:TextBox type="text" class="form-control" ID="blockEmail" placeholder="Email" name="addU" runat="server"></asp:TextBox>
                                </div>
                                <br />
                                <div>
                                    <asp:Button ID="blockUser" runat="server" class="btn btn-primary" Text="Block User" OnClick="blockUser_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="align-content: center; font-weight: bold">Unblock User</div>
                            <div class="panel-body">
                                <div>
                                    <asp:TextBox type="text" class="form-control" ID="unblockEmail" placeholder="Email" name="addU" runat="server"></asp:TextBox>
                                </div>
                                <br />
                                <div>
                                    <asp:Button ID="unblockUser" runat="server" class="btn btn-primary" Text="Unblock User" OnClick="unblockUser_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="align-content: center; font-weight: bold">Delete User</div>
                            <div class="panel-body">
                                <div>
                                    <asp:TextBox type="text" class="form-control" ID="deleteEmail" placeholder="Email" name="addU" runat="server"></asp:TextBox>
                                </div>
                                <br />
                                <div>
                                    <asp:Button ID="Button1" runat="server" class="btn btn-danger" Text="Delete User" OnClick="deleteUser_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

