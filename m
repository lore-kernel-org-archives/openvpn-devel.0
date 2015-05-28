Date: Thu, 28 May 2015 16:53:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150528145308.GY382@...1296...>
References: <1429540256-4906-1-git-send-email-yegorslists@...1030...>
	<20150421075848.GA7377@...2009...>
	<CAGm1_kt0bzLW_1Bwf7prZW2f7PvrBxO0heEjWe0EaQaFFk=JuA@...278...>
	<20150528140036.GW382@...1296...>
	<CAGm1_kuNqwu1BUkV=EK3Y4g6xuVS0TbJOn5xU8jiwm7v61CGLw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iuL7KOmW1iVG2alW"
Content-Disposition: inline
In-Reply-To: <CAGm1_kuNqwu1BUkV=EK3Y4g6xuVS0TbJOn5xU8jiwm7v61CGLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cert_data: fix memory leak
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yegor Yefremov <yegorslists@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

--iuL7KOmW1iVG2alW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 28, 2015 at 04:14:12PM +0200, Yegor Yefremov wrote:
> > Looks reasonable to me, and if Vasily as the primary author acks it,
> > fine to me.  I'll merge it ASAP, though it would make my life easier
> > if I had the original mail (on the openvpn-devel list) to feed into
> > "git am"... :-)
>=20
> Do you mean this one
> http://article.gmane.org/gmane.network.openvpn.devel/9600 or should I
> just include you in CC next time I send a patch?

Ouch.  Sorry, overlooked that one - yes, that is what I had in mind,
patch on list (and preferrably, ACK on list as well :-) ).

And occasional poking if nothing happens.  Apologies.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iuL7KOmW1iVG2alW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWcr1KkuBuNlUUl1AQJeDgP/aIYPXbcsFd8eglIDGBK+ivjm9nTtl++J
5Ag8OmwagbeoxPxC3YxvSsYIINEp0SK6Hx91OfHlUP4NQ37PO335McV2+0h9txbn
GSKqj1GEdmndn2RCHXCVsF3tudSYnxzBuavazpNQmjHZLFFZ+DK14BfhjmNVC7se
PER092HeLRk=
=m0EP
-----END PGP SIGNATURE-----

--iuL7KOmW1iVG2alW--

