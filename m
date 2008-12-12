Date: Fri, 12 Dec 2008 12:21:04 +0530 (IST)
From: Keyur Pujara <keyurpujara@...293...>
In-Reply-To: <493F7145.4000102@...1162...>
MIME-Version: 1.0
Message-ID: <203217.41406.qm@...1163...>
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
To: Michael Heydon <michaelh@...1162...>
Cc: Jan Just Keijser <janjust@...1147...>, Erich Titl <erich.titl@...453...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

> > The iptables suggestion is good. But unfortunately it
> > won't work in my scenario. What I want to achieve is to
> > bind OpenVPN on TCP 443 over two WAN interfaces and Apache
> > on TCP 443 over two LAN interfaces (for management traffic).
>   
> It should still be possible to use iptables to achieve
> this, although you would need to mess about with DNAT to
> another port, kind of ugly.
> 
> How about using ovpn's port sharing?


I am already using "--port-share". Want to avoid it as it induces one Proxy point in the flow. 

As mentioned above - have cleanly separated flows for LAN and WAN ports - so port-share looks like an overhead. 

Regards,
Keyur




      


