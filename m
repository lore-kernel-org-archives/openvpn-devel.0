Subject: Re: [Openvpn-devel] Re: [Openvpn-users] New feature proposal:  --route option
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1062744541.74275@...41...>
In-Reply-To: <00d001c37376$dae287c0$6e166d8c@...94...>
References: <twig.1062740798.74062@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  4 23:50:05 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tom Bin <openvpn@...93...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Tom Bin <openvpn@...93...> said:

> 
> It's really a good idea.
> I think the syntax is good enough...,
> maybe you can take the metric(route cost) into consideration.

That's a good idea.  It looks like most IP stacks support metric, I see that
Windows does too so that is good.

> I would like to suggest the route is added once the vpn is up
> and deleted when the vpn is down.

Yes, that's what I'm planning.  I was also planning a --route-delay with a
number of seconds argument, so the routes addition could be delayed long
enough to allow a tap interface to get its DHCP parameters.

> Moreover, is it possible to have multiple routes added ?

Yes, definitely.

James

> 
> 
> 
> > I would like to implement a --route option that will be a proxy for the
> route
> > command, similar to the way that the --ifconfig option is a proxy for the
> > ifconfig command.
> >
> > The goal would be to present a kind of least-common-denominator route
> > functionality which is basic enough to be portable across OpenVPN's
> platform
> > space.
> >
> > I'm thinking of a syntax such as
> >
> >   --route network netmask gateway
> >
> > I'm looking for a syntax that will cover basic routing -- for more
> advanced
> > usage, one can always write a script.
> >
> > The overall goal is to simplify configuration by getting the common
> operations
> > out of --up scripts and into the OpenVPN config file where they will be
> > portable and easier to support.
> >
> > Comments?
> >
> > James
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




