Date: Tue, 2 Jul 2019 09:11:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190702071122.GQ1097@...1296...>
References: <20190628194637.5038-2-chipitsine@...277...>
 <201907020707.x6277i05056035@...2054...>
 <CAFHpkQHCEYqig-dWvHQbrhdUndndHVdG7sA7KsvWVmU7XfsOFw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Yl/hcSr02N//2x3j"
Content-Disposition: inline
In-Reply-To: <CAFHpkQHCEYqig-dWvHQbrhdUndndHVdG7sA7KsvWVmU7XfsOFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: fix osx builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Yl/hcSr02N//2x3j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 02, 2019 at 12:09:48PM +0500, ???????? ?????????????? wrote:
> ????, 2 ??????. 2019 ??. ?? 12:07, Gert Doering <gert@...1296...>:
>=20
> > Acked-by: Gert Doering <gert@...1296...>
> >
> > (I have no idea what this does, specifically, but it is not a code
> > change and if it fixes our Travis builds, I'm happy - and the explanati=
on
> > given says "it will fix things")
> >
> > Your patch has been applied to the master branch.
>=20
> should we apply to 2.4 as well ?

Good point.  Should have the same brokenness & needs the same fix - so
here we go

commit 5e695c7786259049ea2eb4ac78101e3d7edd8280 (HEAD -> release/2.4)
Author: Ilya Shipitsin <chipitsine@...277...>
Date:   Sat Jun 29 00:46:36 2019 +0500

    travis-ci: fix osx builds

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Yl/hcSr02N//2x3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdGwOWAAoJEB2Cnv7KVigSi0oL/id9S69KxlLk+bGyD+Jz9hIw
nI2wvrYnRQNN0QWgVgtcKqFQpvDj5/FHI/bHIhQqX8aBPVvQWPjMv3Tx0XWKLr+q
wlrwdgPKWiXlf/t9OLF9F/wLrdnHGfdHy06lC6f36GpO5dAZNRUutAjBrL8Q/oRh
mUu6GY6KbtQ6sTHYQqqekOhqbjq0ZRxWbHUeWBcj4vkz9JTuRlOxFJt7k+7n8299
9/MKZvwCsg+qaN5UumI5M6FSovlovzUSTE/uMxaFaVAjF+Au2Qd/XkGTcQvsb2MH
s8uJmRBhfMJ+2QaCT0OPJMeXr19gJTyyMwwiubIruF/bD2wRdwkY1L4bJFdLq0Go
a4voLXO0XvARLnRZr5JXe/mpPpKkCzqN6doRZdEiRfBzkfgWBSzDsmD3UZnNGoaO
WXJFo9qt4/Z0ElPeiK5sd+gBnSmxo/n17aCPeKrdneZJHVgHAJOiD2t51HQ0tbKx
W6vXkIXGFNoBYfz0zEMYxJF1whn23gGzWaxIkFpZTA==
=o2iy
-----END PGP SIGNATURE-----

--Yl/hcSr02N//2x3j--

