From: "Magne J. Andreassen" <magne@...470...>
Message-Id: <1128676652.31184.194.camel@...399...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN session synchronization
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
Date: Fri Oct  7 02:18:29 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

(This is a re-post from the -users list, thought it might be more
appropriate here)

Exactly what kind of information does OpenVPN keep track of for active
VPN sessions? (after the authentication process is finished)


Reason for asking;

OpenVPN supports load-balancing trough the use of round-robin. Be it DNS
round-robin or just by specifying multiple servers in the client config
file.

OpenVPN does not, however, support dynamic failover to another daemon
running on another server. By dynamic failover, I mean that the client
sessions are not interfered by the server going down or in other ways
being inaccessible. (They don't have to re-establish the tunnel)

There was a thread on this list some time ago discussing clustering of
OpenVPN, but not so much details was given.



OpenBSD has a dynamic failover / loadbalancing protocol called CARP that
some of you might be familiar with. It is ported to FreeBSD and Linux.

PF (Packetfilter) and isakmpd uses some small synchronization daemons to
utilize the power of CARP and thereby offering dynamic failover for
these services.

I think, without knowing much about the OpenVPN design, that it would be
possible to synchronize VPN client sessions in the same way and thereby
offering high-availability to OpenVPN clients.

Why would I want this, you might ask? OpenVPN already supports
load-balancing trough the previous mentioned methods. Well, it's not so
much I don't trust these methods or my hardware. Rather, it's a major
strength when it comes to maintenance. I can have service windows in
office hours without users noticing the main VPN server goes down. This
saves time and money. And, clients currently connected to a failing
server, won't notice that they are "moved" to the backup server.

Updating, patching and other maintenance could easily be done without
VPN service downtime.

The strength in using CARP is obviously that OpenVPN don't have to
implement the redundancy protocol itself.

So, the problems(?);

The OpenVPN daemons mush listen on the same server ip-address. Actually,
it must utilize the CARP interface, so no changes to OpenVPN should be
necessary here. Using the '--local host' parameter and listening on the
CARP interface should be sufficient.

OpenVPN should optionally use an external DHCP service to serve
addresses to the clients. If i remember correctly, someone on this list
mentioned that this could be done with a script?

CARP and OpenVPN should be able to interact in some way, so that CARP
could adjust it's adskew (advertising interval deciding which server is
the master) if the OpenVPN daemon is unresponsive.

As far as I can figure, the only thing that is required, is the OpenVPN
daemons to speak to each other and update client session information on
connect and disconnect.

Depending on various parameters, the failover process takes about 1-5
seconds. The clients might notice a stall in connectivity during this
time. Other than that, everything should be transparent to the user.


More problems;

First I started to look at the possibility of writing a simple plugin to
take care of the synchronization and interaction with the various
OpenVPN daemons. But the problem is that the plugin API only offers
callbacks. In other words I don't think it's possible to "manually" add
a VPN session from a plugin.

After skimming trough the various source files for OpenVPN, I think that
the problem might be a bit more complex than first assumed. 

Any comments on this? Any ideas on where the hooks should be placed in
OpenVPN to actually be able to sync sessions?


Magne Andreassen



