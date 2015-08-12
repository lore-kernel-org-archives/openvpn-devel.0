Date: Wed, 12 Aug 2015 13:34:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150812113413.GL382@...1296...>
References: <55CA09E0.3020503@...2052...>
	<20150811191949.GJ382@...1296...>
	<55CB0817.4010503@...2052...> <55CB0B2C.2090605@...2053...>
	<55CB1B6B.8010404@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tJPFfV8UImC1uSC1"
Content-Disposition: inline
In-Reply-To: <55CB1B6B.8010404@...1227...>
Subject: Re: [Openvpn-devel] SRV record support
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

--tJPFfV8UImC1uSC1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 12, 2015 at 12:09:47PM +0200, Arne Schwabe wrote:
> Yes but changing AAAA/A of opnvpn.company.com or IN SRV of
> openvpn.company.com is not such a big difference.

This was my thought as well, but SRV does have merits - especially
the priority thing is something you can't properly do with "traditional"
DNS entries (if you have multiple A/AAAA records, you just get load
sharing).

It's not a killer feature, as "most of it" could be achieved by having

remote openvpn-pri1.company.com
remote openvpn-pri2.company.com
remote openvpn-pri3.company.com

in your configs, and DNS/GeoDNS can steer this to the proper hosts -=20
but SRV makes it more convenient to the user (and much work for the=20
implementor... :) )

So - I wouldn't *implement* this myself, but if it were there, I'd
propably *use* it.  Example: I have rolled out quite a number of=20
.ovpn client profiles that prefer TCP before UDP today.  Given the
nice new tls-float feature, I'd actually love to have them try UDP
first...  without rolling out new .ovpns...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tJPFfV8UImC1uSC1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcsvNKkuBuNlUUl1AQJeHwQAxf1tQBidgnIEXgbb6ZHfaBfe4dW0E4dR
25CgPTTtMtHXs8bjjvSmnOPg6nz6IcAWrRGBJD/Vm7CH3W9a9968zFOl4tvCU2dM
HLPJHPzVy5C6j93GlNeGBmr6dlL9wPcSvHXzkCj+FjH+hz26icXByW+bQ0IoALR3
9M5ldXxFcvA=
=EgY0
-----END PGP SIGNATURE-----

--tJPFfV8UImC1uSC1--

