From: Gert Doering <gert@...1296...>
Date: Sat, 26 Jul 2025 15:51:56 +0200
Message-ID: <20250726135203.3452-1-gert@...1296...>
In-Reply-To: <gerrit.1753487460000.Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547@...2715...>
References: <gerrit.1753487460000.Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] multi: make some multi_*() functions
 static
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

From: Antonio Quartulli <antonio@...2726...>

multi_process_float() and multi_print_status() are both invoked only
within multi.c, which is where they is defined.

For this reason we can make them static and drop their declaration
from multi.h.

Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1115
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c5691ff..c90ed5b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -849,7 +849,7 @@
  * If status file is defined, write to file.
  * If status file is NULL, write to syslog.
  */
-void
+static void
 multi_print_status(struct multi_context *m, struct status_output *so, const int version)
 {
     if (m->hash)
@@ -3210,7 +3210,15 @@
     return ret;
 }
 
-void
+/**
+ * Handles peer floating.
+ *
+ * If peer is floated to a taken address, either drops packet
+ * (if peer that owns address has different CN) or disconnects
+ * existing peer. Updates multi_instance with new address,
+ * updates hashtables in multi_context.
+ */
+static void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
                     struct link_socket *sock)
 {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 8b2704c..3c821d7 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -270,17 +270,6 @@
 
 bool multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags);
 
-/**
- * Handles peer floating.
- *
- * If peer is floated to a taken address, either drops packet
- * (if peer that owns address has different CN) or disconnects
- * existing peer. Updates multi_instance with new address,
- * updates hashtables in multi_context.
- */
-void multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                         struct link_socket *sock);
-
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
 #define MPP_CLOSE_ON_SIGNAL        (1<<2)
@@ -370,8 +359,6 @@
 
 void multi_process_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags);
 
-void multi_print_status(struct multi_context *m, struct status_output *so, const int version);
-
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);
 
 void multi_add_mbuf(struct multi_context *m,

