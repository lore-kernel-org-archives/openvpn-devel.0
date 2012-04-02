Message-ID: <4F79500E.6060005@...1435...>
Date: Mon, 2 Apr 2012 09:06:54 +0200
From: Adriaan de Jong <dejong@...1435...>
MIME-Version: 1.0
References: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
	<1333287988-25921-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333287988-25921-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: gc usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 04/01/2012 03:46 PM, Alon Bar-Lev wrote:
> Cleanup of "Use the garbage collector when retrieving x509 fields"
> patch series.
>
> Discussed at [1].
>
> There should be an effort to produce common function prologue
> and epilogue, so that cleanups will be done at single point.
>
> [1] http://comments.gmane.org/gmane.network.openvpn.devel/5401
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  
>  int
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 5783528..30fb05d 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -538,8 +538,9 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
>  static result_t
>  verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
>  {
> +  result_t ret = FAILURE;
>    char fn[256];
> -  int fd;
> +  int fd = -1;
>    struct gc_arena gc = gc_new();
>  
>    char *serial = x509_get_serial(cert, &gc);
> @@ -547,26 +548,29 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
>    if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
>      {
>        msg (D_HANDSHAKE, "VERIFY CRL: filename overflow");
> -      gc_free(&gc);
> -      return FAILURE;
> +      goto cleanup;
>      }
>    fd = platform_open (fn, O_RDONLY, 0);
>    if (fd >= 0)
>      {
>        msg (D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revoked", serial);
> -      close(fd);
> -      gc_free(&gc);
> -      return FAILURE;
> +      goto cleanup;
>      }
>  
> -  gc_free(&gc);
> +  ret = SUCCESS;
>  
> -  return SUCCESS;
> +cleanup:
> +
> +  if (fd != -1)
> +    close(fd);
> +  gc_free(&gc);
> +  return ret;
>  }
>  
Thanks, looks good. Does platform_open return -1 on failure on all
platforms? If so, ack, otherwise change that to < 0.

Adriaan

