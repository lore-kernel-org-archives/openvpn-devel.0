From: Arne Schwabe <arne@...1227...>
Date: Mon,  6 Dec 2021 02:00:07 +0100
Message-Id: <20211206010007.3072528-1-arne@...1227...>
In-Reply-To: <20211202125455.2593763-1-arne@...1227...>
References: <20211202125455.2593763-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Make --nobind default for --pull
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

Currently we default to local binding with udp. But the majority of
configuration files actually uses --nobind in the configuration to
change the default for --client. And client protocols should normally
use a random source port. This changes the default. Local binding with
--client can still be done using --bind.

This commit refactors the current code to be more easy to add to understand
and adds the the o->pull condition as additional option to opt into setting
local binding to false.

Patch v2: add more commments

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst           |  3 ++-
 src/openvpn/options.c | 16 +++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index e83dda023..b7d7f2054 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -120,7 +120,8 @@ PF (Packet Filtering) support has been removed
 User-visible Changes
 --------------------
 - CHACHA20-POLY1305 is included in the default of ``--data-ciphers`` when available.
-- Option ``--prng`` is ignored as we rely on the SSL library radnom generator.
+- Option ``--prng`` is ignored as we rely on the SSL library random number generator.
+- Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
 
 Overview of changes in 2.5
 ==========================
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 312efb36c..39cf3e99a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2859,14 +2859,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         }
     }
 
-    if (ce->proto == PROTO_TCP_CLIENT && !ce->local
-        && !ce->local_port_defined && !ce->bind_defined)
-    {
-        ce->bind_local = false;
-    }
+    /* an option is present that requires local bind to enabled */
+    bool need_bind = ce->local || ce->local_port_defined || ce->bind_defined;
+
+    /* socks proxy is enabled */
+    bool uses_socks = ce->proto == PROTO_UDP && ce->socks_proxy_server;
 
-    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local
-        && !ce->local_port_defined && !ce->bind_defined)
+    /* If binding is not forced by an explicit options and we have (at least)
+     * one of --tcp-client, --pull (or --client), or socks we do not bind
+     * locally to have "normal" IP client behaviour of a random source port */
+    if (!need_bind && (ce->proto == PROTO_TCP_CLIENT || uses_socks || o->pull))
     {
         ce->bind_local = false;
     }
-- 
2.33.0


