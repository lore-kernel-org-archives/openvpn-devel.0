From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f66c1367-1b63-fe29-1522-3ecd59eb53b8@...515...>
Date: Thu, 30 Jun 2016 18:04:28 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Windows service changes
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I integrated openvpnserv2 to the NSI installer today. A test installer=20
is available here:

<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_git-I903-=
x86_64.exe>

This installer bundles two service binaries, openvpnserv.exe and=20
openvpnserv2.exe. These binaries register three different system services:

1) OpenVPNService ("OpenVPN Service")

This service comes from openvpnserv2.exe. Its "startupmode" is set to=20
"manual", so that VPN connections do not suddenly start launching behind=20
the user's back.

Previously "OpenVPNService" name was registered by the "automatic" part=20
of openvpnserv.exe. The old name was retained here to make upgrades as=20
smooth as possible, and to encourage people to actually use the new (and=20
better) service.

2) OpenVPNServiceInteractive ("OpenVPN Interactive Service")

This service is registered by openvpnserv.exe. This part is still very=20
useful, as it allows OpenVPN GUI to be used without admin privileges.

Right now this service has "startupmode" hardcoded to "automatic" in=20
src/openvpnserv/interactive.c.

3) OpenVPNServiceLegacy ("OpenVPN Legacy Service")

For the time being the old OpenVPN service wrapper will be available as=20
a fallback. Based on issues people have been having with it it will not=20
be sorely missed. The "startupmode" for this is set to "manual".

---

The installer linked to above implement all of the above. However, these=20
three changes are required for things to work properly:

<https://github.com/OpenVPN/openvpn-build/pull/23>
<https://github.com/xkjyeah/openvpnserv2/pull/7>
<https://github.com/OpenVPN/openvpn/pull/57>

The only thing missing is launching the "Interactive Service" at install=20
time, and adding a checkbox "Enable Interactive Service" to the=20
installer, as agreed upon in this email thread:

<http://thread.gmane.org/gmane.network.openvpn.devel/12010/>

Let me know if you have any comments regarding these changes.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

