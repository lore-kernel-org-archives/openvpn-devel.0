Date: Fri, 26 Aug 2022 11:10:44 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwiOFGImmAdwYEtF@...2685...>
References: <20220826085427.25302-1-frank@...2641...>
 <20220826085427.25302-7-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20220826085427.25302-7-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] reformat for sp_arith=add
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

On Fri, Aug 26, 2022 at 10:54:27AM +0200, Frank Lichtenheld wrote:
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

Looking a bit closer at the changes this one seems slightly broken.

Examples:

> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 2a6c0b8b..7ad19bf7 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
[...]
> @@ -217,7 +217,7 @@ prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
>  /* *INDENT-ON* */
>  #define MAC_PRINT_ARG(_mac) _mac[0], _mac[1], _mac[2],  \
>      _mac[3], _mac[4], _mac[5]
> -#define MAC_SCAN_ARG(_mac) &_mac[0], &_mac[1], &_mac[2], \
> +#define MAC_SCAN_ARG(_mac) & _mac[0], &_mac[1], &_mac[2], \
>      &_mac[3], &_mac[4], &_mac[5]
>  
>  #endif /* ifndef MISC_H */
[...]
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 9d89bd0a..26e99f24 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -211,7 +211,7 @@ X509_get0_pubkey(const X509 *x)
>   * @return                   the X509 object stack
>   */
>  static inline STACK_OF(X509_OBJECT)
> -*X509_STORE_get0_objects(X509_STORE *store)
> +* X509_STORE_get0_objects(X509_STORE * store)
>  {
>      return store ? store->objs : NULL;
>  }

So this seems to misinterpret '*' and '&' after ')'.
This doesn't break compilation but is really ugly and confusing.

So NAKing my own patch ;)

Regards,
  Frank

