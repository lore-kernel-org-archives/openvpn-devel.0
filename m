From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 21 Oct 2015 10:33:37 +0300
Message-ID: <56273FD1.30200@...277...>
References: <1445380744-21086-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
In-Reply-To: <1445380744-21086-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: remove usage of
 OPENSSL_malloc() from show_available_curves
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK from me. Less code is better.

On 21.10.2015 01:39, Steffan Karger wrote:
> There is no need to use OPENSSL_malloc(), so use our own functions that
> automatically check for NULL and remove the now redundant NULL check.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>   src/openvpn/ssl_openssl.c | 33 +++++++++++++--------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index c08d4fe..c5543fe 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1447,31 +1447,24 @@ show_available_curves()
>     size_t n = 0;
>
>     crv_len = EC_get_builtin_curves(NULL, 0);
> -
> -  curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
> -
> -  if (curves == NULL)
> -    crypto_msg (M_FATAL, "Cannot create EC_builtin_curve object");
> -  else
> +  ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
> +  if (EC_get_builtin_curves(curves, crv_len))
>     {
> -    if (EC_get_builtin_curves(curves, crv_len))
> +    printf ("Available Elliptic curves:\n");
> +    for (n = 0; n < crv_len; n++)
>       {
> -      printf ("Available Elliptic curves:\n");
> -      for (n = 0; n < crv_len; n++)
> -      {
> -        const char *sname;
> -        sname   = OBJ_nid2sn(curves[n].nid);
> -        if (sname == NULL) sname = "";
> +      const char *sname;
> +      sname   = OBJ_nid2sn(curves[n].nid);
> +      if (sname == NULL) sname = "";
>
> -        printf("%s\n", sname);
> -      }
> +      printf("%s\n", sname);
>       }
> -    else
> -    {
> -      crypto_msg (M_FATAL, "Cannot get list of builtin curves");
> -    }
> -    OPENSSL_free(curves);
>     }
> +  else
> +  {
> +    crypto_msg (M_FATAL, "Cannot get list of builtin curves");
> +  }
> +  free(curves);
>   #else
>     msg (M_WARN, "Your OpenSSL library was built without elliptic curve support. "
>   	       "No curves available.");
>



