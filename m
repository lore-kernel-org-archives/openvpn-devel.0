Message-ID: <4DA85273.9020503@...515...>
Date: Fri, 15 Apr 2011 17:13:07 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4DA805FA.6070908@...515...>
In-Reply-To: <4DA805FA.6070908@...515...>
Subject: Re: [Openvpn-devel] First test build of OpenVPN 2.2 for Windows is
	now available
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Here's the next version of the installer:

<http://build.openvpn.net/openvpn-2.2-preview-2-install.exe>

This version fixes this issue:

<https://community.openvpn.net/openvpn/ticket/120>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hi everyone,
>
> The first test build of OpenVPN 2.2 for Windows is available here:
>
> <http://build.openvpn.net/openvpn-2.2-preview-1-install.exe>
>
> Any help in testing it prior to the final release - hopefully 22nd April
> - is much appreciated! Changes to 2.2-RC2 include:
>
> ---
>
> 2011.04.xx -- Version 2.2
> David Sommerseth (2):
>       Fix the --client-cert-not-required feature
>       Change the default --tmp-dir path to a more suitable path
>
> Gert Doering (1):
>       Add more detailed explanation regarding the function of "--rdns-int=
ernal"
>
> Gisle Vanem (1):
>       Avoid re-defining uint32_t when using mingw compiler
>
> James Yonan (1):
>       Fixed bug in port-share that could cause port share process to crash
>
> Samuli Sepp=E4nen (5):
>       Add man page entry for --redirect-private
>       Change all CRLF linefeeds to LF linefeeds
>       Fix a bug in devcon source code handling
>       Removed Win2k from supported platforms list in INSTALL and win/open=
vpn.nsi
>       Fixed copying of tapinstall.exe to dist/bin when using prebuilt TAP=
-drivers
>
> chantra (1):
>       Clarify --tmp-dir option
>
> rf (2):
>       Update man page with info about --remote-random-hostname
>       Added man page entry for --management-client
>
> ---
>
> The final 2.2 installer may include a few minor additional changes.
>
>=20=20=20


