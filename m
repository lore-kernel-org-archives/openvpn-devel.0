Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <200709212112.46788.news@...165...>
From: Timothy Baldwin <T.E.Baldwin99@...1053...>
Date: Thu, 20 Sep 2007 22:13:15 +0100
Message-ID: <fcunpb$alf$1@...165...>
References: <46E9F75C.1020409@...1050...>
Mime-Version: 1.0
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] How does one use Tun/tap for raw frames???
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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


-- 
OpenPGP key fingerprint: D0A6 F403 9745 CED4 6B3B  94CC 8D74 8FC9 9F7F CFE4




