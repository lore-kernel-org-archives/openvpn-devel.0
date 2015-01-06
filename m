Date: Tue, 6 Jan 2015 18:19:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150106171923.GZ8134@...1296...>
References: <20141208115202.GA4807@...2009...> <20141212165220.GA4575@...2009...>
	<548B32D4.1060607@...1227...> <20150105102207.GA9055@...2009...>
	<1420561439.29022.195.camel@...1866...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <1420561439.29022.195.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net, Anton Karpov <tokza@...2010...>

--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 06, 2015 at 04:23:59PM +0000, David Woodhouse wrote:
> That is, after all, fairly much what PKCS#11 was *designed* to provide.

Thanks for that hint.  Seems we (as in "the currently active developers")
really need to look more closely into the gifts we inherited :-)

> In fact, doesn't such an implementation already exist at
> https://github.com/slushpupie/KeychainToken ?

This looks quite promising :-)  (if a bit "dead", hope it still works)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVKwZG6kuBuNlUUl1AQJkvgQAtaR18dDGpy3ZDbm3ZSn5KSuTjw8ycf87
58gYSOQJsqb8+BGHCvtz+aS16mKVqmjJl1n3GNXzD/TtcGllLHAIsYT1zV0mXh0H
iMi+MJol9jpgAtadVQHVu567OoaU9XvMl0yjvwQz20HUbmY2zrPCkooz1YWTYNnI
/IPgctakLRE=
=noVV
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--

