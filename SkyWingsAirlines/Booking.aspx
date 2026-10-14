<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="SkyWingsAirlines.Booking" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>SkyWings Airlines – Flight Booking</title>
    <link href="Content/booking.css" rel="stylesheet" />
</head>
<body>
    <form id="bookingForm" runat="server" novalidate>
        <header class="hero">
            <div class="hero__content">
                <a class="brand" href="Booking.aspx" aria-label="SkyWings Airlines booking home">
                    <span class="brand__mark" aria-hidden="true">✈</span>
                    <span>SKYWINGS</span>
                </a>
                <div class="hero__copy">
                    <span class="eyebrow">Your journey starts here</span>
                    <asp:Label ID="lblPageTitle" runat="server" CssClass="hero__title"
                        Text="SkyWings Airlines – Flight Booking" />
                    <p>Choose your seat, personalize your trip, and review your booking in moments.</p>
                </div>
            </div>
        </header>

        <main class="page-shell">
            <section class="booking-card" aria-labelledby="lblFormHeading">
                <div class="card-heading">
                    <div>
                        <span class="step-label">Booking request</span>
                        <asp:Label ID="lblFormHeading" runat="server" ClientIDMode="Static"
                            CssClass="card-heading__title" Text="Passenger &amp; flight details" />
                    </div>
                    <span class="required-note"><span aria-hidden="true">*</span> Required fields</span>
                </div>

                <asp:Label ID="lblValidationMessage" runat="server" CssClass="validation-message"
                    Visible="false" role="alert" />

                <section class="form-section" aria-labelledby="lblPassengerHeading">
                    <div class="section-heading">
                        <span class="section-icon" aria-hidden="true">01</span>
                        <asp:Label ID="lblPassengerHeading" runat="server" ClientIDMode="Static"
                            CssClass="section-heading__title" Text="Passenger Information" />
                    </div>
                    <div class="field-grid">
                        <div class="field field--wide">
                            <asp:Label ID="lblFullName" runat="server" AssociatedControlID="txtFullName"
                                CssClass="field__label" Text="Full Name *" />
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="field__input"
                                MaxLength="100" autocomplete="name" placeholder="e.g., Muhammad Abdullah" />
                        </div>
                        <div class="field">
                            <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail"
                                CssClass="field__label" Text="Email Address *" />
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="field__input"
                                TextMode="Email" MaxLength="254" autocomplete="email"
                                placeholder="passenger@example.com" />
                        </div>
                        <div class="field">
                            <asp:Label ID="lblPhone" runat="server" AssociatedControlID="txtPhone"
                                CssClass="field__label" Text="Phone Number *" />
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="field__input"
                                TextMode="Phone" MaxLength="30" autocomplete="tel"
                                placeholder="03001234567" />
                        </div>
                    </div>
                </section>

                <section class="form-section" aria-labelledby="lblFlightHeading">
                    <div class="section-heading">
                        <span class="section-icon" aria-hidden="true">02</span>
                        <asp:Label ID="lblFlightHeading" runat="server" ClientIDMode="Static"
                            CssClass="section-heading__title" Text="Flight Preferences" />
                    </div>
                    <div class="preference-grid">
                        <fieldset class="choice-group">
                            <legend>
                                <asp:Label ID="lblFlightClass" runat="server" CssClass="field__label"
                                    Text="Flight Class *" />
                            </legend>
                            <div class="class-options">
                                <asp:RadioButton ID="rdoEconomy" runat="server" GroupName="FlightClass"
                                    Text="Economy" CssClass="choice choice--class" />
                                <asp:RadioButton ID="rdoBusiness" runat="server" GroupName="FlightClass"
                                    Text="Business" CssClass="choice choice--class" />
                                <asp:RadioButton ID="rdoFirstClass" runat="server" GroupName="FlightClass"
                                    Text="First Class" CssClass="choice choice--class" />
                            </div>
                        </fieldset>
                        <div class="field">
                            <asp:Label ID="lblSeat" runat="server" AssociatedControlID="lstSeat"
                                CssClass="field__label" Text="Select a Seat *" />
                            <asp:ListBox ID="lstSeat" runat="server" CssClass="seat-list" Rows="4">
                                <asp:ListItem Value="A1">A1 – Window</asp:ListItem>
                                <asp:ListItem Value="A2">A2 – Aisle</asp:ListItem>
                                <asp:ListItem Value="B1">B1 – Window</asp:ListItem>
                                <asp:ListItem Value="B2">B2 – Aisle</asp:ListItem>
                            </asp:ListBox>
                            <span class="field__hint">Select one available seat</span>
                        </div>
                    </div>
                </section>

                <section class="form-section" aria-labelledby="lblServicesHeading">
                    <div class="section-heading">
                        <span class="section-icon" aria-hidden="true">03</span>
                        <asp:Label ID="lblServicesHeading" runat="server" ClientIDMode="Static"
                            CssClass="section-heading__title" Text="Additional Services" />
                    </div>
                    <fieldset class="choice-group">
                        <legend class="sr-only">Optional additional services</legend>
                        <div class="service-options">
                            <asp:CheckBox ID="chkExtraBaggage" runat="server" Text="Extra Baggage"
                                CssClass="choice choice--service" />
                            <asp:CheckBox ID="chkMeal" runat="server" Text="In-flight Meal"
                                CssClass="choice choice--service" />
                            <asp:CheckBox ID="chkWifi" runat="server" Text="Wi-Fi Access"
                                CssClass="choice choice--service" />
                        </div>
                    </fieldset>
                </section>

                <div class="form-actions">
                    <p>Review your details in the summary before continuing.</p>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Booking"
                        CssClass="submit-button" OnClick="btnSubmit_Click" />
                </div>
            </section>
            <p class="prototype-note">Prototype booking form for academic demonstration only.</p>
        </main>
    </form>
</body>
</html>
