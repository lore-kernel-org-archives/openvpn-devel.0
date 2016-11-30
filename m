Date: Wed, 30 Nov 2016 09:16:09 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161130011609.GO19791@...2182...>
References: <20161129063843.14526-1-a@...2181...>
	<aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
MIME-Version: 1.0
In-Reply-To: <aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Nov 29, 2016 at 05:43:33PM +0100, Steffan Karger wrote:

[CUT..]

> >  
> > +void
> > +tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
> > +		   const char *crl_file_inline, bool reload)
> 
> This is only used within ssl.c, so should be static and have a function
> declaration, preferably doxygen-documented, at the beginning of ssl.c.

You're absolutely right about this function supposed to be static. I missed
that.

Do I really need to split declaration and definition? Or can I just
doxy-document the definition in the same place where it is now?

> 
> > +{
> > +  /* if something goes wrong with stat(), we'll store 0 as mtime */
> > +  platform_stat_t crl_stat = {0};
> > +
> > +  /*
> > +   * an inline CRL can't change at runtime, therefore there is no need to
> > +   * reload it. It will be reloaded upon config change + SIGHUP.
> > +   */
> > +  if (crl_file_inline && reload)
> > +    return;
> > +
> > +  if (!crl_file_inline)
> > +    platform_stat(crl_file, &crl_stat);
> > +
> > +  /*
> > +   * If this is not a reload, update the CRL right away.
> > +   * Otherwise, update only if the CRL file was modified after the last reload.
> > +   * Note: Windows does not support tv_nsec.
> > +   */
> > +  if (reload &&
> > +      (ssl_ctx->crl_last_mtime.tv_sec >= crl_stat.st_mtime))
> > +    return;
> > +
> > +  ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
> > +  backend_tls_ctx_reload_crl(ssl_ctx, crl_file, crl_file_inline);
> > +}
> 
> This can be done without the 'reload' argument too, something like:
> 
>   /* if something goes wrong with stat(), we'll store 0 as mtime */
>   platform_stat_t crl_stat = {0};
> 
>   if (crl_file_inline)
>     {
>       /*
>        * an inline CRL can't change at runtime, therefore there is no
> need to
>        * reload it. It will be reloaded upon config change + SIGHUP.
>        */
>       if (ssl_ctx->crl_last_mtime.tv_sec)
> 	return;
>       else
>         crl_stat.st_mtime = now; /* Set dummy mtime */
>     }
>   else
>     {
>       platform_stat (crl_file, &crl_stat);
>     }
> 
>   /*
>    * If this is not a reload, update the CRL right away.
>    * Otherwise, update only if the CRL file was modified after the last
> reload.
>    * Note: Windows does not support tv_nsec.
>    */
>   if (ssl_ctx->crl_last_mtime.tv_sec <= crl_stat.st_mtime)
>     {
>       ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
>       backend_tls_ctx_reload_crl (ssl_ctx, crl_file, crl_file_inline);
>     }
> 
> I slightly prefer this over adding the extra argument, but can live with
> your approach just fine too.  Pick what you like best :)

I guess the assumption here is that crl_last_mtime.tv_sec is initialized with 0.
This would make your code work. And yeah, I also prefer to avoid the reload
argument ;)


Will make these changes and resend the patch.

Thanks for the comments!

Cheers,

-- 
Antonio Quartulli

