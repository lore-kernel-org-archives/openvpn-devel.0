From: Antonio Quartulli <a@...2181...>
Date: Thu,  4 Aug 2022 08:40:16 +0200
Message-Id: <20220804064016.20414-1-a@...2181...>
In-Reply-To: <20220719080715.1445-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 12/35] dco: check that pulled options are
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

Changes from v3:
* move pull-option-check to before opening the tun device, for earlier
  bail out
* fix typ0 in error message (missing blank)

Changes from v2:
* split if condition on two lines

Changes from v1:
* move check_dco_pull_options() to dco.c (renamed to
  dco_check_pull_options())
* make options argument const
* add msglevel as first argument
---
 src/openvpn/dco.c  | 12 ++++++++++++
 src/openvpn/dco.h  | 17 +++++++++++++++++
 src/openvpn/init.c |  9 +++++++++
 3 files changed, 38 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b92a0e9c..8c22b7ea 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -370,4 +370,16 @@ dco_check_option_conflict(int msglevel, const struct options *o)
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
index b926e236..fbb35906 100644
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
@@ -156,6 +167,12 @@ dco_check_option_conflict(int msglevel, const struct options *o)
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
index de8faeb4..4423e162 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2382,6 +2382,15 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
     }
 
+    /* Check if pushed options are compatible with DCO, if enabled */
+    if (dco_enabled(&c->options)
+        && !dco_check_pull_options(D_TLS_ERRORS, &c->options))
+    {
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
+            "data channel offload. Use --disable-dco to connect to this server");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.1


