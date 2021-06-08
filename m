References: <20210608194330.1431202-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0cfba17a-6159-f2f8-9c4f-d6fb64b30c90@...2181...>
Date: Tue, 8 Jun 2021 21:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <20210608194330.1431202-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Silence warning about format string in
 check_ca_required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/06/2021 21:43, Arne Schwabe wrote:
> clang does not like if the format argument of printf like function
> is not a string literal:
> 
> warning: format string is not a string literal (potentially insecure)
> 
> Use "%s" as string literal to silence the warning.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8978955c3..5ecb7b7db 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2077,7 +2077,7 @@ check_ca_required(const struct options *options)
>          " or CA path (--capath)"
>  #endif
>          " and/or peer fingerprint verification (--peer-fingerprint)";
> -    msg(M_USAGE, str);
> +    msg(M_USAGE, "%s", str);

Imho this warning is a borderline one.

Rather than using %s as clang suggests, I am more in favor of the following:


diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 819979b1..086f7b6e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2069,7 +2069,7 @@ check_ca_required(const struct options *options)
         return;
     }

-    const char* str = "You must define CA file (--ca)"
+    const char* const str = "You must define CA file (--ca)"
 #ifndef ENABLE_CRYPTO_MBEDTLS
         " or CA path (--capath)"
 #endif



Passing "%s" just to make clang happy looks weird to me.

Regards,



-- 
Antonio Quartulli

