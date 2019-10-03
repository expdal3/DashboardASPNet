using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Main : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        //dvEmployees.DataBind();
        //gvSales.DataBind();
        //udpPanel.Update();
    }
    protected void chkDetailsView_CheckedChanged(object sender, EventArgs e)
    {
        if (chkDetailsView.Checked)
            dvPanel.Visible = true;
        else
            dvPanel.Visible = false;
    }

    protected void dvEmployees_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        dvEmployees.DataBind(); //reload the detail View so that it would update GridView
        gvSales.EditIndex = -1;
        gvSales.DataBind(); //run after item is removed from details view
        gvSummary.DataBind();//added to show how to update Summary Div after deletion of record from dvEmployees
        
        //udpPanel.DataBind();

        //udpPanel.Load();
        //udpPanel.Update();
        /*
        if (IsPostback)
        {
            FillGrid();
        }
        */


    }

    protected void gvSales_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvSummary.DataBind();
    }

    protected void gvSales_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        gvSummary.DataBind(); //refresh summary grid view after a record is deleted from gvSales
    }

    protected void gvSales_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        gvSummary.DataBind(); //refresh summary grid view after a record is deleted from gvSales
    }

    /*
    private void FillGrid()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mydbaseConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("SELECT [ID], [EmpID], [DateSold], [MonthOnly], [Amount] FROM [SalesTable] WHERE ([EmpID] = @EmpID)", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        gvSales.DataSource = dt;
        gvSales.DataBind();
    }
    */

}