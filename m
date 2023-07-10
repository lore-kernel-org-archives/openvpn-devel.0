Date: Mon, 10 Jul 2023 17:56:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZKwqOENpY1rpBM2X@...1296...>
References: <20230707185811.30132-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qSYQnOPuHX1ViY/4"
Content-Disposition: inline
In-Reply-To: <20230707185811.30132-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] show extra info for OpenSSL errors
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

--qSYQnOPuHX1ViY/4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 07, 2023 at 08:58:11PM +0200, Arne Schwabe wrote:
> This also shows the extra data from the OpenSSL error function that
> can contain extra information. For example, the command
>=20
>     openvpn --providers vollbit
>=20
> will print out (on macOS):
>=20
>      OpenSSLerror:12800067:DSO support routines::could not load the share=
d library:filename(/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl=
-modules/vollbit.dylib): dlopen(/opt/homebrew/Cellar/openssl@...1554.../3.1=
.1_1/lib/ossl-modules/vollbit.dylib, 0x0002): tried: '/opt/homebrew/Cellar/=
openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such file), =
'/System/Volumes/Preboot/Cryptexes/OS/opt/homebrew/Cellar/openssl@...2738...=
./3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such file), '/opt/homebrew/Ce=
llar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such fi=
le)

Feature-ACK on providing more detail, because otherwise these errors
can get really hard to track down.

Your example above is somewhat excessive on repeating paths, but I do
not see this on my FreeBSD test case

$ src/openvpn/openvpn --providers legacyXX default --show-tls
2023-07-10 17:44:27 OpenSSLerror:12800067:DSO support routines::could not l=
oad the shared library:filename(/usr/lib/ossl-modules/legacyXX.so): /usr/li=
b/ossl-modules/legacyXX.so: Undefined symbol "ossl_md4_functions"
2023-07-10 17:44:27 OpenSSLerror:12800067:DSO support routines::could not l=
oad the shared library:
2023-07-10 17:44:27 OpenSSLerror:07880025:common libcrypto routines::reason=
(524325):name=3DlegacyXX

"this is just the right amount of details" :-) - for something that
does not exist, I get

2023-07-10 17:45:17 OpenSSLerror:12800067:DSO support routines::could not l=
oad the shared library:filename(/usr/lib/ossl-modules/legacyYY.so): Cannot =
open "/usr/lib/ossl-modules/legacyYY.so"


Code-wise, I would prefer to have someone who understands OpenSSL give
this another look...  Selva, Antonio?  Thanks :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qSYQnOPuHX1ViY/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkrCo4AAoJEB2Cnv7KVigSbOcL/jb5C0KBocRFlekCzB/OBjDy
LQrGkKgJcP9IxGDsHnGy/XTCog5sgF4oGi0a5AR+NFKzGLO/gpgCQG0dRqlkrvIX
ZBh9Cq2r4ndwnG1xfUIOlXbwUEPDtKX64qo8BgcIwkUQEWNr81o05yyUujem/BuG
jWp5Xq03Nl/7696gs3+iWeYtF05qDdfDaADZ+v/CLxo5vE06XVK8P1+fp77naMxU
Ifh2deXZrpkcfVz/RROWm8D5b1/TGakKOxRRCqyMk4OVEQ+gpOZC4+CoixIaBOGi
m3K3bp7vsh1W5zmHsA0ou6PuFtwc9bYkSPgS2uQl3DwiyNpbA0dQ69WMNmYGDq0Q
dPAeC268GE4VzkcJwTyEyyVsuU/+QLx0YK6ewkqGln55BVJLExY7PyCVuD+gbHIH
KBaalrtcNdiP5ilDqSkSgGouNy12Gvdk6navJwFJwBIDr3bsc2z1k8kIqQzHzufd
qIwfSRsEfWO/as6/z9ar0aKsuSMeYvYmObkHYoCKlA==
=n62D
-----END PGP SIGNATURE-----

--qSYQnOPuHX1ViY/4--

