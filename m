Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <lyfx6fciku.fsf@...1290...>
From: Enrico Scholz <enrico.scholz@...1291...>
Date: Fri, 08 Jan 2010 10:39:12 +0100
Message-ID: <lypr5lvsu7.fsf@...1290...>
MIME-Version: 1.0
Subject: [Openvpn-devel] RFE: allow 'lport 0' setup for random port binding
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

Hi,

I am running a multihomed host where 'local <extip>' must be specified
for proper operation.  Unfortunately, this implies 'lport 1194' or
another static port. 

This causes problems with stateful firewalls which register the host/port
pairs in the internal connection tracking table. On ungraceful reconnects,
the new TCP connection will have same the host/port pairs but unexpected
sequence numbers. The new connection will be assumed as invalid hence and
be dropped.

It would be nice when local port can be configured to be bound to a
random port number.  After reading code,

|    else if (streq (p[0], "lport") && p[1])
|  ...
|        port = atoi (p[1]);
|-       if (!legal_ipv4_port (port))
|+       if (port != 0 && !legal_ipv4_port (port))
|          {

in options.c seems to be the only required change.



Enrico

