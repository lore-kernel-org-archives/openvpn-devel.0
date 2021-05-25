MIME-Version: 1.0
References: <20210525092510.27517-1-heiko.wundram@...2614...>
In-Reply-To: <20210525092510.27517-1-heiko.wundram@...2614...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 May 2021 16:42:30 -0400
Message-ID: <CAKuzo_gESgnmaN8QUdnThR-qPcSxdW1Ursvw+vioZFYHTd04Dg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Implement Windows CA template match for
 Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Heiko Wundram <heiko.wundram@...2614...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I'm not convinced of the utility of this. It could be marginally
useful in some setups where all users are tied to a domain and
choosing any certificate that matches a template is appropriate. I
don't have a setup to test this.

Here are some general comments anyway.

On Tue, May 25, 2021 at 5:44 AM Heiko Wundram <heiko.wundram@...2614...> wrote:
>
> The certificate selection process for the Crypto API certificates
> is currently fixed to match on subject or identifier. Especially
> if certificates that are used for OpenVPN are managed by a Windows CA,
> it is appropriate to select the certificate to use by the template
> that it is generated from, especially on domain-joined clients which
> automatically acquire/renew the corresponding certificate.
>
> The attached match implements the match on TMPL: with either a template
> name (which is looked up through CryptFindOIDInfo) or by specifying the
> OID of the template directly, which then is matched against the
> corresponding X509 extensions specifying the template that the certificate
> was generated from.
>
> The logic requires to walk all certificates in the underlying store and
> to match the certificate extensions directly. The hook which is
> implemented in the certificate selection logic is generic to allow
> other Crypto-API certificate matches to also be implemented at some
> point in the future.
>
> The logic to match the certificate template is taken from the
> implementation in the .NET core runtime, see Pal.Windows/FindPal.cs in
> in the implementation of System.Security.Cryptography.X509Certificates.
>
> Signed-off-by: Heiko Wundram <heiko.wundram@...2614...>
> ---
>  src/openvpn/cryptoapi.c | 117 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 112 insertions(+), 5 deletions(-)
>
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index ded8c914..ee4c9014 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -732,6 +732,105 @@ err:
>
>  #endif /* OPENSSL_VERSION_NUMBER >= 1.1.0 */
>
> +static void *
> +decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)
> +{
> +    /* get byte cound for decoding */

typo: count

> +    BYTE *buf;
> +    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type, val->pbData, val->cbData, flags, NULL, cb))
> +        return NULL;
> +
> +    /* do the actual decode */
> +    buf = gc_malloc(*cb, false, gc);
> +    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type, val->pbData, val->cbData, flags, buf, cb))
> +        return NULL;
> +
> +    return buf;
> +}
> +
> +static const CRYPT_OID_INFO *
> +find_oid(DWORD keytype, const void *key, DWORD groupid, bool fallback)
> +{
> +    const CRYPT_OID_INFO *info = NULL;
> +
> +    /* force resolve from local as first step */
> +    if (groupid != CRYPT_HASH_ALG_OID_GROUP_ID &&
> +        groupid != CRYPT_ENCRYPT_ALG_OID_GROUP_ID &&
> +        groupid != CRYPT_PUBKEY_ALG_OID_GROUP_ID &&
> +        groupid != CRYPT_SIGN_ALG_OID_GROUP_ID &&
> +        groupid != CRYPT_RDN_ATTR_OID_GROUP_ID &&
> +        groupid != CRYPT_EXT_OR_ATTR_OID_GROUP_ID &&
> +        groupid != CRYPT_KDF_OID_GROUP_ID)
> +    {

Why not do the local lookup for all grupids? Anyway you are falling
back to domain-wide look up if this fails.

> +        info = CryptFindOIDInfo(keytype, (void*)key, groupid | CRYPT_OID_DISABLE_SEARCH_DS_FLAG);
> +    }
> +
> +    /* try proper resolve if not found yet, also including AD */
> +    if (!info)
> +    {
> +        info = CryptFindOIDInfo(keytype, (void*)key, groupid);

How long would this take to time out -- we try to avoid calling
functions that need network access to the DC as that's often not
available before the tunnel comes up.

> +    }
> +
> +    /* fall back to all groups if not found yet and fallback requested */
> +    if (!info && fallback && groupid)
> +    {
> +        info = CryptFindOIDInfo(keytype, (void*)key, 0);

That could be a second network call. Why not combine the two into one call.

> +    }
> +
> +    return info;
> +}
> +
> +static bool
> +test_certificate_template(struct gc_arena *gc, const char *cert_prop, const CERT_CONTEXT *cert_ctx)
> +{

As this is called from a loop for every certificate in the store until
a match is found, passing in gc that will be released only after
exiting the loop is wasteful memory use.

Just create a new gc clear and clear it at exit. You are not using any
buffers allocated here after return.

> +    const CERT_INFO *info = cert_ctx->pCertInfo;
> +    const CERT_EXTENSION *ext;
> +    DWORD cbext;
> +    void *pvext;
> +    const WCHAR *tmpl_name = wide_string(cert_prop, gc);
> +
> +    /* check for V1 extension (Windows 2K and below) */
> +    ext = CertFindExtension(szOID_ENROLL_CERTTYPE_EXTENSION, info->cExtension, info->rgExtension);
> +    if (ext)
> +    {
> +        pvext = decode_object(gc, X509_UNICODE_ANY_STRING, &ext->Value, 0, &cbext);
> +        if (pvext && cbext >= sizeof(CERT_NAME_VALUE))
> +        {
> +            const CERT_NAME_VALUE *nv = (const CERT_NAME_VALUE*)pvext;
> +            if (!_wcsicmp((const WCHAR*)nv->Value.pbData, tmpl_name))

Is it guaranteed that pbData is NULL terminated? (MS docs are unclear
on this). We may have to add a safety check that the data length
length is >= wcslen(tmpl_name).

> +            {
> +                /* data content matches extension name */
> +                return true;
> +            }
> +        }
> +    }
> +
> +    /* check for V2 extension (Windows 2003+) */
> +    ext = CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtension, info->rgExtension);
> +    if (ext)
> +    {
> +        pvext = decode_object(gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
> +        if (pvext && cbext >= sizeof(CERT_TEMPLATE_EXT))
> +        {
> +            const CERT_TEMPLATE_EXT *cte = (const CERT_TEMPLATE_EXT*)pvext;
> +            const CRYPT_OID_INFO *tmpl_oid = find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID, true);
> +            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
> +            {
> +                /* found OID match in extension against resolved key */
> +                return true;
> +            }
> +            else if (!tmpl_oid && !stricmp(cert_prop, cte->pszObjId))
> +            {

Why not test this first so that the call to find_oid could be avoided
if this matches?

> +                /* found direct OID match with certificate property specified */
> +                return true;
> +            }
> +        }
> +    }
> +
> +    /* no extension found, exit */
> +    return false;
> +}
> +
>  static const CERT_CONTEXT *
>  find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
>  {
> @@ -743,17 +842,25 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
>       * The first matching certificate that has not expired is returned.
>       */
>      const CERT_CONTEXT *rv = NULL;
> -    DWORD find_type;
> -    const void *find_param;
> +    DWORD find_type = CERT_FIND_ANY;
> +    const void *find_param = NULL;
> +    bool (*find_test)(struct gc_arena*, const char*, const CERT_CONTEXT*) = NULL;
>      unsigned char hash[255];
>      CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
>      struct gc_arena gc = gc_new();
>
> -    if (!strncmp(cert_prop, "SUBJ:", 5))
> +    if (!strncmp(cert_prop, "TMPL:", 5))
> +    {
> +        /* skip the tag */
> +        cert_prop += 5;
> +        find_test = &test_certificate_template;
> +    }
> +    else if (!strncmp(cert_prop, "SUBJ:", 5))
>      {
>          /* skip the tag */
> -        find_param = wide_string(cert_prop + 5, &gc);
> +        cert_prop += 5;
>          find_type = CERT_FIND_SUBJECT_STR_W;
> +        find_param = wide_string(cert_prop, &gc);
>      }
>      else if (!strncmp(cert_prop, "THUMB:", 6))
>      {
> @@ -819,7 +926,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
>          {
>              validity = CertVerifyTimeValidity(NULL, rv->pCertInfo);
>          }
> -        if (!rv || validity == 0)
> +        if (!rv || (validity == 0 && (!find_test || find_test(&gc, cert_prop, rv))))
>          {
>              break;
>          }

The warning log below this is meant to be printed only when the cert
matches but validity period is off. But now it will print a warning
for every certificate in the store until a match is found. That's not
acceptable.

There are some missing {} for if/else,  we prefer && at the start of
line for multi-line conditions etc. See
https://community.openvpn.net/openvpn/wiki/CodeStyle


Selva

