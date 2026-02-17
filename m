From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 17 Feb 2026 14:56:05 +0100
Message-ID: <20260217135605.154129-1-frank@...2641...>
In-Reply-To: <gerrit.1771283598000.I633d8cbf75ab4da85e16df44684aef60523811c5@...2715...>
References: <gerrit.1771283598000.I633d8cbf75ab4da85e16df44684aef60523811c5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] options: drop useless init_gc param for
 init_options()
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
Cc: Antonio Quartulli <antonio@...2726...>

From: Antonio Quartulli <antonio@...2726...>

The init_option() function is always invoked with the second
param "init_gc" set to "true".
This makes the parameter useless and it can therefore be removed
while always taking the "true" branch in the related logic.

This way we can also drop the options->gc_owned member as it
would also be always set to true.

Change-Id: I633d8cbf75ab4da85e16df44684aef60523811c5
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1536
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1536
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b7eca19..f38660f 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -202,7 +202,7 @@
 #endif
 
             /* initialize options to default state */
-            init_options(&c.options, true);
+            init_options(&c.options);
 
             /* parse command line options, and read configuration file */
             parse_argv(&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NULL, c.es);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cdb02e9..4e1e32a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -792,15 +792,12 @@
  * will be set to 0.
  */
 void
-init_options(struct options *o, const bool init_gc)
+init_options(struct options *o)
 {
     CLEAR(*o);
-    if (init_gc)
-    {
-        gc_init(&o->gc);
-        gc_init(&o->dns_options.gc);
-        o->gc_owned = true;
-    }
+    gc_init(&o->gc);
+    gc_init(&o->dns_options.gc);
+
     o->mode = MODE_POINT_TO_POINT;
     o->topology = TOP_UNDEF;
     o->ce.proto = PROTO_UDP;
@@ -925,11 +922,9 @@
     {
         CLEAR(*o->remote_list);
     }
-    if (o->gc_owned)
-    {
-        gc_free(&o->gc);
-        gc_free(&o->dns_options.gc);
-    }
+
+    gc_free(&o->gc);
+    gc_free(&o->dns_options.gc);
 }
 
 #ifndef ENABLE_SMALL
@@ -2256,7 +2251,7 @@
     int dev = DEV_TYPE_UNDEF;
     bool pull = false;
 
-    init_options(&defaults, true);
+    init_options(&defaults);
 
     if (!options->test_crypto)
     {
@@ -4824,7 +4819,7 @@
 #else
 
     struct options o;
-    init_options(&o, true);
+    init_options(&o);
 
     fprintf(fp, usage_message, title_string, o.ce.connect_retry_seconds,
             o.ce.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_port, TUN_MTU_DEFAULT,
@@ -5979,7 +5974,7 @@
             struct options sub;
             struct connection_entry *e;
 
-            init_options(&sub, true);
+            init_options(&sub);
             sub.ce = options->ce;
             read_config_string("[CONNECTION-OPTIONS]", &sub, p[1], msglevel, OPT_P_CONNECTION,
                                option_types_found, es);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cf9936b..3d8b505 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -254,7 +254,6 @@
 struct options
 {
     struct gc_arena gc;
-    bool gc_owned;
 
     /* first config file */
     const char *config;
@@ -890,7 +889,7 @@
 
 void show_dco_version(const unsigned int flags);
 
-void init_options(struct options *o, const bool init_gc);
+void init_options(struct options *o);
 
 void uninit_options(struct options *o);
 
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index bb34f01..0b3d7fe 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -248,7 +248,6 @@
     CLEAR(o); /* NB: avoiding init_options to limit dependencies */
     gc_init(&o.gc);
     gc_init(&o.dns_options.gc);
-    o.gc_owned = true;
 
     char *p_expect_someopt[MAX_PARMS];
     char *p_expect_otheropt[MAX_PARMS];

