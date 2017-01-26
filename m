Date: Thu, 26 Jan 2017 15:08:15 +0100
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20170126140815.GM1074@...2038...>
References: <20161021154630.GT25148@...2038...>
	<20161021165926.GV25148@...2038...>
	<20161030134825.GB1791@...2038...>
	<792ca4e9-ca51-0764-bd71-a005ac82a9b3@...1227...>
MIME-Version: 1.0
In-Reply-To: <792ca4e9-ca51-0764-bd71-a005ac82a9b3@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Allow to specify bind interface for
 outbound/inbound connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

Anno domini 2017 Arne Schwabe scripsit:

> A quick from me.

Cool, thanks.

> > diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> > index 73f8c6d..57b1423 100644
> > --- a/src/openvpn/init.c
> > +++ b/src/openvpn/init.c
> > @@ -2856,7 +2856,8 @@ do_init_socket_1 (struct context *c, const int mode)
> >  			   c->options.sndbuf,
> >  			   c->options.mark,
> >  			   &c->c2.server_poll_interval,
> > -			   sockflags);
> > +			   sockflags,
> > +			   c->options.bind_dev);
> >  }
> 
> Should be after the after c->options options.

Ok, will reorder.

> >  /*
> > diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> > index 281ef0b..58dd298 100644
> > --- a/src/openvpn/options.c
> > +++ b/src/openvpn/options.c
> > @@ -167,6 +167,8 @@ static const char usage_message[] =
> >                     " or --socks-proxy"
> >                     " is used).\n"
> >    "--nobind        : Do not bind to local address and port.\n"
> > +  "--bind-dev dev  : Bind to the given device when making connection to a peer or\n"
> > +  "                  listening for connections\n"
> >    "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device.\n"
> >    "--dev-type dt   : Which device type are we using? (dt = tun or tap) Use\n"
> >    "                  this option only if the tun/tap device used with --dev\n"
> > @@ -5128,6 +5130,13 @@ add_option (struct options *options,
> >  	    msg (msglevel, "unknown socket flag: %s", p[j]);	    
> >  	}
> >      }
> > +#ifdef TARGET_LINUX
> > +  else if (streq (p[0], "bind-dev") && p[1])
> > +    {
> > +      VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
> > +      options->bind_dev = p[1];
> > +    }
> > +#endif
> Better use something like HAVE_BIND_TO_DEVICE or similar. Your define
> also misses FREEBSD here.

Should this really get an extra define for this feature?
I see the FREEBSD point, though.

> >    else if (streq (p[0], "txqueuelen") && p[1] && !p[2])
> >      {
> >        VERIFY_PERMISSION (OPT_P_GENERAL);
> > diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> > index b7453a0..3ce4550 100644
> > --- a/src/openvpn/options.h
> > +++ b/src/openvpn/options.h
> > @@ -325,6 +325,7 @@ struct options
> >  
> >    /* socket flags */
> >    unsigned int sockflags;
> > +  char *bind_dev;
> >  
> >    /* route management */
> >    const char *route_script;
> > diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> > index 184c7ad..b345de2 100644
> > --- a/src/openvpn/socket.c
> > +++ b/src/openvpn/socket.c
> > @@ -868,6 +868,15 @@ create_socket (struct link_socket* sock, struct addrinfo* addr)
> >      /* set socket to --mark packets with given value */
> >      socket_set_mark (sock->sd, sock->mark);
> >  
> > +  if (sock->bind_dev)
> > +    {
> > +#if defined(TARGET_LINUX)
> > +      setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1);
> > +#elif defined(TARGET_FREEBSD)
> > +      setsockopt(fd, SOL_SOCKET, IP_SENDIF, sock->bind_dev, strlen (sock->bind_dev) + 1);
> > +#endif
> > +    }
> > +
> The +1 looks strange. A comment why this has to be +1.

That's stolen from the upstream documentation:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/vrf.txt

> I cannot find that IP_SENDIF in any freebsd man page or /usr/include on
> a 10.3 system. I don't think this option exists.

I just googled for this part as I don't have any BSD-ish machines
here. That part is purely theoretical, that's why I asked for testers :)

If this turns out to be wrong I'd just remove this. My understanding
on what I found on the net was that this would have the same effect as
the Linux version so I considered it worth a try.

Best
Max
-- 
Friends are relatives you make for yourself.

