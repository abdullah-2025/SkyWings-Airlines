using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

namespace SkyWingsAirlines
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblValidationMessage.Visible = false;

            List<string> validationErrors = ValidateBooking();
            if (validationErrors.Count > 0)
            {
                lblValidationMessage.Text = "Please correct the following:<br />• "
                    + string.Join("<br />• ", validationErrors);
                lblValidationMessage.Visible = true;
                return;
            }

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

        private List<string> ValidateBooking()
        {
            List<string> errors = new List<string>();
            WebControl firstInvalidControl = null;

            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                errors.Add("Enter the passenger's full name.");
                firstInvalidControl = txtFullName;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                errors.Add("Enter an email address.");
                if (firstInvalidControl == null)
                {
                    firstInvalidControl = txtEmail;
                }
            }
            else if (!IsValidEmail(txtEmail.Text.Trim()))
            {
                errors.Add("Enter a valid email address (for example, passenger@example.com).");
                if (firstInvalidControl == null)
                {
                    firstInvalidControl = txtEmail;
                }
            }

            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                errors.Add("Enter a phone number.");
                if (firstInvalidControl == null)
                {
                    firstInvalidControl = txtPhone;
                }
            }

            int selectedClassCount = 0;
            if (rdoEconomy.Checked)
            {
                selectedClassCount++;
            }
            if (rdoBusiness.Checked)
            {
                selectedClassCount++;
            }
            if (rdoFirstClass.Checked)
            {
                selectedClassCount++;
            }

            if (selectedClassCount != 1)
            {
                errors.Add("Select exactly one flight class.");
                if (firstInvalidControl == null)
                {
                    firstInvalidControl = rdoEconomy;
                }
            }

            if (lstSeat.SelectedItem == null)
            {
                errors.Add("Select a seat.");
                if (firstInvalidControl == null)
                {
                    firstInvalidControl = lstSeat;
                }
            }

            if (firstInvalidControl != null)
            {
                firstInvalidControl.Focus();
            }

            return errors;
        }

        private static bool IsValidEmail(string email)
        {
            try
            {
                MailAddress parsedAddress = new MailAddress(email);
                return string.Equals(parsedAddress.Address, email, StringComparison.OrdinalIgnoreCase);
            }
            catch (FormatException)
            {
                return false;
            }
        }
    }
}
