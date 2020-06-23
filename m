Date: Tue, 23 Jun 2020 09:21:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623072123.GA2034@...1296...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <202006230628.05N6Sa3g001325@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 08:28:36AM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Tested on :
>  - MacOS Mojave with OpenSSL 1.1.1c (brew) and out-of-tree build, works.
>  - Linux with mbedtls (does not try engine tests, good :-) )
>  - Linux with OpenSSL 1.1.1, works
>  - FreeBSD 11.3 with OpenSSL 1.0.2s -> v6 fails, v6 works \o/
>=20
> Conferred with Arne, we agreed on "this is good enough, and who wants=20
> something more sophisticated is welcome to send more patches".

Oh well.  We do need another round - Travis tells me that "make distcheck"
is failing.  Which hints at "autoconf is not told what to pack in the
tarball"

https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158155
...
make[6]: Entering directory '/home/travis/build/OpenVPN/openvpn/openvpn-2.5=
_git/_build/sub/tests/unit_tests/engine-key'
3672make[6]: *** No rule to make target '../../../../../tests/unit_tests/en=
gine-key/openssl.cnf.in', needed by 'openssl.cnf'.  Stop.
3673make[6]: Leaving directory '/home/travis/build/OpenVPN/openvpn/openvpn-=
2.5_git/_build/sub/tests/unit_tests/engine-key'
3674

(so now the source file is missing)

Please... :-9

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8a1zAAoJEB2Cnv7KVigSmHAL+wTNS2nBQ5mLmQrUEBjLvWxu
ls4OG4n/6a2qvpj16NTXcKYR98nCn0v1QEBz4htENEoZXyf8By36Uh1v+WM8lp7E
y5nVOvI3P4YYJdABTwABu3TQ2HrQHGDUBPM0Aqf6AFHTvuGCJEBcsSbMwGUw7oBs
tF0+7anz14zDT/VTe9yv1HzKUjFVC7skVlTq7ZzICs939pmupmI9XHeSZ0MhUNJb
bT250BHiUdN5tlx3fca6LvPzpmUeVXG3U67rW9CgcoPsLSPo/jwa70j762NMLkEK
wccl558c0ZIKSw/cBqCbzjWcJpJrSqwcnOb+VyKkM+TwdkO6nxbQIA4hoOP3QLrt
nAL4FpHc2pyOJjJcMUQI7EjKwgsAIyHhEHylSZoFP7eBbpJewf8zYzJtwJ5khxAH
5JKLejwJWqTUkH5//L9J/8SAT7bEEemh/Vnv9hu0N0Kze6+z0v/jpNpE2gqTqVHP
my0GC/uLTsBBmDCKS95w+tDtlbAYfRM41JJIkgZlBg==
=Ggev
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

