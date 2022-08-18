Message-ID: <94fc3f02ebc035e37b29c6ec54b773ec.squirrel@...2556...>
In-Reply-To: <20220818080550.177771-1-a@...2181...>
References: <20220818080550.177771-1-a@...2181...>
Date: Thu, 18 Aug 2022 10:23:21 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] ssh_util: fix prototype style
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

Hi,

Typo, subject should probably be s/ssh_util/ssl_util

Regards,
Simon

> Function prototypes should have the return type on the same line as the
> function name itself. Fix this in ssl_util.h.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/ssl_util.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
> index f38294c1..3695ca3c 100644
> --- a/src/openvpn/ssl_util.h
> +++ b/src/openvpn/ssl_util.h
> @@ -41,10 +41,8 @@
>   * @return  The content of the variable as NULL terminated string or NULL
> if the
>   *          variable cannot be found.
>   */
> -char *
> -extract_var_peer_info(const char *peer_info,
> -                      const char *var,
> -                      struct gc_arena *gc);
> +char *extract_var_peer_info(const char *peer_info, const char *var,
> +                            struct gc_arena *gc);
>
>  /**
>   * Extracts the IV_PROTO variable and returns its value or 0
> @@ -52,8 +50,7 @@ extract_var_peer_info(const char *peer_info,
>   *
>   * @param peer_info     peer info string to search for IV_PROTO
>   */
> -unsigned int
> -extract_iv_proto(const char *peer_info);
> +unsigned int extract_iv_proto(const char *peer_info);
>
>  /**
>   * Takes a locally produced OCC string for TLS server mode and modifies
> as
> @@ -67,6 +64,6 @@ extract_iv_proto(const char *peer_info);
>   * @param gc        gc_arena to allocate the returned string in
>   * @return          the modified string or options on error
>   */
> -const char *
> -options_string_compat_lzo(const char *options, struct gc_arena *gc);
> +const char *options_string_compat_lzo(const char *options, struct
> gc_arena *gc);
> +
>  #endif
> --
> 2.30.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



