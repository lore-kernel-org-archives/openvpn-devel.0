Date: Fri, 14 Dec 2012 19:51:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121214185144.GR22465@...1296...>
References: <20121214181427.GP22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RcBhtXD8LUOKpJGW"
Content-Disposition: inline
In-Reply-To: <20121214181427.GP22465@...1296...>
Subject: Re: [Openvpn-devel] coverity issue 1 - MF_EXTERNAL_KEY
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--RcBhtXD8LUOKpJGW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 14, 2012 at 07:14:27PM +0100, Gert Doering wrote:
> coverity scanned our source tree, found 201 false positives (they do not
> like msg(M_ERR, ...), msg(M_WARN, ...) or msg(M_FATAL, ...)), and 3
> actual code confusions.

Small correction: in the most recent run, they only found 201+3 things, of
which only 2 are really relevant.

Unfortunately, there's much more stuff - 24 issues tagged as "high!",=20
some of them confusion about ASSERT() inside coverity, but some could
need some reviewing... volunteers?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RcBhtXD8LUOKpJGW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUMt1QKkuBuNlUUl1AQJlnwP9HAjqdm2MT1rWM1acPh+dYMoDYHKT7xTq
s2BUuHQYwFptnftssMJEdtg9UrtYhh5FYTcU0Bu/x/x8ZmIvpoI+CsWMmaSziaEb
57kDjQ0T0N+GLD3PGRCUvaZMWKMN52Lyn0tL+4ow9R7gBn+cwClNXaJbDG0Kurmi
qrD4Y5gzyuY=
=pGWo
-----END PGP SIGNATURE-----

--RcBhtXD8LUOKpJGW--

