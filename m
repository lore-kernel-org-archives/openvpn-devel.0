References: <20180815061240.5027-1-a@...2181...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
Date: Thu, 16 Aug 2018 13:08:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180815061240.5027-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
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

Am 15.08.2018 um 08:12 schrieb Antonio Quartulli:
> The "cleanup" label in ssl_verify.c:verify_user_pass_plugin() is used
> only when PLUGIN_DEF_AUTH is defined, therefore make the label
> definition dependent on the same define.
>
> Fixes the following warning when PLUGIN_DEF_AUTH is not defined:
>
> ssl_verify.c: In function 'verify_user_pass_plugin':
> ssl_verify.c:1223:1: warning: label 'cleanup' defined but not used [-Wunused-label]
>  cleanup:
>  ^~~~~~~
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/ssl_verify.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 61872251..5b46ea72 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1220,7 +1220,9 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): peer provided a blank username");
>      }
>  
> +#ifdef PLUGIN_DEF_AUTH
>  cleanup:
> +#endif
>      return retval;
>  }
>  

NAK.

This is useless #ifdef noise in the code and makes it harder to read,
for compile-time cosmetics.

If you don't want the warnings, feed a proper -Wno-unused-label to your
compiler and move on.


