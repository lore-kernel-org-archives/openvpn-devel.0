Date: Thu, 16 Mar 2017 15:35:35 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170316073535.GD15280@...2182...>
References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
	<20170315210046.GW93896@...1296...>
MIME-Version: 1.0
In-Reply-To: <20170315210046.GW93896@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 15, 2017 at 10:00:47PM +0100, Gert Doering wrote:
> > diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
> > index c64c65f..a974e7e 100644
> > --- a/src/openvpn/ssl_openssl.h
> > +++ b/src/openvpn/ssl_openssl.h
> > @@ -49,7 +49,11 @@
> >    */
> >   struct tls_root_ctx {
> >       SSL_CTX *ctx;
> > +#ifdef _MSC_VER
> > +    struct timeval crl_last_mtime;
> > +#else
> >       struct timespec crl_last_mtime;
> > +#endif
> >       off_t crl_last_size;
> >   };
> 
> 
> We should not do this.  It's not your fault for finding this, but having
> looked at the code to understand why this would be fixing things, I 
> wonder why we're using a "struct timespec" in the first place, or
> why we're having a structure "with subseconds" in there when all we use
> is the "seconds" bit *because* "windows has no nanoseconds"...
> 
> src/openvpn/ssl.c
> 
>     /*
>      * Store the CRL if this is the first time or if the file was changed since
>      * the last load.
>      * Note: Windows does not support tv_nsec.
>      */
>     if ((ssl_ctx->crl_last_size == crl_stat.st_size)
>         && (ssl_ctx->crl_last_mtime.tv_sec == crl_stat.st_mtime))
> ...
>     ssl_ctx->crl_last_mtime.tv_sec = crl_stat.st_mtime;
>     ssl_ctx->crl_last_size = crl_stat.st_size;
> 
> 
> Antonio, this is your code - how shall we handle this?
> 
> Today, we only use seconds, so "struct timeval" on all platforms would
> be good enough.  Some platforms' "struct stat" actually has a st_mtim
> which is a "struct timespec" (and st_mtime is defined as st_mtim.tv_sec),
> so if we ever go for subsecond accuracy, timespec is the right thing to
> do - OTOH, that will need at least one extra configure test, given
> how various OSes <sys/stat.h> weasle around "struct timespec"...
> 
> #if (_POSIX_C_SOURCE - 0) >= 200809L || (_XOPEN_SOURCE - 0) >= 700 || \
>     defined(_NETBSD_SOURCE)
>         struct    timespec st_atim;     /* time of last access */
>         struct    timespec st_mtim;     /* time of last data modification */
>         struct    timespec st_ctim;     /* time of last file status change */
>         struct    timespec st_birthtim; /* time of creation */
> #else
>         time_t    st_atime;             /* time of last access */
>         long      st_atimensec;         /* nsec of last access */
>         time_t    st_mtime;             /* time of last data modification */
>         long      st_mtimensec;         /* nsec of last data modification */
> ...
> 
> 
> So, it might be worth considering just dropping the notion of interest
> in subseconds, and go for a plain "time_t" for "crl_last_mtime"...
> (slightly more code changes, but less portability hassle).
> 
> Again, Antonio, your call...

thanks for pointing this out.
IMHO we could go for time_t and get rid of timespec at all.
struct timespec was version in the first version of my patch, but it lost sense
once it was discovered that we can't easily support subsecond units on every
platform.

If there is no objection, I'll send a patch for this.


Cheers,


-- 
Antonio Quartulli

