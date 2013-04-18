Date: Thu, 18 Apr 2013 22:44:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130418204455.GW29506@...1296...>
References: <5170496A.6000000@...1737...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <5170496A.6000000@...1737...>
Subject: Re: [Openvpn-devel] Support for libsodium?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ed W <lists@...1737...>
Cc: openvpn-devel@lists.sourceforge.net

--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 18, 2013 at 08:28:42PM +0100, Ed W wrote:
> Hi, given the new abstractions to support PolarSSL, what=20
> interest/resistance would there be to supporting libsodium?
>      https://github.com/jedisct1/libsodium

It took us quite some effort to reach the point where a polarssl-compiled
openvpn would be able to talk to a (default-configured) openssl-openvpn,
and I don't really see us using a crypto library that has none of the
algorithms that we need for interoperability.

But then, I'm not the crypto geek here, I'm just the janitor...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUXBbR6kuBuNlUUl1AQIkTAP/e/lTZoLXdpxRzlTl745Ep+gFTzXAuC5b
T6d1WWRezsE9KvP/CpWL1V189ppnTO6Rg4DkK9m06NQdtCu2Pp85RiwFz9+QiqrE
Um1pWscbUKLTH1bSsfanShDY+DBi/BcUFyC5fmdmcF2ReOEra17TJo1D8IdctYPP
xnx60gkaCnc=
=0EV6
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--

