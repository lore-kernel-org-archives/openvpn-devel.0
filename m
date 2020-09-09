From: David Sommerseth <davids@...515...>
Date: Wed,  9 Sep 2020 20:30:12 +0200
Message-Id: <20200909183012.7504-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man: Improve --remote entry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The --remote entry had a syntax mistake in the argument examples, which
was introduced during the .rst conversion.

In addition this section did not have a good flow.  So the text was
regrouped and re-organized a bit so related text pieces are now gathered
in the same context instead of being more spread out.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/client-options.rst | 60 ++++++++++++++++-------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index ec1e3b11..af21fbcd 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -244,43 +244,51 @@ configuration.
   use :code:`ignore`.
 
 --remote args
-  Remote host name or IP address.  It supports two additional optional
-  arguments: ``port`` and ``proto``.  On the client, multiple ``--remote``
-  options may be specified for redundancy, each referring to a different
-  OpenVPN server. Specifying multiple ``--remote`` options for this
-  purpose is a special case of the more general connection-profile
-  feature. See the ``<connection>`` documentation below.
+  Remote host name or IP address, port and protocol.
 
-  The OpenVPN client will try to connect to a server at ``host:port`` in
-  the order specified by the list of ``--remote`` options.
-
-  Examples:
+  Valid syntaxes:
   ::
 
-     remote server.example.net
-     remote server.example.net 1194
-     remote server.example.net tcp
+     remote host
+     remote host port
+     remote host port proto
 
-  ``proto`` indicates the protocol to use when connecting with the remote,
-  and may be :code:`tcp` or :code:`udp`.
+  The ``port`` and ``proto`` arguments are optional. The OpenVPN client
+  will try to connect to a server at ``host:port``.  The ``proto`` argument
+  indicates the protocol to use when connecting with the remote, and may be
+  :code:`tcp` or :code:`udp`.  To enforce IPv4 or IPv6 connections add a
+  :code:`4` or :code:`6` suffix; like :code:`udp4` / :code:`udp6`
+  / :code:`tcp4` / :code:`tcp6`.
 
-  For forcing IPv4 or IPv6 connection suffix tcp or udp with 4/6 like
-  udp4/udp6/tcp4/tcp6.
+  On the client, multiple ``--remote`` options may be specified for
+  redundancy, each referring to a different OpenVPN server, in the order
+  specified by the list of ``--remote`` options. Specifying multiple
+  ``--remote`` options for this purpose is a special case of the more
+  general connection-profile feature. See the ``<connection>``
+  documentation below.
 
   The client will move on to the next host in the list, in the event of
   connection failure. Note that at any given time, the OpenVPN client will
   at most be connected to one server.
 
-  Note that since UDP is connectionless, connection failure is defined by
-  the ``--ping`` and ``--ping-restart`` options.
+  Examples:
+  ::
 
-  Note the following corner case: If you use multiple ``--remote``
-  options, AND you are dropping root privileges on the client with
-  ``--user`` and/or ``--group`` AND the client is running a non-Windows
-  OS, if the client needs to switch to a different server, and that server
-  pushes back different TUN/TAP or route settings, the client may lack the
-  necessary privileges to close and reopen the TUN/TAP interface. This
-  could cause the client to exit with a fatal error.
+     remote server1.example.net
+     remote server1.example.net 1194
+     remote server2.example.net 1194 tcp
+
+  *Note:*
+     Since UDP is connectionless, connection failure is defined by
+     the ``--ping`` and ``--ping-restart`` options.
+
+     Also, if you use multiple ``--remote`` options, AND you are dropping
+     root privileges on the client with ``--user`` and/or ``--group`` AND
+     the client is running a non-Windows OS, if the client needs to switch
+     to a different server, and that server pushes back different TUN/TAP
+     or route settings, the client may lack the necessary privileges to
+     close and reopen the TUN/TAP interface. This could cause the client
+     to exit with a fatal error.
 
   If ``--remote`` is unspecified, OpenVPN will listen for packets from any
   IP address, but will not act on those packets unless they pass all
-- 
2.26.0


