Message-ID: <500866AE.1060603@...1114...>
Date: Thu, 19 Jul 2012 21:57:34 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7B25456904D1BFA6B552854"
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] make non-blocking connect work on
 Windows
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
--------------enigF7B25456904D1BFA6B552854
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/07/12 18:19, Heiko Hund wrote:
> Instead of EINPROGRESS WinSock2 returns WSAEWOULDBLOCK if a non-blocking
> connect(2) cannot be completed immediately.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/socket.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20

Applied to master.


commit 9081e0ad4c496a0334a21fc4e8e4f1f73a470b5a
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Tue Jul 17 18:19:53 2012 +0200

    make non-blocking connect work on Windows
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1342541993-32462-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6875
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigF7B25456904D1BFA6B552854
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAlAIZq4ACgkQDC186MBRfrpUUQCgpMEqdlrUTRE4FGVEqcKTqyW2
9bQAl1qUNKiyT29lS/ljerz5ES8igmI=
=ojzD
-----END PGP SIGNATURE-----

--------------enigF7B25456904D1BFA6B552854--

