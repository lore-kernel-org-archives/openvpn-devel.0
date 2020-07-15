From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:06 +0200
Message-Id: <20200715223013.11726-10-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 09/16] doc/man: Move some options from link
 to advanced section
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

Moved --persist-local-ip, --persist-remote-ip, --rcvbuf, --sndbuf
and --shaper from the link options section to the advanced section.

The rationale is that these options are not common to use and is for
more advanced use cases where special tweaking is required.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/advanced-options.rst | 40 +++++++++++++++++++++++++++
 doc/man-sections/link-options.rst     | 40 ---------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 9e59677d..262e568c 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -34,6 +34,14 @@ used when debugging or testing out special usage scenarios.
 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`).
 
+--persist-local-ip
+  Preserve initially resolved local IP address and port number across
+  ``SIGUSR1`` or ``--ping-restart`` restarts.
+
+--persist-remote-ip
+  Preserve most recently authenticated remote IP address and port number
+  across :code:`SIGUSR1` or ``--ping-restart`` restarts.
+
 --prng args
   *(Advanced)* Change the PRNG (Pseudo-random number generator) parameters
 
@@ -51,6 +59,38 @@ used when debugging or testing out special usage scenarios.
   RAND\_bytes function instead for all of OpenVPN's pseudo-random number
   needs.
 
+--rcvbuf size
+  Set the TCP/UDP socket receive buffer size. Defaults to operation system
+  default.
+
+--shaper n
+  Limit bandwidth of outgoing tunnel data to ``n`` bytes per second on the
+  TCP/UDP port. Note that this will only work if mode is set to
+  :code:`p2p`.  If you want to limit the bandwidth in both directions, use
+  this option on both peers.
+
+  OpenVPN uses the following algorithm to implement traffic shaping: Given
+  a shaper rate of ``n`` bytes per second, after a datagram write of ``b``
+  bytes is queued on the TCP/UDP port, wait a minimum of ``(b / n)``
+  seconds before queuing the next write.
+
+  It should be noted that OpenVPN supports multiple tunnels between the
+  same two peers, allowing you to construct full-speed and reduced
+  bandwidth tunnels at the same time, routing low-priority data such as
+  off-site backups over the reduced bandwidth tunnel, and other data over
+  the full-speed tunnel.
+
+  Also note that for low bandwidth tunnels (under 1000 bytes per second),
+  you should probably use lower MTU values as well (see above), otherwise
+  the packet latency will grow so large as to trigger timeouts in the TLS
+  layer and TCP connections running over the tunnel.
+
+  OpenVPN allows ``n`` to be between 100 bytes/sec and 100 Mbytes/sec.
+
+--sndbuf size
+  Set the TCP/UDP socket send buffer size. Defaults to operation system
+  default.
+
 --tcp-queue-limit n
   Maximum number of output packets queued before TCP (default :code:`64`).
 
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index ca719c75..5f75c5f3 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -173,14 +173,6 @@ the local and the remote host.
 --passtos
   Set the TOS field of the tunnel packet to what the payload's TOS is.
 
---persist-local-ip
-  Preserve initially resolved local IP address and port number across
-  ``SIGUSR1`` or ``--ping-restart`` restarts.
-
---persist-remote-ip
-  Preserve most recently authenticated remote IP address and port number
-  across :code:`SIGUSR1` or ``--ping-restart`` restarts.
-
 --ping n
   Ping remote over the TCP/UDP control channel if no packets have been
   sent for at least ``n`` seconds (specify ``--ping`` on both peers to
@@ -292,10 +284,6 @@ the local and the remote host.
   and has been used since version 2.0-beta17. Previous versions used port
   5000 as the default.
 
---rcvbuf size
-  Set the TCP/UDP socket receive buffer size. Defaults to operation system
-  default.
-
 --reneg-bytes n
   Renegotiate data channel key after ``n`` bytes sent or received
   (disabled by default with an exception, see below). OpenVPN allows the
@@ -439,34 +427,6 @@ the local and the remote host.
   default) and you are using either ``--secret`` (shared-secret key mode)
   or TLS mode with ``--tls-auth``.
 
---shaper n
-  Limit bandwidth of outgoing tunnel data to ``n`` bytes per second on the
-  TCP/UDP port. Note that this will only work if mode is set to
-  :code:`p2p`.  If you want to limit the bandwidth in both directions, use
-  this option on both peers.
-
-  OpenVPN uses the following algorithm to implement traffic shaping: Given
-  a shaper rate of ``n`` bytes per second, after a datagram write of ``b``
-  bytes is queued on the TCP/UDP port, wait a minimum of ``(b / n)``
-  seconds before queuing the next write.
-
-  It should be noted that OpenVPN supports multiple tunnels between the
-  same two peers, allowing you to construct full-speed and reduced
-  bandwidth tunnels at the same time, routing low-priority data such as
-  off-site backups over the reduced bandwidth tunnel, and other data over
-  the full-speed tunnel.
-
-  Also note that for low bandwidth tunnels (under 1000 bytes per second),
-  you should probably use lower MTU values as well (see above), otherwise
-  the packet latency will grow so large as to trigger timeouts in the TLS
-  layer and TCP connections running over the tunnel.
-
-  OpenVPN allows ``n`` to be between 100 bytes/sec and 100 Mbytes/sec.
-
---sndbuf size
-  Set the TCP/UDP socket send buffer size. Defaults to operation system
-  default.
-
 --socket-flags flags
   Apply the given flags to the OpenVPN transport socket. Currently, only
   :code:`TCP_NODELAY` is supported.
-- 
2.26.0


