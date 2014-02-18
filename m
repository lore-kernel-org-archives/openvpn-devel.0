Date: Tue, 18 Feb 2014 09:55:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140218085500.GU16637@...1296...>
References: <5302AADC.80801@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lKkRBIzN5W0l28vM"
Content-Disposition: inline
In-Reply-To: <5302AADC.80801@...277...>
Subject: Re: [Openvpn-devel] ECDH support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: pietrek -- <pietrek.j@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--lKkRBIzN5W0l28vM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

On Tue, Feb 18, 2014 at 01:35:40AM +0100, pietrek -- wrote:
> It's my first contribution, so I could make some mistakes ;)
> In attached patch I added ECDH support to openvpn with openssl.
> Eliptic Curves generation is, in contrast to Diffie-Hellman very fast,=20
> so I do it on every server initialization.

Could you describe in a bit more detail what your patch does?  I don't
really understand the openssl innards well enough, but am curious.

*If* I understand it correctly, what it does is provide keying material
(ECDH) to support EC for the TLS handshake, right?  And there isn't actually
anything in OpenVPN needed (besides provide keying material) as that's
all "inside OpenSSL".

So how do you create the key material?=20=20

Which parts of the key handshake does it cover?  Signature/Certificates,
or *only* DH?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lKkRBIzN5W0l28vM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUwMf5KkuBuNlUUl1AQLU2QP+MvXtikwl/0yyBJhe3xAiRA4BfGIlyAP3
uPtYH7Cj7HdVXoWm2r4YgeoWdT5+RS+2QAWMSCs/lWoPdSlvaQ1E21StsDJ1GAkw
HkHsAUGX5PL3teby+cuV9kwo1Ijvrn1kGTINF4A7UkB6ZIO89U5LFXrE5qfbDfvd
uYXYWGd/nD8=
=54vQ
-----END PGP SIGNATURE-----

--lKkRBIzN5W0l28vM--

