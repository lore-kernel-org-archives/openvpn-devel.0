Date: Wed, 17 May 2017 21:14:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170517191418.GF97029@...1296...>
References: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIlomvtVtXAVxSKT"
Content-Disposition: inline
In-Reply-To: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN rpm packaging - iproute2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam ??tevko <adam.stevko@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--oIlomvtVtXAVxSKT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 17, 2017 at 10:53:58AM +0200, Adam ??tevko wrote:
> this patch adds support to build openvpn rpms with iproute2 support. It's=
 a rather simple change, which defaults to off. Please review.

Is there a particular reason not to *always* build with iproute2 support?

David, what can a program expect to find on RPM based distributions?

(Is this .spec file what Fedora builds use?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oIlomvtVtXAVxSKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZHKEJAAoJEB2Cnv7KVigSvOYL/j6JwLuP9U+RRmiB+WNbsebS
qnpCm0+aHQtjpZxbFiq5nJNc/oMgT8TAjAU1hmA6sMv3relBSD+v3Wy+3cKEfV3M
iFjGCPxxlzcpi17d3NNFJHph86OOPvK1kDqXZUZdvqER+1Aok/4UagZWggK5gQGN
hZ5tYF2oECIGU4yBRaoc67+lQtti4URNKBz2pXOCJtFPvA2Uy2xJn1nwu3ao9O7O
/QyWbFTAVyq4VttqdNlo3JMY7/CH33rwbqrZzTVrJ1KAt4W3l5pYeDbI8ITTQsah
iwXGMcbl41hqaj7iMjsEhYnOQd8D720K+dJadFYK9iAB+RScK1fDJ/hBaBij1XmH
/BvlOaIPn4NGvSZW11EiwET1VsNSi2uAfLIk4/ACvazwUxNwb1Q9tp44xoGozPdy
1cpQiVVUYbZi3FHLTEGAYRZPRtdkSVXTlN0o5GiOWVDHB0f1M0x2DK17CscFJLaE
hxQ5Qr05FY76tfG7VXh+sqIxA4ckg1xXBG5/ZsNZKw==
=L1kb
-----END PGP SIGNATURE-----

--oIlomvtVtXAVxSKT--

