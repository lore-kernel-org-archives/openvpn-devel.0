Message-ID: <4FD856F0.60409@...1114...>
Date: Wed, 13 Jun 2012 11:01:36 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1328446029-30523-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1328446029-30523-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1ADD5A4AA479A4B7E5E6F6D5"
Subject: Re: [Openvpn-devel] [PATCH] remove the --auto-proxy option from
	openvpn
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
--------------enig1ADD5A4AA479A4B7E5E6F6D5
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 05/02/12 13:47, Heiko Hund wrote:
> During discussion on FOSDEM 2012 it was decided that proxy auto detection
> is best done in the GUI as it's highly platform specific and shouldn't be
> handled in openvpn itself for every supported platform in openvpn itself.
>=20
> This removes --auto-proxy from openvpn.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  init.c    |   10 +--
>  openvpn.8 |   12 ---
>  options.c |   40 +----------
>  options.h |    4 -
>  proxy.c   |  242 +------------------------------------------------------=
------
>  proxy.h   |   27 +-------
>  socks.c   |   15 +----
>  socks.h   |    3 +-
>  8 files changed, 11 insertions(+), 342 deletions(-)

This one has been lingering around for quite some months without any
comments.  And since no one have NACKed this, I decided to pull it in
after Gert and Heiko pinging me about it again.

As the patch is even straightforward, I even dared to give it an
explicit ACK too.

commit 8e1975b046dcf821eaf03098677dc5e34cd3a1a5
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Sun Feb 5 13:47:09 2012 +0100

    remove the --auto-proxy option from openvpn

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1328446029-30523-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/5333
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig1ADD5A4AA479A4B7E5E6F6D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/YVvIACgkQDC186MBRfrqtywCeIJ2QruwVmHBwc6TiBYUh8zCc
BekAn1FAJO2iLypVK6xXAStcEtasEQTc
=J/5r
-----END PGP SIGNATURE-----

--------------enig1ADD5A4AA479A4B7E5E6F6D5--

