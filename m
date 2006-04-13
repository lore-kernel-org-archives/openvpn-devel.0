From: Roy Marples <uberlord@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Stick routes to interfaces for Linux
References: <200604072030.52833.uberlord@...594...> <443EB57C.2080801@...41...> <200604132201.18627.uberlord@...594...>
In-Reply-To: <200604132201.18627.uberlord@...594...>
MIME-Version: 1.0
Message-Id: <200604132240.07989.uberlord@...594...>
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
Date: Thu Apr 13 14:41:03 2006
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 13 April 2006 22:01, Roy Marples wrote:
> On Thursday 13 April 2006 21:33, James Yonan wrote:
> > Roy Marples wrote:
> > > In some instances, Linux requires routes being stuck to interfaces
> > > instead of floating. Mainly in virtual environments like Xen and Qemu.
> > >
> > > Attached is a patch that addresses this issue.
> >
> > What about the case where you don't want to associate a route with the
> > tun/tap interface, such as when you're doing the routing dance to make
> > --redirect-gateway work?
>
> Not too sure to be truthfull as I don't use that option. I prefer to have
> both default routes separated by a metric instead. This works very well
> when you have 3 interfaces, wired, wireless and vpn and they all provide
> default routes. In this instance we need to give them metrics and tie them
> to an interface using Linux.

Initial testing shows that it has no adverse effects. Of course, it's my patch 
and I'm biased :P

Maybe someone else could test and chip in? Or enable it by default in the next 
beta and see what breaks if anything. The patch is trivial and could easily 
be removed in any case.

Thanks

-- 
Roy Marples <uberlord@...594...>
Gentoo Linux Developer

