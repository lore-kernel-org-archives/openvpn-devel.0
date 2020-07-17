From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 19:15:44 +0200
Message-Id: <20200717171544.21632-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --no-iv
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

This finializes the depreacation started in OpenVPN 2.4, where --no-iv
was made into a NOOP option.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst                              | 3 +++
 doc/man-sections/server-options.rst      | 2 +-
 doc/man-sections/unsupported-options.rst | 2 +-
 src/openvpn/options.c                    | 5 -----
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index e279d360..7d4fdec6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -39,6 +39,9 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
     adds a security weakness.  This was also highlighted during the
     `OpenVPN 2.4 security audit <https://community.openvpn.net/openvpn/wiki/QuarkslabAndCryptographyEngineerAudits#OVPN-03-3:Insecureconfigurationoptions:--no-replay>`_.
 
+- ``no-iv`` has been removed
+  This option was made into a NOOP option with OpenVPN 2.4.  This has now
+  been completely removed.
 
 Overview of changes in 2.4
 ==========================
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 2381f5c8..75d174ea 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -399,7 +399,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
   ``auth``, ``keysize``, ``secret``,
-  ``no-iv``, ``tls-auth``, ``key-method``, ``tls-server``
+  ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.
 
   This option requires that ``--disable-occ`` NOT be used.
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 8aff5dd9..05ba3ca2 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -19,7 +19,7 @@ longer supported
 
 --no-iv
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
-  VPN tunnel security.
+  VPN tunnel security.  This has been a NOOP option since OpenVPN 2.4.
 
 --no-replay
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e1658472..0f0b37d1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7985,11 +7985,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mute_replay_warnings = true;
     }
-    else if (streq(p[0], "no-iv") && !p[1])
-    {
-        msg(msglevel,
-            "--no-iv is no longer supported. Remove it from client and server configs.");
-    }
     else if (streq(p[0], "replay-persist") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-- 
2.26.0


