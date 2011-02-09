Message-ID: <4D528F70.5080509@...515...>
Date: Wed, 09 Feb 2011 14:58:24 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4D4BE51E.1050905@...515...>
	<4D4C7466.4030301@...1147...>	<4D4FAEB0.3040508@...515...>
	<4D4FDDF2.6000002@...1147...>	<4D505025.2010007@...515...>
	<4D514C06.5010907@...515...> <499331088.20110208193456@...449...>
In-Reply-To: <499331088.20110208193456@...449...>
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.2-rc Windows installer?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Carsten,
> Hello,
>
>=20=20=20
>> The issue was that the installer did not install msvcr90.dll - that's
>> now fixed.
>>=20=20=20=20=20
>
> I haven't checked how the installer does it, but there is a standard
> procedure to do this!
> http://support.microsoft.com/kb/326922/en-us
>=20=20=20
The installer installs the msvcr90.dll into the application program
directory ($OPENVPN_HOME\bin), so it's following this standard
procedure. I did try the "vcredist_<arch>.exe" install route, but that
failed for some reason. I'm sure it could be made to work.
> Why it should be done correctly: http://en.wikipedia.org/wiki/DLL_hell
>
> Additionally good windows software is designed to meet criteria of
> windows logo program, even if you don't want to certify it.
>
> The Windows 7 Software Logo Program
> http://msdn.microsoft.com/en-us/windows/dd203105.aspx
>=20=20=20
The TAP driver is already signed and installs on 64-bit Windows, but I'm
not sure if it has passed the WHQL tests[1]. I would assume no, but I'll
verify that from James.

[1] http://en.wikipedia.org/wiki/Windows_Logo_Program

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



