Date: Mon, 26 Mar 2012 20:22:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326182231.GZ1359@...1296...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
	<CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
	<CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RI0j69zTdciYrvy/"
Content-Disposition: inline
In-Reply-To: <CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--RI0j69zTdciYrvy/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 08:14:50PM +0200, Alon Bar-Lev wrote:
> Are for dependency tracking, so that if you change a file dependencies
> will be recompiled... This was the same in previous build.
>=20
> So we had:
> ---
> gcc -DHAVE_CONFIG_H -I.   -I. -I/usr/kerberos/include    -g -O2 -MT
> status.o -MD -MP -MF .deps/status.Tpo -c -o status.o status.c
> ---

Fine with me...

> And now:
> ---
> if gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include
> -I../../src/compat      -I/usr/include -I/usr/include     -g -O2 -MT
> status.o -MD -MP -MF ".deps/status.Tpo" -c -o status.o status.c;  then
> mv -f ".deps/status.Tpo" ".deps/status.Po"; else rm -f
> ".deps/status.Tpo"; exit 1; fi
> ---

... convolution.  Even the quotation marks get inflation now.

> What this makes sure is that if compile fails the dependencies is removed=
....

Why would anyone want to do that, on a production build?


But anyway.  I've stated my opinion, you've stated yours, and now it's
up to the rest of the community to form a "community decision" which is
the way to go.

Thanks for explaining your view - I sometimes can't help myself, I'm an
old-fashioned programmer who writes Makefiles by hand and has a dislike
for automation that's brittle enough to require careful tending...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RI0j69zTdciYrvy/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3Cz56kuBuNlUUl1AQK3qwP7BX8KhCrxx90M0qhNbsSoCZc7xABh+M5M
nt7rWV5JelReZAMDTdY/ZRtd71CEoc4voMlURRrxeiBIVbUG1HIoEB3iIQmHHJhr
xkQfFt9uD9If5lXTnbNrM586bi+o/OGKAKWNwb7NrE5HAqGvqwjNpOQedlA8QhMG
5xm/JV8cE0M=
=C8na
-----END PGP SIGNATURE-----

--RI0j69zTdciYrvy/--

