MIME-Version: 1.0
References: <20210919162956.695496-1-arne@...1227...>
 <20210919162956.695496-8-arne@...1227...>
In-Reply-To: <20210919162956.695496-8-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 12 Oct 2021 17:38:16 -0400
Message-ID: <CAKuzo_hr+HT+XbS3swe=ou1a_LpwCz1HvYfMsi97NYZe7jUVSg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 8/8] [OSSL 3.0] Use
 EVP_PKEY_get_group_name to query group name
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Looking at the easier ones in this set:

On Sun, Sep 19, 2021 at 12:31 PM Arne Schwabe <arne@...1227...> wrote:
>
> EC_Key methods are deprecated in OpenSSL 3.0. Use
> EVP_PKEY_get_group_name instead to query the EC group name from an
> EVP_PKEY and add a compatibility function for older OpenSSL versions.
> ---
>  src/openvpn/openssl_compat.h | 32 ++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    | 14 ++++++++------
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ce8e2b360..933a71848 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -46,6 +46,38 @@
>  #include <openssl/ssl.h>
>  #include <openssl/x509.h>
>
> +/* Functionality missing in 1.1.1 */
> +#if OPENSSL_VERSION_NUMBER < 0x30000000L

&& !defined(OPENSSL_NO_EC)

> +
> +/* Note that this is not a perfect emulation of the new function but
> + * is good enough for our case of printing certificate details during
> + * handshake */
> +static inline
> +int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
> +                            size_t *gname_len)
> +                            {
> +    if ((EVP_PKEY_get0_EC_KEY(pkey) == NULL ||
> +        EVP_PKEY_get0_EC_KEY(pkey) != NULL))

both == NULL and != NULL on the same value? See also below

> +    {
> +        return 0;
> +    }
> +    const EC_KEY* ec = EVP_PKEY_get0_EC_KEY(pkey);

I think you want to remove the 5 lines before this and add here
if (ec == NULL) {
    return 0;
}

> +    const EC_GROUP* group = EC_KEY_get0_group(ec);
> +
> +    int nid = EC_GROUP_get_curve_name(group);
> +
> +    if (nid != 0)

You mean nid == 0 ?

> +    {
> +        return 0;
> +    }
> +    const char *curve = OBJ_nid2sn(nid);

Add a check for curve != NULL

> +
> +    strncpy(gname, curve, gname_sz);

strncpynt()

> +    *gname_len = min_int(strlen(curve), gname_sz);

gname_sz   -> gname_sz - 1 to be consistent with strlen(curve)

> +    return 1;
> +}
> +#endif
> +
>  /* Functionality missing in 1.1.0 */
>  #if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
>  #define SSL_CTX_set1_groups SSL_CTX_set1_curves
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 68cdb880c..dc0ae20a7 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2049,13 +2049,15 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
>      int typeid = EVP_PKEY_id(pkey);
>
>  #ifndef OPENSSL_NO_EC
> -    if (typeid == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
> +    char groupname[256];
> +    if (typeid == EVP_PKEY_EC)
>      {
> -        const EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> -        const EC_GROUP *group = EC_KEY_get0_group(ec);
> -
> -        int nid = EC_GROUP_get_curve_name(group);
> -        if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
> +        size_t len;
> +        if(EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname), &len))
> +        {
> +           curve = groupname;
> +        }
> +        else
>          {
>              curve = "(error getting curve name)";
>          }

Selva

