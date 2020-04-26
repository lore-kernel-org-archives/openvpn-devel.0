Date: Sun, 26 Apr 2020 11:56:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200426095635.GY1431@...1296...>
References: <20200426095402.65047-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ilwtao6+P+Teod98"
Content-Disposition: inline
In-Reply-To: <20200426095402.65047-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Uncrustify the tests/unit_tests/ part
 of our tree.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ilwtao6+P+Teod98
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 26, 2020 at 11:54:02AM +0200, Gert Doering wrote:
> Apply uncrustify 0.70.1 (FreeBSD port) with our rules to that part
> of the tree, which followed a more compact coding style so far.

Just as a remark: the coding style in tests/unit_tests is fairly
consistent, just *different*.

We can apply the same rules, or we can define a "more compact" ruleset,
which is sometimes more important for tests ("I want to see what the
test is doing, not stare at pages of { } lines").

So this is more out for discussion than for "please apply this patch".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ilwtao6+P+Teod98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJepVrSAAoJEB2Cnv7KVigSoUoL/A4zftEPXqLEk0e+P8XDWqXw
dbbq4pyg+uQNMzpKkiq7DWcJ+/TDmGRpE1q9TAhERu1Wwp9bmhTTjih8gGHhAL+0
Cf5LsVHCPKUzBvcDclknehKQKORM7+gf6cKcLOA16H4JzEjOKlQEJ2lUECuJsxb5
7nOPdTaLLKS4Qevy/zPcnjoTMAtsuUE+PXKezzfQU8aaiOQCCdtcyt8hXvm+kcny
l6xbVPr+9xIWzufG3I+FbrWCcyfQ2FOOdL7fB1czu8dFFIdEQ7+KSHBbWhKh0NUU
a4Y92bcwgmhMZrvcCOcoMeaGzxyXmmjX/Xx/jdzswkKH28qEw8OJ1cdOssq7ereK
Nt+0NLxyhVLuYgJ4cv7V21/cGsOOmh7GsNpYdLpw/Sv4LYZ2d4iW9G6ezXkX4XCz
OLquenX5USvJUB9bMhVJXgrFrWrzBtfEscAN7iNi/sgVJHZSFHuuPUU8rSqcOY0e
NpcgrqC+Z7EbNeLqhx6YedB5qfu0JRXYNDDFX9Myjg==
=lbiA
-----END PGP SIGNATURE-----

--ilwtao6+P+Teod98--

