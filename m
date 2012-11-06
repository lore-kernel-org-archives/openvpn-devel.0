Message-ID: <5098ECA9.5060600@...1114...>
Date: Tue, 06 Nov 2012 11:55:37 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1352196216-11560-1-git-send-email-dazo@...384...>
In-Reply-To: <1352196216-11560-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE41335B59C2AF0B6411643C"
Subject: Re: [Openvpn-devel] [PATCH] Fix double-free issue in
	pf_destroy_context()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: cuzz <cuzz@...1781...>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE41335B59C2AF0B6411643C
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 06/11/12 11:03, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> In commit dc7be6d078ba106f9b0de12f3e879c3561c3c537 the string_alloc() call
> in pf_init_context() was modified to use the gc_arena object for memory
> allocation.  What was not taken into consideration was that pf_destroy_co=
ntext()
> was also freeing memory allocated by string_alloc(), and when pf_init_con=
text()
> is calling gc_free() a double-free situation showed up.
>=20
> Lets remove the explict free, and let gc_free take care of all the memory=
 handling.
>=20
> Reported-by: cuzz@...1781...
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/openvpn/pf.c |    1 -
>  1 file changed, 1 deletion(-)


Applied to master and beta/2.3 branches.

commit 1f300fe94f1bd521966bb05dea40edc1fae82b84 (master)
commit 03dfcd95b29eda81aee117bf9d28c001f2521e15 (beta/2.3)
Author: David Sommerseth <davids@...1347...>
Date:   Tue Nov 6 10:59:01 2012 +0100

    Fix double-free issue in pf_destroy_context()

    Reported-by: cuzz@...1781...
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1352196216-11560-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7124


kind regards,

David Sommerseth


--------------enigEE41335B59C2AF0B6411643C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCY7KsACgkQDC186MBRfro/CACfdkuLcZAhqrF1U9RAkzSzrwqL
XcgAn0YTDcJhzszauVq8oex3vhUZbLtO
=0ElA
-----END PGP SIGNATURE-----

--------------enigEE41335B59C2AF0B6411643C--

