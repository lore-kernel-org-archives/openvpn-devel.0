From: tincanteksup <tincanteksup@...277...>
References: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
 <76addf9c-a14e-0e59-bb01-dace07b56a03@...277...>
 <775f6ca7-227f-6ae9-2206-1fa3d11b6376@...277...>
 <5aa26403-9948-df7a-6eaa-a6c1d0ba0a29@...277...>
Message-ID: <874acac0-8e68-765d-43b1-f1fd185bbb05@...277...>
Date: Thu, 20 Dec 2018 14:22:34 +0000
MIME-Version: 1.0
In-Reply-To: <5aa26403-9948-df7a-6eaa-a6c1d0ba0a29@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [Help required] Testing MSI installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net



On 20/12/2018 14:00, tincanteksup wrote:
>=20
>=20
> On 20/12/2018 13:52, tincanteksup wrote:
>>
>>
>> On 20/12/2018 13:46, tincanteksup wrote:
>>> Hi,
>>>
>>> On 19/12/2018 21:55, Simon Rozman wrote:
>>>> Hi,
>>>
>>>> Remember: Test it to fail!
>>>>
>>>> Any feedback kindly appreciated.
>>>>
>>>
>>> I just tested this on a "fresh" Win7 VM and it failed.
>>>
>>> By "fresh" I mean this:
>>>
>>> =A0=A0 The Win7 VM is from:
>>> =A0=A0 https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/
>>>
>>> =A0=A0 Credit the find to:
>>> =A0=A0 https://easylinuxtipsproject.blogspot.com/p/virtualbox.html
>>>
>>> =A0=A0 The VM i used is IE11-Win7 x86
>>>
>=20
>=20
>=20
> This may be a false alarm because Windows has decided this VM needs
> "some" updates .. I'll update after the reboot dance. *yawn*
>=20

Some 5349 patches later .. the error message is still the same.

But the log has more data:

=3D=3D=3D Logging started: 20/12/2018  06:16:38 =3D=3D=3D
Action 06:16:38: INSTALL.
Action start 06:16:38: INSTALL.
Action 06:16:38: SetDefaultUIFontVista.
Action start 06:16:38: SetDefaultUIFontVista.
Action ended 06:16:38: SetDefaultUIFontVista. Return value 1.
Action 06:16:38: SetDlgStrongFontVista.
Action start 06:16:38: SetDlgStrongFontVista.
Action ended 06:16:38: SetDlgStrongFontVista. Return value 1.
Action 06:16:38: SetDlgTitleFontVista.
Action start 06:16:38: SetDlgTitleFontVista.
Action ended 06:16:38: SetDlgTitleFontVista. Return value 1.
Action 06:16:38: PreparePage.
Action start 06:16:38: PreparePage.
Info 2898. For DefaultUIFontVista textstyle, the system created a 'Segoe=20
UI' font, in 1 character set, of 20 pixels height.
Info 2898. For DlgTitleFontVista textstyle, the system created a 'Segoe=20
UI' font, in 1 character set, of 25 pixels height.
Action 06:16:38: PreparePage. Dialog created
Action ended 06:16:38: PreparePage. Return value 1.
Action 06:16:38: FindRelatedProducts. Searching for related applications
Action start 06:16:38: FindRelatedProducts.
Action ended 06:16:38: FindRelatedProducts. Return value 1.
Action 06:16:38: FindTAPInterfaces. Searching for TAP interfaces
Action start 06:16:38: FindTAPInterfaces.
CustomAction FindTAPInterfaces returned actual error code 1154 (note=20
this may not be 100% accurate if translation happened inside sandbox)
Error 1723. There is a problem with this Windows Installer package. A=20
DLL required for this install to complete could not be run. Contact your=20
support personnel or package vendor.  Action FindTAPInterfaces, entry:=20
FindTAPInterfaces, library: C:\Users\IEUser\AppData\Local\Temp\MSI9064.tmp
MSI (c) (B4:E4) [06:16:48:804]: Product: OpenVPN 2.4.6m3-I603 x86 --=20
Error 1723. There is a problem with this Windows Installer package. A=20
DLL required for this install to complete could not be run. Contact your=20
support personnel or package vendor.  Action FindTAPInterfaces, entry:=20
FindTAPInterfaces, library: C:\Users\IEUser\AppData\Local\Temp\MSI9064.tmp

Action ended 06:16:48: FindTAPInterfaces. Return value 3.
Action 06:16:48: FatalErrorPage.
Action start 06:16:48: FatalErrorPage.
Action 06:16:48: FatalErrorPage. Dialog created
Action ended 06:16:50: FatalErrorPage. Return value 2.
Action ended 06:16:50: INSTALL. Return value 3.
Property(C): InstallMode =3D Typical
Property(C): UpgradeCode =3D {1195A47B-A37A-4055-9D34-B7A691F7E97B}
Property(C): DesktopFolder =3D C:\Users\Public\Desktop\
Property(C): InstallModeRB =3D Change
Property(C): ErrorDialog =3D ErrorDialog
Property(C): LOGAPPEND =3D 0
Property(C): DISABLESAVEPWD =3D #0
Property(C): ADMINGROUP =3D OpenVPN Administrators
Property(C): PRIORITY =3D NORMAL_PRIORITY_CLASS
Property(C): DefaultUIFont =3D DefaultUIFontVista
Property(C): DlgStrongFont =3D {\DlgStrongFontVista}
Property(C): DlgTitleFont =3D {\DlgTitleFontVista}
Property(C): ProgramFilesFolder =3D C:\Program Files\
Property(C): ProgramMenuFolder =3D C:\ProgramData\Microsoft\Windows\Start=20
Menu\Programs\
Property(C): SourceDir =3D C:\Users\IEUser\AppData\Local\Temp\7zS02ECCC21\
Property(C): VersionNT =3D 601
Property(C): ALLUSERS =3D 1
Property(C): ARPPRODUCTICON =3D openvpn.ico
Property(C): ARPURLINFOABOUT =3D https://openvpn.net/index.php/open-source/
Property(C): ARPURLUPDATEINFO =3D=20
https://openvpn.net/index.php/open-source/downloads.html
Property(C): SimpleProductName =3D OpenVPN
Property(C): DisplayVersion =3D 2.4.6m3-I603
Property(C): MSICHECKCRCS =3D 1
Property(C): PROMPTROLLBACKCOST =3D P
Property(C): EDITOR =3D notepad.exe
Property(C): INSTALLLEVEL =3D 2
Property(C): Manufacturer =3D OpenVPN Technologies, Inc.
Property(C): ProductCode =3D {45521BD6-AC59-4050-A7A9-4B4EDDD3DC3D}
Property(C): ProductLanguage =3D 1033
Property(C): ProductName =3D OpenVPN 2.4.6m3-I603 x86
Property(C): ProductVersion =3D 2.4.603
Property(C): Setup =3D Setup
Property(C): ButtonTextInstall =3D &Install Now
Property(C): TitleCustomize =3D Custom Installation
Property(C): Progress1 =3D Installing
Property(C): Progress2 =3D Setup
Property(C): SecureCustomProperties =3D=20
ACTIVETAPINTERFACES;DRIVERCERTIFICATION;NETFRAMEWORK40FULL;TAPINTERFACES;WI=
X_DOWNGRADE_DETECTED;WIX_UPGRADE_DETECTED
Property(C): MsiHiddenProperties =3D=20
AddMachineCertificate;AddUserCertificate;DeleteMachineCertificate;DeleteUse=
rCertificate;RollbackAddMachineCertificate;RollbackAddUserCertificate;Rollb=
ackDeleteMachineCertificate;RollbackDeleteUserCertificate
Property(C): MsiLogFileLocation =3D=20
C:\Users\IEUser\AppData\Local\Temp\OpenVPN-install.log
Property(C): PackageCode =3D {E27BDB21-564E-4BCA-82D4-F33A921B88CC}
Property(C): ProductState =3D -1
Property(C): PackagecodeChanging =3D 1
Property(C): CURRENTDIRECTORY =3D=20
C:\Users\IEUser\AppData\Local\Temp\7zS02ECCC21
Property(C): CLIENTUILEVEL =3D 0
Property(C): CLIENTPROCESSID =3D 3764
Property(C): VersionDatabase =3D 400
Property(C): VersionMsi =3D 5.00
Property(C): WindowsBuild =3D 7601
Property(C): ServicePackLevel =3D 1
Property(C): ServicePackLevelMinor =3D 0
Property(C): MsiNTProductType =3D 1
Property(C): WindowsFolder =3D C:\Windows\
Property(C): WindowsVolume =3D C:\
Property(C): SystemFolder =3D C:\Windows\system32\
Property(C): System16Folder =3D C:\Windows\system\
Property(C): RemoteAdminTS =3D 1
Property(C): TempFolder =3D C:\Users\IEUser\AppData\Local\Temp\
Property(C): CommonFilesFolder =3D C:\Program Files\Common Files\
Property(C): AppDataFolder =3D C:\Users\IEUser\AppData\Roaming\
Property(C): FavoritesFolder =3D C:\Users\IEUser\Favorites\
Property(C): NetHoodFolder =3D=20
C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Network Shortcuts\
Property(C): PersonalFolder =3D C:\Users\IEUser\Documents\
Property(C): PrintHoodFolder =3D=20
C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Printer Shortcuts\
Property(C): RecentFolder =3D=20
C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\Recent\
Property(C): SendToFolder =3D=20
C:\Users\IEUser\AppData\Roaming\Microsoft\Windows\SendTo\
Property(C): TemplateFolder =3D C:\ProgramData\Microsoft\Windows\Templates\
Property(C): CommonAppDataFolder =3D C:\ProgramData\
Property(C): LocalAppDataFolder =3D C:\Users\IEUser\AppData\Local\
Property(C): MyPicturesFolder =3D C:\Users\IEUser\Pictures\
Property(C): AdminToolsFolder =3D C:\ProgramData\Microsoft\Windows\Start=20
Menu\Programs\Administrative Tools\
Property(C): StartupFolder =3D C:\ProgramData\Microsoft\Windows\Start=20
Menu\Programs\Startup\
Property(C): StartMenuFolder =3D C:\ProgramData\Microsoft\Windows\Start Men=
u\
Property(C): FontsFolder =3D C:\Windows\Fonts\
Property(C): GPTSupport =3D 1
Property(C): OLEAdvtSupport =3D 1
Property(C): ShellAdvtSupport =3D 1
Property(C): Intel =3D 6
Property(C): PhysicalMemory =3D 2048
Property(C): VirtualMemory =3D 3650
Property(C): AdminUser =3D 1
Property(C): MsiTrueAdminUser =3D 1
Property(C): LogonUser =3D IEUser
Property(C): UserSID =3D S-1-5-21-3583694148-1414552638-2922671848-1000
Property(C): UserLanguageID =3D 2057
Property(C): ComputerName =3D IEWIN7
Property(C): SystemLanguageID =3D 2057
Property(C): ScreenX =3D 1680
Property(C): ScreenY =3D 936
Property(C): CaptionHeight =3D 24
Property(C): BorderTop =3D 1
Property(C): BorderSide =3D 1
Property(C): TextHeight =3D 20
Property(C): TextInternalLeading =3D 4
Property(C): ColorBits =3D 32
Property(C): TTCSupport =3D 1
Property(C): Time =3D 06:16:50
Property(C): Date =3D 20/12/2018
Property(C): MsiNetAssemblySupport =3D 4.7.3062.0
Property(C): MsiWin32AssemblySupport =3D 6.1.7601.17514
Property(C): RedirectedDllSupport =3D 2
Property(C): MsiRunningElevated =3D 1
Property(C): Privileged =3D 1
Property(C): COMPANYNAME =3D Microsoft
Property(C): DATABASE =3D=20
C:\Users\IEUser\AppData\Local\Temp\7zS02ECCC21\OpenVPN-2.4.6m3-I603-x86.msi
Property(C): OriginalDatabase =3D=20
C:\Users\IEUser\AppData\Local\Temp\7zS02ECCC21\OpenVPN-2.4.6m3-I603-x86.msi
Property(C): SOURCEDIR =3D C:\Users\IEUser\AppData\Local\Temp\7zS02ECCC21\
Property(C): VersionHandler =3D 5.00
Property(C): UILevel =3D 5
Property(C): ACTION =3D INSTALL
Property(C): EXECUTEACTION =3D INSTALL
=3D=3D=3D Logging stopped: 20/12/2018  06:16:50 =3D=3D=3D
MSI (c) (B4:E4) [06:16:50:679]: Windows Installer installed the product.=20
Product Name: OpenVPN 2.4.6m3-I603 x86. Product Version: 2.4.603.=20
Product Language: 1033. Manufacturer: OpenVPN Technologies, Inc..=20
Installation success or error status: 1603.



