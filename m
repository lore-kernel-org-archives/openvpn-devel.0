Message-ID: <4D514C06.5010907@...515...>
Date: Tue, 08 Feb 2011 15:58:30 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D4BE51E.1050905@...515...>
	<4D4C7466.4030301@...1147...>	<4D4FAEB0.3040508@...515...>
	<4D4FDDF2.6000002@...1147...> <4D505025.2010007@...515...>
In-Reply-To: <4D505025.2010007@...515...>
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.2-rc Windows installer?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> hi  Samuli,
>>
>> Samuli Sepp=E4nen wrote:
>>=20=20=20
>>=20=20=20=20=20
>>>> Hi Samuli,
>>>>
>>>> Samuli Sepp=E4nen wrote:
>>>>=20=20=20
>>>>=20=20=20=20=20
>>>>=20=20=20=20=20=20=20
>>>>=20=20=20=20=20=20=20=20=20
>>>>> Hi,
>>>>>
>>>>> As some of you may be aware, I've been working on the new Python-based
>>>>> OpenVPN Windows buildsystem; now the first fully functional OpenVPN
>>>>> installer is ready:
>>>>>
>>>>> <http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-p=
review-1.exe>
>>>>>
>>>>> However, I've only done very limited testing. On Windows 7 64-bit
>>>>> platform the following seems to work:
>>>>>
>>>>> - installing and uninstalling all userspace components
>>>>> - installing and uninstalling the (64-bit) TAP driver
>>>>> - running OpenVPN as service
>>>>> - running OpenVPN using the OpenVPN-GUI
>>>>>
>>>>> I've only noticed two small issues on the Win7 64-bit platform:
>>>>>
>>>>> - uninstall does not remove the OpenVPN start menu entries properly
>>>>> (remove manually using right click -> delete)
>>>>> - "View README" at the end of install does not work
>>>>>
>>>>> Note that the installer itself is not signed, even though the TAP
>>>>> drivers are. This will be fixed in the final 2.2-rc release.
>>>>>
>>>>> Now, I'd need help in verifying that both the installer and the inclu=
ded
>>>>> executables work properly on all supported 32 and 64-bit Windows
>>>>> platforms (XP and later). If you can, please test the installer on so=
me
>>>>> _non-critical system_ and report back, whether everything works prope=
rly
>>>>> or not. Once all installer bugs are squashed, I'll make the
>>>>> openvpn-2.2-rc release. After that I'll clean up my buildsystem patch=
es,
>>>>> send them here for review and then update the Windows building Wiki p=
age:
>>>>>
>>>>>=20=20=20
>>>>>=20=20=20=20=20
>>>>>=20=20=20=20=20=20=20
>>>>>=20=20=20=20=20=20=20=20=20
>>>>>=20=20=20=20=20=20=20=20=20=20=20
>>>> just tried it on a 32bit Windows XP SP3 machine. Installation went OK,=
=20
>>>> the README works but the format of the README file itself does not=20
>>>> display properly in Notepad (CR/LF problem?).
>>>>=20=20=20
>>>> The bad news is that the binaries don't work. All binaries refuse to=20
>>>> start (openvpn.exe, openssl.exe, openvpn-gui.exe). The command-line=20
>>>> tools fail with 'Cannot execute the specified program'. The OpenVPN GU=
I=20
>>>> fails with an error 0xC0150002.
>>>>=20=20=20
>>>>=20=20=20=20=20
>>>>=20=20=20=20=20=20=20
>>>>=20=20=20=20=20=20=20=20=20
>>> Interesting, given that OpenVPN was built on WinXP. This may have
>>> something to do with the (external) manifest files or DLL versions. I'll
>>> setup another WinXP VM to test the installer, fix these issues and then
>>> upload a second preview.
>>>=20=20=20
>>>=20=20=20=20=20
>>>=20=20=20=20=20=20=20
>> did some testing: turns out that the new executables depend on the=20
>> Visual Studio 2008 runtime (msvcr90.dll). The manifest files point to=20
>> these MSVCR files but I did not install them in my VM (nor do I think I=
=20
>> should have to install them).
>> After installing the Visual Studio 2008 RT the openvpn.exe command at=20
>> least *runs* .
>> If I remove the manifest files it no longer works - personally I think=20
>> this is kinda ugly ...
>>
>> cheers,
>>
>> JJK
>>=20=20=20
>>=20=20=20=20=20
> Hi Jan,
>
> Ok, this makes sense. The openvpn.exe runs fine on the build computer,
> which is running Windows XP and has Visual Studio 2008 installed.
> However, the installer does/should contain a redistributable version of
> msvcrt90.dll along with an external manifest file pointing to it.
> Windows should find this  msvcrt90.dll if it's placed in the executable
> directory ($OPENVPN_INSTALL_DIR\bin). Now, I'm not sure if VS tools
> automatically generate an internal (embedded) manifest for each EXE/DLL
> or not. If they do, then manifest/DLL version mismatch is one
> possibility, depending on whether internal or external manifest file
> takes precedence.
>
> I will create a WinXP VM tomorrow and see what's going on.
>
>=20=20=20
Hi,

The issue was that the installer did not install msvcr90.dll - that's
now fixed. The installer, openvpn.exe, openvpnserv.exe and openssl.exe
worked fine on my WinXP 32-bit test VM. The updated installer is here:

<http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-preview=
-2.exe>

I'll do some more testing tomorrow.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


