Message-Id: <200304180553.h3I5r7106802@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] Fwd: RE: Multi-channel VPN
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
Date: Thu Apr 17 22:54:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I'm forwarding this discussion of an interesting feature request.  Namely,
could (and should) OpenVPN have a channel bonding capability, where more than
one UDP connection over different paths is used to connect two peers, and
OpenVPN does channel bonding, load balancing, and failover among the
connections?  Or does this function not belong in OpenVPN since it is
functionally distinct from the role of network security and tunneling and
could be implemented as a module or driver apart from OpenVPN?

James

Forwarded From: "R. Latimer" <latimer@...78...>

> Hi,
> 
> Certainly, I don't mind if you wish to post to the list.
> 
> My reason for suggesting this be done in OpenVPN is primarily due to the
> ability to support multiple platforms (my e-mail should say
> platform-independant, not hardware-independant) without relying on
> additional software being installed at both ends, or OS-specific solutions.
> 
> Thanks,
> 
> - R. Latimer
> 
> -----Original Message-----
> From: James Yonan [mailto:jim@...41...]
> Sent: Thursday, 17 April 2003 22:40
> To: R. Latimer
> Subject: Re: Multi-channel VPN
> 
> 
> Mr. Latimer,
> 
> It's an interesting idea, though I'm not sure that OpenVPN is the right
> place
> to put the channel bonding code.
> 
> Since OpenVPN leaves all routing control to the OS, it would seem to make
> more
> sense to implement the channel bonding at the router level, since channel
> bonding is functionally distinct from the role of a VPN.
> 
> Having said that, it would certainly be possible to implement this in
> OpenVPN
> though it would add the complexity of load balancing, failover, to OpenVPN.
> It would also introduce issues of flow control on the UDP channel(s) that
> OpenVPN hasn't had to deal with before.
> 
> If you don't mind, I would like to post this thread to the list so that
> others
> can comment.
> 
> James
> 
> "R. Latimer" <latimer@...78...> said:
> 
> > Hi James,
> >
> > Sorry to e-mail you directly rather than using the mailing list. I'm not
> > presently subscribed to the development list, but have a feature
> suggestion
> > you may wish to give some consideration (Post-1.4, perhaps much further
> down
> > the development path).
> >
> > I was wondering if it would be possible to allow OpenVPN to use multiple
> > paths to connect two networks? E.g. use two Internet connections here to
> > connect to a single remote VPN. I see no reason both ends couldn't use
> > multiple paths, but a simple one to many relationship alone would be
> handy.
> >
> > The reason for this is, Internet access in NZ is very expensive. I have a
> > 128k connection, and am looking at getting 128k a wireless connection as
> > well for use with a laptop. The VPN terminates in the US, where bandwidth
> is
> > plentiful, and supplying the VPN with 256k wouldn't be a problem.
> >
> > I would like to be able to join the two channels when the laptop is
> > connected to the LAN, and when unavailable, have all traffic automatically
> > sent through a single interface.
> >
> > Each interface would be with a different ISP, so traditional routing
> > protocols to one IP address wouldn't work in this case. In fact, the local
> > telephone company specifically disallows static IPs on the 128k
> > connections - they are only permitted on the expensive (pay per MB)
> > high-speed ADSL connections.
> >
> > I believe this would be possible using two instances of OpenVPN, and
> > NetGraph on FreeBSD, but unfortunately the remote end uses Linux. If
> > possible to do this in OpenVPN, it would provide a hardware-independant
> way
> > to link multiple channels. Currently NetGraph contains no code for
> > intelligently determining the path, it simply alternates between ports. It
> > would be great if OpenVPN could additionally favour one link over another
> > based on actual performance.
> >
> > I've been using OpenVPN since the FreeBSD port became available, and it
> > works very well. Thanks for such a great tool, and I hope you'll give my
> > suggestion some thought.
> >
> > Thanks,
> >
> > - R. Latimer
> >
> >
> 
> 
> 
> --
> 
> 
> 
> 
> 
> 



-- 





