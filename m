Message-ID: <511E0706.9020203@...515...>
Date: Fri, 15 Feb 2013 11:59:34 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.3.0 Windows build I004 released
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

OpenVPN 2.3.0 Windows installer version I004 has been released. It
includes a number of fixes compared to the previous one (I001):

- Uses OpenSSL 1.0.1e that includes a proper fix for CVE-2013-0169[1]
- Fixes broken silent installations[2]
- Installs TAP utilities by default[3]
- Fixes broken man-page link in the Start menu
- Adds and updates other Start menu documentation links

You can download the new installer from here:

<http://openvpn.net/index.php/download/community-downloads.html>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <http://web.nvd.nist.gov/view/vuln/detail?vulnId=3DCVE-2013-0169>
[2] <https://community.openvpn.net/openvpn/ticket/249>
[3] <https://community.openvpn.net/openvpn/ticket/255>

