Message-ID: <5390767A.2030806@...1227...>
Date: Thu, 05 Jun 2014 15:54:02 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <53907082.70804@...1800...>
In-Reply-To: <53907082.70804@...1800...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nQ6e1HWHibBqGAaeaW1gPFOcaXX2ucFE6"
Subject: Re: [Openvpn-devel] latest OpenSSL security advisories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Tancsa <mike@...1800...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQ6e1HWHibBqGAaeaW1gPFOcaXX2ucFE6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 05.06.14 15:28, schrieb Mike Tancsa:
> A few more vulnerabilities it would seem. Can anyone shed light on how=20
> this impacts OpenVPN ?
>
> http://www.openssl.org/news/secadv_20140605.txt
>
> Does OpenVPN make use of DTLS ? or SSL_MODE_RELEASE_BUFFERS  ?
>
> 	---Mike
OpenVPN does not use DTLS or SSL_MODE_RELEASE_BUFFERS

Arne


--nQ6e1HWHibBqGAaeaW1gPFOcaXX2ucFE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQdoAACgkQe8+cMNS4zRddLQCfc6oTKvo9mxfEu5Ps8+qlHmtR
7LEAn0sxkIKp+8kGjxC4/PeGI0g6P8ZZ
=9cL7
-----END PGP SIGNATURE-----

--nQ6e1HWHibBqGAaeaW1gPFOcaXX2ucFE6--

