From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] [PATCH] UDPv6 support  (UDP/IPv6)
Message-ID: <20040924172105.C8393@...283...>
References: <20040924023235.M12953@...283...> <20040924083959.GB11256@...33...> <20040924092438.N12953@...283...> <Pine.LNX.4.58.0409241350420.26514@...269...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0409241350420.26514@...269...>; from jim@...41... on Fri, Sep 24, 2004 at 02:01:46PM -0600
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
Date: Fri Sep 24 13:26:23 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, Sep 24, 2004 at 02:01:46PM -0600, James Yonan wrote:
> 
> 
> On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:
> 
> > On Fri, Sep 24, 2004 at 10:39:59AM +0200, Matthias Andree wrote:
> > > On Fri, 24 Sep 2004, JuanJo Ciarlante wrote:
> > > 
> > > > This README covers UDP/IPv6 ( --udp6 ) support for openvpn-2.0_beta11
> > > > Also, with address family "generalization" changes came local AF_UNIX socket
> > > > support.
> > > 
> > > Is there a use for AF_UNIX in a VPN driver?
> > 
> > It stated in README file.. it allows the creation of local specialized
> > proxys that can  take full advantage of POSIX fileystem perm. semantics.
> > 
> > Currently I;'m working on a Jabber one 8))
> > regards...
> 
> I must say that the thought of running a VPN over Jabber is deliciously 
> subversive :)

yeahhh

> But I cringe when I think of the potential complexification in the sockets 
> code.
> 
> We are already moving in the direction of having lots of transport layer
> options (i.e. TCP, UDP, IPv4, IPv6, HTTP, Socks).  Now we're talking about
> local unix sockets and Jabber!  Maybe it's time to formally codify a
> transport layer driver model, i.e. a pluggable architecture.

Totally agreed, in fact my 1st thought was to try to abstract proxys code
paths, but I left for new now the of the impact.

My patch has a lot of work in this direction (functions like
proto_is_dgram... addr_copy, etc ); you know my first approach was to thinks
AF_UNIX as http/socks, but later I concluded that if we DONT require openvpn
to specify destination to the proxy entity its not a proxy, its a (tunneled)
pee; in the JAbber case , this could be an _already_ connected, _already_
configured destination JID not even known to openvpn, ... for openvpn its
just another channel (socket).

Indeed , AF_INET , AF_INET6 and AF_UNIX are mostly "siblings" from the
connection pointo of view.


> Then people
> can add new drivers to their heart's content, while OpenVPN itself will
> conveniently interact with a generalized abstraction of the model.

Count on me for that ... hope I can resist the temptation 8)))

Regards
-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

