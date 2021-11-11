Date: Thu, 11 Nov 2021 13:43:23 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <KxokXlUfv2R4lv7nQ0nJteWQyyfhnGK9SC5SdPEbPWeEAEWMv7hG1Xn92K7cDwgIzcL610lylOfv-yISPRmpkIlh2JdbzXGiGQYa78rBZiQ=@protonmail.com>
In-Reply-To: <20211111130051.3674331-1-arne@...1227...>
References: <20210520151148.2565578-7-arne@...1227...>
 <20211111130051.3674331-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_pFbS3IfHORUiXvs2vkSTY1mp0YmpDZziNyA4GdifE1g"
Subject: Re: [Openvpn-devel] [PATCH v4] [OSSL 3.0] Allow loading of non
 default providers
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

This is a multi-part message in MIME format.

--b1_pFbS3IfHORUiXvs2vkSTY1mp0YmpDZziNyA4GdifE1g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

One tiny typo:

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Thursday, November 11th, 2021 at 13:00, Arne Schwabe <arne@...1227...> w=
rote:

> This allows OpenVPN to load non-default providers. This is mainly
>
> useful for loading the legacy provider with --provider legacy default
>
> Patch v4: use spaces to seperate providers, unload providers.
>
> Signed-off-by: Arne Schwabe arne@...1227...
>
> doc/man-sections/generic-options.rst | 10 ++++++++++
>
> src/openvpn/crypto_backend.h | 14 +++++++++++++
>
> src/openvpn/crypto_mbedtls.c | 13 ++++++++++++
>
> src/openvpn/crypto_mbedtls.h | 3 +++
>
> src/openvpn/crypto_openssl.c | 30 ++++++++++++++++++++++++++++
>
> src/openvpn/crypto_openssl.h | 9 +++++++++
>
> src/openvpn/openvpn.c | 13 ++++++++++++
>
> src/openvpn/options.c | 7 +++++++
>
> src/openvpn/options.h | 9 +++++++++
>
> 9 files changed, 108 insertions(+)
>
> diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gene=
ric-options.rst
>
> index e6c1fe455..f5b8a9135 100644
>
> --- a/doc/man-sections/generic-options.rst
>
> +++ b/doc/man-sections/generic-options.rst
>
> @@ -280,6 +280,16 @@ which mode OpenVPN is configured as.
>
> This option solves the problem by persisting keys across :code:`SIGUSR1`
>
> resets, so they don't need to be re-read.
>
> +--provider providers
>
> -   Load the : separated list of (OpenSSL) providers. This is mainly usef=
ul for
> -   using an external provider for key management like tpm2-openssl or to=
 load
> -   the legacy provider with
>
> -   ::
>
> -        --provider "legacy:default"
>
>
>
> --remap-usr1 signal
>
> Control whether internally or externally generated :code:`SIGUSR1` signals
>
> are remapped to :code:`SIGHUP` (restart without persisting state) or
>
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
>
> index 5aab3e1b7..40984c559 100644
>
> --- a/src/openvpn/crypto_backend.h
>
> +++ b/src/openvpn/crypto_backend.h
>
> @@ -78,6 +78,20 @@ void crypto_clear_error(void);
>
> /
>
> void crypto_init_lib_engine(const char engine_name);
>
> +
>
> +/
>
> -   -   Load the given (OpenSSL) providers
> -   -   @param provider name of providers to load
> -   -   @return reference to the loaded provider
> -   */
>
>     +provider_t *crypto_load_provider(const char *provider);
>
> +/**
>
> -   -   Unloads the given (OpneSSL) provider
> -   -   @param provider pointer to the provider to unload
> -   /
>
>     +void crypto_unload_provider(const char provname, provider_t *provide=
r);
>
> #ifdef DMALLOC
>
> /*
>
> -   OpenSSL memory debugging. If dmalloc debugging is enabled, tell
>
>     diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtl=
s.c
>
>     index 08b9e004f..39dbf38a5 100644
>
>     --- a/src/openvpn/crypto_mbedtls.c
>
>     +++ b/src/openvpn/crypto_mbedtls.c
>
>     @@ -69,6 +69,19 @@ crypto_init_lib_engine(const char *engine_name)
>
>     "available");
>
>     }
>
>     +provider_t *crypto_load_provider(const char *provider)
>
>     +{
>
> -   if (provider)
> -   {
> -          msg(M_WARN, "Note: mbed TLS provider functionality is not avai=
lable");
>
>
> -   }
> -   return NULL;
>
>     +}
>
> +void crypto_unload_provider(const char* provname, provider_t provider)
>
> +{
>
> +}
>
> +
>
> /
>
> *
>
> -   Functions related to the core crypto library
>
>     diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtl=
s.h
>
>     index 019de01d1..758ab1b40 100644
>
>     --- a/src/openvpn/crypto_mbedtls.h
>
>     +++ b/src/openvpn/crypto_mbedtls.h
>
>     @@ -48,6 +48,9 @@ typedef mbedtls_md_context_t md_ctx_t;
>
>     /** Generic HMAC %context. /
>
>     typedef mbedtls_md_context_t hmac_ctx_t;
>
>     +/ Use a dummy type for the provider */
>
>     +typedef void provider_t;
>
> /** Maximum length of an IV */
>
> #define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>
> index cc1d62210..ab38d6e5c 100644
>
> --- a/src/openvpn/crypto_openssl.c
>
> +++ b/src/openvpn/crypto_openssl.c
>
> @@ -54,6 +54,9 @@
>
> #if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSIO=
N_NUMBER)
>
> #include <openssl/kdf.h>
>
> #endif
>
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
>
> +#include <openssl/provider.h>
>
> +#endif
>
> #if defined(_WIN32) && defined(OPENSSL_NO_EC)
>
> #error Windows build with OPENSSL_NO_EC: disabling EC key is not supporte=
d.
>
> @@ -149,6 +152,33 @@ crypto_init_lib_engine(const char *engine_name)
>
> #endif
>
> }
>
> +provider_t *
>
> +crypto_load_provider(const char *provider)
>
> +{
>
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
>
> -   /* Load providers into the default (NULL) library context */
>
> -   OSSL_PROVIDER* prov =3D OSSL_PROVIDER_load(NULL, provider);
>
> -   if (!prov)
>
> -   {
>
> -          crypto_msg(M_FATAL, "failed to load provider '%s'", provider);
>
>
> -   }
>
> -   return prov;
>
>     +#else /* OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
>
> -   msg(M_WARN, "Note: OpenSSL hardware crypto engine functionality is no=
t available");
>
> -   return NULL;
>
>     +#endif
>
>     +}
>
>
> +void crypto_unload_provider(const char* provname, provider_t *provider)
>
> +{
>
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
>
> -   if (!OSSL_PROVIDER_unload(provider))
> -   {
> -          crypto_msg(M_FATAL, "failed to undload provider '%s'", provnam=
e);


undload -> unload



>
>
> -   }
>
>     +#endif
>
>     +}
>
> /*
>
> *
>
> -   Functions related to the core crypto library
>
>     diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openss=
l.h
>
>     index e540a76b9..446f08508 100644
>
>     --- a/src/openvpn/crypto_openssl.h
>
>     +++ b/src/openvpn/crypto_openssl.h
>
>     @@ -33,6 +33,10 @@
>
>     #include <openssl/hmac.h>
>
> #include <openssl/md5.h>
>
> #include <openssl/sha.h>
>
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
>
> +#include <openssl/provider.h>
>
> +#endif
>
> +
>
> /** Generic cipher key type %context. /
>
> typedef EVP_CIPHER cipher_kt_t;
>
> @@ -49,12 +53,17 @@ typedef EVP_MD_CTX md_ctx_t;
>
> /* Generic HMAC %context. /
>
> #if OPENSSL_VERSION_NUMBER < 0x30000000L
>
> typedef HMAC_CTX hmac_ctx_t;
>
> +
>
> +/ Use a dummy type for the provider /
>
> +typedef void provider_t;
>
> #else
>
> typedef struct {
>
> OSSL_PARAM params[3];
>
> uint8_t key[EVP_MAX_KEY_LENGTH];
>
> EVP_MAC_CTX ctx;
>
> } hmac_ctx_t;
>
> +
>
> +typedef OSSL_PROVIDER provider_t;
>
> #endif
>
> / Maximum length of an IV */
>
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
>
> index da06f59c2..095d448b0 100644
>
> --- a/src/openvpn/openvpn.c
>
> +++ b/src/openvpn/openvpn.c
>
> @@ -112,10 +112,23 @@ void init_early(struct context c)
>
> / init verbosity and mute levels */
>
> init_verb_mute(c, IVM_LEVEL_1);
>
> -   /* Initialise OpenVPN provider, this needs to be initialised this
>
> -   -   early since option post-processing and also openssl info
> -   -   printing depends on it */
> -   for (int j=3D1; j < MAX_PARMS && c->options.providers.names[j]; j++)
>
> -   {
>
> -          c->options.providers.providers[j] =3D
>
>
> -              crypto_load_provider(c->options.providers.names[j]);
>
>
> -   }
>
>     }
>
>     static void uninit_early(struct context *c)
>
>     {
>
> -   for (int j=3D1; j < MAX_PARMS && c->options.providers.providers[j]; j=
++)
>
> -   {
>
> -          crypto_unload_provider(c->options.providers.names[j],
>
>
> -                                 c->options.providers.providers[j]);
>
>
> -   }
>
>     net_ctx_free(&c->net_ctx);
>
>
> }
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>
> index b5d65d293..87062d58d 100644
>
> --- a/src/openvpn/options.c
>
> +++ b/src/openvpn/options.c
>
> @@ -8157,6 +8157,13 @@ add_option(struct options *options,
>
> options->engine =3D "auto";
>
>          }
>      }
>
>
> -   else if (streq(p[0], "provider") && p[1])
>
> -   {
>
> -          for (size_t j =3D 1; j < MAX_PARMS && p[j] !=3D NULL;j++)
>
>
> -          {
>
>
> -              options->providers.names[j] =3D p[j];
>
>
> -          }
>
>
> -   }
>
>     #endif /* ENABLE_CRYPTO_MBEDTLS */
>
>     #ifdef ENABLE_PREDICTION_RESISTANCE
>
>     else if (streq(p[0], "use-prediction-resistance") && !p[1])
>
>     diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>
>     index 20b34ed4e..d4f41cd71 100644
>
>     --- a/src/openvpn/options.h
>
>     +++ b/src/openvpn/options.h
>
>     @@ -179,6 +179,14 @@ struct remote_list
>
>     struct remote_entry *array[CONNECTION_LIST_SIZE];
>
>     };
>
>     +struct provider_list
>
>     +{
>
> -   /* Names of the providers */
>
> -   const char *names[MAX_PARMS];
>
> -   /* Pointers to the loaded providers to unload them */
>
> -   provider_t *providers[MAX_PARMS];
>
>     +};
>
>
> enum vlan_acceptable_frames
>
> {
>
> VLAN_ONLY_TAGGED,
>
> @@ -519,6 +527,7 @@ struct options
>
> const char *ncp_ciphers;
>
> const char *authname;
>
> const char *engine;
>
> -   struct provider_list providers;
>
>     bool replay;
>
>     bool mute_replay_warnings;
>
>     int replay_window;
>
>     --
>
>     2.33.0
>
>
> Openvpn-devel mailing list
>
> Openvpn-devel@lists.sourceforge.net
>
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJhjR3tACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ0z7gf7BDEY0eogQt1IyxRsviF0xmpbN/vmAZo0Fbkid6DSxQF9IrOv
XiIp3OZl48IlqR1PGcl2uuI71bwcmFfpU2cXjPPEDklqRxBDEr5RVT3a5Zjf
Jd4Kb3n52hzfDpHqak1CNvQpc6aTSyK8fKQzk0cYJRr7JcyU9c+JVVHELU98
eBsEyXCz9IcD/7sX3NpNJS+pKds35SV/TWmOyzzBrPZFOijkE3g03R/cLhxD
YVzIj+3EeewlYLufTNH9yVofUT8B8elKMeCBqij3FWTIh5eYofboG6JuXXQu
KgbOeaM6/djMDWnXcdjg92gkLcRhetOb0vhfck+uSrbrplA6UE1hdg=3D=3D
=3DKyKQ
-----END PGP SIGNATURE-----

--b1_pFbS3IfHORUiXvs2vkSTY1mp0YmpDZziNyA4GdifE1g
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_pFbS3IfHORUiXvs2vkSTY1mp0YmpDZziNyA4GdifE1g
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJhjR3tACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ1LvQf/Y4sA
eAw84EYSlxcvI1JXWp7PhZug7cg7VJATZXm/j3uL/Lu2pif807ThFEbnX5NeJbjQi/PAXMPfJm8I
5c8+L8T0nxU+wNK8OXOM3zOvyis3of0Ylb0QxTvEE3cakyHFjOMwotfw1t2NuL9zSJAs2Jy2Z8sQ
JfRzDm6RSZ3t+R2joJ4NkdCZNpRtpc7Wpg+ezQ3Ji/VdeI8HP9TB/IqDpfCn6aWjCyYsOXflceV5
FgEu2fnHKrOLuUAohzEaKLVvLhOKjboANlo92nwx0VXLkcmXajbZvAdp5KtQxaU/EQwHQrIO6WJk
eQMnWjM/naIjbprxqSkO7VL3sArwGulRWg==

--b1_pFbS3IfHORUiXvs2vkSTY1mp0YmpDZziNyA4GdifE1g--


