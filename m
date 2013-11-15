Message-ID: <5286670F.9080404@...68...>
Date: Fri, 15 Nov 2013 19:25:19 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1384535524-6366-1-git-send-email-dazo@...384...>
In-Reply-To: <1384535524-6366-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Jev41hktFmkTb4do3d5d5f6S3ECwuvx98"
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: Check for fping/fping6
	availability
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jev41hktFmkTb4do3d5d5f6S3ECwuvx98
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 15.11.2013 18:12, schrieb David Sommerseth:
> From: David Sommerseth <davids@...1347...>
>=20
> Check if fping and fping6 is available before running the real tests,
> to avoid misleading test failures.
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  tests/t_client.sh.in | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
> index 189eecc..69278ee 100755
> --- a/tests/t_client.sh.in
> +++ b/tests/t_client.sh.in
> @@ -24,6 +24,18 @@ else
>      exit 77
>  fi
>=20=20
> +# Check for external dependencies
> +which fping > /dev/null
...

NAK.
which is not a POSIX command,
so you may introduce false skips here.



--Jev41hktFmkTb4do3d5d5f6S3ECwuvx98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKGZw8ACgkQvmGDOQUufZUwggCg8jHdpq1EcxGF61pyUd0gBdVS
HiUAoO7GxoRlStcrwga0UX5LEENiGfmO
=NGHz
-----END PGP SIGNATURE-----

--Jev41hktFmkTb4do3d5d5f6S3ECwuvx98--

