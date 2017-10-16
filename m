Date: Mon, 16 Oct 2017 18:57:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171016165720.GL958@...1296...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
 <CAFHpkQEgjmdRgMaOC-1-6vRqjYTUoC6fODtcx2yZt0DJUPGcsw@...278...>
 <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: ???????? ?????????????? <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--wRokNccIwvMzawGl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 16, 2017 at 11:33:02AM -0400, Selva wrote:
> I did a quick test on ubuntu trusty (14.04.05 LTS),  and as you pointed
> out, it fails while
> compiling block_dns.c because of some errors in the headers for the
> windows filtering platform API. All the bits are there so its possible to
> build
> after tweaking the installed headers (only a couple of lines) but not
> something
> one would normally want to do.
>=20
> It does look like targeting 14.04 is no more relevant.

I have some sort of mixed feedback from Samuli's buildbots here - it
*used* to compile just fine, but since the latest patch (removing the
"manual" dynamic linking stuff), it fails with

openvpnserv-interactive.o:interactive.c:(.text+0xee2): undefined reference =
to `InitializeUnicastIpAddressEntry'

... so it seems 14.04 mingw does not truly expose all the Vista API bits.


OTOH, we can just document "16.04 is what you need" - that would work
for me, as cross-building is really not "I have this <any breed of unix
OS> and want to build and run OpenVPN here!" building...   (I have much
stricter requirements wrt breaking platforms for "run here" builds :) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ5OTwAAoJEB2Cnv7KVigSs8UL/1tKlFNt54fGhcpWIYm9fns8
YddMD1M1/5qRKL3mL9cCZaHvFElLPa3llPxrCQvFugB6IOc9zFu4kS6bBrQMIXF4
ZwOet8YE4jBrqPD8HxqUd6xhME1vXBWSyzkGZYmFsJu813xLc+wTj9KYvU0y0y3l
JHheoXFGe5jXH8P5pazgALUifZh519G6aIX6CTkds/9dmL8Iwx4lJZPC35dZ0VxA
nbMkjzUa7GmfNKlR1DdWjM1Z/q05c8lY0SmLvMu6j1QH7rxkbnPgMGVppmDrGSV9
aXduT0PisWqVsaZSZm9Dw0ZIXHMoMbt4ilBgjHtdYoJ6lQQ511qEObW5ku5OmVqa
uiYzSKOIoKn7dFxLJB1LTjzMsXUPvdX0IEhL+SuoWQ5AOfxJDAln5NNlD0HemBdx
hzzdZgeeF6lSDBfM9nS7MBYGHErK1PQ8EbouUnKwT53bsv9BBvku40l1u/wsvJy4
8uMpoD8G7WNjuIv5sqoI1ACi0+YodIXK0uvUR9P3tg==
=ahQd
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--

