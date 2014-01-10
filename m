Message-ID: <52D07237.6090004@...1114...>
Date: Fri, 10 Jan 2014 23:20:39 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1389389401-29158-1-git-send-email-gert@...1296...>
In-Reply-To: <1389389401-29158-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AgAnETA4RIiKpTMnxhqcJrwhDqbTBbnlr"
Subject: Re: [Openvpn-devel] [PATCH] Document issue with --chroot,
 /dev/urandom and PolarSSL.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AgAnETA4RIiKpTMnxhqcJrwhDqbTBbnlr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 10/01/14 22:30, Gert Doering wrote:
> See trac#218
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8 | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 7736c63..94fd00e 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2097,6 +2097,13 @@ In many cases, the
>  parameter can point to an empty directory, however
>  complications can result when scripts or restarts
>  are executed after the chroot operation.
> +
> +Note: if OpenVPN is built using the PolarSSL SSL
> +library, it will only work if a /dev/urandom device
> +node is available inside the chroot directory.  This
> +is due to the way PolarSSL works (it wants to open
> +/dev/urandom every time randomness is needed, not just
> +once at startup) and nothing OpenVPN can influence.
>  .\"*********************************************************
>  .TP
>  .B \-\-setcon context

ACK.

Just a tiny nit-pick, "PolarSSL SSL library", isn't it better to say
"PolarSSL library"?


--=20
kind regards,

David Sommerseth


--AgAnETA4RIiKpTMnxhqcJrwhDqbTBbnlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLQcjoACgkQDC186MBRfrq8awCeOQRUBso8oJmhkcD3tqiL2j02
+nIAnRkTgZA9/K0JdGgmYPmxZYKIcKQL
=6Lkw
-----END PGP SIGNATURE-----

--AgAnETA4RIiKpTMnxhqcJrwhDqbTBbnlr--

