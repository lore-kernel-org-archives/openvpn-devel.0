Message-ID: <20100111133111.2974.qmail@...1287...>
Date: Mon, 11 Jan 2010 14:31:11 +0100
From: Peter Stuge <peter@...1287...>
References: <lypr5lvsu7.fsf@...1290...>
	<20100109180748.26114.qmail@...1287...>
	<lyr5pxhrp0.fsf@...1290...>
MIME-Version: 1.0
In-Reply-To: <lyr5pxhrp0.fsf@...1290...>
Subject: Re: [Openvpn-devel] RFE: allow 'lport 0' setup for random
	port	binding
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

Enrico Scholz wrote:
> >> I am running a multihomed host where 'local <extip>' must be
> >> specified for proper operation.
> >
> > Could you add a route and use nobind? Unless you have one openvpn
> > on each IP that should work.
> 
> I would really like to avoid the NAT hackery.

I didn't mean to suggest any NAT. If you have access to the system
that is running openvpn I think you could add routes to the routing
table in that system which will remove the need for openvpn to
explicitly bind at all. Applications that do not bind() are assigned
source address according to the system routing table. Of course this
will affect all processes on the system, not only openvpn.


> > I would actually expect the firewall to notice that there is a new
> > connection. Since it doesn't, maybe you can explicitly allow this
> > traffic?
> 
> I do not have access to this firewall.

Can you reach someone who does? I guess the VPN working right is in
their interest too, and..


> > I know I would prefer fixing the firewall rules.
> 
> I would prefer to fix openvpn ;)

..I maintain that the problem is actually with the firewall that
doesn't notice the new connection. (I guess because of too simplistic
packet inspection?)


> I think, supporting common TCP/UDP client functionality (which choses
> random source ports) suits my needs best.  I do not see reasons why
> 'local' must be tied to 'lport'.

The source IP and source port are specified using one and the same
system call; bind(). It's likely that when developing the binding
options it was simply thought that either both can be specified, or
neither will be neccessary. Perhaps specifically because firewalls
usually do connection tracking better than the one you're dealing
with. :\


//Peter

