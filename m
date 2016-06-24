Date: Fri, 24 Jun 2016 19:37:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160624173713.GZ79504@...1296...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSWi0jal9INzEBQ4"
Content-Disposition: inline
In-Reply-To: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--oSWi0jal9INzEBQ4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2016 at 06:01:41PM +0200, Heiko Hund wrote:
> This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
> initialization code to init_tun, where it belongs, and removes duplicate
> code that is now no longer needed.

While I totally like this, I'm still baffled why we had the other order
before, and what might break due to the change.  I assume you've already
run quite a few --route-method variations in testing?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oSWi0jal9INzEBQ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV21vyKkuBuNlUUl1AQJ3owQAgiczb/XEjnlO4QFCTRtIiFLlHd4+eHiL
RIKD5sHJ7JufI3oXdEnxygrXpWpQuF4iAOOiZLTBBVlA3rY011rVXVMbOnxA7Wwm
xykSKfw2hXIT3sO0/imRQw//NmYr41zlHoWzvgfc+3RUnIW+r1kq/sT9u5FDmn/I
wt/BzaktrFM=
=6Kp7
-----END PGP SIGNATURE-----

--oSWi0jal9INzEBQ4--

