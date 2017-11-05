From: Jeremie Courreges-Anglas <jca@...2272...>
References: <87k1zi18lt.fsf@...2274...>
 <201711041834.vA4IYfGA026870@...2054...>
Date: Sun, 05 Nov 2017 10:14:03 +0100
In-Reply-To: <201711041834.vA4IYfGA026870@...2054...> (Gert
 Doering's message of "Sat, 4 Nov 2017 19:34:41 +0100 (CET)")
Message-ID: <87375t6qas.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Print time_t as long long
 and suseconds_t as long
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04 2017, Gert Doering <gert@...1296...> wrote:
> ACK, thanks.  Reviewed by "staring at the code" (changes are only what it
> says on the tin), compiling with clang and gcc (no format related warning=
s),
> and running tests, of course :-)

Cool, thank you for your time.

> I'm a bit undecided whether this should go to release/2.4 as well, as it
> is "refactoring" and our general policy is "refactoring goes into master"
> (but then it's straightforward enough).  Leaving it in master for now,=20
> but I can be convinced that we want this in 2.4...

FWIW I'm fine with whatever approach you prefer.  openvpn-2.5.0 will
hopefully be released before 2038. :)

Here's another small diff, I forgot one suseconds_t occurrence.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Cast-and-print-another-suseconds_t-as-long.patch
Content-Transfer-Encoding: quoted-printable

From=20cbe8237ff59129501e1e92c8fd6a3488d94c4c0f Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Sun, 5 Nov 2017 10:03:26 +0100
Subject: [PATCH] Cast and print another suseconds_t as long

Missed in 31b5c0e
=2D--
 src/openvpn/forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a91a8d9a..1b7455bb 100644
=2D-- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -649,7 +649,7 @@ check_timeout_random_component_dowork(struct context *c)
     c->c2.timeout_random_component.tv_usec =3D (time_t) get_random() & 0x0=
003FFFF;
     c->c2.timeout_random_component.tv_sec =3D 0;
=20
=2D    dmsg(D_INTERVAL, "RANDOM USEC=3D%d", (int) c->c2.timeout_random_comp=
onent.tv_usec);
+    dmsg(D_INTERVAL, "RANDOM USEC=3D%ld", (long) c->c2.timeout_random_comp=
onent.tv_usec);
 }
=20
 static inline void
=2D-=20
2.14.3


--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAln+1lsACgkQDfp0rhUk
5+7XqRAAmbd6dd6Q3zwm2zlTECbB9N8uhOgthpKrZtTQ78PFZBZPKOrFVqLQDjrF
i2ONeaTtark4TE1sJPw8Z42ZXAEpYPorB/FowX1tucPHGPK3FoIIRCPBFjU/o3JD
9YuKUDZr1lyAY/2kOAYKE/6SsohNF/NGJ9TXvMaErzF/ORY+D8p5iXORq6WSqlmu
zh/LnyJSYdOalzrSPJHzrIqOgUMT3BPrB5iugXnrRhdQv+GBiW5HYUwg8P/S2B35
Ho02D9gZ1iic7IJ3CoGtyv7i2yfzGUJ+m/s/eqPBFOhwI0tdxlLrSACmbF2WWYa2
/3BV7NMqAB4+p4JEUf/0cA7NOBc5iOG0X8clFCFF7IcOYyngwBCVHbcizCNRN5ou
Yl3Opg0MPXa8gt3kdszLVs/jf9JSymKI6HAAugSnuGFWlm+BOdrGYwcS0iNPYN9R
qexQTec+zBAiCU6jhhFC0sHHuHxOlN98Wq5L2inFU9V+HHps+agBl31+lS8xjWWQ
VSrNWJNirTKu+zxd5Os5TwQu3Kbv9UONayhkSt3HiKPV5/TwLYpmamWEQdkGsV+J
lchGvOTE4LpOeBgQj2UfG+MZZZuNU6xzDEdl+VsZG9pyDwyUBwRXBMwx+udTuhFH
UcaDHUEVwK5DhNffStfaGTQqis9r37/rOLJakwNnevQkt1T/nv8=
=qjS3
-----END PGP SIGNATURE-----
--==-=-=--

