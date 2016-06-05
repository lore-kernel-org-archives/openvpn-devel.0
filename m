From: Selva Nair <selva.nair@...277...>
Date: Sun,  5 Jun 2016 17:41:23 -0400
Message-Id: <1465162884-32520-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1464668569-6480-1-git-send-email-selva.nair@...277...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2 v2] Add an option to filter options
	received from server
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

v2 changes:
 - Add the flag "ignore" and have "reject" trigger a restart.
 - Unlimited number of filters: yes, going against the consensus,
   but the code looks simpler and cleaner this way.
 - New commit message to reflect the changes.

Usage: --pull-filter accept|ignore|reject "option"

Permit a client to selectively accept, ignore or reject options
pushed by the server. May be used multiple times. The filters
are applied in the order specified to each pushed option received.
The filtering stops as soon as a match is found. The action "ignore"
removes the option and continues processing the next option, while
"reject" flags an error and restarts the connection with SIGUSR1.

Prefix matching is used so that all options starting with the
specified "option" string are filtered.

Example:

  pull-filter accept "route 192.168."
  pull-filter ignore "route "
  pull-filter accept "ifconfig 10.9.0."
  pull-filter reject "ifconfig "

will ignore all pushed routes except those starting with "192.168."
and reject the assigned ip unless its in the "10.9.0.0/24"
range. A match of the reject filter will trigger a restart. SIGUSR1
restart is used instead of SIGHUP so as to try the next remote
for reconnection.

Note the space at the end of "route " to not reject "route-gateway",
for example. All options not matched by any filter are accepted.

Acknowledges shameless imitation of --push-remove.
Inspired by Trac #682.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 Changes.rst           |    4 ++
 doc/openvpn.8         |   51 +++++++++++++++++
 src/openvpn/options.c |  146 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/options.h |    2 +
 4 files changed, 203 insertions(+)

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
index e1dd7cd..03f31bb 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3830,6 +3830,57 @@ in situations where you don't trust the server to have control
 over the client's routing table.
 .\"*********************************************************
 .TP
+.B \-\-pull\-filter accept|ignore|reject \fItext\fR
+Filter options received from the server if the option starts with
+\fItext\fR.  Runs on client. The action flag
+.B accept
+allows the option,
+.B ignore
+removes it and
+.B reject
+flags an error and triggers a SIGUSR1 restart.
+The filters may be specified multiple times, and each filter is
+applied in the order it is specified. The filtering of each
+option stops as soon as a match is found. Unmatched options are accepted
+by default.
+
+Prefix comparison is used to match \fItext\fR against the
+received option so that
+
+.nf
+.ft 3
+.in +4
+\-\-pull\-filter ignore "route"
+.in -4
+.ft
+.fi
+
+would remove all pushed options starting with
+.B route
+which would include, for example,
+.B route\-gateway.
+Enclose \fItext\fR in quotes to embed spaces.
+
+.nf
+.ft 3
+.in +4
+\-\-pull\-filter accept "route 192.168.1."
+\-\-pull\-filter ignore "route "
+.in -4
+.ft
+.fi
+
+would remove all routes that do not start with 192.168.1.
+
+This option may be used only on clients.
+Note that
+.B reject
+may result in a repeated cycle of failure and reconnect,
+unless multiple remotes are specified and connection to the next remote
+succeeds. To silently ignore an option pushed by the server, use
+.B ignore.
+.\"*********************************************************
+.TP
 .B \-\-auth\-user\-pass [up]
 Authenticate with server using username/password.
 .B up
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 55630c7..23f407c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -489,6 +489,11 @@ static const char usage_message[] =
   "--pull           : Accept certain config file options from the peer as if they\n"
   "                  were part of the local config file.  Must be specified\n"
   "                  when connecting to a '--mode server' remote host.\n"
+  "--pull-filter accept|ignore|reject t : Filter each option received from the\n"
+  "                  server if it starts with the text t. The action flag accept,\n"
+  "                  ignore or reject causes the option to be allowed, removed or\n"
+  "                  rejected with error. May be specified multiple times, and\n"
+  "                  each filter is applied in the order of appearance.\n"
   "--auth-retry t  : How to handle auth failures.  Set t to\n"
   "                  none (default), interact, or nointeract.\n"
   "--static-challenge t e : Enable static challenge/response protocol using\n"
@@ -876,6 +881,37 @@ uninit_options (struct options *o)
     }
 }
 
+struct pull_filter
+{
+# define PUF_TYPE_UNDEF  0   /** undefined filter type */
+# define PUF_TYPE_ACCEPT 1   /** filter type to accept a matching option */
+# define PUF_TYPE_IGNORE 2   /** filter type to ignore a matching option */
+# define PUF_TYPE_REJECT 3   /** filter type to reject and trigger SIGUSR1 */
+  int type;
+  int size;
+  char *pattern;
+  struct pull_filter *next;
+};
+
+struct pull_filter_list
+{
+  struct pull_filter *head;
+  struct pull_filter *tail;
+};
+
+static const char *
+pull_filter_type_name (int type)
+{
+  if (type == PUF_TYPE_ACCEPT)
+    return "accept";
+  if (type == PUF_TYPE_IGNORE)
+    return "ignore";
+  if (type == PUF_TYPE_REJECT)
+    return "reject";
+  else
+    return "???";
+}
+
 #ifndef ENABLE_SMALL
 
 #define SHOW_PARM(name, value, format) msg(D_SHOW_PARMS, "  " #name " = " format, (value))
@@ -1407,6 +1443,20 @@ show_connection_entries (const struct options *o)
   msg (D_SHOW_PARMS, "Connection profiles END");
 }
 
+static void
+show_pull_filter_list (const struct pull_filter_list *l)
+{
+  struct pull_filter *f;
+  if (!l)
+    return;
+
+  msg (D_SHOW_PARMS, "  Pull filters:");
+  for (f = l->head; f; f = f->next)
+    {
+      msg (D_SHOW_PARMS, "    %s \"%s\"", pull_filter_type_name(f->type), f->pattern);
+    }
+}
+
 #endif
 
 void
@@ -1537,6 +1587,8 @@ show_settings (const struct options *o)
   SHOW_BOOL (route_nopull);
   SHOW_BOOL (route_gateway_via_dhcp);
   SHOW_BOOL (allow_pull_fqdn);
+  show_pull_filter_list (o->pull_filter_list);
+
   if (o->routes)
     print_route_options (o->routes, D_SHOW_PARMS);
 
@@ -1797,6 +1849,35 @@ alloc_remote_entry (struct options *options, const int msglevel)
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
+  ALLOC_OBJ_CLEAR_GC (f, struct pull_filter, &o->gc);
+  if (l->head)
+    {
+      ASSERT (l->tail);
+      l->tail->next = f;
+    }
+  else
+    {
+      ASSERT (!l->tail);
+      l->head = f;
+    }
+  l->tail = f;
+  return f;
+}
+
 void
 connection_entry_load_re (struct connection_entry *ce, const struct remote_entry *re)
 {
@@ -2000,6 +2081,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--mode server only works with --dev tun or --dev tap");
       if (options->pull)
 	msg (M_USAGE, "--pull cannot be used with --mode server");
+      if (options->pull_filter_list)
+	msg (M_USAGE, "--pull-filter cannot be used with --mode server");
       if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
 	msg (M_USAGE, "--mode server currently only supports "
 	     "--proto udp or --proto tcp-server or proto tcp6-server");
@@ -3964,6 +4047,45 @@ parse_argv (struct options *options,
     }
 }
 
+/**
+ * Filter an option line by all pull filters.
+ *
+ * If a match is found, the line is modified depending on
+ * the filter type, and returns true. If the filter type is
+ * reject, SIGUSR1 is triggered and the return value is false.
+ * In that case the caller must end the push processing.
+ */
+static bool
+apply_pull_filter (const struct options *o, char *line)
+{
+  struct pull_filter *f;
+
+  if (!o->pull_filter_list) return true;
+
+  for (f = o->pull_filter_list->head; f; f = f->next)
+    {
+      if (f->type == PUF_TYPE_ACCEPT && strncmp (line, f->pattern, f->size) == 0)
+        {
+          msg (D_LOW, "Pushed option accepted by filter: '%s'", line);
+          return true;
+        }
+      else if (f->type == PUF_TYPE_IGNORE && strncmp (line, f->pattern, f->size) == 0)
+        {
+          msg (D_PUSH, "Pushed option removed by filter: '%s'", line);
+          *line = '\0';
+          return true;
+        }
+      else if (f->type == PUF_TYPE_REJECT && strncmp (line, f->pattern, f->size) == 0)
+        {
+          msg (M_WARN, "Pushed option rejected by filter: '%s'. Restarting.", line);
+          *line = '\0';
+          throw_signal_soft (SIGUSR1, "Offending option received from server");
+          return false;
+        }
+    }
+  return true;
+}
+
 bool
 apply_push_options (struct options *options,
 		    struct buffer *buf,
@@ -3981,6 +4103,10 @@ apply_push_options (struct options *options,
       char *p[MAX_PARMS];
       CLEAR (p);
       ++line_num;
+      if (!apply_pull_filter(options, line))
+        {
+          return false; /* Cause push/pull error and stop push processing */
+        }
       if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &options->gc))
 	{
 	  add_option (options, p, file, line_num, 0, msglevel, permission_mask, option_types_found, es);
@@ -5373,6 +5499,26 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->route_nopull = true;
     }
+  else if (streq (p[0], "pull-filter") && p[1] && p[2] && !p[3])
+    {
+      struct pull_filter *f;
+      VERIFY_PERMISSION (OPT_P_GENERAL)
+      f = alloc_pull_filter (options, msglevel);
+
+      if (strcmp ("accept", p[1]) == 0)
+        f->type = PUF_TYPE_ACCEPT;
+      else if (strcmp ("ignore", p[1]) == 0)
+        f->type = PUF_TYPE_IGNORE;
+      else if (strcmp ("reject", p[1]) == 0)
+        f->type = PUF_TYPE_REJECT;
+      else
+        {
+          msg (msglevel, "Unknown --pull-filter type: %s", p[1]);
+          goto err;
+        }
+      f->pattern = p[2];
+      f->size = strlen(p[2]);
+    }
   else if (streq (p[0], "allow-pull-fqdn") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2fa375f..514511b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -597,6 +597,8 @@ struct options
   const char *keying_material_exporter_label;
   int keying_material_exporter_length;
 #endif
+
+  struct pull_filter_list *pull_filter_list;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
-- 
1.7.10.4


