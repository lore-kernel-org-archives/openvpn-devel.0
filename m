From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 14 Feb 2022 18:33:42 +0100
Message-Id: <20220214173342.12655-1-frank@...2641...>
In-Reply-To: <20211209171138.8589-2-frank@...2641...>
References: <20211209171138.8589-2-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3 v2] doc: fix misc documentation issues
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

Only the files touched have been reviewed, all other
files likely have similar issues.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/client-options.rst  |  4 ++--
 doc/man-sections/generic-options.rst | 34 ++++++++++++++++++++--------
 doc/man-sections/link-options.rst    | 26 +++++++++++++--------
 src/openvpn/options.c                |  2 +-
 4 files changed, 43 insertions(+), 23 deletions(-)

v2: remove some changes David disliked. Not that important.

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 92a02e28..c7cec176 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -398,7 +398,7 @@ configuration.
   If hostname resolve fails for ``--remote``, retry resolve for ``n``
   seconds before failing.
 
-  Set ``n`` to "infinite" to retry indefinitely.
+  Set ``n`` to :code:`infinite` to retry indefinitely.
 
   By default, ``--resolv-retry infinite`` is enabled. You can disable by
   setting n=0.
@@ -417,7 +417,7 @@ configuration.
 --server-poll-timeout n
   When connecting to a remote server do not wait for more than ``n``
   seconds for a response before trying the next server. The default value
-  is 120s. This timeout includes proxy and TCP connect timeouts.
+  is :code:`120`. This timeout includes proxy and TCP connect timeouts.
 
 --static-challenge args
   Enable static challenge/response protocol
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index a8f049f2..9060a235 100644
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
@@ -130,8 +130,14 @@ which mode OpenVPN is configured as.
       secret static.key
 
 --daemon progname
-  Become a daemon after all initialization functions are completed. This
-  option will cause all message and error output to be sent to the syslog
+  Become a daemon after all initialization functions are completed.
+
+  Valid syntaxes::
+
+    daemon
+    daemon progname
+
+  This option will cause all message and error output to be sent to the syslog
   file (such as :code:`/var/log/messages`), except for the output of
   scripts and ifconfig commands, which will go to :code:`/dev/null` unless
   otherwise redirected. The syslog redirection occurs immediately at the
@@ -142,7 +148,7 @@ which mode OpenVPN is configured as.
   The optional ``progname`` parameter will cause OpenVPN to report its
   program name to the system logger as ``progname``. This can be useful in
   linking OpenVPN messages in the syslog file with specific tunnels. When
-  unspecified, ``progname`` defaults to "openvpn".
+  unspecified, ``progname`` defaults to :code:`openvpn`.
 
   When OpenVPN is run with the ``--daemon`` option, it will try to delay
   daemonization until the majority of initialization functions which are
@@ -166,6 +172,8 @@ which mode OpenVPN is configured as.
   renegotiation (and reauthentication) occurs.
 
 --disable-occ
+  Disable "options consistency check" (OCC).
+
   Don't output a warning message if option inconsistencies are detected
   between peers. An example of an option inconsistency would be where one
   peer uses ``--dev tun`` while the other peer uses ``--dev tap``.
@@ -177,6 +185,11 @@ which mode OpenVPN is configured as.
 --engine engine-name
   Enable OpenSSL hardware-based crypto engine functionality.
 
+  Valid syntaxes::
+
+    engine
+    engine engine-name
+
   If ``engine-name`` is specified, use a specific crypto engine. Use the
   ``--show-engines`` standalone option to list the crypto engines which
   are supported by OpenSSL.
@@ -191,7 +204,7 @@ which mode OpenVPN is configured as.
   call, improving CPU efficiency by 5% to 10%.
 
   This option can only be used on non-Windows systems, when ``--proto
-  udp`` is specified, and when ``--shaper`` is NOT specified.
+  udp`` is specified, and when ``--shaper`` is *NOT* specified.
 
 --group group
   Similar to the ``--user`` option, this option changes the group ID of
@@ -221,7 +234,7 @@ which mode OpenVPN is configured as.
   May be used in order to execute OpenVPN in unprivileged environment.
 
 --keying-material-exporter args
-  Save Exported Keying Material [RFC5705] of len bytes (must be between 16
+  Save Exported Keying Material [RFC5705] of ``len`` bytes (must be between 16
   and 4095 bytes) using ``label`` in environment
   (:code:`exported_keying_material`) for use by plugins in
   :code:`OPENVPN_PLUGIN_TLS_FINAL` callback.
@@ -289,13 +302,13 @@ which mode OpenVPN is configured as.
 
       --providers legacy default
 
-  Behaviour of changing this option between SIGHUP might not be well behaving.
+  Behaviour of changing this option between :code:`SIGHUP` might not be well behaving.
   If you need to change/add/remove this option, fully restart OpenVPN.
 
 --remap-usr1 signal
   Control whether internally or externally generated :code:`SIGUSR1` signals
   are remapped to :code:`SIGHUP` (restart without persisting state) or
-  SIGTERM (exit).
+  :code:`SIGTERM` (exit).
 
   ``signal`` can be set to :code:`SIGHUP` or :code:`SIGTERM`. By default,
   no remapping occurs.
@@ -372,7 +385,8 @@ which mode OpenVPN is configured as.
   consider using the ``--persist-key`` and ``--persist-tun`` options.
 
 --status args
-  Write operational status to ``file`` every ``n`` seconds.
+  Write operational status to ``file`` every ``n`` seconds. ``n`` defaults
+  to :code:`60` if not specified.
 
   Valid syntaxes:
   ::
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 1cf6dd84..52df843d 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -71,6 +71,9 @@ the local and the remote host.
 
      keepalive interval timeout
 
+  Send ping once every ``interval`` seconds, restart if ping is not received
+  for ``timeout`` seconds.
+
   This option can be used on both client and server side, but it is enough
   to add this on the server side as it will push appropriate ``--ping``
   and ``--ping-restart`` options to the client. If used on both server and
@@ -113,7 +116,7 @@ the local and the remote host.
   ``--nobind`` option.
 
 --mark value
-  Mark encrypted packets being sent with value. The mark value can be
+  Mark encrypted packets being sent with ``value``. The mark value can be
   matched in policy routing and packetfilter rules. This option is only
   supported in Linux and does nothing on other operating systems.
 
@@ -202,7 +205,7 @@ the local and the remote host.
   Do not bind to local address and port. The IP stack will allocate a
   dynamic port for returning packets. Since the value of the dynamic port
   could not be known in advance by a peer, this option is only suitable
-  for peers which will be initiating connections by using the --remote
+  for peers which will be initiating connections by using the ``--remote``
   option.
 
 --passtos
@@ -226,6 +229,8 @@ the local and the remote host.
   (2)  To provide a basis for the remote to test the existence of its peer
        using the ``--ping-exit`` option.
 
+  When using OpenVPN in server mode see also ``--keepalive``.
+
 --ping-exit n
   Causes OpenVPN to exit after ``n`` seconds pass without reception of a
   ping or other packet from remote. This option can be combined with
@@ -326,18 +331,19 @@ the local and the remote host.
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2538421b..92aeba3d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -344,7 +344,7 @@ static const char usage_message[] =
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


