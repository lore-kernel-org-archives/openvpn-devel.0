Date: Mon, 29 Jun 2020 10:25:46 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20200629082546.GD31553@...2038...>
References: <1593197385-30618-1-git-send-email-max@...1047...>
 <1593197385-30618-2-git-send-email-max@...1047...>
 <20200629072053.GK1431@...1296...>
MIME-Version: 1.0
In-Reply-To: <20200629072053.GK1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add --bind-dev option.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Anno domini 2020 Gert Doering scripsit:

Hi,

> reading this more closely at merging/testing time, I do have a change
> request...
> 
> On Fri, Jun 26, 2020 at 08:49:44PM +0200, Maximilian Wilhelm wrote:
> > +#ifdef TARGET_LINUX
> > +    else if (streq (p[0], "bind-dev") && p[1])
> > +    {
> > +        VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
> > +        options->bind_dev = p[1];
> > +    }
> > +#endif
> 
> One could argue whether the argument should be changed for IFNAMSIZ here
> (so we can error-out right away if it's too long).  But this is just 
> something to consider.

That might be a bad idea as of upcoming altnames, see

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a56493f0620cc1b4cffc9bc59289fdefe76b5f3

> > --- a/src/openvpn/socket.c
> > +++ b/src/openvpn/socket.c
> > @@ -1138,6 +1138,14 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
> >      /* set socket to --mark packets with given value */
> >      socket_set_mark(sock->sd, sock->mark);
> >  
> > +#if defined(TARGET_LINUX)
> > +    if (sock->bind_dev)
> > +    {
> > +        msg (M_INFO, "Using bind-dev %s", sock->bind_dev);
> > +        setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1);
> > +    }
> > +#endif
> 
> Here, we *must* have a return code check, and logging of an error message
> if setsocktopt() fails.
> 
> Imagine someone calling "openvpn --bind-dev eht0" (because he has fat
> fingers).  The current code will silently fail the setsockopt() - because
> there is no such interface name - but nothing in the logs will show a hint
> *why* openvpn is just not doing what requested.

I'll look into that and add a patch for that.

Best
Max
-- 
"I have to admit I've always suspected that MTBWTF would be a more useful
 metric of real-world performance."
 -- Valdis Kletnieks on NANOG

