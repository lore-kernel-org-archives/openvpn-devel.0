Message-ID: <504F7E10.6010201@...1114...>
Date: Tue, 11 Sep 2012 20:08:16 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1347364615-26878-1-git-send-email-gert@...1296...>
In-Reply-To: <1347364615-26878-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF61885E091B76204B08EB0B4"
Subject: Re: [Openvpn-devel] [PATCH] make "ipv6 ifconfig" on linux
 compatible with busybox ifconfig
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
--------------enigF61885E091B76204B08EB0B4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/09/12 13:56, Gert Doering wrote:
> We used to call "ifconfig tun0 inet6 add...".  The "inet6" part is option=
al,
> and not understood by busybox.  So now we call "ifconfig tun0 add ...",
> which works on all supported Linux variants.
>=20
> Tested on Gentoo, RHEL5+, Debian Lenny & up.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

ACK.  Applied to master.

commit cae102ae0c2ff934c456cd584cbf87a33cd95206
Author: Gert Doering <gert@...1296...>
Date:   Tue Sep 11 13:56:55 2012 +0200

    make "ipv6 ifconfig" on linux compatible with busybox ifconfig
=20=20=20=20=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1347364615-26878-1-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7052
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigF61885E091B76204B08EB0B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBPfhAACgkQDC186MBRfrq4IACfVkr+YFiFtEbaVyFj7D1b/vok
XYQAnRLuVl8s+hyW2OIHJOU/tcTD70qq
=W69E
-----END PGP SIGNATURE-----

--------------enigF61885E091B76204B08EB0B4--

