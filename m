Date: Wed, 21 Jun 2017 17:49:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170621154928.GX97029@...1296...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
	<103f1dec82c50941570c7103355b8457.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WsZvjFs9m1Pq7715"
Content-Disposition: inline
In-Reply-To: <103f1dec82c50941570c7103355b8457.squirrel@...2257...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--WsZvjFs9m1Pq7715
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 21, 2017 at 05:25:32PM +0200, Simon Matter wrote:
> > .gz is built with "make distcheck", .xz right after from the same
> > tree with "make dist-xz".
> >
> > What differs?
>=20
> The check sum of both extracted tarballs, not really their content.

Ah.  Yeah, that's one of the drawbacks of building two independent
tarballs - timestamps in the tar header (IIRC), so the end result always
differs in a few bytes.

> I suggest to create .xz from .gz instead of building another tarball. That
> way the extracted tarballs from .gz and .xz share the same checksum ->
> less confusion in case something goes wrong - as it did with 2.4.2 and
> now.

David, you're listening?  Should be an easy-enough change from what=20
we have now... ("gunzip <...tar.gz | xz >...tar.xz" or however you
do xz balls) :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WsZvjFs9m1Pq7715
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZSpWHAAoJEB2Cnv7KVigSLQIMAKShQrxvmt71eq4GZwN/XVkS
1kQGmS1TS+E7M/RRrfrt5gclXRpM0l697rUMEZWEvxAMlvNwaWzZiKV+beAMUwH9
+5az795iXj7VXWVzwFpRQf8a15yYEOZUesHmkfQcAWmQ2yZSXMyvJlj08DoMKhXS
wVgUrNjzAFHYsTdvjtChZ80/zsddmAq7xjCxGGZro6YIi21IattKGuFdMfj1bp+2
t9k6VUCkDET0iTI95vyIsMX9L8Frrm4Nex7jZQjAm/bx/e6RIWSLIoRRuILc+hCG
8gDFdiwvI8a8lZZIOeF3tbYYfBSlf7bTGGE/Jxpc06biL1GCZstVyjh6IkXGmaSp
K1aZvfbdVzWu7knxVC7M4lGchFwH58cphEI8AI1ocRBM9Hh3HIovK37ltnpZETas
lE2ETWZnC1KY/TjQJut2BsxApR5e7LLFO7Dv72zCvs0e9KMvVTbKQss+Hsmn8mM6
0xeFWQbtK95djCGyHHTWDOG+93TJgWluUQDJKJBmew==
=FoG1
-----END PGP SIGNATURE-----

--WsZvjFs9m1Pq7715--

