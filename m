From: Juan Rodriguez Hervella <jrh@...176...>
Subject: Re: [Openvpn-devel] Status of IPv6 support in openVPN
References: <twig.1079556181.40316@...41...>
In-Reply-To: <twig.1079556181.40316@...41...>
MIME-Version: 1.0
Message-Id: <200403221159.01108.jrh@...176...>
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
Date: Mon Mar 22 03:00:59 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Wednesday 17 March 2004 21:43, James Yonan wrote:
> Juan,
>
> I think it would be great if you wanted to work on this.  Until now, most
> of the interest has been in IPv6 over IPv4 tunneling, but I would encourage
> you to take the initiative and work on this.

Thank you very much for the info, but Im sorry to decline your offer. I dont
have enough time to work on this, though I will be glad to 
contribute with small patches if it is necessary. 
Besides, I don't know about Windows IPv6 stuff, so I think I couldn't be
able to create portable code.

See one more comment below...

> Here are some thoughts:
>
> * This work should happen in the BETA20 branch, as the 1.x branches are now
> very stable and shouldn't be touched at this point for more than bugfixes
> and localized changes.  While the BETA20 branch is mostly focused right now
> on point-to-multipoint mode (which is not yet finished), it will currently
> build off of the CVS and run in standard point-to-point mode.
>
> * It's important that this work be portable which of course means that we
> want to share as much code between the windows and non-windows versions as
> possible.  I'm not sure to what extent the IPv6 header files are
> standardized, but if they are not, it may be necessary to build a
> platform-general abstraction.  To the extent that portability is
> impossible, the code should ifdef itself out on platforms which don't
> support IPv6.
>
> * OpenVPN uses in_addr_t and sockaddr_in types to refer to IPv4 addresses. 
> We need to decide whether IPv6 should be a whole new mode, i.e. with it's
> own address structs/typedefs and socket6.[ch] files, or whether we should
> use an abstraction for address types which can be either IPv4 or IPv6.

I think it would be easier to do it as  a whole new mode.
Other opinions are welcomed of course (^-^)

Bye bye...

> * There is code in route.c and tun.c which does things like network =
> (ip_addr & netmask).  This code obviously won't work if the protocol
> address size is too big to fit in an intrinsic C type, as it is with IPv6.
>
> James
>
> Juan Rodriguez Hervella <jrh@...176...> said:
> > Hellooooo,
> >
> > It seems that openVPN supports only IPv4 for making
> > connections between the client and the server.
> >
> > I'd like to be able to establish connections over IPv6,
> > what should be changed ? I feel quite depressed when
> > I look at the source code, because I think is gonna be a pain
> > to change the code to turn it to be AF-independent....sigh
> >
> > This should have been done from the scratch...but I don't
> > blame anybody, specially because IPv6 is not widely used yet,
> > (^--^)
> >
> > Is anybody willing to start doing this ?
> > Should we start changing everything to accomplish this task
> > or is it enough to change "socket.c" ? and if we look at socket.c,
> > what's the best way of porting that stuff to IPv6 ? making new
> > functions like "gettaddr_ipv6",  "update_remote_ipv6".....or
> > changing the original functions to deal with both IPv4 and IPv6
> > at the same time ?...
> >
> > Regards
> >
> >
> > --
> > ******
> > JFRH
> > ******
> >
> > Passionate hatred can give meaning and purpose to an empty life.
> > 		-- Eric Hoffer
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
******
JFRH
******

It is not true that life is one damn thing after another -- it's one
damn thing over and over.
		-- Edna St. Vincent Millay

