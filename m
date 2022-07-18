From: Antonio Quartulli <a@...2181...>
Date: Tue, 19 Jul 2022 01:12:40 +0200
Message-Id: <20220718231240.15810-1-a@...2181...>
In-Reply-To: <20220624083809.23487-13-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 12/25] dco: check that pulled options are
 compatible
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
Cc: Antonio Quartulli <a@...2181...>

A server may push options that are not compatible with DCO.
In this case we should log a message and bail out.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* move check_dco_pull_options() to dco.c (renamed to
  dco_check_pull_options())
* make options argument const
* add msglevel as first argument

 src/openvpn/dco.c  | 12 ++++++++++++
 src/openvpn/dco.h  | 17 +++++++++++++++++
 src/openvpn/init.c | 11 +++++++++++
 3 files changed, 40 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b39759e1..fa4a8487 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -339,4 +339,16 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     return true;
 }
 
+bool
+dco_check_pull_options(int msglevel, const struct options *o)
+{
+    if (!o->use_peer_id)
+    {
+        msg(msglevel, "OPTIONS IMPORT: Server did not request DATA_V2 packet "
+            "format required for data channel offload");
+        return false;
+    }
+    return true;
+}
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index cb7f7e4f..a4bf6e37 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -65,6 +65,17 @@ bool dco_available(int msglevel);
  */
 bool dco_check_option_conflict(int msglevel, const struct options *o);
 
+/**
+ * Check whether any of the options pushed by the server is not supported by
+ * our current dco implementation. If so print a warning at warning level
+ * for the first conflicting option found and return false.
+ *
+ * @param msglevel  the msg level to use to print the warnings
+ * @param o         the options struct that hold the options
+ * @return          true if no conflict was detected, false otherwise
+ */
+bool dco_check_pull_options(int msglevel, const struct options *o);
+
 /**
  * Initialize the DCO context
  *
@@ -154,6 +165,12 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     return false;
 }
 
+static inline bool
+dco_check_pull_options(int msglevel, const struct options *o)
+{
+    return false;
+}
+
 static inline bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8e1221dd..ff2787d7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2366,6 +2366,17 @@ finish_options(struct context *c)
         return false;
     }
 
+    /* Check if the pushed options are compatible with DCO if we have
+     * DCO enabled */
+    if (dco_enabled(&c->options) && !dco_check_pull_options(D_TLS_ERRORS,
+                                                            &c->options))
+    {
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
+            "data channel offload. Use --disable-dco to connect"
+            "to this server");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.1


