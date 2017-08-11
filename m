References: <20170811090744.31750-1-a@...2181...>
 <20170811090744.31750-5-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <aeb17a7c-ee50-1212-6103-961402856d09@...1856...>
Date: Fri, 11 Aug 2017 21:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170811090744.31750-5-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/5] remove unused functions
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

On 11-08-17 11:07, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/misc.c        | 23 -----------------------
>  src/openvpn/ssl.c         | 10 ----------
>  src/openvpn/ssl_openssl.c |  6 ------
>  3 files changed, 39 deletions(-)
> 
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 07775992..a599fd70 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -448,29 +448,6 @@ construct_name_value(const char *name, const char *value, struct gc_arena *gc)
>      return BSTR(&out);
>  }
>  
> -bool
> -deconstruct_name_value(const char *str, const char **name, const char **value, struct gc_arena *gc)
> -{
> -    char *cp;
> -
> -    ASSERT(str);
> -    ASSERT(name && value);
> -
> -    *name = cp = string_alloc(str, gc);
> -    *value = NULL;
> -
> -    while ((*cp))
> -    {
> -        if (*cp == '=' && !*value)
> -        {
> -            *cp = 0;
> -            *value = cp + 1;
> -        }
> -        ++cp;
> -    }
> -    return *name && *value;
> -}
> -
>  static bool
>  env_string_equal(const char *s1, const char *s2)
>  {
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 45b20e56..460ef9e8 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2177,16 +2177,6 @@ read_string_alloc(struct buffer *buf)
>      return str;
>  }
>  
> -void
> -read_string_discard(struct buffer *buf)
> -{
> -    char *data = read_string_alloc(buf);
> -    if (data)
> -    {
> -        free(data);
> -    }
> -}
> -
>  /*
>   * Handle the reading and writing of key data to and from
>   * the TLS control channel (cleartext).
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 7ad6414e..fa06f068 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -797,12 +797,6 @@ tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
>      tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, NULL);
>  }
>  
> -void
> -tls_ctx_free_cert_file(X509 *x509)
> -{
> -    X509_free(x509);
> -}
> -
>  int
>  tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
>                         bool priv_key_file_inline)
> 

Verified that these are indeed not used, and safe to remove.  ACK.

-Steffan

