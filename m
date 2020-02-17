References: <20200217082942.173-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <bf6eab71-8ec4-70b5-b4de-3b19de8bff6e@...2181...>
Date: Mon, 17 Feb 2020 09:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200217082942.173-1-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] ssl.c: refactor
 tls_item_in_cipher_list() code
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/02/2020 09:29, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
>  - remove unneeded _orig variable which stores pointer
> to tokenized string. Unlike strsep(), strtok() doesn't modify
> pointer itself, only string, so it is safe to call free() on that pointer.
> 

this makes sense. We can just get rid of tmp_ciphers_orig and directly
free tmp_ciphers.

>  - "token" points to content inside tokenized string. It becomes
> dangling pointer after freeing that string. Check its value before
> free() call.

To me this change is not necessary and the reason behind it is wrong.
(It is also ugly from the style perspective :-P)

> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/ssl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index e708fc93..8cba3a76 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1918,7 +1918,6 @@ bool
>  tls_item_in_cipher_list(const char *item, const char *list)
>  {
>      char *tmp_ciphers = string_alloc(list, NULL);
> -    char *tmp_ciphers_orig = tmp_ciphers;
>  
>      const char *token = strtok(tmp_ciphers, ":");
>      while (token)
> @@ -1929,9 +1928,11 @@ tls_item_in_cipher_list(const char *item, const char *list)
>          }
>          token = strtok(NULL, ":");
>      }
> -    free(tmp_ciphers_orig);
>  
> -    return token != NULL;

This expression simply checks that token contains a value different from
NULL. It's like a simple "a != 0" - it doesn't matter where that address
points to, because the pointer is not dereferenced.

> +    bool found = token != NULL;
> +    free(tmp_ciphers);
> +
> +    return found;

For the reason above I think this change is useless (And even a bit ugly :p)


NAK.

In the future I suggest splitting unrelated changes like these in
different patches.

Assuming we had merged both, at some point of them might need to be
reverted (for whatever reason and due to both fixes being in one patch,
we would not be able to do that.

Cheers,

>  }
>  
>  void
> 

-- 
Antonio Quartulli

