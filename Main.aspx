<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
    <title>Dashboard Homepage </title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Dropdownlist 
            ID="ThemeList"
            runat ="server"
            AutoPostBack="true"
            >
            <asp:ListItem>Azure</asp:ListItem>
            <asp:ListItem>Bisque</asp:ListItem>
            <asp:ListItem>Beige</asp:ListItem>
        </asp:Dropdownlist>
        
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div id="dvDiv" class="Element" style="position: absolute">
            <asp:CheckBox ID="chkDetailsView"
                AutoPostBack="true"
                Checked="false"
                runat="server" OnCheckedChanged="chkDetailsView_CheckedChanged" />
            Show Details
        <asp:UpdatePanel ID="udpPanel" runat="server">
            <ContentTemplate>
                     <asp:Timer ID="Timer1" runat="server" Interval="60000" ontick="Timer1_Tick">
                    </asp:Timer>
                <asp:Panel ID="dvPanel" Visible="false" runat="server">
                    
                    <asp:DetailsView
                        ID="dvEmployees"
                        runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="EmpID" DataSourceID="employeesTableDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" OnItemDeleted="dvEmployees_ItemDeleted">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                        <EditRowStyle BackColor="#999999" />
                        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                        <Fields>
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True" SortExpression="EmpID" />
                            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" ShowDeleteButton="True" />
                        </Fields>

                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />

                    </asp:DetailsView> 
                    <br />
                    <div id="SumSalesDiv">
                    <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" DataSourceID="sqlSummarySalesTable">
                        <Columns>
                            <asp:TemplateField HeaderText="Total Sales ($)" SortExpression="Column1">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Column1") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Column1","{0:C}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="EmpID" HeaderText="Employee ID" SortExpression="EmpID" />
                        </Columns>
                    </asp:GridView>
                        </div>    
                        <asp:SqlDataSource ID="sqlSummarySalesTable" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" SelectCommand="select Sum(Amount), EmpID from SalesTable where EmpID=@EmpID
group by EmpID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dvEmployees" Name="EmpID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <div id="SalesDiv">
                    <asp:GridView ID="gvSales" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="salesTableDataSource" OnRowDeleted="gvSales_RowDeleted" OnRowUpdating="gvSales_RowUpdating" OnSelectedIndexChanged="gvSales_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                            <asp:TemplateField HeaderText="DateSold" 
                                            SortExpression="DateSold">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DateSold") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" 
                                            runat="server" 
                                            Text='<%# Bind("DateSold","{0:d}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="MonthOnly" HeaderText="MonthOnly" SortExpression="MonthOnly" />
                            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server"  Text='<%# Bind("Amount") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Font-Italic="true" Text='<%# Bind("Amount","{0:C}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                        </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
            <asp:SqlDataSource
                ID="employeesTableDataSource"
                runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [EmployeesTable] WHERE [EmpID] = @EmpID" InsertCommand="INSERT INTO [EmployeesTable] ([FirstName], [LastName]) VALUES (@FirstName, @LastName)" SelectCommand="SELECT [EmpID], [FirstName], [LastName] FROM [EmployeesTable]" UpdateCommand="UPDATE [EmployeesTable] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [EmpID] = @EmpID">
                <DeleteParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="EmpID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="salesTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [SalesTable] WHERE [ID] = @ID" InsertCommand="INSERT INTO [SalesTable] ([EmpID], [DateSold], [MonthOnly], [Amount]) VALUES (@EmpID, @DateSold, @MonthOnly, @Amount)" SelectCommand="SELECT [ID], [EmpID], [DateSold], [MonthOnly], [Amount] FROM [SalesTable] WHERE ([EmpID] = @EmpID)" UpdateCommand="UPDATE [SalesTable] SET [EmpID] = @EmpID, [DateSold] = @DateSold, [MonthOnly] = @MonthOnly, [Amount] = @Amount WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="DateSold" />
                    <asp:Parameter Name="MonthOnly" Type="String" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="dvEmployees" DefaultValue="" Name="EmpID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="DateSold" />
                    <asp:Parameter Name="MonthOnly" Type="String" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <ws />
        <div id="divSticky" class="Element" style="position:absolute">
            <textarea id="txtSticky" cols="20" rows="10" style="background-color:yellow" spellcheck="true">
                ...Type something here
            </textarea>
        </div>
        <asp:Menu ID="PrintMenu" runat="server" style="font-family:Arial">
            <Items>
                <asp:MenuItem Text="Print">
                    <asp:MenuItem Text="Summary Grid"></asp:MenuItem>
                    <asp:MenuItem Text="Sales Records"></asp:MenuItem>
                    <asp:MenuItem Text="All"></asp:MenuItem>
                </asp:MenuItem>
            </Items>
        </asp:Menu>
    </form>
    <script>
        $("#dvDiv").draggable();
        $("#divSticky").draggable();
        $(window).on('beforeunload', function () { //get the last position before 'Refresh' the page
            var pos = $("#dvDiv").position();
            var color = $("#ThemeList Option:Selected").text();
            localStorage.setItem('dvDiv', JSON.stringify(pos));
            localStorage.setItem('dvDivColor', color);
            var stickyPos = $("#divSticky").position();
            localStorage.setItem('StickyPosition', JSON.stringify(stickyPos));
            var text = $("#txtSticky").val();
            localStorage.setItem('StickyText', text);//no need JSON.stringify because text var is string format (not JSON)
        });

        //apply after loading the page
        var topLeftdvDiv = JSON.parse(localStorage.getItem('dvDiv')); //set the last position after 'Refresh' the page
        var stickyPos = JSON.parse(localStorage.getItem('StickyPosition')); //set the last position after 'Refresh' the page
        var text = localStorage.getItem('StickyText');
        var backColor = localStorage.getItem('dvDivColor');
        $("#ThemeList").val(backColor);
        $("#dvDiv").css(topLeftdvDiv);
        $("#dvDiv").css("background-color", backColor);
        $("#divSticky").css("background-color", backColor);
        $("#divSticky").css(stickyPos);
        $("#txtSticky").val(text);
        //jQuery code for the print menu
        $("li>a").click(function () {
            if ($(this).text() == 'Sales Records') {
                //print function
                var contents = document.getElementById("SalesDiv").innerHTML; //<-- parse the content of the GridView to variable 'contents
                var printWindow = window.open("", "", "width=500, height=500"); //<--generate the pop-up object call printWindow
                printWindow.document.write(contents); // <-- parse 'contents' to the object printWindow
                printWindow.print();
                printWindow.close();
            }

            if ($(this).text() == 'Summary Grid') {
                //print function
                var contents = document.getElementById("SumSalesDiv").innerHTML; //<-- parse the content of the GridView to variable 'contents
                var printWindow = window.open("", "", "width=500, height=500"); //<--generate the pop-up object call printWindow
                printWindow.document.write(contents); // <-- parse 'contents' to the object printWindow
                printWindow.print();
                printWindow.close();
            }

            if ($(this).text() == 'All') {
                //print function
                var contents = document.getElementById("dvDiv").innerHTML; //<-- parse the content of the GridView to variable 'contents
                var printWindow = window.open("", "", "width=500, height=500"); //<--generate the pop-up object call printWindow
                printWindow.document.write(contents); // <-- parse 'contents' to the object printWindow
                printWindow.print();
                printWindow.close();
            }
        });

    </script>
</body>
</html>

<!--
     $("#dvDiv").draggable()
        //before unload the page - save the position to a text variable
        $(window).on('beforeunload', function () { //get the last position before 'Refresh' the page
            var pos = $("#dvDiv").position()
            localStorage.setItem('dvDiv', JSON.stringify(pos))
        //after loading the page 
           var topLeftdvDiv = JSON.parse(localStorage.getItem('dvDiv')) //set the last position after 'Refresh' the page
            $("#dvDiv").css(topLeftdvDiv)
    -->
