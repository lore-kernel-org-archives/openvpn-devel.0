From: David Sommerseth <davids@...515...>
Date: Mon, 20 Jul 2020 13:51:56 +0200
Message-Id: <20200720115156.13322-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --ifconfig-pool-linear
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

This option has been deprecated since OpenVPN 2.1 and it has been
highlighted in the documentation and log files since OpenVPN 2.4.4.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst           | 3 +++
 src/openvpn/options.c | 9 ---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a1d88a71..57823806 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -42,6 +42,9 @@ https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
   This option will now cause server configurations to not start.  Use
   ``--verify-client-cert none`` instead.
 
+- ``--ifconfig-pool-linear`` has been removed
+  This option is removed.  Use ``--topology p2p`` instead.
+
 User-visible Changes
 --------------------
 - If multiple connect handlers are used (client-connect, ccd, connect
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5a81b0c2..be763cfb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -426,9 +426,6 @@ static const char usage_message[] =
     "                  client instance.\n"
     "--ifconfig-pool start-IP end-IP [netmask] : Set aside a pool of subnets\n"
     "                  to be dynamically allocated to connecting clients.\n"
-    "--ifconfig-pool-linear : (DEPRECATED) Use individual addresses rather \n"
-    "                  than /30 subnets\n in tun mode.  Not compatible with\n"
-    "                  Windows clients.\n"
     "--ifconfig-pool-persist file [seconds] : Persist/unpersist ifconfig-pool\n"
     "                  data to file, at seconds intervals (default=600).\n"
     "                  If seconds=0, file will be treated as read-only.\n"
@@ -6847,12 +6844,6 @@ add_option(struct options *options,
             options->ifconfig_pool_persist_refresh_freq = positive_atoi(p[2]);
         }
     }
-    else if (streq(p[0], "ifconfig-pool-linear") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->topology = TOP_P2P;
-        msg(M_WARN, "DEPRECATED OPTION: --ifconfig-pool-linear, use --topology p2p instead");
-    }
     else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
     {
         const int lev = M_WARN;
-- 
2.26.0


