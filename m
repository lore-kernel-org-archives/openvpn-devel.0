Date: Mon, 31 Aug 2015 14:54:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150831125451.GY34798@...1296...>
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
	<CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
	<55E439ED.1020706@...1227...>
	<CABgPX1nGoy2L9n_v=Y6YM362rg2s_gvvwx=WacxZSDJ5yYWEFg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2bJ57vwr75KGnr5s"
Content-Disposition: inline
In-Reply-To: <CABgPX1nGoy2L9n_v=Y6YM362rg2s_gvvwx=WacxZSDJ5yYWEFg@...278...>
Subject: Re: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Valentin Sawadski <valentin@...2062...>
Cc: openvpn-devel@lists.sourceforge.net

--2bJ57vwr75KGnr5s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 31, 2015 at 01:33:06PM +0200, Valentin Sawadski wrote:
> Assuming I want to remove the TLS handshake as well, would patching
> options.c enough or where else should I start looking?

"write a new vpn software"

TLS is integral to point-to-multipoint OpenVPN

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2bJ57vwr75KGnr5s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeROmqkuBuNlUUl1AQK7mgQAxKUqPjrXFVz88enjRFuDQdDI8/amfsQg
e2YuXtagLGt1CJ72ZPIchpGP7CdrAu4u34ioUqqQxiN4Jn6HdkLRSvTEc2o1oqAp
+mzwV5gcUpvZAymrDKMYIHOqc/5n9ZhulguFOeySr1SV1tka76D+MgPJqqkA+Wzp
XSzM+gTZL/Q=
=rzJ3
-----END PGP SIGNATURE-----

--2bJ57vwr75KGnr5s--

