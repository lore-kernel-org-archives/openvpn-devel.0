Message-ID: <5322C73E.3070602@...515...>
Date: Fri, 14 Mar 2014 11:09:18 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Tap-windows NDIS 6 driver now on GitHub
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

Hi all,

The NDIS 6 version of the tap-windows driver is now available in source
code form:

<https://github.com/OpenVPN/tap-windows6>

The license is the same as that of the old driver (GPLv2). I will
integrate this new driver with experimental OpenVPN 2.3.2 installers
soon. The plan is to maintain both NDIS 5 and NDIS 6 drivers for a
while, because Windows XP lacks NDIS 6 support.

From what I've gathered NDIS 5 support will be removed in Windows 8.2.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


