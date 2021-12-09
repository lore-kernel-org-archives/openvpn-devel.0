From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  9 Dec 2021 18:11:37 +0100
Message-Id: <20211209171138.8589-2-frank@...2641...>
In-Reply-To: <20211209171138.8589-1-frank@...2641...>
References: <20211209171138.8589-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] doc: fix misc documentation issues
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

- Broken/missing formatting
- Make it obvious which arguments are optional
- In some cases moved the "Valid syntax" block
  earlier to make sure the text references argument
  names after they have been declared.

Only the files touched have been reviewed, all other
files likely have similar issues.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/client-options.rst   | 15 +++++------
 doc/man-sections/generic-options.rst  | 35 +++++++++++++++---------
 doc/man-sections/link-options.rst     | 38 +++++++++++++++++----------
 doc/man-sections/protocol-options.rst |  2 +-
 src/openvpn/options.c                 |  2 +-
 5 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index c5b7ad96..3c0bce4b 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -175,17 +175,16 @@ configuration.
   enabled.
 
 --inactive args
+  Valid syntaxes::
+
+       inactive n
+       inactive n bytes
+
   Causes OpenVPN to exit after ``n`` seconds of inactivity on the TUN/TAP
   device. The time length of inactivity is measured since the last
   incoming or outgoing tunnel packet. The default value is 0 seconds,
   which disables this feature.
 
-  Valid syntaxes:
-  ::
-
-       inactive n
-       inactive n bytes
-
   If the optional ``bytes`` parameter is included, exit if less than
   ``bytes`` of combined in/out traffic are produced on the tun/tap device
   in ``n`` seconds.
@@ -329,7 +328,7 @@ configuration.
   If hostname resolve fails for ``--remote``, retry resolve for ``n``
   seconds before failing.
 
-  Set ``n`` to "infinite" to retry indefinitely.
+  Set ``n`` to :code:`infinite` to retry indefinitely.
 
   By default, ``--resolv-retry infinite`` is enabled. You can disable by
   setting n=0.
@@ -348,7 +347,7 @@ configuration.
 --server-poll-timeout n
   When connecting to a remote server do not wait for more than ``n``
   seconds for a response before trying the next server. The default value
-  is 120s. This timeout includes proxy and TCP connect timeouts.
+  is :code:`120`. This timeout includes proxy and TCP connect timeouts.
 
 --static-challenge args
   Enable static challenge/response protocol
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index a8f049f2..c5d5fe62 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -48,7 +48,7 @@ which mode OpenVPN is configured as.
 
   Note: The SSL library will probably need /dev/urandom to be available
   inside the chroot directory ``dir``. This is because SSL libraries
-  occasionally need to collect fresh random. Newer linux kernels and some
+  occasionally need to collect fresh randomness. Newer linux kernels and some
   BSDs implement a getrandom() or getentropy() syscall that removes the
   need for /dev/urandom to be available.
 
@@ -75,7 +75,7 @@ which mode OpenVPN is configured as.
 
 --config file
   Load additional config options from ``file`` where each line corresponds
-  to one command line option, but with the leading '--' removed.
+  to one command line option, but with the leading :code:`--` removed.
 
   If ``--config file`` is the only option to the openvpn command, the
   ``--config`` can be removed, and the command can be given as ``openvpn
@@ -130,6 +130,11 @@ which mode OpenVPN is configured as.
       secret static.key
 
 --daemon progname
+  Valid syntaxes::
+
+    daemon
+    daemon progname
+
   Become a daemon after all initialization functions are completed. This
   option will cause all message and error output to be sent to the syslog
   file (such as :code:`/var/log/messages`), except for the output of
@@ -166,6 +171,8 @@ which mode OpenVPN is configured as.
   renegotiation (and reauthentication) occurs.
 
 --disable-occ
+  Disable "options consistency check" (OCC).
+
   Don't output a warning message if option inconsistencies are detected
   between peers. An example of an option inconsistency would be where one
   peer uses ``--dev tun`` while the other peer uses ``--dev tap``.
@@ -175,6 +182,11 @@ which mode OpenVPN is configured as.
   version.
 
 --engine engine-name
+  Valid syntaxes::
+
+    engine
+    engine engine-name
+
   Enable OpenSSL hardware-based crypto engine functionality.
 
   If ``engine-name`` is specified, use a specific crypto engine. Use the
@@ -221,16 +233,15 @@ which mode OpenVPN is configured as.
   May be used in order to execute OpenVPN in unprivileged environment.
 
 --keying-material-exporter args
+  Valid syntax::
+
+    keying-material-exporter label len
+
   Save Exported Keying Material [RFC5705] of len bytes (must be between 16
   and 4095 bytes) using ``label`` in environment
   (:code:`exported_keying_material`) for use by plugins in
   :code:`OPENVPN_PLUGIN_TLS_FINAL` callback.
 
-  Valid syntax:
-  ::
-
-    keying-material-exporter label len
-
   Note that exporter ``labels`` have the potential to collide with existing
   PRF labels. In order to prevent this, labels *MUST* begin with
   :code:`EXPORTER`.
@@ -295,7 +306,7 @@ which mode OpenVPN is configured as.
 --remap-usr1 signal
   Control whether internally or externally generated :code:`SIGUSR1` signals
   are remapped to :code:`SIGHUP` (restart without persisting state) or
-  SIGTERM (exit).
+  :code:`SIGTERM` (exit).
 
   ``signal`` can be set to :code:`SIGHUP` or :code:`SIGTERM`. By default,
   no remapping occurs.
@@ -372,14 +383,14 @@ which mode OpenVPN is configured as.
   consider using the ``--persist-key`` and ``--persist-tun`` options.
 
 --status args
-  Write operational status to ``file`` every ``n`` seconds.
-
-  Valid syntaxes:
-  ::
+  Valid syntaxes::
 
     status file
     status file n
 
+  Write operational status to ``file`` every ``n`` seconds. ``n`` defaults
+  to :code:`60` if not specified.
+
   Status can also be written to the syslog by sending a :code:`SIGUSR2`
   signal.
 
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 32e72a1b..901751bb 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -51,13 +51,15 @@ the local and the remote host.
   UDP multicast stream which requires fragmentation.
 
 --keepalive args
+  Valid syntax::
+
+     keepalive interval timeout
+
   A helper directive designed to simplify the expression of ``--ping`` and
   ``--ping-restart``.
 
-  Valid syntax:
-  ::
-
-     keepalive interval timeout
+  Send ping once every ``interval`` seconds, restart if ping is not received
+  for ``timeout`` seconds.
 
   This option can be used on both client and server side, but it is enough
   to add this on the server side as it will push appropriate ``--ping``
@@ -96,7 +98,7 @@ the local and the remote host.
   ``--nobind`` option.
 
 --mark value
-  Mark encrypted packets being sent with value. The mark value can be
+  Mark encrypted packets being sent with ``value``. The mark value can be
   matched in policy routing and packetfilter rules. This option is only
   supported in Linux and does nothing on other operating systems.
 
@@ -106,6 +108,11 @@ the local and the remote host.
   implements a multi-client server capability.
 
 --mssfix max
+  Valid syntaxes::
+
+    mssfix
+    mssfix max
+
   Announce to TCP sessions running over the tunnel that they should limit
   their send packet sizes such that after OpenVPN has encapsulated them,
   the resulting UDP packet size that OpenVPN sends to its peer will not
@@ -167,7 +174,7 @@ the local and the remote host.
   Do not bind to local address and port. The IP stack will allocate a
   dynamic port for returning packets. Since the value of the dynamic port
   could not be known in advance by a peer, this option is only suitable
-  for peers which will be initiating connections by using the --remote
+  for peers which will be initiating connections by using the ``--remote``
   option.
 
 --passtos
@@ -191,6 +198,8 @@ the local and the remote host.
   (2)  To provide a basis for the remote to test the existence of its peer
        using the ``--ping-exit`` option.
 
+  When using OpenVPN in server mode see also ``--keepalive``.
+
 --ping-exit n
   Causes OpenVPN to exit after ``n`` seconds pass without reception of a
   ping or other packet from remote. This option can be combined with
@@ -291,18 +300,19 @@ the local and the remote host.
 --replay-window args
   Modify the replay protection sliding-window size and time window.
 
-  Valid syntax:
-  ::
+  Valid syntaxes::
 
-     replay-window n [t]
+     replay-window n
+     replay-window n t
 
-  Use a replay protection sliding-window of size **n** and a time window
-  of **t** seconds.
+  Use a replay protection sliding-window of size ``n`` and a time window
+  of ``t`` seconds.
 
-  By default **n** is 64 (the IPSec default) and **t** is 15 seconds.
+  By default ``n`` is :code:`64` (the IPSec default) and ``t`` is
+  :code:`15` seconds.
 
-  This option is only relevant in UDP mode, i.e. when either **--proto
-  udp** is specified, or no **--proto** option is specified.
+  This option is only relevant in UDP mode, i.e. when either ``--proto
+  udp`` is specified, or no ``--proto`` option is specified.
 
   When OpenVPN tunnels IP packets over UDP, there is the possibility that
   packets might be dropped or delivered out of order. Because OpenVPN,
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 1c6b1200..b3edc499 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -125,7 +125,7 @@ configured in a compatible way between both the local and remote side.
   configuration if supported by the client and otherwise switch to ``comp-lzo no``
   and add ``--push comp-lzo`` to the client specific configuration.
 
-  ***Security Considerations***
+  **Security Considerations**
 
   Compression and encryption is a tricky combination. If an attacker knows
   or is able to control (parts of) the plain-text of packets that contain
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ac13412a..c1ec7ed0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -343,7 +343,7 @@ static const char usage_message[] =
     "                       and received from TCP/UDP (caps) or tun/tap (lc)\n"
     "                : 6 to 11 -- debug messages of increasing verbosity\n"
     "--mute n        : Log at most n consecutive messages in the same category.\n"
-    "--status file n : Write operational status to file every n seconds.\n"
+    "--status file [n] : Write operational status to file every n seconds.\n"
     "--status-version [n] : Choose the status file format version number.\n"
     "                  Currently, n can be 1, 2, or 3 (default=1).\n"
     "--disable-occ   : Disable options consistency check between peers.\n"
-- 
2.30.2


