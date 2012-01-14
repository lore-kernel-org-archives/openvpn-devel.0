Date: Sat, 14 Jan 2012 22:46:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120114214625.GQ5060@...1296...>
References: <CAMaBZnHTP5SbPhf5sCGeE2E-zQOGFYhXFQRSh2t1mnNvZ0c3Wg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XLWMkxR+mZNQ4WTO"
Content-Disposition: inline
In-Reply-To: <CAMaBZnHTP5SbPhf5sCGeE2E-zQOGFYhXFQRSh2t1mnNvZ0c3Wg@...278...>
Subject: Re: [Openvpn-devel] Setup a test openvpn network with ipv6 payload
	between all sites.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Praetorian <praetoriancode@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XLWMkxR+mZNQ4WTO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 14, 2012 at 04:36:13PM -0500, Praetorian wrote:
> #6 In linux client config file should be dev tun-ipv6 and not just tun-ip=
v6

The command "tun-ipv6" is not there to set the device, but to enable IPv6
on tunnels :-) - and normally you don't need that command in the client
config at all, as the server will push it (if server-ipv6 is configured).

"dev tun-ipv6" tells it to use a tunnel device named "tun-ipv6", which
is something else.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XLWMkxR+mZNQ4WTO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTxH3sakuBuNlUUl1AQKXAQQAgJwN/5PIEqTpN/Ih2sbKMG0rJ8/egLGL
7PkBtmm0kzrm24m+olD57CZHzWn65sT44rwR3muz1cyAAE86Eqmih9xWSabEYuBO
ePX7pt7511Zh3l2Kmm9/OqxdT09HcgF6DZow1Zn0A4iUFnj3CBuCe5+GUGlQ8ObR
LEQBOm9xAcI=
=6eys
-----END PGP SIGNATURE-----

--XLWMkxR+mZNQ4WTO--

