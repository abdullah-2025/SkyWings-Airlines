# SkyWings Airlines Setup

## Required environment

Use a Windows computer with:

- Visual Studio 2022
- The **ASP.NET and web development** workload
- .NET Framework 4.8 SDK and targeting pack
- IIS Express (included with the Visual Studio web workload)

No NuGet packages, database server, Node.js installation, or external APIs are required.

## Open and run

1. Open `SkyWingsAirlines.sln` in Visual Studio 2022.
2. If Visual Studio asks to install a missing targeting pack or web component, install the .NET Framework 4.8 developer tools and ASP.NET web workload through Visual Studio Installer.
3. In Solution Explorer, right-click `Booking.aspx` and choose **Set as Start Page** if it is not already selected.
4. Select **Debug > Start Without Debugging** (or press `Ctrl+F5`).
5. IIS Express should open the booking form in the default browser.

`Web.config` also lists `Booking.aspx` as the default document, so browsing to the application root opens the form.

## Build from a Visual Studio Developer Command Prompt

```powershell
msbuild SkyWingsAirlines.sln /t:Build /p:Configuration=Debug
```

Run that command from the outer `SkyWingsAirlines` directory.

## Verification status on the authoring machine

The source was authored on macOS, where Visual Studio 2022, IIS Express, MSBuild for full .NET Framework, and the .NET Framework 4.8 reference assemblies were not available. Per the assignment constraints, no replacement framework or development dependency was installed. Therefore, compilation and browser execution were not claimed on this machine.

Static checks completed on the authoring machine:

- solution and project paths were checked for consistency;
- `SkyWingsAirlines.csproj` and `Web.config` were parsed as well-formed XML;
- all code-behind control references were matched to designer declarations;
- the required Web Forms control counts were checked;
- the `Click` event name was matched between markup and code-behind.

Complete the runtime test cases in `SkyWingsAirlines/Documentation/Assignment-Report.md` on Windows after building successfully.

## Troubleshooting

- **The .NET Framework 4.8 reference assemblies were not found:** add the .NET Framework 4.8 SDK/targeting pack in Visual Studio Installer.
- **The Web Application targets were not found:** add the ASP.NET and web development workload.
- **The root URL does not open the page:** right-click `Booking.aspx`, choose **Set as Start Page**, and run again.
- **A generated designer file is out of sync:** right-click `Booking.aspx` and choose **Convert to Web Application**. The committed designer file should normally make this unnecessary.
