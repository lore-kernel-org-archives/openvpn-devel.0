Date: Mon, 28 Apr 2014 17:22:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140428152231.GT16637@...1296...>
References: <53593C96.1040404@...1901...>
	<201404281504.s3SF4A96017619@...309...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bniG9LpkhGP4pQp3"
Content-Disposition: inline
In-Reply-To: <201404281504.s3SF4A96017619@...309...>
Subject: Re: [Openvpn-devel] Topics for today's community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: George Ross <gdmr@...308...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Timothe Litt <litt@...1901...>

--bniG9LpkhGP4pQp3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 28, 2014 at 04:04:10PM +0100, George Ross wrote:
> OK, with the attached patch it does appear to work for me.  I'll give it
> some more exercise tomorrow morning, but in a quick test the tunnel does
> now appear to come up properly.

Thanks.  That confirms the theory "it's the TLS negotiation patch", and
in particular "TLS 1.1 works, TLS 1.2 breaks".

Now the even more interesting question is "why is it breaking for you
in particular, while it works for other Linux users just fine" (half
of my testbed is Linux...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bniG9LpkhGP4pQp3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU15yN6kuBuNlUUl1AQKczQP9FFihBIccsLq2yVqUUobnwkaT8725K5J+
HlLp2gJxrfkenj4v/8OftBVcjso+yiWbQPfmpouhZp1MXk/daXs9zK3gpYHzZ7fp
YhY/6yOPiws9hxxN7PjSv/XCVaIIX+3gqFl/jDpqRU0sa6uK6Z7IQnjFICj4pVIs
hGGou/EfWfo=
=9klu
-----END PGP SIGNATURE-----

--bniG9LpkhGP4pQp3--

