From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
In-Reply-To: <20040924092438.N12953@...283...>
Message-ID: <Pine.LNX.4.58.0409241350420.26514@...269...>
References: <20040924023235.M12953@...283...> <20040924083959.GB11256@...33...>
 <20040924092438.N12953@...283...>
MIME-Version: 1.0
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
Date: Fri Sep 24 13:02:18 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: JuanJo Ciarlante <jjo-ipsec@...283...>
Cc: openvpn-devel@lists.sourceforge.net


On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:

> On Fri, Sep 24, 2004 at 10:39:59AM +0200, Matthias Andree wrote:
> > On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:
> > 
> > > This README covers UDP/IPv6 ( --udp6 ) support for openvpn-2.0_beta11
> > > Also, with address family "generalization" changes came local AF_UNIX socket
> > > support.
> > 
> > Is there a use for AF_UNIX in a VPN driver?
> 
> It stated in README file.. it allows the creation of local specialized
> proxys that can  take full advantage of POSIX fileystem perm. semantics.
> 
> Currently I;'m working on a Jabber one 8))
> regards...

I must say that the thought of running a VPN over Jabber is deliciously 
subversive :)

But I cringe when I think of the potential complexification in the sockets 
code.

We are already moving in the direction of having lots of transport layer
options (i.e. TCP, UDP, IPv4, IPv6, HTTP, Socks).  Now we're talking about
local unix sockets and Jabber!  Maybe it's time to formally codify a
transport layer driver model, i.e. a pluggable architecture.  Then people
can add new drivers to their heart's content, while OpenVPN itself will
conveniently interact with a generalized abstraction of the model.

James


