Date: Fri, 12 Dec 2008 21:54:09 +0100
From: Emrah <eka@...1164...>
Message-ID: <20081212205409.GA9510@...1165...>
References: <20081212084127.GA31936@...1165...>
	<200812121615.19957.opensource@...519...>
	<9e0cf0bf0812120728w15717291p8ed848a7ec924938@...278...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf0812120728w15717291p8ed848a7ec924938@...278...>
Subject: Re: [Openvpn-devel] Porting OpenVPN to Symbian
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

Thanks for pointing this direction out. It's a good idea actually but if there is any chance to have an OpenVPN running... 
then I'd rather take it!

Noam: I'd like to port it to RIM OS as well and I already mentionned it to some friends but... Java seems to be more an 
obstacle than anything else in this case... 
The only reason I put Symbian in first priority is because of the integrated SIP client in S60 3rd edition phones.

Thanks a lot for your replies.
Emrah
On Fri, Dec 12, 2008 at 05:28:10PM +0200, Alon Bar-Lev <alon.barlev@...277...> wrote:
> On 12/12/08, Till Maas <opensource@...519...> wrote:
> > On Fri December 12 2008, Emrah wrote:
> >
> >  >       What's up with the possibility to port OpenVPN to Symbian?
> >  > If anybody is interested to face this challenge, I'd be ready to fully
> >  > sponsor a bounty. In this case, how much $$$ would you expect?
> >
> >
> > I would like to have this done, too. But this seems not that easy. Once I
> >  googled around a little and did not find any hint on how to create e.g. a tap
> >  device on symbian or even any other floss vpn client or some other software
> >  that can e.g. manipulate the routing table of symbian devices. But I
> >  appreciate any pointers for such software or other obstacles that may make
> >  this difficult.
> 
> It would be easier to use a simple TCP/UDP redirection, configure
> local application to use local port and forward it using TLS with
> client authentication to a host. It is not transparent VPN but will
> provide decent solution.
> 
> Alon.
> 
> ------------------------------------------------------------------------------
> SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
> The future of the web can't happen without you.  Join us at MIX09 to help
> pave the way to the Next Web now. Learn more and register at
> http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Emrah KAVUN
<eka@...1164...>

