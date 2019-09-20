MIME-Version: 1.0
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1568724293-5069-1-git-send-email-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Sep 2019 17:44:44 +0300
Message-ID: <CAGyAFMVjqC4mdjy83v+UqgLBnv3yLGwRT5Hg_PAB+_PwEMoDZw@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ae2ed0592fd1dbe"
Subject: Re: [Openvpn-devel] [PATCH 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000ae2ed0592fd1dbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Wintun driver is now signed for Windows 10,

https://staging.openvpn.net/openvpn2/wintun-0.6-signed.zip

So if you want to try out super fast openvpn2, no need to meddle anymore
with test mode / disabling signature checks.

ti 17. syysk. 2019 klo 15.45 Lev Stipakov (lstipakov@...277...) kirjoitti:

> From: Lev Stipakov <lev@...515...>
>
> This set of patches adds support of wintun kernel driver (
> https://www.wintun.net) to OpenVPN.
>
> While wintun is in beta, it performs significantly faster comparison to
> tap-windows6.
>
> Here are some performance numbers (download bandwidth):
>
> Server - community openvpn2
>
> mingw, tap-windows6   - 340Mbit/s
> mingw, wintun         - 675Mbit/s
> VS2019, tap-windows6  - 425Mbit/s
> VS2019, wintun        - 750Mbit/s
>
> Server - propietary openvpn3 with kernel acceleration (in development)
>
> mingw, tap-windows6   - 360Mbit/s
> mingw, wintun         - 840Mbit/s
> VS2019, tap-windows6  - 430Mbit/s
> VS2019, wintun        - 1,14Gbit/s
>
> And for the reference
> openvpn3 test client, VS2019, wintun - 1,71Gbit/s
>
> Some observations from those numbers:
>
>     * wintun performs more than twice faster comparison to tap-windows6
> agains community server (750Mbit/s vs 340Mbit/s)
>     * Visual Studio provides noticeable performance boost (up to 25%)
>         * we should build Windows clients with VS, not with mingw
>     * There's room for improvement in openvpn2, since under best
> conditions openvpn3 performs 50% faster
>
> Steps to try out new client:
>
>     * Install Wintun driver
>         * since driver is not signed, you need to enable test mode to
> install unsigned driver
>             * run in administrative command prompt:
>               bcdedit /set testsigning on
>             * restart
>         * download and unpack
> https://staging.openvpn.net/openvpn2/wintun-0.6-unsigned.zip to
> C:\Temp\wintun (for example)
>         * if you have OpenVPN GUI client installed, run under
> administrative command prompt:
>           c:\Program Files\TAP-Windows\bin>tapinstall.exe install
> c:\Temp\wintun\wintun.inf wintun
>         * alternatively you can install driver via windows device manager
> -> action ->add legacy hardware -> install manually ->
>           point to wintun.inf in C:\Temp\wintun
>
>     * Install openvpn client with wintun support
>         * download and unpack
> https://staging.openvpn.net/openvpn2/openvpn2-wintun-support.zip to
> C:\Temp\openvpn (for example)
>         * if you use OpenVPN GUI, copy all files from C:\Temp\openvpn to
> C:\Program Files\OpenVPN\bin. Don't forget to
>           stop OpenVPN Interactive Service before copying and start it
> back afterwards (net stop/start OpenVPNServiceInteractive in admin command
> prompt)
>
>     * Connect to VPN from command line
>         * run from administrative command prompt
>           c:\Temp\openvpn>openvpn.exe --config client.ovpn
> --windows-driver wintun
>         * you should see something around these lines in log
>           Tue Sep 17 15:09:58 2019 us=3D296000 interactive service
> msg_channel=3D0
>           Tue Sep 17 15:09:58 2019 us=3D312000 open_tun
>           Tue Sep 17 15:09:58 2019 us=3D312000 Wintun device
> [L=C3=A4hiverkkoyhteys] opened:
> \\?\ROOT#NET#0004#{cac88484-7515-4c03-82e6-71a87abac361}
>           Tue Sep 17 15:09:58 2019 us=3D312000 do_ifconfig, ipv4=3D1, ipv=
6=3D0
>           Tue Sep 17 15:09:59 2019 us=3D312000 NETSH:
> C:\Windows\system32\netsh.exe interface ip set address L=C3=A4hiverkkoyht=
eys
> static 10.8.0.2 255.255.255.0
>           Tue Sep 17 15:10:00 2019 us=3D406000 NETSH:
> C:\Windows\system32\netsh.exe interface ip delete dns L=C3=A4hiverkkoyhte=
ys all
>           Tue Sep 17 15:10:01 2019 us=3D484000 NETSH:
> C:\Windows\system32\netsh.exe interface ip set dns L=C3=A4hiverkkoyhteys =
static
> 10.8.0.1
>           Tue Sep 17 15:10:14 2019 us=3D578000 NETSH:
> C:\Windows\system32\netsh.exe interface ip delete wins L=C3=A4hiverkkoyht=
eys all
>           Tue Sep 17 15:10:19 2019 us=3D296000 TEST ROUTES: 0/0 succeeded
> len=3D0 ret=3D1 a=3D0 u/d=3Dup
>           Tue Sep 17 15:10:19 2019 us=3D296000 WARNING: this configuration
> may cache passwords in memory -- use the auth-nocache option to prevent t=
his
>           Tue Sep 17 15:10:19 2019 us=3D296000 Initialization Sequence
> Completed
>         * congratulations!
>
>     * Connect to VPN from OpenVPN GUI
>         * right click on tray icon -> profile name -> Edit Config
>         * add "windows-driver wintun" to profile, save and close
>         * right click on tray icon -> profile name -> Connect
>         * you should see something around these lines in log
>           Tue Sep 17 15:15:46 2019 interactive service msg_channel=3D676
>           Tue Sep 17 15:15:46 2019 open_tun
>           Tue Sep 17 15:15:46 2019 Wintun device [L=C3=A4hiverkkoyhteys]
> opened: \\?\ROOT#NET#0004#{cac88484-7515-4c03-82e6-71a87abac361}
>           Tue Sep 17 15:15:46 2019 Ring buffers registered via service
>           Tue Sep 17 15:15:46 2019 do_ifconfig, ipv4=3D1, ipv6=3D0
>           Tue Sep 17 15:15:46 2019 MANAGEMENT:
> >STATE:1568722546,ASSIGN_IP,,10.8.0.2,,,,
>           Tue Sep 17 15:15:46 2019 Setting IPv4 dns servers on
> 'L=C3=A4hiverkkoyhteys' (if_index =3D 3) using service
>           Tue Sep 17 15:15:46 2019 IPv4 dns servers set using service
>           Tue Sep 17 15:15:51 2019 TEST ROUTES: 0/0 succeeded len=3D0 ret=
=3D1
> a=3D0 u/d=3Dup
>           Tue Sep 17 15:15:51 2019 WARNING: this configuration may cache
> passwords in memory -- use the auth-nocache option to prevent this
>           Tue Sep 17 15:15:51 2019 Initialization Sequence Completed
>         * congratulations!
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/compat/compat.vcxproj             | 12 ++++++------
>  src/openvpn/openvpn.vcxproj           | 12 ++++++------
>  src/openvpnmsica/openvpnmsica.vcxproj | 14 +++++++-------
>  src/openvpnserv/openvpnserv.vcxproj   | 12 ++++++------
>  src/tapctl/tapctl.vcxproj             | 14 +++++++-------
>  5 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
> index 111dacd..e388008 100644
> --- a/src/compat/compat.vcxproj
> +++ b/src/compat/compat.vcxproj
> @@ -22,30 +22,30 @@
>      <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
>      <RootNamespace>compat</RootNamespace>
>      <Keyword>Win32Proj</Keyword>
> -
> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>StaticLibrary</ConfigurationType>
>      <CharacterSet>MultiByte</CharacterSet>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>StaticLibrary</ConfigurationType>
>      <CharacterSet>MultiByte</CharacterSet>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>StaticLibrary</ConfigurationType>
>      <CharacterSet>MultiByte</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>StaticLibrary</ConfigurationType>
>      <CharacterSet>MultiByte</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>    <ImportGroup Label=3D"ExtensionSettings">
> @@ -115,4 +115,4 @@
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label=3D"ExtensionTargets">
>    </ImportGroup>
> -</Project>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 92d7e32..3422b64 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -22,30 +22,30 @@
>      <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
>      <RootNamespace>openvpn</RootNamespace>
>      <Keyword>Win32Proj</Keyword>
> -
> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>    <ImportGroup Label=3D"ExtensionSettings">
> @@ -299,4 +299,4 @@
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label=3D"ExtensionTargets">
>    </ImportGroup>
> -</Project>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
> b/src/openvpnmsica/openvpnmsica.vcxproj
> index 5f1d699..afa4fae 100644
> --- a/src/openvpnmsica/openvpnmsica.vcxproj
> +++ b/src/openvpnmsica/openvpnmsica.vcxproj
> @@ -31,32 +31,32 @@
>      <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
>      <Keyword>Win32Proj</Keyword>
>      <RootNamespace>openvpnmsica</RootNamespace>
> -
> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> @@ -64,14 +64,14 @@
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index 7407757..7061b7b 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -22,30 +22,30 @@
>      <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
>      <RootNamespace>openvpnserv</RootNamespace>
>      <Keyword>Win32Proj</Keyword>
> -
> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <CharacterSet>Unicode</CharacterSet>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>    <ImportGroup Label=3D"ExtensionSettings">
> @@ -139,4 +139,4 @@
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label=3D"ExtensionTargets">
>    </ImportGroup>
> -</Project>
> +</Project>
> \ No newline at end of file
> diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
> index 5c1983b..1d593fc 100644
> --- a/src/tapctl/tapctl.vcxproj
> +++ b/src/tapctl/tapctl.vcxproj
> @@ -31,32 +31,32 @@
>      <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
>      <Keyword>Win32Proj</Keyword>
>      <RootNamespace>tapctl</RootNamespace>
> -
> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>    </PropertyGroup>
>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>true</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> @@ -64,14 +64,14 @@
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
>    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
>      <ConfigurationType>Application</ConfigurationType>
>      <UseDebugLibraries>false</UseDebugLibraries>
> -    <PlatformToolset>v141</PlatformToolset>
> +    <PlatformToolset>v142</PlatformToolset>
>      <WholeProgramOptimization>true</WholeProgramOptimization>
>      <CharacterSet>Unicode</CharacterSet>
>    </PropertyGroup>
> --
> 2.7.4
>
>

--=20
-Lev

--0000000000000ae2ed0592fd1dbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Wintun driver is now signed for =
Windows 10,</div><div><br></div><div><a href=3D"https://staging.openvpn.net=
/openvpn2/wintun-0.6-signed.zip">https://staging.openvpn.net/openvpn2/wintu=
n-0.6-signed.zip</a></div><div><br></div><div>So if you want to try out sup=
er fast openvpn2, no need to meddle anymore with test mode / disabling sign=
ature checks.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">ti 17. syysk. 2019 klo 15.45 Lev Stipakov (<a href=3D"ma=
ilto:lstipakov@...277...">lstipakov@...277...</a>) kirjoitti:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov &lt;<a hre=
f=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
This set of patches adds support of wintun kernel driver (<a href=3D"https:=
//www.wintun.net" rel=3D"noreferrer" target=3D"_blank">https://www.wintun.n=
et</a>) to OpenVPN.<br>
<br>
While wintun is in beta, it performs significantly faster comparison to tap=
-windows6.<br>
<br>
Here are some performance numbers (download bandwidth):<br>
<br>
Server - community openvpn2<br>
<br>
mingw, tap-windows6=C2=A0 =C2=A0- 340Mbit/s<br>
mingw, wintun=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- 675Mbit/s<br>
VS2019, tap-windows6=C2=A0 - 425Mbit/s<br>
VS2019, wintun=C2=A0 =C2=A0 =C2=A0 =C2=A0 - 750Mbit/s<br>
<br>
Server - propietary openvpn3 with kernel acceleration (in development)<br>
<br>
mingw, tap-windows6=C2=A0 =C2=A0- 360Mbit/s<br>
mingw, wintun=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- 840Mbit/s<br>
VS2019, tap-windows6=C2=A0 - 430Mbit/s<br>
VS2019, wintun=C2=A0 =C2=A0 =C2=A0 =C2=A0 - 1,14Gbit/s<br>
<br>
And for the reference<br>
openvpn3 test client, VS2019, wintun - 1,71Gbit/s<br>
<br>
Some observations from those numbers:<br>
<br>
=C2=A0 =C2=A0 * wintun performs more than twice faster comparison to tap-wi=
ndows6 agains community server (750Mbit/s vs 340Mbit/s)<br>
=C2=A0 =C2=A0 * Visual Studio provides noticeable performance boost (up to =
25%)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * we should build Windows clients with VS, not =
with mingw<br>
=C2=A0 =C2=A0 * There&#39;s room for improvement in openvpn2, since under b=
est conditions openvpn3 performs 50% faster<br>
<br>
Steps to try out new client:<br>
<br>
=C2=A0 =C2=A0 * Install Wintun driver<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * since driver is not signed, you need to enabl=
e test mode to install unsigned driver<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * run in administrative command p=
rompt:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bcdedit /set testsigning o=
n<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * restart<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * download and unpack <a href=3D"https://stagin=
g.openvpn.net/openvpn2/wintun-0.6-unsigned.zip" rel=3D"noreferrer" target=
=3D"_blank">https://staging.openvpn.net/openvpn2/wintun-0.6-unsigned.zip</a=
> to C:\Temp\wintun (for example)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * if you have OpenVPN GUI client installed, run=
 under administrative command prompt:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c:\Program Files\TAP-Windows\bin&gt;tapi=
nstall.exe install c:\Temp\wintun\wintun.inf wintun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * alternatively you can install driver via wind=
ows device manager -&gt; action -&gt;add legacy hardware -&gt; install manu=
ally -&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 point to wintun.inf in C:\Temp\wintun<br>
<br>
=C2=A0 =C2=A0 * Install openvpn client with wintun support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * download and unpack <a href=3D"https://stagin=
g.openvpn.net/openvpn2/openvpn2-wintun-support.zip" rel=3D"noreferrer" targ=
et=3D"_blank">https://staging.openvpn.net/openvpn2/openvpn2-wintun-support.=
zip</a> to C:\Temp\openvpn (for example)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * if you use OpenVPN GUI, copy all files from C=
:\Temp\openvpn to C:\Program Files\OpenVPN\bin. Don&#39;t forget to <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop OpenVPN Interactive Service before =
copying and start it back afterwards (net stop/start OpenVPNServiceInteract=
ive in admin command prompt)<br>
<br>
=C2=A0 =C2=A0 * Connect to VPN from command line<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * run from administrative command prompt<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c:\Temp\openvpn&gt;openvpn.exe --config =
client.ovpn --windows-driver wintun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * you should see something around these lines i=
n log<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:09:58 2019 us=3D296000 int=
eractive service msg_channel=3D0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:09:58 2019 us=3D312000 ope=
n_tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:09:58 2019 us=3D312000 Win=
tun device [L=C3=A4hiverkkoyhteys] opened: \\?\ROOT#NET#0004#{cac88484-7515=
-4c03-82e6-71a87abac361}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:09:58 2019 us=3D312000 do_=
ifconfig, ipv4=3D1, ipv6=3D0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:09:59 2019 us=3D312000 NET=
SH: C:\Windows\system32\netsh.exe interface ip set address L=C3=A4hiverkkoy=
hteys static 10.8.0.2 255.255.255.0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:00 2019 us=3D406000 NET=
SH: C:\Windows\system32\netsh.exe interface ip delete dns L=C3=A4hiverkkoyh=
teys all<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:01 2019 us=3D484000 NET=
SH: C:\Windows\system32\netsh.exe interface ip set dns L=C3=A4hiverkkoyhtey=
s static 10.8.0.1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:14 2019 us=3D578000 NET=
SH: C:\Windows\system32\netsh.exe interface ip delete wins L=C3=A4hiverkkoy=
hteys all<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:19 2019 us=3D296000 TES=
T ROUTES: 0/0 succeeded len=3D0 ret=3D1 a=3D0 u/d=3Dup<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:19 2019 us=3D296000 WAR=
NING: this configuration may cache passwords in memory -- use the auth-noca=
che option to prevent this<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:10:19 2019 us=3D296000 Ini=
tialization Sequence Completed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * congratulations!<br>
<br>
=C2=A0 =C2=A0 * Connect to VPN from OpenVPN GUI<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * right click on tray icon -&gt; profile name -=
&gt; Edit Config<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * add &quot;windows-driver wintun&quot; to prof=
ile, save and close<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * right click on tray icon -&gt; profile name -=
&gt; Connect<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * you should see something around these lines i=
n log<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 interactive ser=
vice msg_channel=3D676<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 open_tun<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 Wintun device [=
L=C3=A4hiverkkoyhteys] opened: \\?\ROOT#NET#0004#{cac88484-7515-4c03-82e6-7=
1a87abac361}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 Ring buffers re=
gistered via service<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 do_ifconfig, ip=
v4=3D1, ipv6=3D0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 MANAGEMENT: &gt=
;STATE:1568722546,ASSIGN_IP,,10.8.0.2,,,,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 Setting IPv4 dn=
s servers on &#39;L=C3=A4hiverkkoyhteys&#39; (if_index =3D 3) using service=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:46 2019 IPv4 dns server=
s set using service<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:51 2019 TEST ROUTES: 0/=
0 succeeded len=3D0 ret=3D1 a=3D0 u/d=3Dup<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:51 2019 WARNING: this c=
onfiguration may cache passwords in memory -- use the auth-nocache option t=
o prevent this<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tue Sep 17 15:15:51 2019 Initialization =
Sequence Completed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * congratulations!<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/compat/compat.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 12 ++++++------<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 12 ++++++------<br>
=C2=A0src/openvpnmsica/openvpnmsica.vcxproj | 14 +++++++-------<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0| 12 ++++++------<br>
=C2=A0src/tapctl/tapctl.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 14 +++++++-------<br>
=C2=A05 files changed, 32 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj<br>
index 111dacd..e388008 100644<br>
--- a/src/compat/compat.vcxproj<br>
+++ b/src/compat/compat.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{4B2E2719-E661-45D7-9203-F6F456B22F1=
9}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;compat&lt;/RootNamespace&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -115,4 +115,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 92d7e32..3422b64 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{29DF226E-4D4E-440F-ADAF-5829CFD4CA9=
4}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpn&lt;/RootNamespace&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -299,4 +299,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openv=
pnmsica.vcxproj<br>
index 5f1d699..afa4fae 100644<br>
--- a/src/openvpnmsica/openvpnmsica.vcxproj<br>
+++ b/src/openvpnmsica/openvpnmsica.vcxproj<br>
@@ -31,32 +31,32 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{D41AA9D6-B818-476E-992E-0E16EB86BEE=
2}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpnmsica&lt;/RootNamespace&gt;=
<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
@@ -64,14 +64,14 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index 7407757..7061b7b 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{9C91EE0B-817D-420A-A1E6-15A5A9D98BA=
D}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpnserv&lt;/RootNamespace&gt;<=
br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -139,4 +139,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj<br>
index 5c1983b..1d593fc 100644<br>
--- a/src/tapctl/tapctl.vcxproj<br>
+++ b/src/tapctl/tapctl.vcxproj<br>
@@ -31,32 +31,32 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{A06436E7-D576-490D-8BA0-0751D920334=
A}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;tapctl&lt;/RootNamespace&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
@@ -64,14 +64,14 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--0000000000000ae2ed0592fd1dbe--

