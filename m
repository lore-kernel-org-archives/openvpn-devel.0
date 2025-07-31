Date: Thu, 31 Jul 2025 16:44:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aIuBXxMRJSQtm3X8@...1296...>
References: <20250711100405.240625-1-frank@...2641...>
 <202507140921.56E9LZ1U032354@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BiGl4h+yuagkefzK"
Content-Disposition: inline
In-Reply-To: <202507140921.56E9LZ1U032354@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix compiler warning in
 reliable.c with --disable-debug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--BiGl4h+yuagkefzK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 14, 2025 at 11:21:35AM +0200, Gert Doering wrote:
> Interesting trick :-)
>=20
> Looking forward to see the first patch come in to remove this "totally
> useless line" again.  But that's what "git blame" is for...
>=20
> Since the buildbots are happy and this line explicitly does nothing
> I have not tested this further.
>=20
> Your patch has been applied to the master branch.
>=20
> commit fcd8f0f9fccdba02ed643dee5df7422ba36ced12
> Author: Frank Lichtenheld
> Date:   Fri Jul 11 12:04:05 2025 +0200
>=20
>      Fix compiler warning in reliable.c with --disable-debug

As it makes sense, backported ("cherry-pick -x", trivial) to release/2.6
as well.

commit abd2e52a3142e72b79532b82c02bfa7aa9e3c0aa (HEAD -> release/2.6)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Fri Jul 11 12:04:05 2025 +0200

    Fix compiler warning in reliable.c with --disable-debug

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--BiGl4h+yuagkefzK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoi4FfAAoJEB2Cnv7KVigSGdMMAJSC7nuPbgv7OIRgif76eRsK
DS6mP/oFssIovGhBqyzeWlX0rjyIbE4HTBk8Nr0b9wJfMlSf5fjeu6Os5a/ayh00
Qslc5vqOH/vfm6YgwxA9yZdzCAHSBc6H4OFlheh1wg5iqqc41VmZTf0lY8E9ExC8
vA9XKKphsWHkYMdmkfuEgQeb1HloOM3cEOm+Fn1ZjzCYxe122C0lz6JMRJsTRi73
vTThiguE9U1Z5l3cqPJknRxXz17EUmi85ZxKf25k8sizERJf/2/Kp7R1d3AUBa7W
dOmqrcmC40ZHysKcuDC6S8j0bbaqxl36H7/vOzqhf7jiOiHCignl9scONNHEFyA+
GyRvXZcx1r+XrSrCo/kHiZqlHKSZDA286ZOt+O/OA0RWWT22BDX0CzaP/m/6ZUHl
uzjR8KVO18x9GelEFbiJbS6Vg6bVhp3UjE0aHHaAAXSInwQxruFSYOsFkzd0N6Tb
DqMU1wVa2lbDCIlyohsk/u5kgHXA/AH+sEo/RWgLkg==
=Ynht
-----END PGP SIGNATURE-----

--BiGl4h+yuagkefzK--

