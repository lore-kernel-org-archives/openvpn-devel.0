Subject: Re: [Openvpn-devel] OpenVPN session synchronization
From: "Magne J. Andreassen" <magne@...470...>
In-Reply-To: <Pine.LNX.4.58.0510070324570.32321@...41...>
References: <1128676652.31184.194.camel@...399...>
	 <Pine.LNX.4.58.0510070324570.32321@...41...>
Message-Id: <1128696355.31184.320.camel@...399...>
Mime-Version: 1.0
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
Date: Fri Oct  7 07:47:25 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Fri, 2005-10-07 at 04:20 -0600, James Yonan wrote:
> On Fri, 7 Oct 2005, Magne J. Andreassen wrote:
> 
> > Exactly what kind of information does OpenVPN keep track of for active
> > VPN sessions? (after the authentication process is finished)
> 
> See struct context in openvpn.h -- this is the master object that denotes 
> a VPN session.
> 

Thanks!

[...]
> > 
> > Any comments on this? Any ideas on where the hooks should be placed in
> > OpenVPN to actually be able to sync sessions?
> 
> The major issue to deal with when doing transparent, seamless failover is 
> making sure that the new server inherits the precise state from the old 
> server so that the switchover is invisible to the client.  This is a 
> complicated undertaking -- there's a lot of data that makes up a client
> instance object on the server.
> 
Yes, I understand. Would it be easier to "simulate" the events (connect,
disconnect and so on) on the backup server than to actually synchronize
the data?

> In a lot of respects, the problem of doing OpenVPN transparent failover is
> more akin to the problem of doing transparent failover for routers, than
> it is for doing failover for conventional "services" like SMTP or HTTP.
> 
> So unless CARP supports router failover, it's probably not going to be a 
> drop-in solution for OpenVPN.
> 

CARP operates at layer 2 and 3 in the OSI model, let me take some time
to detail the solution.

Let's forget about OpenVPN for a second and talk about CARP.

We have 2 servers with 1 physical interface each. They also have a
pseudo CARP interface, configured with the same ip-address, say
192.168.0.10. Now, CARP can be configured in two ways, either master /
slave, or "load-balancing" mode. The latter kinda works like a simple
round-robin algorithm, but not suitable for this setup (I'll explain
this later). In master / slave mode, CARP sends advertisements at a
given interval, and the machine advertising at the highest frequency, is
considered the master. The master will reply for the arp requests and
the ip-address, while the slave is considered a "hot-standby". If the
master fails, the slave will have the highest advertisement frequency,
and thereby start answering for the arp request and the (common)
ip-adress.

The "load-balancing" mode (called arp-balancing) uses the source
ip-address to compute witch of the hosts should answer the request.
Because arp don't traverse routers, this setup only works on the local
network segment.

Anyway, when a client connects to the ip-address 192.168.0.10,
regardless the protocol or service, it is connected to the current
master.

 ----------------
 | 192.168.0.10 |
 ----------------
   |          |
|------|   |------|
| VPN1 |   | VPN2 |
|------|   |------|

If we installed OpenVPN (as of today) on these two boxes, we would gain
redundancy, but the users would have to re-authenticate to the backup
server if the master fails.

You could of course, as you mentioned, use some sort of duplicating
mechanism so that clients are always connected to both servers (don't
know if this would work). Packetfilter has a dup-to keyword that will
duplicate all traffic to another destination.

But if these two OpenVPN daemons where able to do two-way
synchronization of session information, it would not matter which server
the clients where connected to.

Here is an example server configuration(just interesting params):


#Serving we are...
mode server
#OpenVPN listens on the CARP interface, NOT the 
#ip-address of the physical interface.
local 192.168.0.10
#Device
dev tun0
#The OpenVPN server takes the address 10.8.0.1 itself,
#and this is common for daemons on both servers!
server 10.8.0.0 255.255.255.0
#This file would be consistent on both servers assuming that 
#session information is synchronized.
ifconfig-pool-persist /tmp/ipp.txt


Both OpenVPN daemons could use the exact same configuration (including
ip-address and client address scope.)

So, the OpenVPN daemon running at the slave server, shares the session
information with the master, including routing tables, but there is
really no traffic from or to the clients. This probably yields some sort
of new directive for OpenVPN (like e.g. --sync-sessions-if <interface>)
and have this parameter make OpenVPN hold the session information
regardless of traffic flowing or not. And of course listen / send
session data on this interface.

The best way to sync session data would probably be to add a second
interface to the servers and broadcast(!) the synchronization there.

|------|                            |------|
| VPN1 |.1----192.168.100.0/xx----.2| VPN2 |
|------|                            |------|

Ok, so exactly what OpenVPN session data is necessary to sync? As far as
I can figure, the context and context_1 structs are interesting. Session
keys, remote address list, status output, user / password, ++

I don't know exactly, but it seems that context_2 is mostly temporary
data? (statistics, sequence numbers and so on). A comment is saying that
this is wiped across SIGUSR1 and SIGHUP restarts. This probably means
that also this data is necessary to sync?


> Longer term I would like to design a clustering feature for OpenVPN, that 
> would also support seamless failover in under 5 seconds.
> 

Sounds like a plan :) I'm guessing you are planning to implement this as
a OpenVPN internal feature, not using external services like CARP?

> However if you really want to do seamless failover now, without waiting 
> for future development, you could probably do it this way:
> 

You are right, it's an option. But making the clients connect to both
servers probably means a special client config is needed. I think this i
a server side setup, thus there should be no need for doing client
reconfiguration.

> (1) Set up primary and backup OpenVPN servers.
> 
> (2) Set up clients to always connect to both servers.
> 
> (3) Set up VPN client <-> server routing through both primary and backup
> servers with the primary having a lower metric.
> 
> (4) Have a server/up down sensor such as CARP dynamically change the
> routing metrics based on which server is available.  This could be done by
> having CARP run a script every time there is a change in server/up down
> status -- the script would need to multicast a RIP2 or OSPF notification
> through the VPN to change the routing metric to prefer the currently alive
> server (I'm not sure if there's a command line tool to multicast dynamic 
> routing updates).
> 
> When we implement the clustering feature, the goal will be to automate the
> above steps.  I will probably make plugin callbacks for (a) the server/up
> down sensor and (b) multicast of dynamic routing updates, so that 
> these functions could be carried out outside of the OpenVPN core.
> 

With CARP, you would not need to multicast a RIP2 or OSPF notify to
clients.

One last question; is clustering a high prioritized feature?


Magne


Here is some more info on CARP:

http://www.openbsd.org/cgi-bin/man.cgi?query=carp&apropos=0&sektion=0&manpath=OpenBSD+Current&arch=i386&format=html

http://www.countersiege.com/doc/pfsync-carp/

http://kerneltrap.org/node/view/1021



