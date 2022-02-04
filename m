From: Gert Doering <gert@...1296...>
Date: Fri,  4 Feb 2022 12:42:01 +0100
Message-Id: <20220204114201.5632-1-gert@...1296...>
In-Reply-To: <20220204102356.1271-1-gert@...1296...>
References: <20220204102356.1271-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Repair --inactive with 'bytes' argument
 larger 2Gbytes.
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

--inactive has an optional 2nd parameter specifiying the number of
bytes that need to be sent/received in the given time window.  This
was parsed with atoi(), stored in an 32bit int.  atoi() overflows at
2Gbyte (signed int), which makes gcc return "0" and MSVC "2^31-1"
for the value reported in the ticket (10G) - so on gcc, this was
behaving like "not set", while windows builds after 2.5.4 honoured
this setting, and aborted (unexpectedly) due to "not enough traffic".

Fix by increasing word length of all involved variables to int64_t.

While add it, add option printer SHOW_LONG(), and print variable.

This has the potential to break existing setups where this value is
set unreasonably high, thus "impossible to achieve in the interval",
but which was never noticed before due to "overflow, 0, ignored".
Thus, print WARNING if a value >INT_MAX (2Gbyte) is configured.

v2: use atoll(), as atol() is limited to INT_MAX on MSVC, and PRi64
for format string.  Rename SHOW_LONG() to SHOW_INT64().

Trac: #1448

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/openvpn.h |  2 +-
 src/openvpn/options.c | 13 ++++++++++++-
 src/openvpn/options.h |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a5c312c6..77263dfb 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -286,7 +286,7 @@ struct context_2
 
     /* --inactive */
     struct event_timeout inactivity_interval;
-    int inactivity_bytes;
+    int64_t inactivity_bytes;
 
     /* the option strings must match across peers */
     char *options_string_local;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2297a970..705f7e0c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -939,6 +939,7 @@ pull_filter_type_name(int type)
                                           "'%s'")
 #define SHOW_INT(var)       SHOW_PARM(var, o->var, "%d")
 #define SHOW_UINT(var)      SHOW_PARM(var, o->var, "%u")
+#define SHOW_INT64(var)     SHOW_PARM(var, o->var, "%" PRIi64)
 #define SHOW_UNSIGNED(var)  SHOW_PARM(var, o->var, "0x%08x")
 #define SHOW_BOOL(var)      SHOW_PARM(var, (o->var ? "ENABLED" : "DISABLED"), "%s");
 
@@ -1610,6 +1611,7 @@ show_settings(const struct options *o)
     SHOW_INT(keepalive_ping);
     SHOW_INT(keepalive_timeout);
     SHOW_INT(inactivity_timeout);
+    SHOW_INT64(inactivity_minimum_bytes);
     SHOW_INT(ping_send_timeout);
     SHOW_INT(ping_rec_timeout);
     SHOW_INT(ping_rec_timeout_action);
@@ -6268,7 +6270,16 @@ add_option(struct options *options,
         options->inactivity_timeout = positive_atoi(p[1]);
         if (p[2])
         {
-            options->inactivity_minimum_bytes = positive_atoi(p[2]);
+            int64_t val = atoll(p[2]);
+            options->inactivity_minimum_bytes = (val < 0) ? 0 : val;
+            if ( options->inactivity_minimum_bytes > INT_MAX )
+            {
+                msg(M_WARN, "WARNING: '--inactive' with a 'bytes' value"
+                    " >2 Gbyte was silently ignored in older versions.  If "
+                    " your VPN exits unexpectedly with 'Inactivity timeout'"
+                    " in %d seconds, revisit this value.",
+                    options->inactivity_timeout );
+            }
         }
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2523399..13d6b0da 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -304,7 +304,7 @@ struct options
     int keepalive_timeout;
 
     int inactivity_timeout;     /* --inactive */
-    int inactivity_minimum_bytes;
+    int64_t inactivity_minimum_bytes;
 
     int ping_send_timeout;      /* Send a TCP/UDP ping to remote every n seconds */
     int ping_rec_timeout;       /* Expect a TCP/UDP ping from remote at least once every n seconds */
-- 
2.26.3


