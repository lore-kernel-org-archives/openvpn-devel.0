Message-ID: <50B7D0C6.60503@...1114...>
Date: Thu, 29 Nov 2012 22:16:54 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1353063726-25113-1-git-send-email-dazo@...384...>
In-Reply-To: <1353063726-25113-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57353116F03C7EC3B03D030B"
Subject: Re: [Openvpn-devel] [PATCH] Avoid recursion in
	virtual_output_callback_func()
Reply-To: openvpn-devel@lists.sourceforge.net
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
--------------enig57353116F03C7EC3B03D030B
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/11/12 12:02, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This solves a SEGV situation when using the management API while OpenVPN
> is closing down.
>=20
> The situation happens when the management socket has closed and OpenVPN
> tries to write an error about this to the management socket.  What happens
> is that
>=20
>  virtual_output_callback_func() is called, which then calls
>  -> man_output_list_push_finalize()
>     -> man_output_standalone()
>        -> man_write()  <-- this does the socket write
>           -> man_io_error()
>              -> x_msg()
>                 -> virtual_output_print()
>                    -> virtual_output_callback_func() (recursion start)
>=20
> virtual_output_callback_func() do have a mechanism to avoid recursion,
> but that did not keep the recurse counter when man_output_list_push_final=
ize()
> is called.
>=20
> This patch just reorganise the recursion block to also keep the counter w=
hile
> calling the other functions from virtual_output_callback_func()
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/openvpn/manage.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied to master and beta/2.3 branches

commit b2b66179f6dcc37de9582d5c3044f0357dda3df3 (master)
commit 5541ea21691b5b39adc4bd3e1ff1af86a050c71d (beta/2.3)
Author: David Sommerseth <davids@...1347...>
Date:   Fri Nov 16 12:02:06 2012 +0100

    Avoid recursion in virtual_output_callback_func()
=20=20=20=20
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1353063726-25113-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7130


--=20
kind regards,

David Sommerseth


--------------enig57353116F03C7EC3B03D030B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlC30MYACgkQDC186MBRfrpmOgCfdh75fQGhoA/07Yku8mLUfaWT
ub8AoJJsAi9zU/lSe5durSEDpjW5/mbc
=2Xnu
-----END PGP SIGNATURE-----

--------------enig57353116F03C7EC3B03D030B--

