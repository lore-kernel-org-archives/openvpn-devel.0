Date: Thu, 21 May 2015 20:14:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150521181409.GY382@...1296...>
References: <555BF270.3090706@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYpwwOSOoAAr8PNn"
Content-Disposition: inline
In-Reply-To: <555BF270.3090706@...1147...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--qYpwwOSOoAAr8PNn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 20, 2015 at 04:33:20AM +0200, Jan Just Keijser wrote:
> here's my patch for bug #93: missing ifconfig_* env vars after=20
> up-restart. Tested with both IPv4, IPv6, topology subnet and topology net=
30

Reading through #93, I'm wondering - what about the other environment
variables mentioned, like "route_gateway" etc.?

In other words, your patch looks like it will nicely fix the missing
ifconfig_* variables (by ensuring that what close_instance() destroyed
is re-initialized even if not calling init_tun() - and cleaning up that
one a bit while at it :-) ), but I wonder if more needs to be done?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qYpwwOSOoAAr8PNn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVV4gcakuBuNlUUl1AQJZbwP9Ge02B8ah6vwKlTlupg+fOy9gOs+tTeO1
T2nV5mdIBIqMuJp/CBbrlih8iTF3NlxMLBfdnOGnavhPCW20QaKA+zA4Yz3e7Itu
kVGBzrXJdWE4HVjWw5VIzefcGUwcTNpadbe3joZMOFjnVFTQbMfbLXuKu0dxXJk9
LFHE/+UCjpI=
=vbRp
-----END PGP SIGNATURE-----

--qYpwwOSOoAAr8PNn--

