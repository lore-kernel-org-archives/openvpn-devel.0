Message-ID: <510E7997.8040909@...1114...>
Date: Sun, 03 Feb 2013 15:52:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <510E43DE.20008@...1147...>
In-Reply-To: <510E43DE.20008@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7C7C9F84C1D59F7EF42B5D7"
Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7C7C9F84C1D59F7EF42B5D7
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 03/02/13 12:02, Jan Just Keijser wrote:
> hi,
>=20
> what is the second option to '--crl-verify' supposed to do? in options.c=
=20
> it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the function=20
> 'verify_check_crl_dir'. However, this function does not seem to do=20
> anything....

Quickly looked at the code ... with the 'dir' flag (which sets
SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
you create (touch) a file in the defined directory with the file name
matching a particular client's serial number; the connection will be denied.

--=20
kind regards,

David Sommerseth


--------------enigF7C7C9F84C1D59F7EF42B5D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEOeZcACgkQDC186MBRfrqUcgCePaCE2emdu9cuugEu9vKyujbG
13gAoJLyTXeEZ2WkjvHMCdRe7Ma9CVXM
=l2NF
-----END PGP SIGNATURE-----

--------------enigF7C7C9F84C1D59F7EF42B5D7--

