From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 29 Nov 2022 15:47:31 +0100
Message-Id: <20221129144731.35105-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] documentation: avoid recommending --user
 nobody
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

Recommend to create an user dedicated to openvpn
so that there is no priviledge escalation between
different services using that user.

cf. https://wiki.ubuntu.com/nobody

Trac: #1335
CC: tincantech <tincantech@...2282...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/generic-options.rst       | 9 +++++++--
 sample/sample-config-files/client.conf     | 4 ++--
 sample/sample-config-files/server.conf     | 8 ++++----
 sample/sample-config-files/tls-home.conf   | 8 ++++----
 sample/sample-config-files/tls-office.conf | 8 ++++----
 src/openvpn/init.c                         | 2 +-
 6 files changed, 22 insertions(+), 17 deletions(-)

Low-hanging fruit found when cleaning up Trac.

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 394c2186..d2b226c4 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -294,7 +294,7 @@ which mode OpenVPN is configured as.
 --persist-key
   Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
 
-  This option can be combined with ``--user nobody`` to allow restarts
+  This option can be combined with ``--user`` to allow restarts
   triggered by the :code:`SIGUSR1` signal. Normally if you drop root
   privileges in OpenVPN, the daemon cannot be restarted since it will now
   be unable to re-read protected key files.
@@ -491,7 +491,7 @@ which mode OpenVPN is configured as.
   able to gain control of an OpenVPN session. Though OpenVPN's security
   features make this unlikely, it is provided as a second line of defense.
 
-  By setting ``user`` to :code:`nobody` or somebody similarly unprivileged,
+  By setting ``user`` to an unprivileged user dedicated to run openvpn,
   the hostile party would be limited in what damage they could cause. Of
   course once you take away privileges, you cannot return them to an
   OpenVPN session. This means, for example, that if you want to reset an
@@ -501,5 +501,10 @@ which mode OpenVPN is configured as.
   operations in order to restart (such as re-reading key files or running
   ``ifconfig`` on the TUN device).
 
+  NOTE: Previous versions of openvpn used :code:`nobody` as the example
+  unpriviledged user. It is not recommended to actually use that user
+  since it is usually used by other system services already. Always
+  create a dedicated user for openvpn.
+
 --writepid file
   Write OpenVPN's main process ID to ``file``.
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 47ca4099..15cb1b37 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -58,8 +58,8 @@ resolv-retry infinite
 nobind
 
 # Downgrade privileges after initialization (non-Windows only)
-;user nobody
-;group nobody
+;user openvpn
+;group openvpn
 
 # Try to preserve some state across restarts.
 persist-key
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index e7020639..d9345b64 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -269,10 +269,10 @@ cipher AES-256-CBC
 # It's a good idea to reduce the OpenVPN
 # daemon's privileges after initialization.
 #
-# You can uncomment this out on
-# non-Windows systems.
-;user nobody
-;group nobody
+# You can uncomment this on non-Windows
+# systems after creating a dedicated user.
+;user openvpn
+;group openvpn
 
 # The persist options will try to avoid
 # accessing certain resources on restart
diff --git a/sample/sample-config-files/tls-home.conf b/sample/sample-config-files/tls-home.conf
index 3a9297cc..ff19d50d 100644
--- a/sample/sample-config-files/tls-home.conf
+++ b/sample/sample-config-files/tls-home.conf
@@ -47,11 +47,11 @@ cipher AES-256-GCM
 # for local and remote.
 ; port 1194
 
-# Downgrade UID and GID to
-# "nobody" after initialization
+# Downgrade UID and GID to an
+# unpriviledged user after initialization
 # for extra security.
-; user nobody
-; group nobody
+; user openvpn
+; group openvpn
 
 # If you built OpenVPN with
 # LZO compression, uncomment
diff --git a/sample/sample-config-files/tls-office.conf b/sample/sample-config-files/tls-office.conf
index 81052211..152e58a0 100644
--- a/sample/sample-config-files/tls-office.conf
+++ b/sample/sample-config-files/tls-office.conf
@@ -50,11 +50,11 @@ cipher AES-256-GCM
 # for local and remote.
 ; port 1194
 
-# Downgrade UID and GID to
-# "nobody" after initialization
+# Downgrade UID and GID to an
+# unpriviledged user after initialization
 # for extra security.
-; user nobody
-; group nobody
+; user openvpn
+; group openvpn
 
 # If you built OpenVPN with
 # LZO compression, uncomment
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0e476977..fee44232 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2020,7 +2020,7 @@ do_close_tun(struct context *c, bool force)
         }
 
         /* Run the down script -- note that it will run at reduced
-         * privilege if, for example, "--user nobody" was used. */
+         * privilege if, for example, "--user" was used. */
         run_up_down(c->options.down_script,
                     c->plugins,
                     OPENVPN_PLUGIN_DOWN,
-- 
2.34.1


