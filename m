References: <009203331.11779-1-gert@...1296...>
 <20201010081435.2154-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d26eed8f-8f03-540f-c6c5-bd329e235e00@...1856...>
Date: Sat, 10 Oct 2020 11:08:20 +0200
MIME-Version: 1.0
In-Reply-To: <20201010081435.2154-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Fix compilation on pre-EKM mbedTLS
 libraries.
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 10-10-2020 10:14, Gert Doering wrote:
> commit f0734e49956217 simplified key_state_export_keying_material(),
> changing the function prototype.  For older mbedTLS versions, there
> is an "always fail" dummy function which was overlooked in that change.
> 
> Fix prototype.
> 
> v2: also adjust function return (NULL -> false)
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/ssl_mbedtls.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index bb5633b7..11fbeae4 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -252,14 +252,13 @@ key_state_export_keying_material(struct tls_session *session,
>      }
>  }
>  #else
> -unsigned char*
> +bool
>  key_state_export_keying_material(struct tls_session *session,
>                                   const char* label, size_t label_size,
> -                                 size_t ekm_size,
> -                                 struct gc_arena *gc)
> +                                 void *ekm, size_t ekm_size)
>  {
>      /* Dummy function to avoid ifdefs in the common code */
> -    return NULL;
> +    return false;
>  }
>  #endif /* HAVE_EXPORT_KEYING_MATERIAL */
>  
> 

Sorry, totally missed this. Fix looks good.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

