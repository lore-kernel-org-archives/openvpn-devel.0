Message-ID: <4FD86BBA.2080802@...1114...>
Date: Wed, 13 Jun 2012 12:30:18 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120607174638.GW1059@...1296...>
In-Reply-To: <20120607174638.GW1059@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig947FC5EC77BE86F49E2B9439"
Subject: Re: [Openvpn-devel] implement dynamic search for first-free tun/tap
 on Solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig947FC5EC77BE86F49E2B9439
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/06/12 19:46, Gert Doering wrote:
> Hi,
>=20
> Solaris buildslave failed to test, because "--dev tun" did not work
> if tun0 was already in use (didn't hunt to tun1).
>=20
> Fixed, tested on OpenSolaris 10 / i386 - but the code is straightforward,=
=20
> so it should work on "standard Solaris" and "sparc" as well.  Managed to
> get it to hunt to tun2 just fine, and then ran out of possible OpenVPN
> targets :-) but if it works for tun0, tun1, tun2 there is no reason why
> it shouldn't work for tun63.=20
>=20
> The moving around of the open() calls is purely cosmetic - I wanted to
> have all code that relates to tun device unit number in one block, not
> "first parse device name, then open unrelated stuff, then try to use
> that just-parsed device and the resulting 'ptr' variable".

ACK.  Applied to master branch.

commit 21ae2ec2b963e33e1b48b6cf9069e774b3f656b1
Author: Gert Doering <gert@...1296...>
Date:   Thu Jun 7 17:38:17 2012 +0200

    Implement search for "first free" tun/tap device on Solaris
=20=20=20=20
    Without this patch, Solaris will do "--dev tun3" just fine, but "--dev =
tun"
    will either use "tun0" if that is available, or fail.  With the patch, =
the
    first available device is searched if "--dev tun" or "--dev tap" (witho=
ut
    a number) is specified.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 20120607174638.GW1059@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6705
    Signed-off-by: David Sommerseth <davids@...1347...>

 src/openvpn/tun.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)


kind regards,

David Sommerseth


--------------enig947FC5EC77BE86F49E2B9439
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Ya7oACgkQDC186MBRfro0egCgpWdjwlJtE/PPWay68VTgqGTs
QMcAn3k3hsU4QplG1YXGTGUGHhf9Ae4S
=Bndg
-----END PGP SIGNATURE-----

--------------enig947FC5EC77BE86F49E2B9439--

