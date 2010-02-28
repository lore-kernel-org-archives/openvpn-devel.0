From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 14:44:14 +0100
Message-Id: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Allow 'lport 0' setup for random port
	binding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Enrico Scholz <enrico.scholz@...1291...>, David Sommerseth <dazo@...384...>

From: Enrico Scholz <enrico.scholz@...1291...>

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

This has been discussed here:
<http://thread.gmane.org/gmane.network.openvpn.user/28622>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 options.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/options.c b/options.c
index c5ca8b6..36b9913 100644
--- a/options.c
+++ b/options.c
@@ -4072,7 +4072,7 @@ add_option (struct options *options,
 
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       port = atoi (p[1]);
-      if (!legal_ipv4_port (port))
+      if ((port != 0) && !legal_ipv4_port (port))
 	{
 	  msg (msglevel, "Bad local port number: %s", p[1]);
 	  goto err;
-- 
1.6.6.1


