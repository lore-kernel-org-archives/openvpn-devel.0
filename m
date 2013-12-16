Date: Mon, 16 Dec 2013 08:30:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131216073024.GC161@...1296...>
References: <52ADF633.8040003@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BgQJZ2C4CvD3QqKI"
Content-Disposition: inline
In-Reply-To: <52ADF633.8040003@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
	deprecated, RSA_generate_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--BgQJZ2C4CvD3QqKI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 15, 2013 at 07:34:27PM +0100, Steffan Karger wrote:
> One note on the implementation though; the code generates one ephemeral
> RSA key that is used during the entire lifetime of an OpenVPN process.
> If OpenSSL requests a new (ephemeral) key, it will keep on returning the
> same (usually rather small) key. Not the best solution.
>=20
> To actually run this code, I had to force usage by selecting the
> TLS-RSA-EXPORT-WITH-DES40-CBC-SHA tls-cipher. That generated a 512-bit
> ephemeral RSA key, and uses the outdated DES encryption protocol.

I'm not sure I understand the whole picture here.  What is happening in
the "normal" scenario, and why is this particular cipher calling a=20
different code path inside OpenVPN?

> Using this mode could lead to a false sense of security. Then again, one
> should be using (Ephemeral) Diffie-Hellman anyway, and OpenVPN requires
> a tls-server to supply dh parameters. A user would need to deliberately
> choose a weak tls-cipher like TLS-RSA-EXPORT-WITH-DES40-CBC-SHA, which
> would be aligning a gun with his foot anyway. If one would decide this
> implementation is not good enough anymore, I'd suggest to just strip out
> support for this completely.

I'm tempted to agree with this :) - single-DES (and 40 bit to that!)=20
really isn't what we want to use.

So what would happen if we remove this code, and a user tries to use this
tls-cipher?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BgQJZ2C4CvD3QqKI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUq6sD6kuBuNlUUl1AQKpUQP+MmAMwyexbm+lv+llmUjQdE5X3HKpo04K
mwJPux8ceJrwNgWxyL3q+/sf2xTWr/ehiuJnJyYAVEEIobemUV6qim6cS9zWxW2R
D23O0w9Y5v7s0J5KLCRa2/hUPSbJLQ8ujBGjRlIFsdpI3oOQzgMaoIzTKbI7sN6e
7ncFUsiqjW0=
=RDnl
-----END PGP SIGNATURE-----

--BgQJZ2C4CvD3QqKI--

