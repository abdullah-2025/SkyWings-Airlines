# SkyWings Airlines Setup

## This macOS machine

This repository targets classic ASP.NET Web Forms on .NET Framework 4.8.
That framework and IIS Express are Windows-only, so the project uses Mono and
the XSP development server as a local compatibility environment on this Mac.

The following tools have already been installed on this machine:

- Mono 6.14.1 through Homebrew;
- the Mono `xbuild` compiler and .NET Framework 4.8 reference assemblies;
- XSP 4.8, compiled from the archived official Mono XSP source;
- Autoconf, Automake, Libtool, and pkgconf (needed to build XSP).

From the repository root, start the application with:

```bash
./scripts/run-macos.sh --open
```

The script builds the solution, starts XSP on port `50421`, and opens:

```text
http://127.0.0.1:50421/Booking.aspx
```

Press `Control-C` in the terminal to stop the server. To use a different port:

```bash
SKYWINGS_PORT=5050 ./scripts/run-macos.sh --open
```

In VS Code, use **Terminal > Run Task** and select either **SkyWings: Build**
or **SkyWings: Run on macOS**. C# Dev Kit does not provide native project-system
or debugger support for legacy ASP.NET Web Forms on macOS; the included tasks
are the supported workflow for this machine.

To reinstall the macOS prerequisites on another Homebrew-based Mac:

```bash
brew install mono autoconf automake libtool pkgconf
git clone https://github.com/mono/xsp.git /tmp/xsp
cd /tmp/xsp
./autogen.sh --prefix=/opt/homebrew
make -j4
make install
```

XSP is suitable only for local development and assignment testing. Do not
expose it to a network or use it as a production server.

## Native Windows environment

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

## Verification status on this machine

The solution builds successfully with Mono, and the rendered `Booking.aspx`
page and `Content/booking.css` both return HTTP 200 from XSP. Windows with
Visual Studio and IIS Express remains the authoritative environment for final
submission testing.

## Troubleshooting

- **The .NET Framework 4.8 reference assemblies were not found:** add the .NET Framework 4.8 SDK/targeting pack in Visual Studio Installer.
- **The Web Application targets were not found:** add the ASP.NET and web development workload.
- **The root URL does not open the page:** right-click `Booking.aspx`, choose **Set as Start Page**, and run again.
- **A generated designer file is out of sync:** right-click `Booking.aspx` and choose **Convert to Web Application**. The committed designer file should normally make this unnecessary.
- **`xsp4: command not found` on macOS:** reinstall XSP using the commands in **This macOS machine** above.
- **Port 50421 is already in use:** stop the earlier server with `Control-C`, or set `SKYWINGS_PORT` to another port.
