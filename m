MIME-Version: 1.0
References: <20220510113055.1829260-1-arne@...1227...>
In-Reply-To: <20220510113055.1829260-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 May 2022 13:40:44 -0400
Message-ID: <CAKuzo_iZCs0HoNjpa2PAJc=u_8T+7jm8RkVE5wSch_3cma_JAw@...278...>
Content-Type: multipart/alternative; boundary="000000000000cc007605debff1a7"
Subject: Re: [Openvpn-devel] [PATCH] Implement ED448 and ED25519 support in
 xkey_provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cc007605debff1a7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, May 10, 2022 at 7:32 AM Arne Schwabe <arne@...1227...> wrote:

> OpenSSL's implementation of ED448 and ED25519 has a few idiosyncrasies.
> Instead of belonging to the eliptic curve type or to a common Edwards
> curve type, ED448 and ED25519 have each their own type.
>
> Also, OpenSSL excepts singatures using these curves to be done with the
>

expects
signatures

(good to know I'm not the only one afflicted by transposition errors)


> EVP_DigestSign API instead of the EVP_Sign API but using md=NULL.

This has been tested using a "fake" external key that used a normal
> software key instead of a hardware implementation but that makes no
> difference from the perspective of xkey_provider/managment interface.
>

management


> ---
>  src/openvpn/xkey_helper.c                |   4 +
>  src/openvpn/xkey_provider.c              | 121 +++++++++++++++++++++--
>  tests/unit_tests/openvpn/test_provider.c |  21 ++--
>  3 files changed, 134 insertions(+), 12 deletions(-)
>
> diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
> index ecc7b1204..d59b16858 100644
> --- a/src/openvpn/xkey_helper.c
> +++ b/src/openvpn/xkey_helper.c
> @@ -206,6 +206,10 @@ xkey_management_sign(void *unused, unsigned char
> *sig, size_t *siglen,
>              openvpn_snprintf(alg_str, sizeof(alg_str),
> "ECDSA,hashalg=%s", alg.mdname);
>          }
>      }
> +    else if(!strcmp(alg.keytype, "ED448") || !strcmp(alg.keytype,
> "ED25519"))
> +    {
> +        strncpynt(alg_str, alg.keytype, sizeof(alg_str));
> +    }
>      /* else assume RSA key */
>      else if (!strcmp(alg.padmode, "pkcs1") && (flags &
> MF_EXTERNAL_KEY_PKCS1PAD))
>      {
> diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
> index 46e57e0fe..e8ac3904b 100644
> --- a/src/openvpn/xkey_provider.c
> +++ b/src/openvpn/xkey_provider.c
> @@ -99,12 +99,28 @@ typedef struct
>      int refcount;                /**< reference count */
>  } XKEY_KEYDATA;
>
> -static int
> -KEYTYPE(const XKEY_KEYDATA *key)
> +static inline const char *
> +get_keytype(const XKEY_KEYDATA *key)
>  {
> -    return key->pubkey ? EVP_PKEY_get_id(key->pubkey) : 0;
> +    int keytype = key->pubkey ? EVP_PKEY_get_id(key->pubkey) : 0;
> +
> +    switch (keytype)
> +    {
> +        case EVP_PKEY_RSA:
> +            return "RSA";
> +
> +        case EVP_PKEY_ED448:
> +            return "ED448";
> +
> +        case EVP_PKEY_ED25519:
> +            return "ED25519";
> +
> +        default:
> +            return "EC";

+    }
>  }
>
> +
>  static int
>  KEYSIZE(const XKEY_KEYDATA *key)
>  {
> @@ -310,6 +326,22 @@ ec_keymgmt_import(void *keydata, int selection, const
> OSSL_PARAM params[])
>      return keymgmt_import(keydata, selection, params, "EC");
>  }
>
> +static int
> +ed448_keymgmt_import(void *keydata, int selection, const OSSL_PARAM
> params[])
> +{
> +    xkey_dmsg(D_XKEY, "entry");
> +
> +    return keymgmt_import(keydata, selection, params, "ED448");
> +}
> +
> +static int
> +ed25519_keymgmt_import(void *keydata, int selection, const OSSL_PARAM
> params[])
> +{
> +    xkey_dmsg(D_XKEY, "entry");
> +
> +    return keymgmt_import(keydata, selection, params, "ED25519");
> +}
> +
>  /* This function has to exist for key import to work
>   * though we do not support import of individual params
>   * like n or e. We simply return an empty list here for
> @@ -449,7 +481,7 @@ keymgmt_import_helper(XKEY_KEYDATA *key, const
> OSSL_PARAM *params)
>          ASSERT(pkey);
>
>          int id = EVP_PKEY_get_id(pkey);
> -        if (id != EVP_PKEY_RSA && id != EVP_PKEY_EC)
> +        if (id != EVP_PKEY_RSA && id != EVP_PKEY_EC && id !=
> EVP_PKEY_ED25519 && id != EVP_PKEY_ED448)
>          {
>              msg(M_WARN, "Error: xkey keymgmt_import: unknown key type
> (%d)", id);
>              return 0;
> @@ -556,6 +588,40 @@ ec_keymgmt_name(int id)
>      return "EC";
>  }
>
> +static const char *
> +ed448_keymgmt_name(int id)
> +{
> +    xkey_dmsg(D_XKEY, "entry");
> +
> +    /* though we do not implement keyexch we could be queried for
> +     * keyexch mechanism supported by EC keys
> +     */
> +    if (id == OSSL_OP_SIGNATURE || id == OSSL_OP_KEYEXCH)
> +    {
> +        return "ED448";

+    }
> +
> +    msg(D_XKEY, "xkey ed448_keymgmt_name called with op_id != SIGNATURE
> or KEYEXCH id=%d", id);
> +    return "EC";
>

I think this should be either "ED448" or NULL. The default provider does
not define the query_operation function for this key type in the dispatch
table --- likely because the name will then default to the keymgmt name
(ED448). Also, I just realized that in the default provider, the
query_operation_name (when defined) returns NULL for ids not recognized.
That leads to triggering an error message in the library which is good.

We could either return NULL here or "ED448" and then convert the above
debug msg() to a warning. Or leave out this function altogether and remove
it from the dispatch table.

+}
> +
> +static const char *
> +ed25519_keymgmt_name(int id)
> +{
> +    xkey_dmsg(D_XKEY, "entry");
> +
> +    /* though we do not implement keyexch we could be queried for
> +     * keyexch mechanism supported by EC keys
> +     */
> +    if (id == OSSL_OP_SIGNATURE || id == OSSL_OP_KEYEXCH)
> +    {
> +        return "ED25519";
> +    }

+
> +    msg(D_XKEY, "xkey ed448_keymgmt_name called with op_id != SIGNATURE
> or KEYEXCH id=%d", id);
> +    return "EC";
>

same comment as above with ED448 --> ED25519.


> +}
> +
>  static const OSSL_DISPATCH rsa_keymgmt_functions[] = {
>      {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
>      {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
> @@ -588,10 +654,45 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] = {
>      {0, NULL }
>  };
>
> +static const OSSL_DISPATCH ed448_keymgmt_functions[] = {
> +    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
> +    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
> +    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
> +    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
> +    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
> +    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed448_keymgmt_import},
> +    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void
> (*)(void))keymgmt_import_types},
> +    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void
> (*)(void))keymgmt_gettable_params},
> +    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
> +    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
> +    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void
> (*)(void))keymgmt_gettable_params},       /* same as gettable */
> +    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void
> (*)(void))ed448_keymgmt_name},
>

see above


> +    {0, NULL }
> +};
> +
> +static const OSSL_DISPATCH ed25519_keymgmt_functions[] = {
> +    {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},
> +    {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},
> +    {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},
> +    {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},
> +    {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},
> +    {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed25519_keymgmt_import},
> +    {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void
> (*)(void))keymgmt_import_types},
> +    {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void
> (*)(void))keymgmt_gettable_params},
> +    {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_params},
> +    {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_params},
> +    {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void
> (*)(void))keymgmt_gettable_params},       /* same as gettable */
> +    {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void
> (*)(void))ed25519_keymgmt_name},
>



> +    {0, NULL }
> +};
> +
> +
>  const OSSL_ALGORITHM keymgmts[] = {
>      {"RSA:rsaEncryption", XKEY_PROV_PROPS, rsa_keymgmt_functions,
> "OpenVPN xkey RSA Key Manager"},
>      {"RSA-PSS:RSASSA-PSS", XKEY_PROV_PROPS, rsa_keymgmt_functions,
> "OpenVPN xkey RSA-PSS Key Manager"},
>      {"EC:id-ecPublicKey", XKEY_PROV_PROPS, ec_keymgmt_functions, "OpenVPN
> xkey EC Key Manager"},
> +    {"ED448", XKEY_PROV_PROPS, ed448_keymgmt_functions, "OpenVPN xkey
> ED448 Key Manager"},
> +    {"ED25519", XKEY_PROV_PROPS, ed25519_keymgmt_functions, "OpenVPN xkey
> ED25519 Key Manager"},
>      {NULL, NULL, NULL, NULL}
>  };
>
> @@ -835,7 +936,7 @@ signature_sign_init(void *ctx, void *provkey, const
> OSSL_PARAM params[])
>      }
>      sctx->keydata = provkey;
>      sctx->keydata->refcount++; /* we are keeping a copy */
> -    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA"
> : "EC";
> +    sctx->sigalg.keytype = get_keytype(sctx->keydata);
>
>      signature_set_ctx_params(sctx, params);
>
> @@ -929,13 +1030,19 @@ signature_digest_sign_init(void *ctx, const char
> *mdname,
>      }
>      sctx->keydata = provkey; /* used by digest_sign */
>      sctx->keydata->refcount++;
> -    sctx->sigalg.keytype = KEYTYPE(sctx->keydata) == EVP_PKEY_RSA ? "RSA"
> : "EC";
> +    sctx->sigalg.keytype = get_keytype(sctx->keydata);
>
>      signature_set_ctx_params(ctx, params);
>      if (mdname)
>      {
>          sctx->sigalg.mdname = xkey_mdname(mdname); /* get a string
> literal pointer */
>      }
> +    else if (!strcmp(sctx->sigalg.keytype, "ED448") ||
> !strcmp(sctx->sigalg.keytype, "ED25519"))
> +    {
> +        /* EdDSA requires NULL as digest for the DigestSign API instead
> +         * of using the normal Sign API */
> +        sctx->sigalg.mdname = "none";
> +    }
>

Instead of this order, we have to assert that mdname must be NULL if
keytype is ED25519 or ED448. OpenSSL does not impose this when the key is
in provider, but docs for EVP_DigestSignInit() says mdname should be NULL
for such keys. So I think we should return an error if mdname is not NULL.

In fact we do call EVP_DigestSignInit() in our unit test with mdname=SHA256
and Ed25519 key (after this patch) which exposes this issue (see below).


>      else
>      {
>          msg(M_WARN, "xkey digest_sign_init: mdname is NULL.");
> @@ -1073,6 +1180,8 @@ static const OSSL_DISPATCH signature_functions[] = {
>  const OSSL_ALGORITHM signatures[] = {
>      {"RSA:rsaEncryption", XKEY_PROV_PROPS, signature_functions, "OpenVPN
> xkey RSA Signature"},
>      {"ECDSA", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey ECDSA
> Signature"},
> +    {"ED448", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey Ed448
> Signature"},
> +    {"ED25519", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey
> Ed25519 Signature"},
>      {NULL, NULL, NULL, NULL}
>  };
>
> diff --git a/tests/unit_tests/openvpn/test_provider.c
> b/tests/unit_tests/openvpn/test_provider.c
> index 0b0952ee2..e29252838 100644
> --- a/tests/unit_tests/openvpn/test_provider.c
> +++ b/tests/unit_tests/openvpn/test_provider.c
> @@ -66,7 +66,11 @@ static const char *const pubkey2 = "-----BEGIN PUBLIC
> KEY-----\n"
>
> "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
>                                     "-----END PUBLIC KEY-----\n";
>
> -static const char *pubkeys[] = {pubkey1, pubkey2};
> +static const char *const pubkey3 = "-----BEGIN PUBLIC KEY-----\n"
> +
>  "MCowBQYDK2VwAyEA+q5xjF5hGyyqYZidJdz/0saEQabL3N4wIZJBxNGbgJE=\n"
> +                                   "-----END PUBLIC KEY-----";
> +
> +static const char *pubkeys[] = {pubkey1, pubkey2, pubkey3};
>
>  static const char *prov_name = "ovpn.xkey";
>
> @@ -158,12 +162,17 @@ management_query_pk_sig(struct management *man,
> const char *b64_data,
>      if (strstr(algorithm, "data=message"))
>      {
>          expected_tbs = test_msg_b64;
> -        assert_non_null(strstr(algorithm, "hashalg=SHA256"));
> +        /* ED25519 does not have a hash algorithm even though it goes via

+         * the DigestSign path (data=message) */
> +        if (!strstr(algorithm, "ED25519"))
> +        {
> +            assert_non_null(strstr(algorithm, "hashalg=SHA256"));
> +        }

     }
>      assert_string_equal(b64_data, expected_tbs); Though it still uses
> digestSign()
>
> -    /* We test using ECDSA or PSS with saltlen = digest */
> -    if (!strstr(algorithm, "ECDSA"))
> +    /* We test using ED25519, ECDSA or PSS with saltlen = digest */
> +    if (!strstr(algorithm, "ECDSA") && !strstr(algorithm, "ED25519"))
>      {
>          assert_non_null(strstr(algorithm,
> "RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest"));
>      }
> @@ -328,13 +337,13 @@ xkey_sign(void *handle, unsigned char *sig, size_t
> *siglen,
>          assert_memory_equal(tbs, test_digest, sizeof(test_digest));
>      }
>
> -    /* For the test use sha256 and PSS padding for RSA */
> +    /* For the test use sha256 and PSS padding for RSA and none for EDDSA
> */
>      assert_int_equal(OBJ_sn2nid(s.mdname), NID_sha256);
>

This works now because we wrongly call Ed25519 signature with mdname=sha256
in the test. I think we want this to be something like

 if (!strcmp(s.keytype, "ED25519"))
 {
     assert_string_equal(s.mdname, "none");
 }
else
{
    assert_int_equal(OBJ_sn2nid(s.mdname), NID_sha256);
}

And, in digest_sign() we want to set mdname=NULL for Ed25519 key.. Like:

diff --git a/tests/unit_tests/openvpn/test_provider.c
b/tests/unit_tests/openvpn/test_provider.c
index e2925283..aa2ac7b9 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -237,6 +237,10 @@ digest_sign(EVP_PKEY *pkey)
         params[3] =
OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_MGF1_DIGEST, (char
*)saltlen, 0);
         params[4] = OSSL_PARAM_construct_end();
     }
+    else if (EVP_PKEY_get_id(pkey) == EVP_PKEY_ED25519)
+    {
+        mdname = NULL;
+    }


     if (!strcmp(s.keytype, "RSA"))
>      {
>          assert_string_equal(s.padmode, "pss"); /* we use PSS for the test
> */
>      }
> -    else if (strcmp(s.keytype, "EC"))
> +    else if (strcmp(s.keytype, "EC") && strcmp(s.keytype,"ED25519"))
>      {
>          fail_msg("Unknown keytype: %s", s.keytype);
>      }
>

Finally, xkey_management_sign() in xkey_helper.c should not call
xkey_digest() if mdname is "none". So line 182 in xkey_helper.c will have
to become something like:

if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_DIGEST) &&
strcmp(alg.mdname,"none"))

All look good otherwise.

Regards,

Selva

--000000000000cc007605debff1a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 10, 2022 at 7:32 AM Ar=
ne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1186...=
.1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">OpenSSL&#39;s implementation of ED448 and ED25519 has a few idiosyn=
crasies.<br>
Instead of belonging to the eliptic curve type or to a common Edwards<br>
curve type, ED448 and ED25519 have each their own type.<br>
<br>
Also, OpenSSL excepts singatures using these curves to be done with the<br>=
</blockquote><div><br></div><div>expects</div><div>signatures</div><div><br=
></div><div>(good to know I&#39;m not the only one afflicted by transpositi=
on errors)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
EVP_DigestSign API instead of the EVP_Sign API but using md=3DNULL.=C2=A0</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This has been tested using a &quot;fake&quot; external key that used a norm=
al<br>
software key instead of a hardware implementation but that makes no<br>
difference from the perspective of xkey_provider/managment interface.<br></=
blockquote><div><br></div><div>management</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0src/openvpn/xkey_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0src/openvpn/xkey_provider.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 121 +++++++++++++++++++++--<br>
=C2=A0tests/unit_tests/openvpn/test_provider.c |=C2=A0 21 ++--<br>
=C2=A03 files changed, 134 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c<br>
index ecc7b1204..d59b16858 100644<br>
--- a/src/openvpn/xkey_helper.c<br>
+++ b/src/openvpn/xkey_helper.c<br>
@@ -206,6 +206,10 @@ xkey_management_sign(void *unused, unsigned char *sig,=
 size_t *siglen,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_snprintf(alg_str, s=
izeof(alg_str), &quot;ECDSA,hashalg=3D%s&quot;, alg.mdname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else if(!strcmp(alg.keytype, &quot;ED448&quot;) || !strcmp(a=
lg.keytype, &quot;ED25519&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpynt(alg_str, alg.keytype, sizeof(alg_str=
));<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0/* else assume RSA key */<br>
=C2=A0 =C2=A0 =C2=A0else if (!strcmp(alg.padmode, &quot;pkcs1&quot;) &amp;&=
amp; (flags &amp; MF_EXTERNAL_KEY_PKCS1PAD))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c<br>
index 46e57e0fe..e8ac3904b 100644<br>
--- a/src/openvpn/xkey_provider.c<br>
+++ b/src/openvpn/xkey_provider.c<br>
@@ -99,12 +99,28 @@ typedef struct<br>
=C2=A0 =C2=A0 =C2=A0int refcount;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /**&lt; reference count */<br>
=C2=A0} XKEY_KEYDATA;<br>
<br>
-static int<br>
-KEYTYPE(const XKEY_KEYDATA *key)<br>
+static inline const char *<br>
+get_keytype(const XKEY_KEYDATA *key)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return key-&gt;pubkey ? EVP_PKEY_get_id(key-&gt;pubkey) : 0;=
<br>
+=C2=A0 =C2=A0 int keytype =3D key-&gt;pubkey ? EVP_PKEY_get_id(key-&gt;pub=
key) : 0;<br>
+<br>
+=C2=A0 =C2=A0 switch (keytype)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EVP_PKEY_RSA:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;RSA&quot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EVP_PKEY_ED448:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;ED448&quot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EVP_PKEY_ED25519:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;ED25519&quot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;EC&quot;;</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+<br>
=C2=A0static int<br>
=C2=A0KEYSIZE(const XKEY_KEYDATA *key)<br>
=C2=A0{<br>
@@ -310,6 +326,22 @@ ec_keymgmt_import(void *keydata, int selection, const =
OSSL_PARAM params[])<br>
=C2=A0 =C2=A0 =C2=A0return keymgmt_import(keydata, selection, params, &quot=
;EC&quot;);<br>
=C2=A0}<br>
<br>
+static int<br>
+ed448_keymgmt_import(void *keydata, int selection, const OSSL_PARAM params=
[])<br>
+{<br>
+=C2=A0 =C2=A0 xkey_dmsg(D_XKEY, &quot;entry&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return keymgmt_import(keydata, selection, params, &quot;ED44=
8&quot;);<br>
+}<br>
+<br>
+static int<br>
+ed25519_keymgmt_import(void *keydata, int selection, const OSSL_PARAM para=
ms[])<br>
+{<br>
+=C2=A0 =C2=A0 xkey_dmsg(D_XKEY, &quot;entry&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return keymgmt_import(keydata, selection, params, &quot;ED25=
519&quot;);<br>
+}<br>
+<br>
=C2=A0/* This function has to exist for key import to work<br>
=C2=A0 * though we do not support import of individual params<br>
=C2=A0 * like n or e. We simply return an empty list here for<br>
@@ -449,7 +481,7 @@ keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PAR=
AM *params)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(pkey);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int id =3D EVP_PKEY_get_id(pkey);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id !=3D EVP_PKEY_RSA &amp;&amp; id !=3D EV=
P_PKEY_EC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id !=3D EVP_PKEY_RSA &amp;&amp; id !=3D EV=
P_PKEY_EC &amp;&amp; id !=3D EVP_PKEY_ED25519 &amp;&amp; id !=3D EVP_PKEY_E=
D448)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;Error: xk=
ey keymgmt_import: unknown key type (%d)&quot;, id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -556,6 +588,40 @@ ec_keymgmt_name(int id)<br>
=C2=A0 =C2=A0 =C2=A0return &quot;EC&quot;;<br>
=C2=A0}<br>
<br>
+static const char *<br>
+ed448_keymgmt_name(int id)<br>
+{<br>
+=C2=A0 =C2=A0 xkey_dmsg(D_XKEY, &quot;entry&quot;);<br>
+<br>
+=C2=A0 =C2=A0 /* though we do not implement keyexch we could be queried fo=
r<br>
+=C2=A0 =C2=A0 =C2=A0* keyexch mechanism supported by EC keys<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (id =3D=3D OSSL_OP_SIGNATURE || id =3D=3D OSSL_OP_KEYEXCH=
)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;ED448&quot;;</blockquote><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 msg(D_XKEY, &quot;xkey ed448_keymgmt_name called with op_id =
!=3D SIGNATURE or KEYEXCH id=3D%d&quot;, id);<br>
+=C2=A0 =C2=A0 return &quot;EC&quot;;<br></blockquote><div><br></div><div>I=
 think this should be either &quot;ED448&quot; or NULL. The default provide=
r does not define the query_operation function for this key type in the dis=
patch table --- likely because the name will then default to the keymgmt na=
me (ED448). Also, I just realized that in the default provider, the query_o=
peration_name (when defined) returns NULL for ids not recognized. That lead=
s to triggering an error message in the library which is good.=C2=A0</div><=
div><br></div><div>We could either return NULL here or &quot;ED448&quot; an=
d then convert the above debug msg() to a warning. Or leave out this functi=
on altogether and remove it from the dispatch table.</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static const char *<br>
+ed25519_keymgmt_name(int id)<br>
+{<br>
+=C2=A0 =C2=A0 xkey_dmsg(D_XKEY, &quot;entry&quot;);<br>
+<br>
+=C2=A0 =C2=A0 /* though we do not implement keyexch we could be queried fo=
r<br>
+=C2=A0 =C2=A0 =C2=A0* keyexch mechanism supported by EC keys<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (id =3D=3D OSSL_OP_SIGNATURE || id =3D=3D OSSL_OP_KEYEXCH=
)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;ED25519&quot;;<br>
+=C2=A0 =C2=A0 }=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+=C2=A0 =C2=A0 msg(D_XKEY, &quot;xkey ed448_keymgmt_name called with op_id =
!=3D SIGNATURE or KEYEXCH id=3D%d&quot;, id);<br>
+=C2=A0 =C2=A0 return &quot;EC&quot;;<br></blockquote><div><br></div><div>s=
ame comment as above with ED448 --&gt; ED25519.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
=C2=A0static const OSSL_DISPATCH rsa_keymgmt_functions[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},<b=
r>
=C2=A0 =C2=A0 =C2=A0{OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},=
<br>
@@ -588,10 +654,45 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] =3D=
 {<br>
=C2=A0 =C2=A0 =C2=A0{0, NULL }<br>
=C2=A0};<br>
<br>
+static const OSSL_DISPATCH ed448_keymgmt_functions[] =3D {<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed448_keymgmt_imp=
ort},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_imp=
ort_types},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_=
gettable_params},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_p=
arams},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_p=
arams},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_=
gettable_params},=C2=A0 =C2=A0 =C2=A0 =C2=A0/* same as gettable */<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))ed4=
48_keymgmt_name},<br></blockquote><div><br></div><div>see above</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 {0, NULL }<br>
+};<br>
+<br>
+static const OSSL_DISPATCH ed25519_keymgmt_functions[] =3D {<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))keymgmt_new},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))keymgmt_free},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))keymgmt_load},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))keymgmt_has},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))keymgmt_match},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))ed25519_keymgmt_i=
mport},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))keymgmt_imp=
ort_types},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))keymgmt_=
gettable_params},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))keymgmt_get_p=
arams},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_SET_PARAMS, (void (*)(void))keymgmt_set_p=
arams},<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS, (void (*)(void))keymgmt_=
gettable_params},=C2=A0 =C2=A0 =C2=A0 =C2=A0/* same as gettable */<br>
+=C2=A0 =C2=A0 {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))ed2=
5519_keymgmt_name},<br>
</blockquote><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">+=C2=A0 =C2=A0 {0, NULL }<br>
+};<br>
+<br>
+<br>
=C2=A0const OSSL_ALGORITHM keymgmts[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{&quot;RSA:rsaEncryption&quot;, XKEY_PROV_PROPS, rsa_ke=
ymgmt_functions, &quot;OpenVPN xkey RSA Key Manager&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{&quot;RSA-PSS:RSASSA-PSS&quot;, XKEY_PROV_PROPS, rsa_k=
eymgmt_functions, &quot;OpenVPN xkey RSA-PSS Key Manager&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{&quot;EC:id-ecPublicKey&quot;, XKEY_PROV_PROPS, ec_key=
mgmt_functions, &quot;OpenVPN xkey EC Key Manager&quot;},<br>
+=C2=A0 =C2=A0 {&quot;ED448&quot;, XKEY_PROV_PROPS, ed448_keymgmt_functions=
, &quot;OpenVPN xkey ED448 Key Manager&quot;},<br>
+=C2=A0 =C2=A0 {&quot;ED25519&quot;, XKEY_PROV_PROPS, ed25519_keymgmt_funct=
ions, &quot;OpenVPN xkey ED25519 Key Manager&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{NULL, NULL, NULL, NULL}<br>
=C2=A0};<br>
<br>
@@ -835,7 +936,7 @@ signature_sign_init(void *ctx, void *provkey, const OSS=
L_PARAM params[])<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sctx-&gt;keydata =3D provkey;<br>
=C2=A0 =C2=A0 =C2=A0sctx-&gt;keydata-&gt;refcount++; /* we are keeping a co=
py */<br>
-=C2=A0 =C2=A0 sctx-&gt;sigalg.keytype =3D KEYTYPE(sctx-&gt;keydata) =3D=3D=
 EVP_PKEY_RSA ? &quot;RSA&quot; : &quot;EC&quot;;<br>
+=C2=A0 =C2=A0 sctx-&gt;sigalg.keytype =3D get_keytype(sctx-&gt;keydata);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0signature_set_ctx_params(sctx, params);<br>
<br>
@@ -929,13 +1030,19 @@ signature_digest_sign_init(void *ctx, const char *md=
name,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sctx-&gt;keydata =3D provkey; /* used by digest_sign */=
<br>
=C2=A0 =C2=A0 =C2=A0sctx-&gt;keydata-&gt;refcount++;<br>
-=C2=A0 =C2=A0 sctx-&gt;sigalg.keytype =3D KEYTYPE(sctx-&gt;keydata) =3D=3D=
 EVP_PKEY_RSA ? &quot;RSA&quot; : &quot;EC&quot;;<br>
+=C2=A0 =C2=A0 sctx-&gt;sigalg.keytype =3D get_keytype(sctx-&gt;keydata);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0signature_set_ctx_params(ctx, params);<br>
=C2=A0 =C2=A0 =C2=A0if (mdname)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sctx-&gt;sigalg.mdname =3D xkey_mdname(md=
name); /* get a string literal pointer */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else if (!strcmp(sctx-&gt;sigalg.keytype, &quot;ED448&quot;)=
 || !strcmp(sctx-&gt;sigalg.keytype, &quot;ED25519&quot;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* EdDSA requires NULL as digest for the Diges=
tSign API instead<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* of using the normal Sign API */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sctx-&gt;sigalg.mdname =3D &quot;none&quot;;<b=
r>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Instead of this order,=
 we have to assert that mdname must be NULL if keytype is ED25519 or ED448.=
 OpenSSL does not impose this when the key is in provider, but docs for EVP=
_DigestSignInit() says mdname should be NULL for such keys. So I think we s=
hould return an error if mdname is not NULL.</div><div><br></div><div>In fa=
ct we do call EVP_DigestSignInit() in our unit test with mdname=3DSHA256 an=
d Ed25519 key (after this patch) which exposes this issue (see below).</div=
><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;xkey digest_sign_init: =
mdname is NULL.&quot;);<br>
@@ -1073,6 +1180,8 @@ static const OSSL_DISPATCH signature_functions[] =3D =
{<br>
=C2=A0const OSSL_ALGORITHM signatures[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{&quot;RSA:rsaEncryption&quot;, XKEY_PROV_PROPS, signat=
ure_functions, &quot;OpenVPN xkey RSA Signature&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{&quot;ECDSA&quot;, XKEY_PROV_PROPS, signature_function=
s, &quot;OpenVPN xkey ECDSA Signature&quot;},<br>
+=C2=A0 =C2=A0 {&quot;ED448&quot;, XKEY_PROV_PROPS, signature_functions, &q=
uot;OpenVPN xkey Ed448 Signature&quot;},<br>
+=C2=A0 =C2=A0 {&quot;ED25519&quot;, XKEY_PROV_PROPS, signature_functions, =
&quot;OpenVPN xkey Ed25519 Signature&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{NULL, NULL, NULL, NULL}<br>
=C2=A0};<br>
<br>
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c<br>
index 0b0952ee2..e29252838 100644<br>
--- a/tests/unit_tests/openvpn/test_provider.c<br>
+++ b/tests/unit_tests/openvpn/test_provider.c<br>
@@ -66,7 +66,11 @@ static const char *const pubkey2 =3D &quot;-----BEGIN PU=
BLIC KEY-----\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;u95ff1JiUaJIkYNI=
kZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ=3D=3D\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-----END PUBLIC =
KEY-----\n&quot;;<br>
<br>
-static const char *pubkeys[] =3D {pubkey1, pubkey2};<br>
+static const char *const pubkey3 =3D &quot;-----BEGIN PUBLIC KEY-----\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;MCowBQYDK2VwAyEA+=
q5xjF5hGyyqYZidJdz/0saEQabL3N4wIZJBxNGbgJE=3D\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-----END PUBLIC K=
EY-----&quot;;<br>
+<br>
+static const char *pubkeys[] =3D {pubkey1, pubkey2, pubkey3};<br>
<br>
=C2=A0static const char *prov_name =3D &quot;ovpn.xkey&quot;;<br>
<br>
@@ -158,12 +162,17 @@ management_query_pk_sig(struct management *man, const=
 char *b64_data,<br>
=C2=A0 =C2=A0 =C2=A0if (strstr(algorithm, &quot;data=3Dmessage&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_tbs =3D test_msg_b64;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert_non_null(strstr(algorithm, &quot;hashal=
g=3DSHA256&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ED25519 does not have a hash algorithm even=
 though it goes via</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the DigestSign path (data=3Dmessage) *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strstr(algorithm, &quot;ED25519&quot;))<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert_non_null(strstr(algorithm=
, &quot;hashalg=3DSHA256&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0</blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0assert_string_equal(b64_data, expected_tbs); Though it =
still uses digestSign()<br>
<br>
-=C2=A0 =C2=A0 /* We test using ECDSA or PSS with saltlen =3D digest */<br>
-=C2=A0 =C2=A0 if (!strstr(algorithm, &quot;ECDSA&quot;))<br>
+=C2=A0 =C2=A0 /* We test using ED25519, ECDSA or PSS with saltlen =3D dige=
st */<br>
+=C2=A0 =C2=A0 if (!strstr(algorithm, &quot;ECDSA&quot;) &amp;&amp; !strstr=
(algorithm, &quot;ED25519&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert_non_null(strstr(algorithm, &quot;R=
SA_PKCS1_PSS_PADDING,hashalg=3DSHA256,saltlen=3Ddigest&quot;));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -328,13 +337,13 @@ xkey_sign(void *handle, unsigned char *sig, size_t *s=
iglen,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert_memory_equal(tbs, test_digest, siz=
eof(test_digest));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* For the test use sha256 and PSS padding for RSA */<br>
+=C2=A0 =C2=A0 /* For the test use sha256 and PSS padding for RSA and none =
for EDDSA */<br>
=C2=A0 =C2=A0 =C2=A0assert_int_equal(OBJ_sn2nid(s.mdname), NID_sha256);<br>=
</blockquote><div><br></div><div>This works now because we wrongly call Ed2=
5519 signature with mdname=3Dsha256 in the test. I think we want this to be=
 something like</div><div><br></div><div>=C2=A0if (!strcmp(s.keytype, &quot=
;ED25519&quot;))</div>=C2=A0{</div><div class=3D"gmail_quote">=C2=A0 =C2=A0=
 =C2=A0assert_string_equal(s.mdname, &quot;none&quot;);<br>=C2=A0}<br>else<=
/div><div class=3D"gmail_quote">{<br>=C2=A0 =C2=A0 assert_int_equal(OBJ_sn2=
nid(s.mdname), NID_sha256);<br>}</div><div class=3D"gmail_quote"><br></div>=
<div class=3D"gmail_quote">And, in digest_sign() we want to set mdname=3DNU=
LL for Ed25519 key.. Like:</div><div class=3D"gmail_quote"><br></div><div c=
lass=3D"gmail_quote">diff --git a/tests/unit_tests/openvpn/test_provider.c =
b/tests/unit_tests/openvpn/test_provider.c<br>index e2925283..aa2ac7b9 1006=
44<br>--- a/tests/unit_tests/openvpn/test_provider.c<br>+++ b/tests/unit_te=
sts/openvpn/test_provider.c<br>@@ -237,6 +237,10 @@ digest_sign(EVP_PKEY *p=
key)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params[3] =3D OSSL_PARAM_construc=
t_utf8_string(OSSL_SIGNATURE_PARAM_MGF1_DIGEST, (char *)saltlen, 0);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0params[4] =3D OSSL_PARAM_construct_end();<br=
>=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else if (EVP_PKEY_get_id(pkey) =3D=
=3D EVP_PKEY_ED25519)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0m=
dname =3D NULL;<br>+ =C2=A0 =C2=A0}<br></div><div class=3D"gmail_quote"><br=
></div><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (!strcmp(s.keytype, &quot;RSA&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert_string_equal(s.padmode, &quot;pss&=
quot;); /* we use PSS for the test */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 else if (strcmp(s.keytype, &quot;EC&quot;))<br>
+=C2=A0 =C2=A0 else if (strcmp(s.keytype, &quot;EC&quot;) &amp;&amp; strcmp=
(s.keytype,&quot;ED25519&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fail_msg(&quot;Unknown keytype: %s&quot;,=
 s.keytype);<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div>=C2=A0<br></div><div>Finally, xk=
ey_management_sign() in xkey_helper.c should not call xkey_digest() if mdna=
me is &quot;none&quot;. So line 182 in xkey_helper.c will have to become so=
mething like:</div><div><br></div><div>if (!strcmp(alg.op, &quot;DigestSign=
&quot;) &amp;&amp; !(flags &amp; MF_EXTERNAL_KEY_DIGEST) &amp;&amp; strcmp(=
alg.mdname,&quot;none&quot;))<br></div><div><br></div><div>All look good ot=
herwise.</div><div><br></div><div>Regards,</div><div><br></div><div>Selva=
=C2=A0</div></div></div></div>

--000000000000cc007605debff1a7--

