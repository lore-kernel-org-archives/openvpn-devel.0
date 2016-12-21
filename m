References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
Date: Wed, 21 Dec 2016 22:09:17 +0100
MIME-Version: 1.0
In-Reply-To: <1482085616-17149-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2OF5Wx05TdeEs72qXgMArEDwrMRtKRohV"
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
 crypto*.{c, h}
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2OF5Wx05TdeEs72qXgMArEDwrMRtKRohV
Content-Type: multipart/mixed; boundary="f4AsfQEgDN0AQavNrEKeiQP6S8Ud8iJ0s";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in crypto*.{c, 
	h}
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
In-Reply-To: <1482085616-17149-1-git-send-email-steffan@...1856...>

--f4AsfQEgDN0AQavNrEKeiQP6S8Ud8iJ0s
Content-Type: multipart/mixed; boundary="------------E0FCE3BF2F880A7C77C04E40"

This is a multi-part message in MIME format.
--------------E0FCE3BF2F880A7C77C04E40
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 18/12/16 19:26, Steffan Karger wrote:
> Now that we have touched each and every file anyway, I decided to go over
> the code I regularly work with and reformat it some more by hand.  This is
> how for I got today, and is a large enough patch I think.
>=20
> This commit is mostly just reordering and changing whitespace, with one
> exception: it removes the #if 0 around some debugging code in
> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
> enabled.
>=20
> This patch is best reviewed with something like
> 'git diff --ignore-space-change'.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
>=20
>  src/openvpn/crypto.c         | 425 ++++++++++++++++++++++---------------=
------
>  src/openvpn/crypto.h         |  27 ++-
>  src/openvpn/crypto_mbedtls.c |  63 ++++---
>  src/openvpn/crypto_openssl.c |  38 ++--
>  src/openvpn/cryptoapi.c      | 101 ++++++----
>  5 files changed, 356 insertions(+), 298 deletions(-)
>=20
[...snip...]

Hmmm ... I like that we're trying to clean up the formatting further.
But I'm not too happy that uncrustify seems to disagree slightly ...
See the attached patch what happened after applying your patch and then
running:

   $ uncrustify --no-backup -l C $files

We should either see if our uncrustify config is correct or need slight
adjustments (without needing to re-run it on the complete tree once again)


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------E0FCE3BF2F880A7C77C04E40
Content-Type: text/x-patch;
 name="uncrustify-changes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="uncrustify-changes.patch"

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 06e7b7e..a665648 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -268,9 +268,9 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer =
work,
             {
                 struct packet_id_net pin;
                 packet_id_alloc_outgoing(&opt->packet_id.send, &pin,
-                        BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM));=

+                                         BOOL_CAST(opt->flags & CO_PACKE=
T_ID_LONG_FORM));
                 ASSERT(packet_id_write(&pin, buf,
-                        BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM), =
true));
+                                       BOOL_CAST(opt->flags & CO_PACKET_=
ID_LONG_FORM), true));
             }
             if (ctx->hmac)
             {
@@ -570,7 +570,7 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer =
work,
=20
             /* initialize work buffer with FRAME_HEADROOM bytes of prepe=
nd capacity */
             const int work_headroom =3D
-                    FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECR=
YPT);
+                FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)=
;
             ASSERT(buf_init(&work, work_headroom));
=20
             /* use IV if user requested it */
@@ -718,7 +718,7 @@ openvpn_decrypt(struct buffer *buf, struct buffer wor=
k,
=20
 void
 crypto_adjust_frame_parameters(struct frame *frame, const struct key_typ=
e *kt,
-        bool use_iv, bool packet_id, bool packet_id_long_form)
+                               bool use_iv, bool packet_id, bool packet_=
id_long_form)
 {
     size_t crypto_overhead =3D 0;
=20
@@ -840,7 +840,7 @@ init_key_type(struct key_type *kt, const char *cipher=
name,
 /* given a key and key_type, build a key_ctx */
 void
 init_key_ctx(struct key_ctx *ctx, struct key *key, const struct key_type=
 *kt,
-        int enc, const char *prefix)
+             int enc, const char *prefix)
 {
     struct gc_arena gc =3D gc_new();
     CLEAR(*ctx);
@@ -1101,7 +1101,7 @@ test_crypto(struct crypto_options *co, struct frame=
 *frame)
 #ifdef HAVE_AEAD_CIPHER_MODES
     /* init implicit IV */
     const cipher_kt_t *cipher =3D
-            cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
+        cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
     if (cipher_kt_mode_aead(cipher))
     {
         size_t impl_iv_len =3D cipher_kt_iv_size(cipher) - sizeof(packet=
_id_type);
@@ -1114,7 +1114,7 @@ test_crypto(struct crypto_options *co, struct frame=
 *frame)
         co->key_ctx_bi.encrypt.implicit_iv_len =3D impl_iv_len;
=20
         memcpy(co->key_ctx_bi.decrypt.implicit_iv,
-                co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGT=
H);
+               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH=
);
         co->key_ctx_bi.decrypt.implicit_iv_len =3D impl_iv_len;
     }
 #endif /* ifdef HAVE_AEAD_CIPHER_MODES */
@@ -1172,8 +1172,8 @@ test_crypto(struct crypto_options *co, struct frame=
 *frame)
=20
 void
 crypto_read_openvpn_key(const struct key_type *key_type, struct key_ctx_=
bi *ctx,
-        const char *key_file, const char *key_inline, const int key_dire=
ction,
-        const char *key_name, const char *opt_name)
+                        const char *key_file, const char *key_inline, co=
nst int key_direction,
+                        const char *key_name, const char *opt_name)
 {
     struct key2 key2;
     struct key_direction_state kds;
@@ -1419,7 +1419,7 @@ read_key_file(struct key2 *key2, const char *file, =
const unsigned int flags)
     for (int i =3D 0; i < (int) SIZE(key2->keys); ++i)
     {
         const char *fmt =3D format_hex_ex((const uint8_t *)&key2->keys[i=
],
-                sizeof(key2->keys[i]), 0, 16, "\n", &gc);
+                                        sizeof(key2->keys[i]), 0, 16, "\=
n", &gc);
         dmsg(D_SHOW_KEYS, "[%d]\n%s\n\n", i, fmt);
     }
=20
@@ -1715,7 +1715,7 @@ prng_reset_nonce()
         msg(M_FATAL,
             "ERROR: Random number generator cannot obtain entropy for PR=
NG");
     }
-#else
+#else  /* if 1 */
     /* Only for testing -- will cause a predictable PRNG sequence */
     {
         int i;
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2f66e33..f8405bd 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -150,9 +150,9 @@ print_cipher(const cipher_kt_t *info)
                  ))
     {
         const char *ssl_only =3D
-                cipher_kt_mode_cbc(info) ? "" : ", TLS client/server mod=
e only";
+            cipher_kt_mode_cbc(info) ? "" : ", TLS client/server mode on=
ly";
         const char *var_key_size =3D info->flags
-                & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ? " by default" : "";
+                                   & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ? "=
 by default" : "";
=20
         printf("%s  (%d bit key%s, %d bit block%s)\n",
                cipher_kt_name(info), cipher_kt_key_size(info) * 8, var_k=
ey_size,
@@ -421,7 +421,7 @@ cipher_kt_get(const char *ciphername)
     {
         msg(D_LOW,
             "Cipher algorithm '%s' uses a default key size (%d bytes) wh=
ich is "
-            "larger than "PACKAGE_NAME"'s current maximum key size (%d b=
ytes)",
+            "larger than "PACKAGE_NAME "'s current maximum key size (%d =
bytes)",
             ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
         return NULL;
     }
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 5beac36..0d40312 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -87,25 +87,25 @@
=20
 static ERR_STRING_DATA CRYPTOAPI_str_functs[] =3D {
     { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),
-            "microsoft cryptoapi"},
+      "microsoft cryptoapi"},
     { ERR_PACK(0, CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE, 0),
-            "CertOpenSystemStore" },
+      "CertOpenSystemStore" },
     { ERR_PACK(0, CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE, 0),
-            "CertFindCertificateInStore" },
+      "CertFindCertificateInStore" },
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY, 0),=

-            "CryptAcquireCertificatePrivateKey" },
+      "CryptAcquireCertificatePrivateKey" },
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_CREATE_HASH, 0),
-            "CryptCreateHash" },
+      "CryptCreateHash" },
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_GET_HASH_PARAM, 0),
-            "CryptGetHashParam" },
+      "CryptGetHashParam" },
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SET_HASH_PARAM, 0),
-            "CryptSetHashParam" },
+      "CryptSetHashParam" },
     { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),
-            "CryptSignHash" },
+      "CryptSignHash" },
     { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),
-            "LoadLibrary" },
+      "LoadLibrary" },
     { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),
-            "GetProcAddress" },
+      "GetProcAddress" },
     { 0, NULL }
 };
=20
@@ -308,7 +308,7 @@ rsa_priv_enc(int flen, const unsigned char *from, uns=
igned char *to, RSA *rsa, i
 /* decrypt */
 static int
 rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA=
 *rsa,
-        int padding)
+             int padding)
 {
     /* I haven't been able to trigger this one, but I want to know if it=
 happens... */
     assert(0);
@@ -537,7 +537,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, c=
onst char *cert_prop)
         goto err;
     }
     /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa=
', so
-     * we decrease it here with RSA_free(), or it will never be cleaned =
up. */
+    * we decrease it here with RSA_free(), or it will never be cleaned u=
p. */
     RSA_free(rsa);
     return 1;
=20

--------------E0FCE3BF2F880A7C77C04E40--

--f4AsfQEgDN0AQavNrEKeiQP6S8Ud8iJ0s--

--2OF5Wx05TdeEs72qXgMArEDwrMRtKRohV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYWu99AAoJEIbPlEyWcf3yA5wP/1Mv7RjBA6Ra/pQlj6FKMNUV
Dn54HiD5HS4erK3lfeXfhDqlA8w5d4RH4jg/dGvXNwhwHOf4UYvrqJ33yc9GTck5
PX5uN0F057EUTCfih7UGRHrrhM6tJpwd7jFxoFbiH1o22tnMO3jggMHYoB92P2a7
UHvzBI19s9wkNoBnEMSfudwF56CPH1fsgFdQolBlXwX/0+Ak+6mpSRRTcmfcs3ee
1gklte27C33UiYjqOsKHyulaNrOaPikr7GVM+fojZFZ4O08i8OwV2UkJZHNkqhDA
+MBGMOQxuI6123pMNnGAP+d1jtQIXS7fd2ykKQSW/lTvd4y410w80w+bh+PxXOVD
Ii5rs8CQnEUMKtRVR6yr8BSkDrsU4gEuF2Wew8uQlVamf0SPHHzHCXIy1EYbreV2
ll6DiSFFF5D9eBpmWVc2VMfH5lCfQhKjZ7nILUsvxUDWNhkAeCr7aPUv02Sw4zPN
BLkyFVPFMtMTJAQYijEtoeESHbc+3+D7b/eUQRXrldYI21a0kP07uVQ63dqV20vG
46B0eyOzkxXmm12fR2p6MoBAxbu9kcPcUqHbkxvFhiMoEyKr0vjyroTseCmIx6Vf
Rj9qbJb6X8TXr8lEjqJ/YmhEx99JoeZIdpR5E+W6+NZ6yPDmzMcYP03juW8fjqKt
UJCgv8wfzn0FpSe0L3P+
=4CMy
-----END PGP SIGNATURE-----

--2OF5Wx05TdeEs72qXgMArEDwrMRtKRohV--

