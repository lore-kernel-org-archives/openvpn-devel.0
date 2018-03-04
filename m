From: Jeremie Courreges-Anglas <jca@...2272...>
References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
 <20180304161716.GN69387@...1296...>
 <87d10jkctn.fsf@...2274...>
 <CAKuzo_iMnsbUsu9N7LDX+h9AYNrtmAvr2dY7iumrP0bVcXguPA@...278...>
Date: Sun, 04 Mar 2018 23:23:16 +0100
Message-ID: <87inab32gb.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Mina Barret <mina.barret@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04 2018, Selva Nair <selva.nair@...277...> wrote:

[...]

> Libressl developers break API compatibility with openssl in such
> perverse ways that there are no easy ways to support it. Take, for
> example, the patch I just sent out which checks for certain functions
> instead of disabling using LIBRESSL_VERSION_NUMBER. It finds two "set"
> functions defined in libressl but two related "get" ones are not
> found. So the compat layer will get used for those. But there is no
> guarantee that such mixed usage leads to logically correct code. In
> fact, the compat layer functions for min/max proto-version are not the
> same as those in openssl 1.1. Those are a work around meant for
> cleanly handling multiple versions of openssl without using ifdefs all
> over the code. If libressl has implemented those set functions as in
> openssl 1.1, then those get functions from compat layer would not be
> what you should be using, but that's what you will get.

I'd like to add more details here.

At the time LibreSSL added the setters (May 2017)[1], OpenSSL itself
only provided said setters (since 2015)[2].  The getters were added to
OpenSSL later (Sep 2017)[3].

[1] https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/lib/libssl/ssl.h.diff?r1=
=3D1.127&r2=3D1.128
[2] https://github.com/openssl/openssl/commit/7946ab33cecce60afcc00afc8fc18=
f31f9e66bff
[3] https://github.com/openssl/openssl/commit/3edabd3ccb7aac89af5a63cfb2378=
e33a8be05d7

So I don't think the current situation can be summed up as a plain
oversight or bad design choice.

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlqccdUACgkQDfp0rhUk
5+4C2A/9GYvELSjwwwWHdW+fE3x6OoTTMuQZTiUH4qzGFkIpWt3c8hMRnmdMkrHk
9tjNOg2cPfhj7JEdzythdgbyDu4ZHWvljBOVmJYinmPPOgQwJkT3cauqz/k4k92D
Ewif72mwZ6qXaP1RBPT2MTJO+AcTEbz8g5XIYfI2Sdcgy3OLAhqwN1UnVDUJomnL
gmOTAAdrkAwHQsWHoK2XfqJl4LWRRf/KtD1Lgm4adHaP74wIbqVK1uF5wTgv+Qjg
flLlLNkIuF72omdOIhPJsPl/4v/q4BV4qr2LmpowKWPZc53t8fFn2g1S2wsikd10
YBuDFbGomWltIa1/wxQKWu8iYkeHksx3TXfadVQM+D+xcUjIwPoGzDDBcV3RYhAW
D/nTA9irMNri4ULDKu6rwtHeu5N6ZNwVwhjwEb5QSrlbgu5jaRnApDi6ZWKsl8Ct
nJ00nSBHtcORrpABF9RGcmxwCEFVGZtQO9z+Nye6vAa7pHpAQ/m0bU+GO8hniSV6
ie82XDOR81oqsTvxC7SkOG9Zg52X3KQs12Y9iuhGCfH8cVA10sLUp/ioyGvK3UU2
0mayTmZxn6wCzOlk2xqTRAAkmvH0or9snAp8a7XqB4BuOK46TYadLwu1eBUvzPXI
OunYM5EW+mVjsmBWFgWZIRRaiNBuEfUy3K23jyuWqfP3IL4/upw=
=W8wf
-----END PGP SIGNATURE-----
--=-=-=--

