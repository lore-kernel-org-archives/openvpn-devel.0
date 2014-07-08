Date: Tue, 8 Jul 2014 21:56:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140708195609.GW1118@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7VYoR/Ws5oXf5rNY"
Content-Disposition: inline
Subject: [Openvpn-devel] RFD: building OpenVPN without socks and/or http
	proxy support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--7VYoR/Ws5oXf5rNY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

we have a patch on the table to remove support for compile-time disabling
of socks proxy and http proxy support in OpenVPN.

Right now you can "./configure --disable-socks --disable-http-proxy"=20
and save about 20kbyte executable size.

The downside is that the code is more complex to maintain and test, as
we have 4 extra build variants ("both, socks only, http only, none") to
test - which is adding up with all the other variants.

So: putting this on both the openvpn-devel and openvpn-users list, to
get feedback fromthe user base.=20=20

If *you* really use OpenVPN on a platform that is so small that you need=20
those extra 20kbyte executable size squeezed off, and at the same time do=20
not need the client proxy support (my assumption is "proxy support is=20
quite important for the embedded side, as it might be behind whatever
network madness happens"), please let us know until July 18 (Friday),
and explain why it really makes a difference.

Otherwise, the #ifdef maze goes - that is, socks and http proxy will
be always compiled in (of course you're free to just not use it :) ).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7VYoR/Ws5oXf5rNY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU7xM2akuBuNlUUl1AQJ1/QQAw2OG/cMg22naB1+v48ZPvKiB9BOVUWI5
zJYb+w9O/GxFC8eLSnvjX+qtGP6xnQJ4LiuOYt1Z+99r9QyIeGI8pLnDcxDt9UNV
XHGB9d+iN52rWuksVbj0MbTSXkkfS1W6AVc+ElgHrbWspTR/PLjiXAvh36cPNZm9
LM2rjeSN6h8=
=4rkj
-----END PGP SIGNATURE-----

--7VYoR/Ws5oXf5rNY--

