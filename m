Message-ID: <53907F22.2060005@...1114...>
Date: Thu, 05 Jun 2014 16:30:58 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <53907082.70804@...1800...>
In-Reply-To: <53907082.70804@...1800...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9q6huFSS7MfQIjx30kPugLtFrUd8DbpoA"
Subject: Re: [Openvpn-devel] latest OpenSSL security advisories
Reply-To: openvpn-devel@lists.sourceforge.net
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
--9q6huFSS7MfQIjx30kPugLtFrUd8DbpoA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 05/06/14 15:28, Mike Tancsa wrote:
> A few more vulnerabilities it would seem. Can anyone shed light on how=20
> this impacts OpenVPN ?
>=20
> http://www.openssl.org/news/secadv_20140605.txt
>=20
> Does OpenVPN make use of DTLS ? or SSL_MODE_RELEASE_BUFFERS  ?

I don't remember the details around SSL_MODE_RELEASE_BUFFERS.  As I
understand, it needs to be explicitly enabled.  At a very quick glance
(git grep), I don't see that being used at all.

But OpenVPN does not make use of DTLS.  DTLS came 4-5 years (roughly)
after the first OpenVPN release.  There are currently no immediate plans
to move over to DTLS

So, as most of these OpenSSL issues:  OpenVPN itself is secure, as long
as OpenSSL is safe.  And in most cases, enabling --tls-auth is an
additional security barrier which can often make attacks on OpenVPN
tunnels more difficult.


--=20
kind regards,

David Sommerseth


--9q6huFSS7MfQIjx30kPugLtFrUd8DbpoA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQfyQACgkQDC186MBRfrrl7wCcC93rch7Shsq0BRBQgScNLUW1
Mt0AoI1/0zRoymjstaZ1/kDKoGJii6aL
=nY+k
-----END PGP SIGNATURE-----

--9q6huFSS7MfQIjx30kPugLtFrUd8DbpoA--

