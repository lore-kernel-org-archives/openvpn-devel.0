Message-Id: <200406192330.i5JNURKh096362@...242...>
Subject: Re: [Openvpn-devel] Enabling multicast on OpenBSD tun interface 
In-Reply-To: Message from "James Yonan" <jim@...41...> 
   of "Sat, 19 Jun 2004 23:15:08 -0000." <twig.1087686908.13338@...41...> 
From: Pavlin Radoslavov <pavlin@...241...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jun 20 10:29:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Pavlin Radoslavov <pavlin@...241...>, openvpn-devel@lists.sourceforge.net

> Pavlin,
> 
> Thanks for the patch.  Is there any reason why someone might not want to have
> multicast turned on by default, i.e. is there any chance this could break
> something?  Should it be controllable by an option?

James,

I consider the IFF_MULTICAST flag as a capability flag of an
interface. E.g., if an interface is capable of supporting multicast,
then it should have this flag set. For example, it appears that on
FreeBSD the flag is always set for the tun interfaces created by
openvpn, so doing the same thing with OpenBSD would make things more
consistent. In addition, the flag cannot be turned off on physical
interfaces by programs like "ifconfig".

Of course, given the flexibility you have with openvpn you can
always add the option to explicitly turn the flag off. However, off
the top of my head I cannot think of any good reasons why someone
may want to do that. Also, I don't think enabling the flag will
break anything.

Nevertheless,I am neutral to adding such option and it is up to the
openvpn developers :)
Though, I'd recommend that it is ON by default.

Thanks,
Pavlin

> 
> James
> 
> Pavlin Radoslavov <pavlin@...241...> said:
> 
> > Hi!
> > 
> > [OS: OpenBSD-3.5]
> > [openvpn: 2.0_beta5, 1.5]
> > 
> > It appears that openvpn doesn't enable the multicast flag for the
> > tun interface on OpenBSD (on FreeBSD for example, the flag is always
> > set). E.g., if I use:
> > 
> > openvpn --local <...> --remote <...> --ifconfig <...> <...> --dev tun0
> > 
> > Then the interface doesn't have the MULTICAST flag set:
> > 
> > tun0: flags=51<UP,POINTOPOINT,RUNNING> mtu 1500
> >         inet ...
> > 
> > I believe the following simple patch (against 2.0_beta5) fixes the
> > problem.
> > 
> > Thanks,
> > Pavlin
> > 
> > --- tun.c.org	Sun Jun 13 00:34:28 2004
> > +++ tun.c	Tue Jun 15 23:24:58 2004
> > @@ -1274,6 +1274,24 @@
> >  open_tun (const char *dev, const char *dev_type, const char *dev_node, bool
> ipv6, struct tuntap *tt)
> >  {
> >    open_tun_generic (dev, dev_type, dev_node, ipv6, true, true, tt);
> > +
> > +  /* Enable multicast on the interface */
> > +  if (tt->fd >= 0)
> > +    {
> > +      struct tuninfo info;
> > +
> > +      if (ioctl (tt->fd, TUNGIFINFO, &info) < 0) {
> > +	msg (M_WARN | M_ERRNO, "Can't get interface info: %s",
> > +	  strerror(errno));
> > +      }
> > +
> > +      info.flags |= IFF_MULTICAST;
> > +
> > +      if (ioctl (tt->fd, TUNSIFINFO, &info) < 0) {
> > +	msg (M_WARN | M_ERRNO, "Can't set interface info: %s",
> > +	  strerror(errno));
> > +      }
> > +    }
> >  }
> >  
> >  void
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> > Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> > Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> > REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> > 
> 
> 
> 
> -- 
> 
> 
> 


