From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 May 2016 00:22:49 -0400
Message-Id: <1464668569-6480-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Add an option to filter options received
	from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Usage: --pull-filter accept|reject "option string"

Permit a client to selectively accept or reject options pushed
by the server. May be used multiple times. The filters are
applied in the order specified to each pushed option received. The
filtering stops as soon as a match is found. Full regex support is
not available but partial matching is used to allow some flexibility.
Thus

  pull-filter accept "ifconfig 10.9.0."
  pull-filter reject "ifconfig "
  pull-filter accept "route 10."
  pull-filter reject "route "

will reject assigned ip unless its in the "10.9.0.0/24" range and
all pushed routes except those starting with "10.". Note the space
at the end of "route " to not reject "route-gateway", for example.

There is an implicit 'pull-filter accept ""' at the end so that all
options not rejected by any filter are accepted.

A maximum of 64 filters are supported.

Acknowledges shameless imitation of --push-remove.
Inspired by Trac #682.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 Changes.rst           |    4 ++
 doc/openvpn.8         |   34 +++++++++++++++++
 src/openvpn/options.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/options.h |   19 ++++++++++
 4 files changed, 155 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index a6bb2a5..1ac3c2b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -5,6 +5,10 @@ Version 2.4.0
 New features
 ------------
 
+pull-filter
+    New option to explicitly allow or reject options pushed by the server.
+    May be used multiple times and is applied in the order specified.
+
 push-remove
     new option to remove options on a per-client basis from the "push" list
     (more fine-grained than "push-reset")
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e1dd7cd..aec37da 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3830,6 +3830,40 @@ in situations where you don't trust the server to have control
 over the client's routing table.
 .\"*********************************************************
 .TP
+.B \-\-pull\-filter accept|reject opt
+Filter options matching
+.B opt
+pushed by the server:
+.B accept
+allows the option,
+.B reject
+removes it. May be specified multiple times, and each filter is
+applied in the order it is specified. The filtering of each pushed
+option stops as soon as a match (accept or reject) is found.
+
+Partial matching is used so that
+.B \-\-pull\-filter reject route
+would remove all pushed options starting with
+.B route
+which would include, for example,
+.B route\-gateway.
+Enclose the option string in quotes to embed spaces.
+
+.nf
+.ft 3
+.in +4
+\-\-pull\-filter accept "route 192.168.1."
+\-\-pull\-filter reject "route "
+.in -4
+.ft
+.fi
+
+would reject all pushed routes that do not start with
+.B 192.168.1.
+
+A maximum of 64 filters are supported. May be used only on clients.
+.\"*********************************************************
+.TP
 .B \-\-auth\-user\-pass [up]
 Authenticate with server using username/password.
 .B up
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 55630c7..ad472ee 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -489,6 +489,10 @@ static const char usage_message[] =
   "--pull           : Accept certain config file options from the peer as if they\n"
   "                  were part of the local config file.  Must be specified\n"
   "                  when connecting to a '--mode server' remote host.\n"
+  "--pull-filter accept|reject opt : Selectively accept or reject an option pushed\n"
+  "                  by the server if it matches opt. Uses strncmp for comparison,\n"
+  "                  so partial matching is possible. May be specified multiple\n"
+  "                  times, and each filter is applied in the order of appearance.\n"
   "--auth-retry t  : How to handle auth failures.  Set t to\n"
   "                  none (default), interact, or nointeract.\n"
   "--static-challenge t e : Enable static challenge/response protocol using\n"
@@ -1407,6 +1411,21 @@ show_connection_entries (const struct options *o)
   msg (D_SHOW_PARMS, "Connection profiles END");
 }
 
+static void
+show_pull_filter_list (const struct pull_filter_list *l)
+{
+  int i;
+  if (!l)
+    return;
+
+  msg (D_SHOW_PARMS, "  Pull filters:");
+  for (i = 0; i < l->len; i++)
+    {
+      msg (D_SHOW_PARMS, "    %s \"%s\"", l->array[i]->type == PUF_TYPE_REJECT ?
+                         "reject " : "accept ", l->array[i]->filter);
+    }
+}
+
 #endif
 
 void
@@ -1537,6 +1556,8 @@ show_settings (const struct options *o)
   SHOW_BOOL (route_nopull);
   SHOW_BOOL (route_gateway_via_dhcp);
   SHOW_BOOL (allow_pull_fqdn);
+  show_pull_filter_list (o->pull_filter_list);
+
   if (o->routes)
     print_route_options (o->routes, D_SHOW_PARMS);
 
@@ -1797,6 +1818,31 @@ alloc_remote_entry (struct options *options, const int msglevel)
   return e;
 }
 
+static struct pull_filter_list *
+alloc_pull_filter_list (struct options *o)
+{
+  if (!o->pull_filter_list)
+    ALLOC_OBJ_CLEAR_GC (o->pull_filter_list, struct pull_filter_list, &o->gc);
+  return o->pull_filter_list;
+}
+
+static struct pull_filter *
+alloc_pull_filter (struct options *o, const int msglevel)
+{
+  struct pull_filter_list *l = alloc_pull_filter_list (o);
+  struct pull_filter *f;
+
+  if (l->len >= PULL_FILTER_LIST_SIZE)
+    {
+      msg (msglevel, "Maximum number of 'pull-filter' options (%d) exceeded",
+                      PULL_FILTER_LIST_SIZE);
+      return NULL;
+    }
+  ALLOC_OBJ_GC (f, struct pull_filter, &o->gc);
+  l->array[l->len++] = f;
+  return f;
+}
+
 void
 connection_entry_load_re (struct connection_entry *ce, const struct remote_entry *re)
 {
@@ -2000,6 +2046,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--mode server only works with --dev tun or --dev tap");
       if (options->pull)
 	msg (M_USAGE, "--pull cannot be used with --mode server");
+      if (options->pull_filter_list)
+	msg (M_USAGE, "--pull-filter cannot be used with --mode server");
       if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
 	msg (M_USAGE, "--mode server currently only supports "
 	     "--proto udp or --proto tcp-server or proto tcp6-server");
@@ -3964,6 +4012,32 @@ parse_argv (struct options *options,
     }
 }
 
+static bool
+apply_pull_filter (const struct options *o, const char *line)
+{
+  int i;
+  struct pull_filter_list *l = o->pull_filter_list;
+
+  if (!l) return true;
+
+  for (i = 0; i < l->len; i++)
+    {
+      struct pull_filter *f = l->array[i];
+      if (f->type == PUF_TYPE_REJECT && strncmp (f->filter, line, f->size) == 0)
+        {
+          msg (D_PUSH, "Pushed option rejected by filter: '%s'", line);
+          return false;
+        }
+      else if (f->type == PUF_TYPE_ACCEPT && strncmp (f->filter, line, f->size) == 0)
+        {
+          msg (D_LOW, "Pushed option accepted by filter: '%s'", line);
+          return true;
+        }
+    }
+  /* accept by default */
+  return true;
+}
+
 bool
 apply_push_options (struct options *options,
 		    struct buffer *buf,
@@ -3981,6 +4055,10 @@ apply_push_options (struct options *options,
       char *p[MAX_PARMS];
       CLEAR (p);
       ++line_num;
+      if (!apply_pull_filter(options, line))
+        {
+          continue;
+        }
       if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &options->gc))
 	{
 	  add_option (options, p, file, line_num, 0, msglevel, permission_mask, option_types_found, es);
@@ -5373,6 +5451,26 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->route_nopull = true;
     }
+  else if (streq (p[0], "pull-filter") && p[1] && p[2] && !p[3])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL)
+      struct pull_filter *f = alloc_pull_filter (options, msglevel);
+
+      /* f could be NULL if number of filters exceeded the limit */
+      if (!f)
+        goto err;
+      if (strcmp ("accept", p[1]) == 0)
+        f->type = PUF_TYPE_ACCEPT;
+      else if (strcmp ("reject", p[1]) == 0)
+        f->type = PUF_TYPE_REJECT;
+      else
+        {
+          msg (msglevel, "Unknown --pull-filter type: %s", p[1]);
+          goto err;
+        }
+      f->filter = p[2];
+      f->size = strlen(p[2]);
+    }
   else if (streq (p[0], "allow-pull-fqdn") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2fa375f..b73bafc 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -163,6 +163,23 @@ struct remote_host_store
   char port[RH_PORT_LEN];
 };
 
+#define PULL_FILTER_LIST_SIZE 64
+struct pull_filter
+{
+# define PUF_TYPE_UNDEF 0
+# define PUF_TYPE_ACCEPT 1
+# define PUF_TYPE_REJECT 2
+  int type;
+  int size;
+  char *filter;
+};
+
+struct pull_filter_list
+{
+  int len;
+  struct pull_filter *array[PULL_FILTER_LIST_SIZE];
+};
+
 /* Command line options */
 struct options
 {
@@ -597,6 +614,8 @@ struct options
   const char *keying_material_exporter_label;
   int keying_material_exporter_length;
 #endif
+
+  struct pull_filter_list *pull_filter_list;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
-- 
1.7.10.4


