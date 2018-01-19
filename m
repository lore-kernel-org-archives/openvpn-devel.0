References: <CAKuzo_jx+ZudY-dzkqPro1Xqzj+djT4+Qhs+cQHzchjwpSsOHg@...278...>
 <20180119192252.6229-1-steffan@...1856...>
 <CAKuzo_gPWm6rdBYt+tcaxz+zSQ4M-A4UDu8ZEgWjtvrLZ54ipw@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0be0401f-4ba4-1497-b664-34c57b39dfb3@...1856...>
Date: Fri, 19 Jan 2018 22:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gPWm6rdBYt+tcaxz+zSQ4M-A4UDu8ZEgWjtvrLZ54ipw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3 v3] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 19-01-18 21:56, Selva Nair wrote:
> Thanks for the v3.
> 
> All good except (sorry to say that :)
> 
> The compat versions of SSL_CTX_get_max_proto_version and its min counterpart
> should return a long or int not void. Assuming we want to continue
> supporting 
> openssl 1.0.
> 
> This was not an issue earlier when return value was not checked. Anyway,
> the correct
> signature of the 1.1 functions (well macros) it replaces is long.
> 
> I should have pointed this out earlier...

Gah, no, I should have thought about that before sending the patch.  Not
enough brains left on Friday night I guess...  v4 coming.

> There is one more thing that I'm not sure of. See below.
> 
> On Fri, Jan 19, 2018 at 2:22 PM, Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
>     As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...
>     <mailto:80e6b449-c536-dc87-7215-3693872bce5a@...376...>> on
>     the openvpn-devel mailing list, --tls-version-min no longer works with
>     OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:
> 
>     "This is marked as important because if you switch to openssl 1.1.0
>     the defaults minimum version in Debian is currently TLS 1.2 and
>     you can't override it with the options that you're currently using
>     (and are deprecated)."
> 
>     This patch is loosely based on the original patch by Kurt, but
>     solves the
>     issue by adding functions to openssl-compat.h, like we also did for all
>     other openssl 1.1. breakage.  This results in not having to add more
>     ifdefs
>     in ssl_openssl.c and thus cleaner code.
> 
>     Signed-off-by: Steffan Karger <steffan@...1856...
>     <mailto:steffan@...1856...>>
>     ---
>     v2: fix define name, obey system lib default minimum version
>     v3: add error handling, fix bug in setting default minimum
> 
>      src/openvpn/openssl_compat.h |  63 +++++++++++++++++++++++++++
>      src/openvpn/ssl.c            |   5 ++-
>      src/openvpn/ssl_backend.h    |   4 +-
>      src/openvpn/ssl_mbedtls.c    |   3 +-
>      src/openvpn/ssl_openssl.c    | 100
>     +++++++++++++++++++++++++++----------------
>      5 files changed, 136 insertions(+), 39 deletions(-)
> 
>     diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
>     index 05ec4e95..4931fad3 100644
>     --- a/src/openvpn/openssl_compat.h
>     +++ b/src/openvpn/openssl_compat.h
>     @@ -661,4 +661,67 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>      #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT     
>      RSA_F_RSA_EAY_PRIVATE_ENCRYPT
>      #endif
> 
>     +#ifndef SSL_CTX_get_min_proto_version
>     +/** Dummy SSL_CTX_get_min_proto_version for OpenSSL < 1.1 (not
>     really needed) */
>     +static inline int
>     +SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
>     +{
>     +    return 0;
>     +}
>     +#endif /* SSL_CTX_get_min_proto_version */
>     +
>     +#ifndef SSL_CTX_set_min_proto_version
>     +/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
>     +static inline void
>     +SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
> 
> 
> static inline long (or int)
> ...
>  
> 
>     +{
>     +    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do <
>     TLS 1.0 */
>     +
>     +    if (tls_ver_min > TLS1_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1;
>     +    }
>     +#ifdef SSL_OP_NO_TLSv1_1
>     +    if (tls_ver_min > TLS1_1_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1_1;
>     +    }
>     +#endif
>     +#ifdef SSL_OP_NO_TLSv1_2
>     +    if (tls_ver_min > TLS1_2_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1_2;
>     +    }
>     +#endif
>     +    SSL_CTX_set_options(ctx, sslopt);
> 
> 
> return 1;
>  
> 
>     +}
>     +#endif /* SSL_CTX_set_min_proto_version */
>     +
>     +#ifndef SSL_CTX_set_max_proto_version
>     +/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
>     +static inline void
>     +SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
> 
> 
> static inline long (or int)
> ...
>  
> 
>     +{
>     +    long sslopt = 0;
>     +
>     +    if (tls_ver_max < TLS1_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1;
>     +    }
>     +#ifdef SSL_OP_NO_TLSv1_1
>     +    if (tls_ver_max < TLS1_1_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1_1;
>     +    }
>     +#endif
>     +#ifdef SSL_OP_NO_TLSv1_2
>     +    if (tls_ver_max < TLS1_2_VERSION)
>     +    {
>     +        sslopt |= SSL_OP_NO_TLSv1_2;
>     +    }
>     +#endif
>     +    SSL_CTX_set_options(ctx, sslopt);
> 
> 
> return 1;
>  
> 
>     +}
>     +#endif /* SSL_CTX_set_max_proto_version */0
>     +
> 
> 
> ...
> 
>     +/** Convert internal version number to openssl version number */
>     +static int
>     +openssl_tls_version(int ver)
>     +{
>     +    if (ver == TLS_VER_1_0)
>     +    {
>     +        return TLS1_VERSION;
>     +    }
>     +    else if (ver == TLS_VER_1_1)
>     +    {
>     +        return TLS1_1_VERSION;
>     +    }
>     +    else if (ver == TLS_VER_1_2)
>     +    {
>     +        return TLS1_2_VERSION;
>     +    }
>     +    return 0;
>     +}
> 
> 
> TLS1_2_VERSION may not be defined in openssl prior to 1.0.1, would it?
> Is that a problem? Do we still support 0.9.8 etc? I'm lazy to check this
> myself.

The defines are already present in 0.9.8, and our master branch (which
should get this patch first) only supports openssl 1.0.1 and newer.
I'll need to double-check everything before cherry-picking to
release/2.4 though.  Let's first see if I can manage to send a correct
patch for master...

Now testing the v4 against both 1.0.1 and 1.1.0, and will send to the ml
soon.

Thanks!

-Steffan

