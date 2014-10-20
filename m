Message-ID: <5444CE65.5000901@...515...>
Date: Mon, 20 Oct 2014 11:57:09 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Regarding OpenVPN 2.3.5 release and
	tap-windows6-related fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

People have encountered a few rather serious issues with OpenVPN 2.3.x
for Windows. These issues only materialize when one is using OpenVPN
2.3.x with tap-windows6:

<https://community.openvpn.net/openvpn/ticket/430>
<https://community.openvpn.net/openvpn/ticket/432>

The underlying issue is that OpenVPN 2.3.x does not handle return code
995 from tap-windows6 at all. According to the driver author most s.c.
tap-windows6 issues stem from this single omission in OpenVPN 2.3.x itself.

There are now tentative fixes for the 995 issue here:

<https://github.com/TDivine/openvpn/commit/c391f10e79d88d01405eedbc6822bc92=
cf8a210d>
<https://github.com/TDivine/openvpn/commit/44b56c14c66201074805a4c5b97da2cf=
b1e1f248>

However, those fixes are for the Git "master" branch, which cannot
currently be built using "openvpn-build" (i.e. for Windows). A few weeks
ago I backported the above patches to OpenVPN 2.3.4 and released test
installers[1] which apparently fixed the primary issue[2]. Do we / can
we merge the patches to "master" without testing based on the fact that
they worked for OpenVPN 2.3.4?

We'd also need to backport these fixes to 2.3 and make a new release.
Looks like there's quite a lot of stuff in the pipe for 2.3.5, so it
probably makes sense to release all of it along with these
tap-windows6-related fixes in one go. Anything blocking 2.3.5 release atm?

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1]
<http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.4-I603-=
i686.exe>
<http://swupdate.openvpn.org/community/releases/openvpn-install-2.3.4-I603-=
x86_64.exe>
[2] <https://community.openvpn.net/openvpn/ticket/430#comment:11>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlREzmUACgkQwp2X7RmNIqNguACeLDF/720Obl6IrNNs0OWYU88N
6GoAn3PQSgxKX+M2UxY6WJKujLXtOTOI
=3DXb+t
-----END PGP SIGNATURE-----



