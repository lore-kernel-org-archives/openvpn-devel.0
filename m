Date: Wed, 8 Mar 2023 15:40:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZAieahHoe5SjTOnT@...1296...>
References: <20230204004512.250271-1-selva.nair@...277...>
 <202302101859.31AIx3Y8031056@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ev/55N9VAWfEMaAB"
Content-Disposition: inline
In-Reply-To: <202302101859.31AIx3Y8031056@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Conditionally add
 subdir-objects option to automake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Ev/55N9VAWfEMaAB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 10, 2023 at 07:59:03PM +0100, Gert Doering wrote:
> This warning has been quite an annoyance for some time - thanks for
> taking care of it, and also figuring out what caveats apply.  I do
> not understand autoconf intricacies, but I have fed this to github and
> to the buildbots, and they all seem to agree "things still build fine" :-)
> (the oldest buildbot is FreeBSD 7.4 with automake-1.11, and then there's
> the OpenIndiana buildbot with automake-1.15.1, so we have everything
> in the mix... the "current" OSes in the zoo all have 1.16.2 or later)
>=20
> Your patch has been applied to the master and release/2.6 branch.
>=20
> commit 8b915c48252da81b96041de66847272b0902c755 (master)
> commit 7f72abcf8a56bb35a510a3409e03a4e2aaba50da (release/2.6)
> Author: Selva Nair
> Date:   Fri Feb 3 19:45:10 2023 -0500
>=20
>      Conditionally add subdir-objects option to automake


This patch brought with it a somewhat unexpected and unexplainable (to me
and Frank, that is) side effect - "make distcheck" explodes:

gert@...2718... ~/openvpn-26.git $ git pull --rebase
Already up to date.
gert@...2718... ~/openvpn-26.git $ make distcheck
...
config.status: creating config.h
config.status: creating include/openvpn-plugin.h
config.status: executing depfiles commands
config.status: error: in `/home/gert/openvpn-26.git/openvpn-2.6.1/_build/su=
b':
config.status: error: Something went wrong bootstrapping makefile fragments
    for automatic dependency tracking.  If GNU make was not used, consider
    re-running the configure script with MAKE=3D"gmake" (or whatever is
    necessary).  You can also try re-running configure with the
    '--disable-dependency-tracking' option to at least be able to build
    the package (albeit without support for automatic dependency tracking).
See `config.log' for more details
make: *** [Makefile:834: distcheck] Error 1

the relevant "config.log" is hiding, but there are some errors that look
relevant:

gert@...2718... ~/openvpn-26.git/openvpn-2.6.1/_build/sub $ less config.log
...
config.status:1694: cd tests/unit_tests/plugins/auth-pam       && sed -e '/=
# am-
-include-marker/d' Makefile         | make -f - am--depfiles
make[1]: Entering directory '/home/gert/openvpn-26.git/openvpn-2.6.1/_build=
/sub/
tests/unit_tests/plugins/auth-pam'
/bin/mkdir: cannot create directory '../../../../../../src/plugins/auth-pam=
/.dep
s': Permission denied

(many of them)


Not sure what to do about it... for now we've decided to move onwards
with the 2.6.1 release, as the "make dist" built tarball passes all
the tests - including "out of tree" builds - so it's not crucially
urgent ("yesterday" urgent), but it would be good to get this fixed again.

Anyone who understands autoconf...?

(This is on Gentoo, with automake 1.16.5, autoconf 2.71, libtool 2.4.7)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ev/55N9VAWfEMaAB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkCJ5pAAoJEB2Cnv7KVigS9JQL/0nuIoEgrnGX/3LJKB27S7Ok
rxG4y2KPc5y8bez0e72ow4FRTDxUd4zlq2+w/cdS6VclwzOYnbjjeAqXV7Ekwjos
0G9H+vx6LYDrrS84QuZeIQlse/vVFORLKL6RC9IV8fq4DlLU6DiRAtfts6M85mVK
1FXoPw9VFCEHRCZ90J9BG9k0i7Yi6zqrhQhPX0OEY70MCw36qwKC4dQHBHI9uA9A
BNo4eq8p9/73ahx0Q0ctZ00q3Y5EFWDoESOmZ4nQjeDzbOnrFDkDkiZROHQEEN18
m1IwQQBLzMo74ZzrotYUp61Vc7rigMSfGqD4wjSr3IyjY3mBv+WYRgz/+7VbuQsI
+30kzIAyKBWbDcVaxrkkYCEDYFAWvWoFeOduHYcg7CmirhIU9D2+kCkq9oiJKcA+
JxbeLEolnlxiIBNT0Z3P26957xUe4eRnRIS6VyWUjgjKGh+zyN6Ryh2PlQgchWCz
L+DMES7sgXJtc35ezXjjMzzKod7ofIb1iG3j2D6BFQ==
=PHrP
-----END PGP SIGNATURE-----

--Ev/55N9VAWfEMaAB--

