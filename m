From: Jeremie Courreges-Anglas <jca@...2272...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...>
 <8760a6kjwc.fsf@...2274...>
Date: Sun, 19 Nov 2017 23:18:04 +0100
In-Reply-To: <8760a6kjwc.fsf@...2274...> (Jeremie Courreges-Anglas's
 message of "Sun, 19 Nov 2017 23:01:39 +0100")
Message-ID: <87vai5kj4z.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19 2017, Jeremie Courreges-Anglas <jca@...2272...> wrote:
> On Sun, Nov 19 2017, Gert Doering <gert@...1296...> wrote:
>> Hi,
>>
>> On Sun, Nov 19, 2017 at 09:37:56PM +0100, Gert Doering wrote:
>>> .. of course this conflicts with o->renegotiate_seconds_min...
>>>=20
>>> Nevertheless, thanks for the patch :-) - it makes my FreeBSD 10.3=20
>>> (mbedTLS 2.6) buildslave now happy again (on the default settings - with
>>> --tls-cert-profile preferred, it refuses the old-hash cert, as it shoul=
d).
>>>=20
>>> Also tested with openssl 1.0.1, where it warns and does nothing, as
>>> expected.  Good :-)
>>
>> I *should* have tested with LibreSSL as well...
>>
>> ssl_openssl.o: In function `tls_ctx_set_cert_profile':
>> /home/buildbot/build-openvpn/build-cron2-openbsd-60-amd64-stable-master-=
-disable -lzo--disable-management/build/src/openvpn/ssl_openssl.c:404:
>> undefined reference to `SSL_CTX_set_security_level'
>> /home/buildbot/build-openvpn/build-cron2-openbsd-60-amd64-stable-master-=
-disable-lzo--disable-management/build/src/openvpn/ssl_openssl.c:400: undef=
ined reference to `SSL_CTX_set_security_level'
>>
>> ... *roll eyes*
>>
>> (Not sure, though, why it only complains about two out of three, but
>> still annoyance...  if LibreSSL claims OPENSSL_VERSION_NUMBER >=3D 0x101=
00000
>> it better should provide everything needed)
>
> LibreSSL defines:
>
>   #define OPENSSL_VERSION_NUMBER        0x20000000L
>
> breaking #ifdef checks based on it.  Sadly, people tend to prefer adding
>
>   && !defined(LIBRESSL_VERSION_NUMBER)
>
> to fix the build, rather than doing features detection using autoconf or
> similar.  openvpn can easily solve this.
>
>> This is on OpenBSD 6.0, which happens to be something Samuli's vagrant
>> setup can provide nicely if anyone wants to have a look :-)
>
> Here's a diff, master builds and seems to run fine as a client on
> OpenBSD-current.
>
> I can cook a similar diff for the remaining OPENSSL /
> LIBRESSL_VERSION_NUMBER #ifdef.

Here's another diff to detect SSL_CTX_get0_certificate().

Tested against LibreSSL only; adding

  #define HAVE_SSL_CTX_GET0_CERTIFICATE 1

to config.h lets ssl_openssl.c build (with a warning), the link fails as
expected.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Detect-if-SSL_CTX_get0_certificate-is-available.patch
Content-Transfer-Encoding: quoted-printable

From=201abd6089a45260e4ce7adfae3fa619f9055edcaf Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Sun, 19 Nov 2017 23:12:30 +0100
Subject: [PATCH] Detect if SSL_CTX_get0_certificate is available

Don't rely on #ifdef OPENSSL/LIBRESSL_VERSION_NUMBER checks.

Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
=2D--
 configure.ac              | 1 +
 src/openvpn/ssl_openssl.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index acfddb22..ac6e7a76 100644
=2D-- a/configure.ac
+++ b/configure.ac
@@ -925,6 +925,7 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypto_=
library}" =3D "openssl"; then
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
+			SSL_CTX_get0_certificate \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
 			SSL_CTX_set_security_level \
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b782946e..3df70166 100644
=2D-- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -425,7 +425,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
=20
     ASSERT(ctx);
=20
=2D#if OPENSSL_VERSION_NUMBER >=3D 0x10002000L && !defined(LIBRESSL_VERSION=
_NUMBER)
+#ifdef HAVE_SSL_CTX_GET0_CERTIFICATE
     /* OpenSSL 1.0.2 and up */
     cert =3D SSL_CTX_get0_certificate(ctx->ctx);
 #else
@@ -460,7 +460,7 @@ tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
     }
=20
 cleanup:
=2D#if OPENSSL_VERSION_NUMBER < 0x10002000L || defined(LIBRESSL_VERSION_NUM=
BER)
+#ifndef HAVE_SSL_CTX_GET0_CERTIFICATE
     SSL_free(ssl);
 #endif
     return;
=2D-=20
2.15.0


--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAloSAxwACgkQDfp0rhUk
5+7DnA//QyP1fIvxvcYP9uTMofg/NjZ/MiIj1C0qgtB6AUnkKEwaRV97LH1DDPJ+
f3clC5Fnr1h5Itfx7HzUI1omde0vELvT2qpHZQ61TII6JjCOBT41ZfmuUVZpa6As
uvFzF2q3l1zX2U10nPYSIjU+cpnL8OvPZkSrQZsVqZ3oB1few78b7f1fWiYzJ/wx
Ku+MOEVTH/+Po1put6QeBxuw/hmCsiMbQxbb4qoStlEfL68RdwnV/QBfeXtjEvDV
mQNsU4iXM3jfp/L+xIZGXs/YaAbvMfpufKrV/PMvacTDZ47Mb0UMmX/gorFOtl1w
U0LrLhasoJ+57LQRWWrH9dtAnKPzS+/47+t0UKX70lFWBVwqNsHyds2pHSYXz8rQ
oZZX5ZNDMORj0Q4pYq34g8yjEhydmLviqtA2HHOgouUvBtNNydCsP7kkZo5L6chz
xRenTYiIrXZuspBwhS4e470FBtsxAUEL7Ia2es3VIYsb9m+sZjyQUiLz5RSuiUff
+Ugigd2b0gtqE1GXtUxQa1PWdNGw0Gonz+i0aocL6A7bMfBkju6qvxGsLqJjDxai
Xo5D7IsIDs2n6coRXuDTIKZBxPoeEfWhuPIrJcqdRZPnPYqUQWtFgsHtOcfoutaj
PnjgyimBi1Ni0HcfpLMbErERrEN4qUIhK8gge8D6+T0DNa5nteE=
=Cv9v
-----END PGP SIGNATURE-----
--==-=-=--

