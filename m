Date: Thu, 23 Jun 2022 18:17:30 +0200
From: frank@...2641...
Message-ID: <YrSSGjmdav75AiEN@...2678...>
References: <20220512231901.1077306-1-heiko@...2662...>
MIME-Version: 1.0
In-Reply-To: <20220512231901.1077306-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] make %x destination unsigned
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Trivial and looks correct to me according to the
man sscanf.

On Fri, May 13, 2022 at 01:19:01AM +0200, Heiko Hund wrote:
> The %x specifier requires for the argument to be an unsigned int.
> 
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9ff384d0..3dbd3fab 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1104,7 +1104,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>      ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
>  
>      char term = 0;
> -    int byte;
> +    unsigned int byte;
>  
>      while (*cp && i < nbytes)
>      {
> -- 
> 2.32.0

