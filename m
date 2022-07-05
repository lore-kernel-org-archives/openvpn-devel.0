From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:38:22 +0200
Message-ID: <5043494.lAjphJqujW@...2664...>
In-Reply-To: <20220705091842.24053-1-a@...2181...>
References: <20220705091842.24053-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] networking: fix doc for net_iface_new()
 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Dienstag, 5. Juli 2022 11:18:42 CEST Antonio Quartulli wrote:
> Some auto correction must have sneaked in.
> Restore proper wording.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/networking.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
> index 647718e0..79963756 100644
> --- a/src/openvpn/networking.h
> +++ b/src/openvpn/networking.h
> @@ -94,7 +94,8 @@ void net_ctx_free(openvpn_net_ctx_t *ctx);
>   * @param iface     interface to create
>   * @param type      string describing interface type
>   * @param arg       extra data required by the specific type
> - * @return int 0 on success, negative error code on error
> + *
> + * @return          0 on success, negative error code on error
>   */
>  int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
> const char *type, void *arg);

Acked-by: Heiko Hund <heiko@...2662...>




