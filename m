Date: Mon, 6 Nov 2017 09:07:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171106080731.GP958@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
 <20170922205944.GA70062@...1296...>
 <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
 <20171104162253.GW958@...1296...>
 <fc836d9417be8c9d85e314d40dea51c8.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Jl04SkPfyEiGE6TK"
Content-Disposition: inline
In-Reply-To: <fc836d9417be8c9d85e314d40dea51c8.squirrel@...2257...>
Subject: Re: [Openvpn-devel] LZ4 library version printing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

--Jl04SkPfyEiGE6TK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 06, 2017 at 08:15:54AM +0100, Simon Matter wrote:
> > It now has...  (1.7.5).
> >
> > I'm not sure where LZ4_versionString() got introduced, though - their
> > git repo does not have tags for 1.7.1 or 1.7.2, it is in the 1.7.3 tag,
> > but not in the "last of the old numbering scheme" version.
> >
> > Our configure.ac requires 1.7.1 - so if LZ4_versionString() is not in
> > there yet, we might want to bump to 1.7.3 then.
>=20
> according to the NEWS file in lz4 there is no such thing as release 1.7.1
> or 1.7.2, it goes from r131 -> v1.7.3. I therefore suggest to set the
> minimum version to 1.7.3 as I'm also unable to locate any official 1.7.1
> or 1.7.2 release.

Sounds like a reasonable plan.

> BTW, for 2.4.4 I've changed to patch to the one attached.
>=20
> Regards,
> Simon

> --- openvpn-2.4.4/src/openvpn/options.c.orig	2017-09-26 11:27:37.00000000=
0 +0200
> +++ openvpn-2.4.4/src/openvpn/options.c	2017-09-28 06:21:57.977919621 +02=
00
> @@ -61,6 +61,10 @@
>=20=20
>  #include "memdbg.h"
>=20=20
> +#if defined(ENABLE_LZ4)
> +#include "lz4.h"
> +#endif
> +

This will fail if we use the bundled LZ4, which has "compat-lz4.h" -=20
so maybe we really should go back to including "comp-lz4.h" here, and
move the lz4.h/compat-lz4.h including to that one.

("bundled LZ4" is what we can have right now, so we need to take that into
account.  If we want to drop it, that's an independent discussion)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Jl04SkPfyEiGE6TK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaABhDAAoJEB2Cnv7KVigS7q0L/2v0YjJYc83nSv08Fk05K4Dh
9ieYj1SeKTo88PcmBlgHlt1TbOLQZF4KC32JlB4HdDOCBcIUFbikqDsvnauBPONB
BgJIptxROlRNVqJJpyFC7hoBFANWKdCSfJZp0YHsmq79VhFnSdzqUWMM2N11R7Bm
2sB4/tTPazuqMehBQvdFr17sr1ASaono0WLB1R2d5uZAaZGdGZa2jTua8LYXss8i
AIS4m/aMnaMXjxB8ubNiCvhHb2NNu/maLgt45zxvPV6aEzWyaHMpT+OoApQBUFsu
Jolqx2Q1tpX8yNawWnvWphBSQEkbW0HcyKOkqhy1hkrlsR+27exukUcmCN2E1VnP
7ir26mNycgT3edr7RSoS7h0gbzfPYdO7HTDnHqJfw4nLbN6o1SnC7PsXz4mdJpU0
N3NtzwqOmHZcvsxpWYTgu50t6/8UjQwJX9wyqj/ayWC++lM8PjF1PhpWPIGOpv5w
xr1aFc6MqqkTpG4tNlAFX5rL/1ZU4ZbHqD9wdygysw==
=aM81
-----END PGP SIGNATURE-----

--Jl04SkPfyEiGE6TK--

