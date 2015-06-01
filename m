Message-ID: <556CADD2.90108@...1114...>
Date: Mon, 01 Jun 2015 21:09:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1433185487-9724-1-git-send-email-gert@...1296...>
In-Reply-To: <1433185487-9724-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wv5gorc8LmdjRlWFunQtgieqgjAK73k3H"
Subject: Re: [Openvpn-devel] [PATCH] Use configure.ac hack to apply
 serial_test AM option only if supported.
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
--wv5gorc8LmdjRlWFunQtgieqgjAK73k3H
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/06/15 21:04, Gert Doering wrote:
> Inspired by libguestfs' configure.ac hack - test automake version,
> and if 1.12 or newer, use m4 magic to pass "serial_tests" option
> to AM_INIT_AUTOMAKE().
>=20
> https://www.redhat.com/archives/libguestfs/2013-February/msg00102.html
>=20
> Trac #427
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  configure.ac | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20

ACK.

I've tested on:

  - CentOS 5 with automake 1.9.6
  - RHEL 7 with automake 1.13.4
  - Fedora 22 Beta with automake 1.15

Tested autoreconf, ./configure, make and make check successfully.


--=20
kind regards,

David Sommerseth


--wv5gorc8LmdjRlWFunQtgieqgjAK73k3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVsrdIACgkQDC186MBRfrp6HQCdEWtkbWZvYXCr75EBeZyA2n8T
0vIAoJSJB7vCGB8IWNTKhENl2L5EvvYH
=rdW7
-----END PGP SIGNATURE-----

--wv5gorc8LmdjRlWFunQtgieqgjAK73k3H--

