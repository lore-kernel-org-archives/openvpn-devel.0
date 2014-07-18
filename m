Date: Fri, 18 Jul 2014 20:32:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140718183203.GA1118@...1296...>
References: <20140708195609.GW1118@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQOvt/yUJ6yzDJmH"
Content-Disposition: inline
In-Reply-To: <20140708195609.GW1118@...1296...>
Subject: Re: [Openvpn-devel] RFD: building OpenVPN without socks and/or http
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

--JQOvt/yUJ6yzDJmH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 08, 2014 at 09:56:09PM +0200, Gert Doering wrote:
> we have a patch on the table to remove support for compile-time disabling
> of socks proxy and http proxy support in OpenVPN.
[..]
> Otherwise, the #ifdef maze goes - that is, socks and http proxy will
> be always compiled in (of course you're free to just not use it :) ).

No feedback received, which I consider "no veto".  Out it goes.

commit a4b8f653ee5be9c2292cf92dac09d7aadcc9a487
Author: Arne Schwabe <arne@...1227...>

    Always enable http-proxy and socks-proxy

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JQOvt/yUJ6yzDJmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU8loI6kuBuNlUUl1AQLyNwQAvGoxb1thrM0CJboLUONpG/PM58KF5AFa
9Wex0WASJ1cNXWcCbLVq8V1h3NKSuRbvC8lLNwD0urFBmJf49vLqarzQGHKpieJD
AF3jXmHcz3eLPOx2RCMQd/YhenXR0UXo9QWlpRj9J+kDVEI8zfZxPPLmvXbJOQty
gXuav+9t67E=
=YCz1
-----END PGP SIGNATURE-----

--JQOvt/yUJ6yzDJmH--

