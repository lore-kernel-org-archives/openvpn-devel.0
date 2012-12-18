Date: Tue, 18 Dec 2012 23:43:47 +0100
From: Jeremie Le Hen <jeremie@...1793...>
Message-ID: <20121218224347.GJ23292@...1794...>
References: <20121217220355.GB23292@...1794...>
MIME-Version: 1.0
In-Reply-To: <20121217220355.GB23292@...1794...>
Subject: Re: [Openvpn-devel] Fixing "passtos" on !Linux
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
To: openvpn-devel@lists.sourceforge.net

Hi again,

I saw that 2.3-RC2 has been released.  Any chance to get this committed
before the release?

Regards,

On Mon, Dec 17, 2012 at 11:03:55PM +0100, Jeremie Le Hen wrote:
> Hi!
> 
> On non-Linux systems (that is I checked on FreeBSD, NetBSD, OpenBSD,
> DragonflyBSD, Darwin, Solaris and IllumOS), setsockopt(2) with the
> IP_TOS option expects a pointer to a int rather than a char.  Therefore
> this doesn't work on little-endian systems (x86 is the main victim).
> 
> The problem is well understood, a fix has been posted by Torsten Vielhak
> on the bug tracker nearly 2 years ago but the problem has remained
> ignored, probably because the author didn't bring it to your attention.
> The patch only handled FreeBSD though.  See ticket/135.
> 
> I thereby kindly ask you to bring this patch in the source tree.  I
> don't know about your release procedure, but it would be really nice if
> it could hit the tree before 2.3 is released.
> 
> Relevant manpages:
> http://www.freebsd.org/cgi/man.cgi?query=ip&format=html
> http://netbsd.gw.com/cgi-bin/man-cgi?ip
> http://www.openbsd.org/cgi-bin/man.cgi?query=ip&format=html
> http://leaf.dragonflybsd.org/cgi/web-man?command=ip&section=ANY
> https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man4/ip.4.html
> http://docs.oracle.com/cd/E19082-01/819-2254/ip-7p/index.html
> http://illumos.org/man/7p/ip
> 
> 
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 9cb01fa..07224c4 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -237,7 +237,21 @@ struct link_socket
>  
>  #if PASSTOS_CAPABILITY
>    /* used to get/set TOS. */
> +#if defined(TARGET_LINUX)
>    uint8_t ptos;
> +#elif defined(TARGET_SOLARIS)
> +  int ptos;
> +#elif defined(TARGET_OPENBSD)
> +  int ptos;
> +#elif defined(TARGET_NETBSD)
> +  int ptos;
> +#elif defined(TARGET_FREEBSD)
> +  int ptos;
> +#elif defined(TARGET_DRAGONFLY)
> +  int ptos;
> +#elif defined(TARGET_DARWIN)
> +  int ptos;
> +#endif
>    bool ptos_defined;
>  #endif
> 
>  
> Cheers,
> -- 
> Jeremie Le Hen                        jeremie.le-hen.org jlh.freebsd.org
>                               (emails above use SOA record-style format)
> Scientists say the world is made up of Protons, Neutrons and Electrons.
> They forgot to mention Morons.

-- 
Jeremie Le Hen

Scientists say the world is made up of Protons, Neutrons and Electrons.
They forgot to mention Morons.

