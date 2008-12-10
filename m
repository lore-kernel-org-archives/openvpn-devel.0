Date: Wed, 10 Dec 2008 12:33:38 +0530 (IST)
From: Keyur Pujara <keyurpujara@...293...>
In-Reply-To: <493E9854.8010508@...453...>
MIME-Version: 1.0
Message-ID: <536670.53582.qm@...1160...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Running Single OpenVPN Daemon
	on multiple (selective) interfaces
Reply-To: keyurpujara@...293...
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
To: Jan Just Keijser <janjust@...1147...>, Erich Titl <erich.titl@...453...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Thanks all for your inputs. 

The iptables suggestion is good. But unfortunately it won't work in my scenario. What I want to achieve is to bind OpenVPN on TCP 443 over two WAN interfaces and Apache on TCP 443 over two LAN interfaces (for management traffic). 

Thanks,
Keyur


> >>   
> > openvpn can bind to either a single interface or to
> all interfaces 
> > (0.0.0.0); so to solve your issue you need two
> instances. AFAIK there 
> > are no plans to change this in the near future.
> Openvpn 2.1 has 
> > something called connection profiles, but this applies
> to the *client* 
> > side only.
> > 
> 
> Just bind to all interfaces and use iptables to select on
> which ones to
> accept the openvpn packets.
> 
> Erich


      


