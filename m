MIME-Version: 1.0
Date: Fri, 21 Sep 2007 21:21:16 +0100
Message-Id: <200709212121.16296.T.E.Baldwin99@...1053...>
From: Timothy Baldwin <T.E.Baldwin99@...1053...>
Subject: Re: [Openvpn-devel] How does one use Tun/tap for raw frames???
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

<posted & mailed>

In message <46E9F75C.1020409@...1050...>, Jeff Wiegley <jeffw@...1050...> wrote:


> Basically...
> 
> # tunctl -u jeffw
> # ifconfig tap0 10.10.0.1 netmask 255.255.255.0
> $ ./tapwatcher tap0
> 
> Then from another window I want to be able to do
> "ping 10.10.0.1" and tapwatcher should spew the
> raw Ethernet frames that would be generated on
> tap0.

No, that won't work as 10.10.0.1 is a local IP address. Try pinging
10.10.0.2, your program should then receive some ARP packets.
 
> Am I missing something fundamental?

LOL

The address of an interface is an address of the host which the interface
belongs to, and hosts process traffic addressed to them.

Jeff Wiegley, I suggest you forward this message to jeffw@...1050... so that
he can read it.



