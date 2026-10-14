# SkyWings Airlines – Flight Booking

## 1. Project title and objective

**Project:** SkyWings Airlines – Flight Booking

The objective is to demonstrate a complete ASP.NET Web Forms input workflow. A passenger enters contact information, selects exactly one flight class and one seat, optionally requests extra services, and submits the form. Server-side C# validates the input and displays a readable prototype summary in a JavaScript alert. The system is an academic prototype; it does not confirm a real reservation.

## 2. Technology stack

- ASP.NET Web Forms
- C# code-behind
- .NET Framework 4.8
- ASP.NET server controls
- HTML5 and responsive CSS
- JavaScript `alert()` registered from the server
- Visual Studio 2022 Web Application project

No database, authentication system, payment provider, JavaScript framework, or airline API is used.

## 3. GUI layout diagram

```text
┌──────────────────────────────────────────────────────────────┐
│  ✈ SKYWINGS                                                 │
│  SkyWings Airlines – Flight Booking                         │
│  Choose your seat, personalize your trip...                 │
└──────────────────────────────────────────────────────────────┘
              ┌──────────────────────────────────────┐
              │ Passenger & flight details          │
              ├──────────────────────────────────────┤
              │ [validation messages, when needed]  │
              │                                      │
              │ 01  Passenger Information            │
              │ Full Name                            │
              │ [                                  ] │
              │ Email                 Phone           │
              │ [                  ]  [             ] │
              ├──────────────────────────────────────┤
              │ 02  Flight Preferences               │
              │ Flight Class          Select a Seat   │
              │ ( ) Economy           ┌─────────────┐ │
              │ ( ) Business          │ A1 – Window │ │
              │ ( ) First Class       │ A2 – Aisle  │ │
              │                       │ B1 – Window │ │
              │                       │ B2 – Aisle  │ │
              │                       └─────────────┘ │
              ├──────────────────────────────────────┤
              │ 03  Additional Services              │
              │ [ ] Extra Baggage  [ ] In-flight Meal│
              │ [ ] Wi-Fi Access                      │
              ├──────────────────────────────────────┤
              │                 [ Submit Booking ]    │
              └──────────────────────────────────────┘
```

On screens below 760 pixels wide, multi-column fields and choices become a single-column layout and the submit button spans the available width.

## 4. Six required GUI control types

The page uses all six required ASP.NET Web Forms GUI control types. Every control has a unique `ID` and `runat="server"`.

| Type | Implemented count | Purpose |
|---|---:|---|
| `Label` | 11 | Page/section headings, accessible field captions, and validation feedback |
| `TextBox` | 3 (exactly) | Full name, email address, and phone number input |
| `ListBox` | 1 | Single seat selection from four visible options |
| `RadioButton` | 3 | Mutually exclusive Economy, Business, or First Class selection |
| `CheckBox` | 3 | Independent optional service selections |
| `Button` | 1 | Server-side booking submission |

## 5. Control inventory and purpose

| IDs | Control | Purpose |
|---|---|---|
| `lblPageTitle`, `lblFormHeading` | Label | Identify the page and form |
| `lblPassengerHeading`, `lblFlightHeading`, `lblServicesHeading` | Label | Identify the three form sections |
| `lblFullName`, `lblEmail`, `lblPhone`, `lblFlightClass`, `lblSeat` | Label | Caption the user inputs; text/seat labels use `AssociatedControlID` |
| `lblValidationMessage` | Label | Show meaningful server-side errors with `role="alert"` |
| `txtFullName` | TextBox | Passenger name, maximum 100 characters |
| `txtEmail` | TextBox | Email input, maximum 254 characters |
| `txtPhone` | TextBox | Phone input, maximum 30 characters |
| `rdoEconomy`, `rdoBusiness`, `rdoFirstClass` | RadioButton | One selection in the `FlightClass` group |
| `lstSeat` | ListBox | One of A1, A2, B1, or B2 |
| `chkExtraBaggage`, `chkMeal`, `chkWifi` | CheckBox | Independent optional services |
| `btnSubmit` | Button | Invoke `btnSubmit_Click` |

## 6. Important control properties

Properties store or configure control state.

| Control | Important properties | How they apply |
|---|---|---|
| Label | `Text`, `ForeColor`, `Visible` | `Text` supplies captions/messages. `Visible` hides the validation label until needed. `ForeColor` is available for server-side color configuration, while this page uses CSS for consistent presentation. |
| TextBox | `Text`, `MaxLength`, `TextMode` | `.Text` reads input; `MaxLength` limits it; `TextMode="Email"` and `TextMode="Phone"` provide appropriate HTML input semantics. |
| ListBox | `Items`, `SelectedIndex`, `SelectedValue` | `Items` contains four seats. `SelectedIndex` identifies the current item (`-1` means none), while `SelectedValue` would return A1/A2/B1/B2. The implementation reads `SelectedItem.Text` for the full description. |
| RadioButton | `Text`, `Checked`, `GroupName` | `Text` displays a class name, `Checked` reports its selection, and the shared `FlightClass` group enforces a single browser selection. |
| CheckBox | `Text`, `Checked`, `Enabled` | `Text` names each service, `Checked` reports inclusion, and `Enabled` could disable an unavailable service. |
| Button | `Text`, `Enabled`, `ID`, `OnClick` | `Text` is “Submit Booking,” `ID` is `btnSubmit`, and `OnClick` binds the server handler. `Enabled` can control availability. |

## 7. Relevant methods and events

Methods perform actions; events notify code that an interaction or state change occurred.

| Control | Methods | Events |
|---|---|---|
| Label | `DataBind()`, `Focus()` | Labels have no task-specific event here. `DataBind()` binds expressions/data; inherited `Focus()` requests focus when appropriate. |
| TextBox | `Focus()` | `TextChanged` occurs when posted text changes (normally with postback). The page calls inherited `Focus()` on the first invalid input. |
| ListBox | `Items.Add()`, `ClearSelection()` | `SelectedIndexChanged` is available when a selection changes. `Items.Add()` can add a seat and `ClearSelection()` removes selections. |
| RadioButton | `Focus()` (inherited) | `CheckedChanged` occurs when checked state changes. The page focuses the Economy option when the group is invalid. |
| CheckBox | `Focus()` (inherited) | `CheckedChanged` occurs when checked state changes. |
| Button | `Focus()` (inherited) | `Click` is raised on submission and is connected through `OnClick="btnSubmit_Click"`. |

The listed APIs explain the controls; not every available method or change event needs to be called by this form. The implemented interaction is the Button `Click` event.

## 8. Reasons for selecting each control

- **Label:** renders server-managed, accessible captions and lets the server show or hide validation feedback.
- **TextBox:** is the standard Web Forms control for free-form text and supports browser-appropriate email and telephone modes.
- **ListBox:** keeps all four seats visible and provides a direct single-selection interface.
- **RadioButton:** communicates that flight classes are mutually exclusive; the common `GroupName` enforces the relationship.
- **CheckBox:** correctly represents independent optional services where zero, one, or many choices are valid.
- **Button:** causes a server postback and raises the `Click` event required to validate and summarize the form.

## 9. C# button-click implementation

`Booking.aspx` declares `OnClick="btnSubmit_Click"`. The matching protected handler in `Booking.aspx.cs` has the required signature:

```csharp
protected void btnSubmit_Click(object sender, EventArgs e)
```

The handler first calls `ValidateBooking()`. If validation fails, it displays the error label, focuses the first invalid control, and returns before registering a script. If validation passes, it reads the three `.Text` values and `lstSeat.SelectedItem.Text`. An `if / else if` chain determines flight class. Three separate `if` statements determine the optional service values. A `StringBuilder` combines all values into one readable summary.

Before the summary becomes JavaScript source, `HttpUtility.JavaScriptStringEncode()` escapes quotes, line breaks, backslashes, and other special characters. The alert is then registered with:

```csharp
ClientScript.RegisterStartupScript(GetType(), "BookingSummary", script, true);
```

## 10. Application logic flow

```text
Open Booking.aspx
        │
Enter passenger details and make selections
        │
Click Submit Booking
        │
Server runs ValidateBooking()
        │
        ├── Invalid ──> Show messages + focus first invalid field
        │               (no success alert registered)
        │
        └── Valid ────> Read controls
                        Determine class with if / else if
                        Determine services with separate if statements
                        Build summary
                        JavaScript-encode summary
                        Register and display alert
```

## 11. Validation explanation

Validation is performed on the server so it cannot be bypassed simply by disabling browser validation. The form intentionally has `novalidate` so the assignment's server-side messages are consistently demonstrated.

- Full name is rejected when null, empty, or whitespace.
- Email is required and parsed with `System.Net.Mail.MailAddress`; the parsed address must equal the complete entered value.
- Phone number is required and rejects null, empty, or whitespace.
- The three radio states are counted, and the count must be exactly one.
- `SelectedItem` must not be null before its `.Text` property is read.
- Additional services are optional and require no error.
- Invalid input returns before `RegisterStartupScript()`, so no success popup appears.
- User-controlled values are passed through `JavaScriptStringEncode()` before insertion into the alert script.

## 12. Test cases and expected results

| # | Test input/action | Expected result |
|---:|---|---|
| 1 | Submit every field empty | Messages request name, email, phone, one class, and one seat; no alert appears. |
| 2 | Enter all required values but use `invalid-email` | A valid-email message appears; no alert appears. |
| 3 | Enter contact details and seat but no class | “Select exactly one flight class” appears; no alert appears. |
| 4 | Enter contact details and class but no seat | “Select a seat” appears; no alert appears. |
| 5 | Submit valid details with no optional services | Alert lists the passenger data and “No” for all three services. |
| 6 | Select Business, A1, baggage and meal | Alert lists Business, “A1 – Window,” Yes, Yes, and No for Wi-Fi. |
| 7 | Check all three services | Alert lists “Yes” for each service. |
| 8 | Put an apostrophe, quote, or `<script>` text in the name | Text appears as summary content without breaking out of the JavaScript string or executing injected script. |
| 9 | Select each flight-class option in turn | Only one option remains checked because every radio uses `GroupName="FlightClass"`. |
| 10 | Resize browser below 760 px | Fields and option cards stack into a readable single-column layout. |

## 13. Screenshot evidence references

Runtime evidence belongs in `Documentation/Screenshots/` under these names:

- `booking-form.png` — desktop view of the complete page.
- `validation-errors.png` — invalid submission and server messages.
- `booking-summary.png` — successful JavaScript summary alert.
- `responsive-form.png` — narrow responsive layout.

The authoring environment did not contain the Windows-only .NET Framework 4.8/IIS Express runtime, so runtime screenshots were not fabricated. `Screenshots/README.md` records the capture checklist. These four images should be captured during the documented Visual Studio 2022 verification session.

## 14. Conclusion

SkyWings Airlines meets the assignment's requested Web Forms structure and uses all six required control types with the exact constrained counts. It separates presentation, server controls, code-behind, validation, and documentation. The responsive interface remains simple enough for an academic demonstration, while server validation and JavaScript encoding make the prototype robust against missing input and script-string injection.
