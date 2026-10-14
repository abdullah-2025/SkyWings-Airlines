using System;
using System.Text;
using System.Web;

namespace SkyWingsAirlines
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string passengerName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string selectedSeat = lstSeat.SelectedItem.Text;

            string flightClass = string.Empty;
            if (rdoEconomy.Checked)
            {
                flightClass = "Economy";
            }
            else if (rdoBusiness.Checked)
            {
                flightClass = "Business";
            }
            else if (rdoFirstClass.Checked)
            {
                flightClass = "First Class";
            }

            string extraBaggage = "No";
            string inFlightMeal = "No";
            string wifiAccess = "No";

            if (chkExtraBaggage.Checked)
            {
                extraBaggage = "Yes";
            }

            if (chkMeal.Checked)
            {
                inFlightMeal = "Yes";
            }

            if (chkWifi.Checked)
            {
                wifiAccess = "Yes";
            }

            StringBuilder summary = new StringBuilder();
            summary.AppendLine("SkyWings Booking Summary");
            summary.AppendLine();
            summary.AppendLine("Passenger: " + passengerName);
            summary.AppendLine("Email: " + email);
            summary.AppendLine("Phone: " + phone);
            summary.AppendLine("Flight Class: " + flightClass);
            summary.AppendLine("Selected Seat: " + selectedSeat);
            summary.AppendLine("Extra Baggage: " + extraBaggage);
            summary.AppendLine("In-flight Meal: " + inFlightMeal);
            summary.AppendLine("Wi-Fi Access: " + wifiAccess);
            summary.AppendLine();
            summary.Append("This is a prototype summary, not a reservation confirmation.");

            string safeSummary = HttpUtility.JavaScriptStringEncode(summary.ToString());
            string script = "alert('" + safeSummary + "');";
            ClientScript.RegisterStartupScript(GetType(), "BookingSummary", script, true);
        }
    }
}
