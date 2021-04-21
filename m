From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <ca34aa38-a88a-13ff-a66e-c30e6e61d871@...515...>
Date: Wed, 21 Apr 2021 13:00:23 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] OpenVPN 2.4.11 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.4.11.=20
It fixes two related security vulnerabilities (CVE-2020-15078) which=20
under very specific circumstances allow tricking a server using delayed=20
authentication (plugin or management) into returning a PUSH_REPLY before=20
the AUTH_FAILED message, which can possibly be used to gather=20
information about a VPN setup. This release also includes other bug=20
fixes and improvements. Updated OpenSSL and OpenVPN GUI are included in=20
Windows installers.

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community-downloads/>

Debian and Ubuntu packages are available in the official apt repositories:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

