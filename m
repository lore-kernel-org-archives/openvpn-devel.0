Date: Sun, 4 Feb 2018 19:01:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180204180104.GA65347@...1296...>
References: <1517391662-21325-1-git-send-email-arne@...1227...>
 <201802041050.w14Ao3W3061831@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <201802041050.w14Ao3W3061831@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Treat dhcp-option DNS6 and
 DNS identical
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 04, 2018 at 11:50:03AM +0100, Gert Doering wrote:
> I've taken the liberty to change the commit message and mention that it's
> "v3" here :-)
>=20
> commit 849006bf17bba524e6f3344598adcbe41bedf450 (master)
> commit 61a72ecd59a57a50d0757b56b16f4ed3ce700f3f (release/2.4)
> Author: Arne Schwabe
> Date:   Wed Jan 31 10:41:02 2018 +0100
>=20
>      Treat dhcp-option DNS6 and DNS identical

This is... interesting.  The change is minor, but seems to have pushed the
endless if/else if/else construction in options.c over an invisible cliff,
and some buildbots (FreeBSD 7.4, Debian 8.5) now *sometimes* bomb with
"signal 11" when gcc is compiling options.c ...

  gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include  -I../..=
/src/compat           -DPLUGIN_LIBDIR=3D\"/usr/local/lib/openvpn/plugins\" =
 -g -O2 -std=3Dc99 -MT options.o -MD -MP -MF .deps/options.Tpo -c -o option=
s.o options.c
  gcc: Internal error: Killed: 9 (program cc1)
  Please submit a full bug report.
  See <URL:http://gcc.gnu.org/bugs.html> for instructions.


dmesg points to "too much stuff running on that box"

pid 91411 (cc1), uid 1000, was killed: out of swap space

(it's not a general problem - I can compile options.c just fine on f7.4,
but buildbot failed...)

So - if you bump into this, give your system more RAM.  This particular
VM has 512M RAM and *no* swap, seems this is not enough anymore.

Besides this, I don't think we need to do anything about it - except
document this here, so google can find it.

gert

PS: and yes, I know that FreeBSD 7.4 is more ancient than the dawn of
time, but for some reasons I've become fond of it - "my first buildbot!" -
and it's well firewalled off the public Internet...  and it's sort of
my "how far back will it still work?" test.  If we break it, and for good
reason, it will be the XP/Vista thing - I'll try to not break it, but
if there is reasonable API changes that we want to have, goodbye.

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJad0pgAAoJEB2Cnv7KVigSM0AL+wQGptCadK2N0LICKuk6Ci5C
ho2nFF31sTwd+UF2WlPBW/zf0OqlIiU0BotDM1SCT788+ChKsvIyD5dfzgR9hIGi
Y75284h94pQKlj6U+Z3NDnNHJpoNwzCCeBmkxbkozHAFWOr19MZrhB6zaWGIm1O+
Zqo3MzCc4ToCqDwzvKFOgopD3wXuPzdQB0GKjlpVVpoJlMDC4dLx9ZHET9CJoarD
iFRW4Vgk0o3EYezA0UqZagPi/w7ApcMtIsOSZxRRn5ThWQKLinwhXOY94nDvLhSg
tArtgPw4c/cly+hejZ2z2RPGerOXS8KYJYeemqCiKx7SPA5lDJbOI93o88PeMq91
fy8+sqd20ru+Gi4TlbZtDjdzNW5/NB9iF55FRnV7SDO3o3UbkQy0MjNJ8ZNGkbjW
pwcNARa/75yOTIe72C86637ap3z4DGVY9lcMJBBNF8iWjZ1Rryt8rpccGTlqwg6a
4rmk50ogGIAfMMmBxDzrK40J38fKftBUxlxx2OyyKw==
=7zVK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

