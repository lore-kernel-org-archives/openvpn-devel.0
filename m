From: "James Yonan" <jim@...41...>
Message-ID: <twig.1080688545.10218@...41...>
Subject: [Openvpn-devel] OpenVPN 2.0 -- Project Update and Release Notes
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
Date: Tue Mar 30 15:16:09 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

OpenVPN 2.0 -- Project Update and Release Notes

I'm happy to announce that the first OpenVPN 2.0 beta is here, and well ahead
of schedule.  This is in large part thanks to a generous contribution by
Meetrix Inc. which has allowed me to work full-time on the project during the
last month.

Download:

http://openvpn.sourceforge.net/beta/

The latest 2.0 beta is called test18 and a .tar.gz and Windows self-install
are provided.  Keep in mind that these are very early-stage releases, so the
usual caveats apply for those of you who like to dwell on the bleeding edge :)

The key features in this first beta include:

* A highly scalable server for handling multiple UDP clients over
point-to-point tun interfaces, all using a single UDP port number.  The server
has been designed for maximum efficiency and scalability, and should scale to
hundreds or even thousands of clients where the hardware and network bandwidth
can support it.  The code includes a new O(N) scheduler based on a randomized
treap binary tree algorithm plus efficient hash tables for looking up client
instances.

* The server configuration file is only slightly more complex than a
configuration file for a single tunnel instance.  The server-side crypto
configuration is simplified by the use of TLS which allows any incoming client
to be accepted if (a) the client's certificate was signed by the master VPN CA
and (b) the client certificate is not explicitly disallowed by a CRL
(certificate revocation list).

* The server is able to handle an arbitrary number of clients using a single
UDP port, a single tun interface, and a single config file.  As such, it is
designed to not overly stress the OS even when its own client load is high. 
This means that the server can also run well on Windows which is not capable
of scaling up to a large number of tun/tap interfaces.

* The server configuration file adds serveral new options: (a) --ifconfig-pool
allows the server to manage a DHCP-like pool of /30 subnets to be dynamically
allocated to client instances, (b) --push allows the server to push certain
options back to the client such as routes, ifconfig endpoints, and DHCP
options for Windows machines without actually requiring a DHCP server, and (c)
the new --mode option controls whether OpenVPN will run in multi-client UDP
mode or classic peer-to-peer mode.

* On the client side, --pull has been added, which basically says "accept
certain config file options which the server pushes back to you."  There is
obviously a security implication with --push/--pull in that the client is
trusting the server to control its configuration.  As such, the client is
strict about what kind of options it will accept from the server, and (by
default) will not accept any option which would cause file modification or
script execution.  The major win of the push/pull capability is that the same
client configuration file can be used on each client provided each client has
its own set of SSL/TLS keys which have been signed by the master CA.

* The Windows TAP-Win32 driver has been extensively reworked based on some
very good feedback I received from the
microsoft.public.development.device.drivers newsgroup.  The goal is to
eliminate required reboots after install or uninstall on certain platforms
such as Win2K.  I would especially like to get feedback on whether this new
driver fixes the rare problem of winsock corruption which has been reported to
me by 3 users, but never reproduced by myself.  Also, this driver lets you
explicitly set the TAP adapter MAC address in the adapter advanced properties
dialog, a feature that has been suggested by several of you.  This driver
should be backportable to OpenVPN 1.x.

* The server requires TLS mode and will not work with static keys.  I don't
see this as really being a disadvantage because the major reason to use static
keys in the first place is that they are very easy to configure.  This
advantage is lost in a scalable environment where potentially hundreds or
thousands of client keys would need to be maintained by the server.  On the
other hand, SSL/TLS is a big win for scalability and server-side managment
because the server only needs a single pair of SSL/TLS keys.  It doesn't need
to be personally familiar with every possible client, it only needs to check
that a client's certificate was signed by the master CA certificate and that
the client certificate is not in the CRL (certificate revocation list).

* The server has been designed so that it can run with reduced privilege.

* For those of you who look at the source code, you will see major changes. 
In OpenVPN 1.x the tunnel state is basically maintained on the stack in the
openvpn() function.  In 2.0 an object has been added (called struct context)
that fully encapsulates the state information of a tunnel instance.  The
openvpn() function is now small and consise, with most support code having
been moved to init.c and forward.c.

Still to do before 2.0 final:

* Add TCP support to server mode.

* Add multithreading to server mode to take advantage of SMP capabilities and
reduce worst-case latency.

* Add an internal routing capability to the OpenVPN server to allow
client-to-client communication, without going through the tun interface on the
server.

Other features that may or may not make it into 2.0 final:

* Add tap interface and ethernet bridging support to server mode with the
caveat that tap-based VPNs scale badly on network bandwidth because of their
reliance on broadcasts, which must be copied and forwarded separately to every
client.  Most people want ethernet bridging to allow for easy windows
file-sharing and browsing.  However with a little bit of extra configuration,
taking advantage of new options such as --dhcp-options to push a WINS server
address to connecting clients (without even needing a real DHCP server), it
should be possible to get the major benefits of bridging in a scalable, routed
configuration.

* Right now clients are allocated a single, dynamic IP address.  It would be
nice if a connecting client could specify a full subnet to be tunneled.

* --push/--pull has some present limitations in the options it is able to
support.  Some options such as enabling compression and setting crypto options
are not yet supported in a push/pull context.  If an unsupported option is
used, the client will non-fatally complain.

* It would be nice to provide for some client-side failover by allowing
--remote to specify a set of machines, or allow a hostname in --remote that
has been configured with multiple addresses in DNS.  The idea is that a server
would be randomly chosen from the list, and if the connect failed, another
would be tried.

Caveats:

* Man page slightly lagging behind latest features, though usage message is
complete.

* --tun-mtu 1500 --mssfix 1450 is now the default (in 1.x the default is
--link-mtu 1300 for tun interfaces and --tun-mtu 1500 for tap interfaces, with
--mssfix disabled).

* For TLS usage, --key-method 2 is now the default.  Use --key-method 1 to
communicate with 1.x.

Other points worth mentioning:

* Windows self-install exe ships with OpenSSL 0.9.7d.

Ideas for beyond 2.0:

* True point-to-multipoint capability -- essentially a generalization of the
current multi-client server model.  In point-to-multipoint mode, a host can
securely connect into a kind of "VPN cloud" that is fully distributed, without
a single point of failure.  The VPN cloud is like a small version of the
internet itself and uses a protcol such as OSPF to dynamically manage routing
information.  The key advantage of this model is that it is distributed rather
than being bound to a single server.  This means that VPN traffic will take a
direct path between any 2 points in the cloud, rather than needing to go
through a central server.

Sample Configuration files:

########################################
# Sample OpenVPN config file for
# multi-client udp server

port 5000
dev tun

# TLS parms

tls-server 
ca sample-keys/tmp-ca.crt
cert sample-keys/server.crt
key sample-keys/server.key
dh sample-keys/dh1024.pem

# Tell OpenVPN to be a multi-client udp server
mode server

# The server's virtual endpoints
ifconfig 10.8.0.1 10.8.0.2

# Pool of /30 subnets to be allocated to clients.
# When a client connects, an --ifconfig command
# will be automatically generated and pushed back to
# the client.
ifconfig-pool 10.8.0.4 10.8.0.255

# Push route to client to bind it to our local
# virtual endpoint.
push "route 10.8.0.1 255.255.255.255"

# Delete client instances after some period
# of inactivity.
inactive 600

# Route the --ifconfig pool range into the
# OpenVPN server.
route 10.8.0.0 255.255.255.0

# The server doesn't need privileges
user nobody
group nobody

verb 4

#########################################
# Sample client-side OpenVPN config file
# for connecting to multi-client server.
#
# The server can be pinged at 10.8.0.1.
#
# This configuration can be used by multiple
# clients, however each client should have
# its own cert and key files.

port 5000
dev tun
remote [my server hostname or IP address]

# TLS parms

tls-client
ca sample-keys/tmp-ca.crt
cert sample-keys/client.crt
key sample-keys/client.key

# This parm is required for connecting
# to a multi-client server.  It tells
# the client to accept options which
# the server pushes to us.
pull

verb 4

###########################################




