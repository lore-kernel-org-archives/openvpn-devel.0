Message-ID: <50F15D0E.3090607@...68...>
Date: Sat, 12 Jan 2013 13:54:38 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <20130108093912.7ae7c6f8@...1799...>
In-Reply-To: <20130108093912.7ae7c6f8@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig02BB87FE8AEF2B7F631E6523"
Subject: Re: [Openvpn-devel] fix build with automake 1.13(.1)
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
--------------enig02BB87FE8AEF2B7F631E6523
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 08.01.2013 09:39, schrieb Christian Hesse:

> AM_CONFIG_HEADER has been deprecated for some time, finally it is removed=
 on
> automake 1.13. The attached patch replaces it with AC_CONFIG_HEADERS and
> fixes build process with latest automake. Please apply.

ACK.




--------------enig02BB87FE8AEF2B7F631E6523
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDxXQ4ACgkQvmGDOQUufZVc3QCgtbJgaKKQMbNwzTOhNVF9cEm5
05YAn3HDLqnzxOqg4SDDNM1PUhtZzx9e
=MJbx
-----END PGP SIGNATURE-----

--------------enig02BB87FE8AEF2B7F631E6523--

