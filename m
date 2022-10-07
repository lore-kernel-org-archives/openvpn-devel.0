Date: Fri, 7 Oct 2022 12:22:43 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yz/98xq5nt+rngnE@...2685...>
References: <20220826085427.25302-1-frank@...2641...>
 <20220826085427.25302-6-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20220826085427.25302-6-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] uncrustify: add space around all
 arithmetic operators
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

On Fri, Aug 26, 2022 at 10:54:26AM +0200, Frank Lichtenheld wrote:
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  dev-tools/uncrustify.conf | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
> index 3c721396..d5c2a8a7 100644
> --- a/dev-tools/uncrustify.conf
> +++ b/dev-tools/uncrustify.conf
> @@ -34,8 +34,7 @@ sp_inside_sparen=remove
>  sp_cond_colon=add
>  sp_cond_question=add
>  sp_bool=add
> -sp_arith=ignore
> -sp_arith_additive=add
> +sp_arith=add
>  sp_compare=add
>  sp_else_brace=add
>  sp_brace_else=add
> -- 

Just for the benefit of the list: The NACK for 6/6 obviously also
includes 5/6.

Regards,
-- 
  Frank Lichtenheld

