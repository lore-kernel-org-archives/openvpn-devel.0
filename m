Date: Mon, 19 Nov 2012 19:21:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121119182128.GM22465@...1296...>
References: <1353348737-21920-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <1353348737-21920-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Error message if max-routes used
	incorrectly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 19, 2012 at 07:12:17PM +0100, Arne Schwabe wrote:
> the route/route-ipv6/redirect-gateway options allocate the route structe =
with max_routes number of routes. A max-routes after any of this commands h=
as no effect. This can be problematic (http://code.google.com/p/ics-openvpn=
/issues/detail?id=3D101)

ACK, for 2.3.  Makes sense.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUKp4qKkuBuNlUUl1AQKWVQP8DKnR6iMkpqBPSH9iirEiRYaz25O5onVZ
8zWV6BCUibTbfNnCOXLNVjdu9uQpZ3EslnRZxZyNS37jXcp2Uy0ZRtEYDaozMw12
k6FvWBvIpRnu6zYVQNQssxDmVhHdRmsa4DOOy0bLEFru/OjhQR3wu94AbYO+1GK9
EGWOt7QV+Rg=
=1/Ab
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--

