Date: Sat, 11 Jan 2014 20:59:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140111195928.GO226@...1296...>
References: <1389455615-11543-1-git-send-email-gabriel.corona@...1861...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjYxckON9mHZ0A1q"
Content-Disposition: inline
In-Reply-To: <1389455615-11543-1-git-send-email-gabriel.corona@...1861...>
Subject: Re: [Openvpn-devel] [PATCH] Add management command to reopen log
	file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gabriel Corona <gabriel.corona@...1861...>
Cc: openvpn-devel@lists.sourceforge.net

--PjYxckON9mHZ0A1q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 04:53:35PM +0100, Gabriel Corona wrote:
> Useful for better logrotate integration without going the syslog path.
> Triggered by the "reopen-log" management command.

NAK, the way it is written.  It is introducing  *18* additional #ifdefs,
and we have already way too many of them, causing testing troubles to
no end.

Dubious on the feature itself - why not use syslog if you need log file
rotation (=3D "neither an ACK nor a NAK")?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PjYxckON9mHZ0A1q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtGioKkuBuNlUUl1AQIfagP9GS2Ezt08WYlfxhU9L0h2+d+6LoPbEoLq
IFPztjKD/x/4DQP9Aho2m0t+bGe4MfI6PZBu5nT4A+BImf35Vo0FAo/XzjQJMtkt
KnedgRWC+BLOtE9mVT09AwW74dkGZOdfRWZU7XnsJbq2QGSq+2biCOAU6P0NHpXn
o+eQz7+mwU4=
=RWU6
-----END PGP SIGNATURE-----

--PjYxckON9mHZ0A1q--

