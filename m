Date: Mon, 19 Dec 2022 13:21:37 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6BXURT8t2+o++1O@...2685...>
References: <20221218192203.1214943-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20221218192203.1214943-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not include auth-token in pulled
 option digest
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Dec 18, 2022 at 02:22:03PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> As change in auth-token is common on restart and does not
> require tun-reopen, exclude it from the "pulled options digest"
> calculation. Without this tun is always re-opened on SIGUSR1
> if auth-token is in use which breaks persist-tun.
> 
> Fixes #200
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/push.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index ad2f3c65..95e3ae49 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -989,8 +989,8 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
>      char line[OPTION_PARM_SIZE];
>      while (buf_parse(buf, ',', line, sizeof(line)))
>      {
> -        /* peer-id might change on restart and this should not trigger reopening tun */
> -        if (strprefix(line, "peer-id "))
> +        /* peer-id and auth-token might change on restart and this should not trigger reopening tun */
> +        if (strprefix(line, "peer-id ") || strprefix(line, "auth-token"))

If I interpret this correctly, this will also exclude auth-token-user, because you didn't
add the space after the option name like for peer-id. This should either be reflected
in the comment above or changed.

Regards,
-- 
  Frank Lichtenheld

