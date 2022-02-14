From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 03:10:53 +0100
Message-Id: <20220214021054.3750071-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Fix 'defined but not used' warnings
 with enable-small/disable-management
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

Some functions are only used when management is used or enable-small is
not used. Fix the ifdefs to correctly also include these helper
functions the ifdefs to avoid compile errors when using -Werror
---
 src/openvpn/multi.c   | 11 +++++------
 src/openvpn/options.c |  7 +++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6f7bb6f8..e7f2c697 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3653,6 +3653,11 @@ multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *m
     multi_close_instance(m, mi, false);
 }
 
+/*
+ * Management subsystem callbacks
+ */
+#ifdef ENABLE_MANAGEMENT
+
 static void
 multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
 {
@@ -3660,12 +3665,6 @@ multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const
     multi_close_instance_on_signal(m, mi);
 }
 
-/*
- * Management subsystem callbacks
- */
-
-#ifdef ENABLE_MANAGEMENT
-
 static void
 management_callback_status(void *arg, const int version, struct status_output *so)
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 813d34c9..2538421b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -910,6 +910,8 @@ struct pull_filter_list
     struct pull_filter *tail;
 };
 
+#ifndef ENABLE_SMALL
+
 static const char *
 pull_filter_type_name(int type)
 {
@@ -931,8 +933,6 @@ pull_filter_type_name(int type)
     }
 }
 
-#ifndef ENABLE_SMALL
-
 #define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " = " format, (value))
 #define SHOW_STR(var)       SHOW_PARM(var, (o->var ? o->var : "[UNDEF]"), "'%s'")
 #define SHOW_STR_INLINE(var)    SHOW_PARM(var, \
@@ -1268,6 +1268,7 @@ dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array,
 
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
+#ifndef ENABLE_SMALL
 static const char *
 print_vlan_accept(enum vlan_acceptable_frames mode)
 {
@@ -1285,8 +1286,6 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
     return NULL;
 }
 
-#ifndef ENABLE_SMALL
-
 static void
 show_p2mp_parms(const struct options *o)
 {
-- 
2.33.0


