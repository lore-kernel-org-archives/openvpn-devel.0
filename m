References: <56B86D5C.5070506@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56BCB9ED.7050802@...515...>
Date: Thu, 11 Feb 2016 18:42:21 +0200
MIME-Version: 1.0
In-Reply-To: <56B86D5C.5070506@...515...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

I generated new installers which include the latest version of the PR:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13v2-I603=
-i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13v2-I603=
-x86_64.exe>

These installers contain a manually patched openvpn-gui which reverts=20
commit 2af86368964 ("Run with highest privilege available"), so that=20
users with administrator privileges can launch OpenVPN-GUI with=20
non-elevated privileges. I tested the latter installer on a Windows 7=20
Pro 64-bit laptop and there were two issues.

1) Interactive service not installed by default

First, OpenVPN-GUI would silently fail to create routes when launched as=20
a normal user, as if interactive service was not present. And indeed it=20
is not out of the box. The fix was fairly simple (but not obvious):

PS> C:\> openvpnserv.exe -install
PS> C:\> openvpnserv.exe -start automatic

After this the interactive service is running, but the non-interactive=20
one is not:

PS> C:\> Get-Service|Where-Object { $_.DisplayName -like "*openvpn*" }

Status   Name               DisplayName
------   ----               -----------
Stopped  OpenVPNService     OpenVPN Service
Running  OpenVPNServiceI... OpenVPN Interactive Service

When OpenVPN-GUI is now launched, it can now communicate with the=20
interactive service and the VPN works properly.

2) OpenVPN-GUI points OpenVPN config directory to a system-wide location

While OpenVPN-GUI now saves the registry keys under "HKCU" (=3Dcurrent=20
user) instead of "HKLM" (=3Dlocal-machine), the default value for OpenVPN=20
configs is still C:\Program Files\OpenVPN\config (or equivalent). At=20
least on my test system the OpenVPN configuration files under that=20
directory could not be read by a normal user, even though listing the=20
files was permitted. This caused OpenVPN-GUI to see the config file, but=20
upon loading it just hanged.

---

A few things to fix:

- Revert commit 2af86368964 in openvpn-gui
- Make OpenVPN-GUI fail/warn if it can't reach interactive service
- Enable interactive service at OpenVPN install
- Relax OpenVPN's config file permissions, or...
- ... make OpenVPN-GUI read configs from user's home dir by default

Given that OpenVPNService and OpenVPNServiceInteractive have been=20
separated, replacing the non-interactive variant with openvpnserv2=20
should not be too difficult.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> Hi,
>
> Selva has a pending pull request to openvpn-gui, which completes the
> integration of interactive service into OpenVPN installers:
>
> <https://github.com/OpenVPN/openvpn-gui/pull/13>
>
> The pull request contains several changes which need testing:
>
> <https://github.com/OpenVPN/openvpn-gui/pull/13/commits>
>
> I built test installers which include the new openvpn-gui code:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13-I601=
-i686.exe>
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3_guipr13-I601=
-x86_64.exe>
>
>
> If you test these installers please report back and tell how things
> went. I'll try to do testing on my own later today.
>
> Best regards,
>


