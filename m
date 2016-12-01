Date: Thu, 1 Dec 2016 18:29:37 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161201102937.GQ19791@...2182...>
References: <20161201065534.15050-1-a@...2181...>
	<631a86a3-e0f3-4391-2241-16848ce9c686@...1856...>
MIME-Version: 1.0
In-Reply-To: <631a86a3-e0f3-4391-2241-16848ce9c686@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] reload CRL only if file was modified
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Dec 01, 2016 at 09:13:36AM +0100, Steffan Karger wrote:
> Hi,
> 
> Tested on linux and windows, works as expected, except for one thing:
> 
> On 01-12-16 07:55, Antonio Quartulli wrote:
> > +  /*
> > +   * an inline CRL can't change at runtime, therefore there is no need to
> > +   * reload it. It will be reloaded upon config change + SIGHUP.
> > +   * Use always '1' as dummy timestamp in this case: it will trigger the
> > +   * first load, but will prevent any future reload.
> > +   */
> > +  if (crl_file_inline)
> > +    crl_stat.st_mtime = 1;
> > +  else
> > +    platform_stat(crl_file, &crl_stat);
> 
> I still think this should issue a warning when we do not reload the CRL
> because platform_stat() fails, e.g. due to the CRL file missing.  So, if
> we replace this with:
> 
>   if (crl_file_inline)
>     {
>       crl_stat.st_mtime = 1;
>     }
>   else if (0 != platform_stat(crl_file, &crl_stat))
>     {
>       msg (M_WARN, "WARNING: Failed to stat CRL file, using cached CRL.");
>     }
> 
> I can ACK this.
> 
> Since the deadline for 2.4_rc1 is this afternoon (CET), and Antonio
> seems to be awake at quite different times than the Europeans doing the
> tagging, maybe one of the committers can make this change on the file if
> he agrees?  Of course, if Antonio does read this in time, a v3 would be
> even better!

v3 is coming ;)

> 
> Thanks,
> -Steffan
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

