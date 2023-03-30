Date: Thu, 30 Mar 2023 15:19:20 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZCWMWHtignrX5odm@...2685...>
References: <20221127085933.3487177-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221127085933.3487177-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] [RFC] fix warning with gcc 12.2.0
 (compiler bug?)
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
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Nov 27, 2022 at 09:59:33AM +0100, Arne Schwabe wrote:
> Changing the argument of check_malloc_return from const void* to void*
> removes the warning from gcc 12.2.0:
> 
> In file included from ../../../openvpn-git/src/openvpn/crypto_openssl.c:40:
> ../../../openvpn-git/src/openvpn/buffer.h: In function ‘hmac_ctx_new’:
> ../../../openvpn-git/src/openvpn/buffer.h:1030:9: warning: ‘ctx’ may be used uninitialized [-Wmaybe-uninitialized]
>  1030 |         check_malloc_return((dptr) = (type *) malloc(sizeof(type))); \
>       |         ^~~~~~~~~~~~~~~~~~~
> ../../../openvpn-git/src/openvpn/buffer.h:1076:1: note: by argument 1 of type ‘const void *’ to ‘check_malloc_return’ declared here
>  1076 | check_malloc_return(const void *p)
>       | ^~~~~~~~~~~~~~~~~~~
> 
> This more a quick fix/heads up for other people encountering the issue
> on GCC 12.2.0 like on Ubuntu 22.10 until we figure out if this is a bug in
> our code or a compiler bug.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/buffer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index fece6336d..9ad281562 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -1073,7 +1073,7 @@ gc_reset(struct gc_arena *a)
>      }
>  
>  static inline void
> -check_malloc_return(const void *p)
> +check_malloc_return(void *p)
>  {
>      if (!p)
>      {

Seen this with gcc 11.3 on Ubuntu 22.04 as well. It only seems to occur
on -O0, probably since check_malloc_return will be inlined otherwise.

I would suggest to go ahead with applying the patch. While I think that
in our specific case it is a false-positive, the general assumption
"a const pointer to a clearly uninitialized area is not useful" is
valid in general. Testing the pointer for NULL like we do is literally
the one and only thing you can do with it.

On anything other than -O0 it will make no difference anyway. And removing
the const is much less ugly than to add some pragmas for gcc to suppress
the warning.

So:
Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

