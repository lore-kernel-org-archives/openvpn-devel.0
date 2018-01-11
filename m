Date: Thu, 11 Jan 2018 17:13:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180111161334.GQ69387@...1296...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <201801091431.w09EVeSP070386@...2054...>
 <c2b39501-3ec7-0c62-f1c6-96da33c46173@...1435...>
 <20180111140152.GP69387@...1296...>
 <a4b2a94e-6d88-9d90-357a-3ce691c0996b@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Jm4NjHtWXfjOIegD"
Content-Disposition: inline
In-Reply-To: <a4b2a94e-6d88-9d90-357a-3ce691c0996b@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis: use clang's
 -fsanitize=address to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Jm4NjHtWXfjOIegD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 11, 2018 at 03:42:44PM +0100, Steffan Karger wrote:
> Uh, right.  Though this one is useful too ;-)

ok, so here's 2.4 updates...

commit b968f43f9142f832483ae91c8b4e44a5c9efed57 (HEAD -> release/2.4)
Author: Ilya Shipitsin <chipitsine@...277...>
Date:   Fri Jan 5 00:37:10 2018 +0500

    travis-ci: add brew cache, remove ccache
    (cherry picked from commit 0c1b9864184e609b68c2bb317ee57317ae12a026)


commit a5dc64653e261a233cc9df0b5adc46767b544645 (HEAD -> release/2.4)
Author: Steffan Karger <steffan.karger@...1435...>
Date:   Fri Dec 29 10:47:37 2017 +0100

    travis: use clang's -fsanitize=3Daddress to catch more bugs
    (cherry picked from commit 7b11915ddfe97d8c28f998db54c40384a4eafb93)


(cherry-picked from master, no code changes)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Jm4NjHtWXfjOIegD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaV40tAAoJEB2Cnv7KVigSIi0MAIso73lrhLsRLT3zeHfNmliB
Oc0g9zc4igX35gmGm11jm14nQzWc6Jem7/cKLwmS61jNKCuLhBQUa8YovBN3i0bt
qhoPrV/2v8RRdQJgpaWHZQqczRSY3TsUR2MVMTBPEScjq/XoFJ+qPt88/xJ839Sf
SZRXg/I28o1OF3cIFCGVEoVDvrEN17wKYKWhEkicaT2IJLLyoOPhLL5HI2miO6Zx
rgpmZ5nJQ68eJ1tQgSOZOHZ4LDhqWEmxDYaTR9QHkencplI4l/OxCdUACwHdQJWC
b7FJlZwu0CFzB+YvGTvNnk7buBlZEYgtF5ijpI3AH+GlTYO3pl8hYGoyc/C2kl7c
AQ/gltDV22uLOAdVFSrZg8HezTWJBYUlBUEW9ODwwA6zWedbtroCXzsgJYon0HwR
ap0R2iiXFVchDzwrFZaLeIXfpfdW4ItoYfLShwcWJKWmkAul2z6BM2RXcfsSm1Ab
Z/Eqn/02QcZ2k9VHBDudO5LS6fJoZn/GL/29Nrvvjg==
=GiiQ
-----END PGP SIGNATURE-----

--Jm4NjHtWXfjOIegD--

