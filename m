Subject: Re: [Openvpn-devel] --redirect-gateway on FreeBSD
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078498926.20189@...41...>
In-Reply-To: <200403051358.54465.jrh@...176...>
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
Date: Fri Mar  5 07:09:12 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Juan Rodriguez Hervella <jrh@...176...>, openvpn-devel@lists.sourceforge.net

Juan Rodriguez Hervella <jrh@...176...> said:

> Hello,
> 
> I've just subscribed to this list, but I've read on the
> archives that the --redirect-gateway function is not
> working yet on FreeBSD because of the problem of
> retreiving the address of the default gateway.
> 
> I've just written a small program which makes that,
> looking at /usr/src/sbin/route.c
> 
> Hope this helps, I've tested it on both FreeBSD-4.9
> and FreeBSD-5.2
> 
> It uses PF_ROUTE sockets.
> 
> hope this helps!
> -- 
> ******
> JFRH
> ******
> 
> Go climb a gravity well!

Juan,

It would be ideal if you could code this into OpenVPN's route.c, following the
form of the other platforms, i.e.:

..

#elif defined(TARGET_FREEBSD)

static bool
get_default_gateway (in_addr_t *ret)
{
  /* code me -- put gateway address into *ret */
}

#else

..

James


