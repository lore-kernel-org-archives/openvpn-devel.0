From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 18:24:42 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <18343c107bc9d2012a06fde0dcbf95934390f55e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oLJduotlyEE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oLJduotlyEE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................

PUSH_UPDATE: Allow OpenVPN in client mode to receive and handle PUSH UPDATE=
 control messages to allow options updating at runtime.

* Added IV_PROTO_PUSH_UPDATE flag bit to support push-updates.
* Added process_incoming_push_update(), in a separate file to create tests =
more easily.
* Modified incoming_push_message(), process_incoming_push_msg(), apply_push=
_options(),
  apply_pull_filter() to process also push-update messages.
* Added the check_push_update_option_flags() function used in apply_pull_fi=
lter() to
  check options formatting inside push-update messages, if the options are =
updatables
  and to check for '?' and '-' flags that may be present in front of the op=
tions.
  The '-' flag is used to indicate that the option in question should be re=
moved,
  while the '?' indicates that the option is optional and to do not generate
  errors if the client cannot update that option.
  For more info you can read the RFC at https://github.com/OpenVPN/openvpn-=
rfc .
* Created some unit tests for the push-update message handling in test_push=
_update_msg.c.

Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Signed-off-by: Marco Baffo <marco@...2726...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/push.c
M src/openvpn/push.h
A src/openvpn/push_util.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/test_push_update_msg.c
15 files changed, 612 insertions(+), 112 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..9dd67bb 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -496,6 +496,7 @@
     src/openvpn/ps.c
     src/openvpn/ps.h
     src/openvpn/push.c
+    src/openvpn/push_util.c
     src/openvpn/push.h
     src/openvpn/pushlist.h
     src/openvpn/reflect_filter.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ecb2bcf..55ec565 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -114,7 +114,7 @@
 	proto.c proto.h \
 	proxy.c proxy.h \
 	ps.c ps.h \
-	push.c push.h \
+	push.c push_util.c push.h \
 	pushlist.h \
 	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..2c75953 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2031,7 +2031,7 @@
     }

     /* check for incoming control messages on the control channel like
-     * push request/reply, or authentication failure and 2FA messages */
+     * push request/reply/update, or authentication failure and 2FA messag=
es */
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel(c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9371024..f8d9d06 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2030,8 +2030,8 @@
         /* possibly add routes */
         if ((route_order(c->c1.tuntap) =3D=3D ROUTE_AFTER_TUN) && (!c->opt=
ions.route_delay_defined))
         {
-            int status =3D do_route(&c->options, c->c1.route_list, c->c1.r=
oute_ipv6_list,
-                                  c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx);
+            bool status =3D do_route(&c->options, c->c1.route_list, c->c1.=
route_ipv6_list,
+                                   c->c1.tuntap, c->plugins, c->c2.es, &c-=
>net_ctx);
             *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);
         }

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61f6285..8dea578 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -63,6 +63,7 @@
 #include <ctype.h>

 #include "memdbg.h"
+#include "options_util.h"

 const char title_string[] =3D
     PACKAGE_STRING
@@ -927,24 +928,6 @@
     }
 }

-struct pull_filter
-{
-#define PUF_TYPE_UNDEF  0    /** undefined filter type */
-#define PUF_TYPE_ACCEPT 1    /** filter type to accept a matching option */
-#define PUF_TYPE_IGNORE 2    /** filter type to ignore a matching option */
-#define PUF_TYPE_REJECT 3    /** filter type to reject and trigger SIGUSR1=
 */
-    int type;
-    int size;
-    char *pattern;
-    struct pull_filter *next;
-};
-
-struct pull_filter_list
-{
-    struct pull_filter *head;
-    struct pull_filter *tail;
-};
-
 #ifndef ENABLE_SMALL

 static const char *
@@ -5469,84 +5452,6 @@
     }
 }

-/**
- * Filter an option line by all pull filters.
- *
- * If a match is found, the line is modified depending on
- * the filter type, and returns true. If the filter type is
- * reject, SIGUSR1 is triggered and the return value is false.
- * In that case the caller must end the push processing.
- */
-static bool
-apply_pull_filter(const struct options *o, char *line)
-{
-    struct pull_filter *f;
-
-    if (!o->pull_filter_list)
-    {
-        return true;
-    }
-
-    /* skip leading spaces matching the behaviour of parse_line */
-    while (isspace(*line))
-    {
-        line++;
-    }
-
-    for (f =3D o->pull_filter_list->head; f; f =3D f->next)
-    {
-        if (f->type =3D=3D PUF_TYPE_ACCEPT && strncmp(line, f->pattern, f-=
>size) =3D=3D 0)
-        {
-            msg(D_LOW, "Pushed option accepted by filter: '%s'", line);
-            return true;
-        }
-        else if (f->type =3D=3D PUF_TYPE_IGNORE && strncmp(line, f->patter=
n, f->size) =3D=3D 0)
-        {
-            msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
-            *line =3D '\0';
-            return true;
-        }
-        else if (f->type =3D=3D PUF_TYPE_REJECT && strncmp(line, f->patter=
n, f->size) =3D=3D 0)
-        {
-            msg(M_WARN, "Pushed option rejected by filter: '%s'. Restartin=
g.", line);
-            *line =3D '\0';
-            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
-            return false;
-        }
-    }
-    return true;
-}
-
-bool
-apply_push_options(struct options *options,
-                   struct buffer *buf,
-                   unsigned int permission_mask,
-                   unsigned int *option_types_found,
-                   struct env_set *es)
-{
-    char line[OPTION_PARM_SIZE];
-    int line_num =3D 0;
-    const char *file =3D "[PUSH-OPTIONS]";
-    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
-
-    while (buf_parse(buf, ',', line, sizeof(line)))
-    {
-        char *p[MAX_PARMS+1];
-        CLEAR(p);
-        ++line_num;
-        if (!apply_pull_filter(options, line))
-        {
-            return false; /* Cause push/pull error and stop push processin=
g */
-        }
-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &opti=
ons->gc))
-        {
-            add_option(options, p, false, file, line_num, 0, msglevel,
-                       permission_mask, option_types_found, es);
-        }
-    }
-    return true;
-}
-
 void
 options_server_import(struct options *o,
                       const char *filename,
@@ -5680,6 +5585,44 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }

+bool
+apply_push_options(struct context *c,
+                   struct options *options,
+                   struct buffer *buf,
+                   unsigned int permission_mask,
+                   unsigned int *option_types_found,
+                   struct env_set *es,
+                   bool is_update)
+{
+    char line[OPTION_PARM_SIZE];
+    int line_num =3D 0;
+    const char *file =3D "[PUSH-OPTIONS]";
+    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
+
+    while (buf_parse(buf, ',', line, sizeof(line)))
+    {
+        char *p[MAX_PARMS+1];
+        CLEAR(p);
+        ++line_num;
+        unsigned int push_update_option_flags =3D 0;
+
+        if (!apply_pull_filter(options, line, is_update, &push_update_opti=
on_flags))
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
+            return false; /* Cause push/pull error and stop push processin=
g */
+        }
+        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &opti=
ons->gc))
+        {
+            if (!is_update)
+            {
+                add_option(options, p, false, file, line_num, 0, msglevel,
+                           permission_mask, option_types_found, es);
+            }
+        }
+    }
+    return true;
+}
+
 static void
 set_user_script(struct options *options,
                 const char **script,
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ee39dbb..5125f79 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -777,6 +777,33 @@
 #define MAN_CLIENT_AUTH_ENABLED(opt) (false)
 #endif

+/*
+ * some PUSH_UPDATE options
+ */
+#define OPT_P_U_ROUTE           (1<<0)
+#define OPT_P_U_ROUTE6          (1<<1)
+#define OPT_P_U_DNS             (1<<2)
+#define OPT_P_U_DHCP            (1<<3)
+#define OPT_P_U_REDIR_GATEWAY   (1<<4)
+
+struct pull_filter
+{
+#define PUF_TYPE_UNDEF  0    /** undefined filter type */
+#define PUF_TYPE_ACCEPT 1    /** filter type to accept a matching option */
+#define PUF_TYPE_IGNORE 2    /** filter type to ignore a matching option */
+#define PUF_TYPE_REJECT 3    /** filter type to reject and trigger SIGUSR1=
 */
+    int type;
+    int size;
+    char *pattern;
+    struct pull_filter *next;
+};
+
+struct pull_filter_list
+{
+    struct pull_filter *head;
+    struct pull_filter *tail;
+};
+
 void parse_argv(struct options *options,
                 const int argc,
                 char *argv[],
@@ -845,11 +872,13 @@

 void pre_connect_restore(struct options *o, struct gc_arena *gc);

-bool apply_push_options(struct options *options,
+bool apply_push_options(struct context *c,
+                        struct options *options,
                         struct buffer *buf,
                         unsigned int permission_mask,
                         unsigned int *option_types_found,
-                        struct env_set *es);
+                        struct env_set *es,
+                        bool is_update);

 void options_detach(struct options *o);

diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index a9e020a..87282c3 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -30,6 +30,8 @@

 #include "options_util.h"

+#include "push.h"
+
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {
@@ -98,3 +100,176 @@
     gc_free(&gc);
     return message;
 }
+
+static const char *updatable_options[] =3D {
+    "block-ipv6",
+    "block-outside-dns",
+    "dhcp-option",
+    "dns",
+    "ifconfig",
+    "ifconfig-ipv6",
+    "push-continuation",
+    "redirect-gateway",
+    "redirect-private",
+    "route",
+    "route-gateway",
+    "route-ipv6",
+    "route-metric",
+    "topology",
+    "tun-mtu",
+    "keepalive"
+};
+
+static bool
+check_push_update_option_flags(char **line, unsigned int *flags)
+{
+    if (!line || !*line || !**line)
+    {
+        return false;
+    }
+    *flags =3D 0;
+    bool opt_is_updatable =3D false;
+    char *str =3D *line;
+    char c =3D **line;
+
+    if (c =3D=3D '?')
+    {
+        *flags |=3D PUSH_OPT_OPTIONAL;
+        if (str[1])
+        {
+            c =3D *(++str);
+        }
+        else
+        {
+            return false;
+        }
+    }
+    else if (c =3D=3D '-')
+    {
+        *flags |=3D PUSH_OPT_TO_REMOVE;
+        if (str[1])
+        {
+            c =3D *(++str);
+        }
+        else
+        {
+            return false;
+        }
+    }
+
+    if (c =3D=3D '-' && !(*flags & PUSH_OPT_TO_REMOVE))
+    {
+        *flags |=3D PUSH_OPT_TO_REMOVE;
+        if (str[1])
+        {
+            c =3D *(++str);
+        }
+        else
+        {
+            return false;
+        }
+    }
+
+    /* Skip '?' and '-' if they are present */
+    size_t len =3D strlen(str);
+    memmove(*line, str, len);
+    (*line)[len] =3D '\0';
+    str =3D *line;
+
+    int count =3D sizeof(updatable_options)/sizeof(char *);
+    for (int i =3D 0; i < count; ++i)
+    {
+        size_t opt_len =3D strlen(updatable_options[i]);
+        if (len < opt_len)
+        {
+            continue;
+        }
+        if (!strncmp(str, updatable_options[i], opt_len)
+            && (!str[opt_len] || str[opt_len] =3D=3D ' '))
+        {
+            opt_is_updatable =3D true;
+            break;
+        }
+    }
+
+    if (!opt_is_updatable)
+    {
+        if (*flags & PUSH_OPT_OPTIONAL)
+        {
+            msg(D_PUSH, "Pushed option is not updatable: '%s'", *line);
+            return true;
+        }
+        else
+        {
+            msg(M_WARN, "Pushed option is not updatable: '%s'. Restarting.=
", *line);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Filter an option line by all pull filters.
+ *
+ * If a match is found, the line is modified depending on
+ * the filter type, and returns true. If the filter type is
+ * reject, SIGUSR1 is triggered and the return value is false.
+ * In that case the caller must end the push processing.
+ */
+bool
+apply_pull_filter(const struct options *o, char *line, bool is_update, uns=
igned int *push_update_option_flags)
+{
+    struct pull_filter *f;
+
+    if (!o->pull_filter_list && !(is_update))
+    {
+        return true;
+    }
+
+    /* skip leading spaces matching the behaviour of parse_line */
+    while (isspace(*line))
+    {
+        line++;
+    }
+
+    if (is_update)
+    {
+        if (!check_push_update_option_flags(&line, push_update_option_flag=
s))
+        {
+            return false;
+        }
+        if (!o->pull_filter_list)
+        {
+            return true;
+        }
+    }
+
+    for (f =3D o->pull_filter_list->head; f; f =3D f->next)
+    {
+        if (f->type =3D=3D PUF_TYPE_ACCEPT && strncmp(line, f->pattern, f-=
>size) =3D=3D 0)
+        {
+            msg(D_LOW, "Pushed option accepted by filter: '%s'", line);
+            return true;
+        }
+        else if (f->type =3D=3D PUF_TYPE_IGNORE && strncmp(line, f->patter=
n, f->size) =3D=3D 0)
+        {
+            msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
+            return true;
+        }
+        else if (f->type =3D=3D PUF_TYPE_REJECT && strncmp(line, f->patter=
n, f->size) =3D=3D 0)
+        {
+            if (is_update && (*push_update_option_flags & PUSH_OPT_OPTIONA=
L))
+            {
+                msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
+                return true;
+            }
+            else
+            {
+                msg(M_WARN, "Pushed option rejected by filter: '%s'. Resta=
rting.", line);
+                return false;
+            }
+        }
+    }
+    return true;
+}
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 29bc9dc..64ee0d6 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -30,4 +30,10 @@
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason);

+bool
+apply_pull_filter(const struct options *o,
+                  char *line,
+                  bool is_update,
+                  unsigned int *push_update_option_flags);
+
 #endif
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6c06374..71a0372 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -39,8 +39,6 @@
 #include "ssl_util.h"
 #include "options_util.h"

-static char push_reply_cmd[] =3D "PUSH_REPLY";
-
 /*
  * Auth username/password
  *
@@ -519,21 +517,31 @@
     {
         msg(D_PUSH_ERRORS, "WARNING: Received bad push/pull message: %s", =
sanitize_control_message(BSTR(buffer), &gc));
     }
-    else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_CONTIN=
UATION)
+    else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE=
 || status =3D=3D PUSH_MSG_CONTINUATION)
     {
         c->options.push_option_types_found |=3D option_types_found;

         /* delay bringing tun/tap up until --push parms received from remo=
te */
-        if (status =3D=3D PUSH_MSG_REPLY)
+        if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE)
         {
             if (!options_postprocess_pull(&c->options, c->c2.es))
             {
                 goto error;
             }
-            if (!do_up(c, true, c->options.push_option_types_found))
+            if (status =3D=3D PUSH_MSG_REPLY)
             {
-                msg(D_PUSH_ERRORS, "Failed to open tun/tap interface");
-                goto error;
+                if (!do_up(c, true, c->options.push_option_types_found))
+                {
+                    msg(D_PUSH_ERRORS, "Failed to open tun/tap interface");
+                    goto error;
+                }
+            }
+            else
+            {
+                if (!option_types_found)
+                {
+                    msg(M_WARN, "No option found");
+                }
             }
         }
         event_timeout_clear(&c->c2.push_request_interval);
@@ -1048,11 +1056,13 @@
             md_ctx_init(c->c2.pulled_options_state, "SHA256");
             c->c2.pulled_options_digest_init_done =3D true;
         }
-        if (apply_push_options(&c->options,
+        if (apply_push_options(c,
+                               &c->options,
                                buf,
                                permission_mask,
                                option_types_found,
-                               c->c2.es))
+                               c->c2.es,
+                               false))
         {
             push_update_digest(c->c2.pulled_options_state, &buf_orig,
                                &c->options);
@@ -1103,6 +1113,12 @@
         return process_incoming_push_reply(c, permission_mask,
                                            option_types_found, &buf);
     }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_update_cmd))
+    {
+        return process_incoming_push_update(c, permission_mask,
+                                            option_types_found, &buf);
+    }
     else
     {
         return PUSH_MSG_ERROR;
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 4a13327..52ca715 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -33,9 +33,22 @@
 #define PUSH_MSG_AUTH_FAILURE     4
 #define PUSH_MSG_CONTINUATION     5
 #define PUSH_MSG_ALREADY_REPLIED  6
+#define PUSH_MSG_UPDATE           7
+
+#define push_reply_cmd "PUSH_REPLY"
+#define push_update_cmd "PUSH_UPDATE"
+
+/* Push-update options flags */
+#define PUSH_OPT_TO_REMOVE (1<<0)
+#define PUSH_OPT_OPTIONAL (1<<1)
=20
 int process_incoming_push_request(struct context *c);

+int process_incoming_push_update(struct context *c,
+                                 unsigned int permission_mask,
+                                 unsigned int *option_types_found,
+                                 struct buffer *buf);
+
 int process_incoming_push_msg(struct context *c,
                               const struct buffer *buffer,
                               bool honor_received_options,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
new file mode 100644
index 0000000..b4d1e8b
--- /dev/null
+++ b/src/openvpn/push_util.c
@@ -0,0 +1,44 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "push.h"
+
+int
+process_incoming_push_update(struct context *c,
+                             unsigned int permission_mask,
+                             unsigned int *option_types_found,
+                             struct buffer *buf)
+{
+    int ret =3D PUSH_MSG_ERROR;
+    const uint8_t ch =3D buf_read_u8(buf);
+    if (ch =3D=3D ',')
+    {
+        if (apply_push_options(c,
+                               &c->options,
+                               buf,
+                               permission_mask,
+                               option_types_found,
+                               c->c2.es,
+                               true))
+        {
+            switch (c->options.push_continuation)
+            {
+                case 0:
+                case 1:
+                    ret =3D PUSH_MSG_UPDATE;
+                    break;
+
+                case 2:
+                    ret =3D PUSH_MSG_CONTINUATION;
+                    break;
+            }
+        }
+    }
+    else if (ch =3D=3D '\0')
+    {
+        ret =3D PUSH_MSG_UPDATE;
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8040e7b..b006917 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1947,6 +1947,9 @@
         /* support for exit notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;

+        /* support push-updates */
+        iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+
         if (session->opt->pull)
         {
             /* support for receiving push_reply before sending
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index eea1323..53b7f2c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -110,6 +110,9 @@
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)

+/** Supports push-update */
+#define IV_PROTO_PUSH_UPDATE     (1<<12)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index a4e6235..1b2414c 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -11,7 +11,7 @@
 endif

 test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver
+	pkt_testdriver ssl_testdriver user_pass_testdriver push_update_msg_testdr=
iver

 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -307,3 +307,25 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/list.c
+
+push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
+	-I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/tests/unit_tests/openvpn \
+	-ffunction-sections \
+	@TEST_CFLAGS@ \
+	@CMOCKA_CFLAGS@
+
+push_update_msg_testdriver_LDFLAGS =3D \
+	@TEST_LDFLAGS@ \
+	@CMOCKA_LIBS@ \
+	-L$(top_srcdir)/src/openvpn \
+	$(OPTIONAL_CRYPTO_LIBS)
+
+push_update_msg_testdriver_SOURCES =3D test_push_update_msg.c \
+	mock_msg.c \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/push_util.c \
+	$(top_srcdir)/src/openvpn/options_util.c \
+	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
new file mode 100644
index 0000000..8574855
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -0,0 +1,245 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <setjmp.h>
+#include <cmocka.h>
+#include "push.h"
+#include "options_util.h"
+
+/* mocks */
+
+unsigned int
+pull_permission_mask(const struct context *c)
+{
+    unsigned int flags =3D
+        OPT_P_UP
+        | OPT_P_ROUTE_EXTRAS
+        | OPT_P_SOCKBUF
+        | OPT_P_SOCKFLAGS
+        | OPT_P_SETENV
+        | OPT_P_SHAPER
+        | OPT_P_TIMER
+        | OPT_P_COMP
+        | OPT_P_PERSIST
+        | OPT_P_MESSAGES
+        | OPT_P_EXPLICIT_NOTIFY
+        | OPT_P_ECHO
+        | OPT_P_PULL_MODE
+        | OPT_P_PEER_ID
+        | OPT_P_NCP
+        | OPT_P_PUSH_MTU
+        | OPT_P_ROUTE
+        | OPT_P_DHCPDNS;
+    return flags;
+}
+
+bool
+apply_push_options(struct context *c,
+                   struct options *options,
+                   struct buffer *buf,
+                   unsigned int permission_mask,
+                   unsigned int *option_types_found,
+                   struct env_set *es,
+                   bool is_update)
+{
+    char line[OPTION_PARM_SIZE];
+
+    while (buf_parse(buf, ',', line, sizeof(line)))
+    {
+        unsigned int push_update_option_flags =3D 0;
+
+        if (!apply_pull_filter(options, line, is_update, &push_update_opti=
on_flags))
+        {
+            msg(M_WARN, "Offending option received from server");
+            return false;
+        }
+        /*
+         * No need to test also the application part here
+         * (add_option/remove_option/update_option)
+         */
+    }
+    return true;
+}
+
+int
+process_incoming_push_msg(struct context *c,
+                          const struct buffer *buffer,
+                          bool honor_received_options,
+                          unsigned int permission_mask,
+                          unsigned int *option_types_found)
+{
+    struct buffer buf =3D *buffer;
+
+    if (buf_string_compare_advance(&buf, "PUSH_REQUEST"))
+    {
+        return PUSH_MSG_REQUEST;
+    }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_reply_cmd))
+    {
+        return PUSH_MSG_REPLY;
+    }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_update_cmd))
+    {
+        return process_incoming_push_update(c, permission_mask,
+                                            option_types_found, &buf);
+    }
+    else
+    {
+        return PUSH_MSG_ERROR;
+    }
+}
+
+/* tests */
+
+static void
+test_incoming_push_message_basic(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route=
 0.0.0.0 0.0.0.0 10.10.10.1";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_error1(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+
+static void
+test_incoming_push_message_error2(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE ,dhcp-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_1(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE, ?-dns, route something, ?dhcp=
-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_bad_format(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE, -dhcp-option, -?dns";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_not_updatable_option(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE, dev tun";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_mix(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE,-dhcp-option, route 10.10.10.0=
, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.local,=
 keepalive 10 60";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_mix2(void **state)
+{
+    struct context *c =3D *state;
+    struct buffer buf =3D alloc_buf(256);
+    const char *update_msg =3D "PUSH_UPDATE,-dhcp-option,dhcp-option DNS 8=
.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found =3D 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static int
+setup(void **state)
+{
+    struct context *c =3D calloc(1, sizeof(struct context));
+    c->options.pull =3D true;
+    c->options.route_nopull =3D false;
+    *state =3D c;
+    return 0;
+}
+
+static int
+teardown(void **state)
+{
+    struct context *c =3D *state;
+    free(c);
+    return 0;
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_basic, =
setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_error1,=
 setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_error2,=
 setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_not_upd=
atable_option, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_1, setu=
p, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_for=
mat, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, se=
tup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, s=
etup, teardown)
+    };
+
+    return cmocka_run_group_tests(tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--oLJduotlyEE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">PUSH_UPDATE: Allow OpenVPN in client mode to =
receive and handle PUSH UPDATE control messages to allow options updating a=
t runtime.<br><br>* Added IV_PROTO_PUSH_UPDATE flag bit to support push-upd=
ates.<br>* Added process_incoming_push_update(), in a separate file to crea=
te tests more easily.<br>* Modified incoming_push_message(), process_incomi=
ng_push_msg(), apply_push_options(),<br>  apply_pull_filter() to process al=
so push-update messages.<br>* Added the check_push_update_option_flags() fu=
nction used in apply_pull_filter() to<br>  check options formatting inside =
push-update messages, if the options are updatables<br>  and to check for &=
#39;?&#39; and &#39;-&#39; flags that may be present in front of the option=
s.<br>  The &#39;-&#39; flag is used to indicate that the option in questio=
n should be removed,<br>  while the &#39;?&#39; indicates that the option i=
s optional and to do not generate<br>  errors if the client cannot update t=
hat option.<br>  For more info you can read the RFC at https://github.com/O=
penVPN/openvpn-rfc .<br>* Created some unit tests for the push-update messa=
ge handling in test_push_update_msg.c.<br><br>Change-Id: I6ecd4cb47571cc8c2=
0e46de8595c742aeec6064a<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&=
gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvp=
n/forward.c<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/ope=
nvpn/options.h<br>M src/openvpn/options_util.c<br>M src/openvpn/options_uti=
l.h<br>M src/openvpn/push.c<br>M src/openvpn/push.h<br>A src/openvpn/push_u=
til.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>M tests/unit_tests/o=
penvpn/Makefile.am<br>A tests/unit_tests/openvpn/test_push_update_msg.c<br>=
15 files changed, 612 insertions(+), 112 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 5db207d..9dd67b=
b 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLi=
sts.txt</span><br><span>@@ -496,6 +496,7 @@</span><br><span>     src/openvp=
n/ps.c</span><br><span>     src/openvpn/ps.h</span><br><span>     src/openv=
pn/push.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/op=
envpn/push_util.c</span><br><span>     src/openvpn/push.h</span><br><span> =
    src/openvpn/pushlist.h</span><br><span>     src/openvpn/reflect_filter.=
c</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefi=
le.am</span><br><span>index ecb2bcf..55ec565 100644</span><br><span>--- a/s=
rc/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span>=
<br><span>@@ -114,7 +114,7 @@</span><br><span> 	proto.c proto.h \</span><br=
><span> 	proxy.c proxy.h \</span><br><span> 	ps.c ps.h \</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	push.c push.h \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	push.c push_util.c push.h \</span><br><s=
pan> 	pushlist.h \</span><br><span> 	reflect_filter.c reflect_filter.h \</s=
pan><br><span> 	reliable.c reliable.h \</span><br><span>diff --git a/src/op=
envpn/forward.c b/src/openvpn/forward.c</span><br><span>index d50b24c..2c75=
953 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ =
b/src/openvpn/forward.c</span><br><span>@@ -2031,7 +2031,7 @@</span><br><sp=
an>     }</span><br><span> </span><br><span>     /* check for incoming cont=
rol messages on the control channel like</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * push request/reply, or authentication failure and=
 2FA messages */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * push request/reply/update, or authentication failure and 2FA messages *=
/</span><br><span>     if (tls_test_payload_len(c-&gt;c2.tls_multi) &gt; 0)=
</span><br><span>     {</span><br><span>         check_incoming_control_cha=
nnel(c);</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index 9371024..f8d9d06 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-2030,8 +2030,8 @@</span><br><span>         /* possibly add routes */</span=
><br><span>         if ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TU=
N) &amp;&amp; (!c-&gt;options.route_delay_defined))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int st=
atus =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_i=
pv6_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                      c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&=
gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     bool status =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&g=
t;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                   c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;=
c2.es, &amp;c-&gt;net_ctx);</span><br><span>             *error_flags |=3D =
(status ? 0 : ISC_ROUTE_ERRORS);</span><br><span>         }</span><br><span=
> </span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options=
.c</span><br><span>index 61f6285..8dea578 100644</span><br><span>--- a/src/=
openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><sp=
an>@@ -63,6 +63,7 @@</span><br><span> #include &lt;ctype.h&gt;</span><br><s=
pan> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util.h&quot;</span=
><br><span> </span><br><span> const char title_string[] =3D</span><br><span=
>     PACKAGE_STRING</span><br><span>@@ -927,24 +928,6 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-struct pull_filter</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine PUF_TYPE_UNDEF  0    /** undefined filter type */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_ACCEPT 1    /** filter t=
ype to accept a matching option */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define PUF_TYPE_IGNORE 2    /** filter type to ignore a match=
ing option */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
PUF_TYPE_REJECT 3    /** filter type to reject and trigger SIGUSR1 */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int type;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *pattern;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct pull_filter *next;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
uct pull_filter_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filte=
r *head;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pu=
ll_filter *tail;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifnde=
f ENABLE_SMALL</span><br><span> </span><br><span> static const char *</span=
><br><span>@@ -5469,84 +5452,6 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Filter an option l=
ine by all pull filters.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If a match is=
 found, the line is modified depending on</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * the filter type, and returns true. If the filter typ=
e is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * reject, SIGUSR=
1 is triggered and the return value is false.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * In that case the caller must end the push proces=
sing.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-apply_pull_filter(const struct options *o, =
char *line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *f;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!o-&gt;pull_filter_list)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* skip le=
ading spaces matching the behaviour of parse_line */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while (isspace(*line))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        line++;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (f =3D o-&gt;p=
ull_filter_list-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (f-&gt;type =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strncmp(l=
ine, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(D_LOW, &quot;Pushed option accepted by filter: &#39=
;%s&#39;&quot;, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
else if (f-&gt;type =3D=3D PUF_TYPE_IGNORE &amp;&amp; strncmp(line, f-&gt;p=
attern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(D_PUSH, &quot;Pushed option removed by filter: &#39;%s&#39;&quo=
t;, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 *line =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            return true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else if (f-&gt;type =3D=3D PUF_TYPE_REJECT &amp;&amp; strncmp(line, f-&gt=
;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_WARN, &quot;Pushed option rejected by filter: &#39;%s&#39;.=
 Restarting.&quot;, line);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            *line =3D &#39;\0&#39;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            throw_signal_soft(SIGUSR1, &quot;Offending o=
ption received from server&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            return false;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-apply_push_options(struct options *options,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   struct buffer *buf,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                   unsigned int per=
mission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
           unsigned int *option_types_found,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   struct env_set *es)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    char line[OPTION_PARM_SIZE];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int line_num =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const char *file =3D &quot;[PUSH-OPTI=
ONS]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        char *p[MAX_PARMS+1];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        CLEAR(p);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ++line_num;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!apply_pull_filter(options, line))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return false; /* Cause push/=
pull error and stop push processing */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &=
amp;options-&gt;gc))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a=
dd_option(options, p, false, file, line_num, 0, msglevel,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                       permission_mask,=
 option_types_found, es);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> options_s=
erver_import(struct options *o,</span><br><span>                       cons=
t char *filename,</span><br><span>@@ -5680,6 +5585,44 @@</span><br><span>  =
   return options-&gt;forward_compatible ? M_WARN : msglevel;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_=
options(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   struct options *options,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   struct buffer *buf,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   unsign=
ed int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   unsigned int *option_types_found,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                   struct env_set *es,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
bool is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_P=
ARM_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int l=
ine_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const int msglevel =3D D_PUSH_ERRORS|M_OPTE=
RR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse(buf, &#39;,&#3=
9;, line, sizeof(line)))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
har *p[MAX_PARMS+1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ++line_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       unsigned int push_update_option_flags =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!apply_pull_filter(options, line, is_update, &am=
p;push_update_option_flags))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           throw_signal_soft(SIGUSR1, &quot;Offending option received from =
server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return false; /* Cause push/pull error and stop push processing */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (parse_line(line, p,=
 SIZE(p)-1, file, line_num, msglevel, &amp;options-&gt;gc))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (!is_update)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                add_option(options, p, fa=
lse, file, line_num, 0, msglevel,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                           permission_mask, option_types_foun=
d, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> static void</span><br><span> set_user_script=
(struct options *options,</span><br><span>                 const char **scr=
ipt,</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/optio=
ns.h</span><br><span>index ee39dbb..5125f79 100644</span><br><span>--- a/sr=
c/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><=
span>@@ -777,6 +777,33 @@</span><br><span> #define MAN_CLIENT_AUTH_ENABLED(=
opt) (false)</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * some PUSH_UPDATE options</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OPT_P_U_ROUTE           (1&lt;&lt;0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_ROUTE6          (1&lt;&l=
t;1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U=
_DNS             (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OPT_P_U_DHCP            (1&lt;&lt;3)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_REDIR_GATEWAY   (1&lt;&l=
t;4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct pull_filter</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define PUF_TYPE_UNDEF  0    /** undefined filter typ=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYP=
E_ACCEPT 1    /** filter type to accept a matching option */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_IGNORE 2    /** f=
ilter type to ignore a matching option */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define PUF_TYPE_REJECT 3    /** filter type to rejec=
t and trigger SIGUSR1 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *pattern;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct pull_filter *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct pull_filter_list</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct pull_filter *head;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct pull_filter *tail;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> void parse_argv(struct opti=
ons *options,</span><br><span>                 const int argc,</span><br><s=
pan>                 char *argv[],</span><br><span>@@ -845,11 +872,13 @@</s=
pan><br><span> </span><br><span> void pre_connect_restore(struct options *o=
, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool apply_push_options(struct options *options,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool apply_push_options(st=
ruct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     struct options *options,</span><br><span>             =
            struct buffer *buf,</span><br><span>                         un=
signed int permission_mask,</span><br><span>                         unsign=
ed int *option_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        struct env_set *es);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        struct env_set *es,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    bool is_update);</span><br><span> </span><br><span> void options_detach=
(struct options *o);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/options_util.c b/src/openvpn/options_util.c</span><br><span>index a9e0=
20a..87282c3 100644</span><br><span>--- a/src/openvpn/options_util.c</span>=
<br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -30,6 +30,8 @=
@</span><br><span> </span><br><span> #include &quot;options_util.h&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;push.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> const char *</span><br><span> parse_auth_failed_temp(=
struct options *o, const char *reason)</span><br><span> {</span><br><span>@=
@ -98,3 +100,176 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
     return message;</span><br><span> }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static const char *updatable_options[] =3D {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;block-ipv6&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;block-outside-dns&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dhcp-option&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dns&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ifconf=
ig&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
ifconfig-ipv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;push-continuation&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;redirect-gateway&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;redirect-private&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;route&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;route-gateway&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;route-i=
pv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;route-metric&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;topology&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;tun-mtu&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;keepalive&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+check_push_update_option_f=
lags(char **line, unsigned int *flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!line || !*line || !**line)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *flag=
s =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool op=
t_is_updatable =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *str =3D *line;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    char c =3D **line;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c =3D=3D &#39;?&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
flags |=3D PUSH_OPT_OPTIONAL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (str[1])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            c =3D *(++str);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (c =3D=3D &#39;-&#39;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        *flags |=3D PUSH_OPT_TO_REMO=
VE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str[=
1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            c =3D *(++str)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(c =3D=3D &#39;-&#39; &amp;&amp; !(*flags &amp; PUSH_OPT_TO_REMOVE))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *flags |=3D PUSH_OPT_TO_REMOVE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str[1])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            c =3D *(++str);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Sk=
ip &#39;?&#39; and &#39;-&#39; if they are present */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(str);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    memmove(*line, str, len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (*line)[len] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  str =3D *line;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int count =3D size=
of(updatable_options)/sizeof(char *);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; count; ++i)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        size_t opt_len =3D strlen(updatable_option=
s[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (l=
en &lt; opt_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
ontinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(=
str, updatable_options[i], opt_len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &amp;&amp; (!str[opt_len] || str[opt_len] =3D=
=3D &#39; &#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
opt_is_updatable =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!opt_is_updatable)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (*flags &amp; PUSH_OPT_OPTIONAL)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH, &quot;=
Pushed option is not updatable: &#39;%s&#39;&quot;, *line);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_WARN, &quot;Pushed option is not updata=
ble: &#39;%s&#39;. Restarting.&quot;, *line);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Filter an option line by all pull filters.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * If a match is found, the line is modified depending o=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the filter type=
, and returns true. If the filter type is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * reject, SIGUSR1 is triggered and the return value =
is false.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In that=
 case the caller must end the push processing.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+appl=
y_pull_filter(const struct options *o, char *line, bool is_update, unsigned=
 int *push_update_option_flags)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct pull_filter *f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;pul=
l_filter_list &amp;&amp; !(is_update))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* skip leading spaces =
matching the behaviour of parse_line */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while (isspace(*line))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        line++;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_update)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!check_push_update_option_f=
lags(&amp;line, push_update_option_flags))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!o-&gt;pull_filter_list)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (f =3D o-&gt;p=
ull_filter_list-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (f-&gt;type =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strnc=
mp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_LOW, &quot;Pushed option accepted by filt=
er: &#39;%s&#39;&quot;, line);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else if (f-&gt;type =3D=3D PUF_TYPE_IGNORE &amp;&amp; strncmp=
(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_PUSH, &quot;Pushed option removed by filter=
: &#39;%s&#39;&quot;, line);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else if (f-&gt;type =3D=3D PUF_TYPE_REJECT &amp;&amp; strncmp(l=
ine, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (is_update &amp;&amp; (*push_update_option_flags=
 &amp; PUSH_OPT_OPTIONAL))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(D_PUSH, &quot;Pushed option removed by filter: &#39;%s=
&#39;&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(M_WARN, &quot;Pushed option rejected by filter: &#39;%s&#39;.=
 Restarting.&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h</spa=
n><br><span>index 29bc9dc..64ee0d6 100644</span><br><span>--- a/src/openvpn=
/options_util.h</span><br><span>+++ b/src/openvpn/options_util.h</span><br>=
<span>@@ -30,4 +30,10 @@</span><br><span> const char *</span><br><span> par=
se_auth_failed_temp(struct options *o, const char *reason);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+apply_pull_filter(const struct o=
ptions *o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
         char *line,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  bool is_update,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  unsigned int *push_update_option_flags);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #en=
dif</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</s=
pan><br><span>index 6c06374..71a0372 100644</span><br><span>--- a/src/openv=
pn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -39,8=
 +39,6 @@</span><br><span> #include &quot;ssl_util.h&quot;</span><br><span>=
 #include &quot;options_util.h&quot;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static char push_reply_cmd[] =3D &quot;PUS=
H_REPLY&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> /*</span><br><span>  * Auth username/password</span><br><span>  =
*</span><br><span>@@ -519,21 +517,31 @@</span><br><span>     {</span><br><s=
pan>         msg(D_PUSH_ERRORS, &quot;WARNING: Received bad push/pull messa=
ge: %s&quot;, sanitize_control_message(BSTR(buffer), &amp;gc));</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_CONTINUATION)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (status =3D=
=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE || status =3D=3D PUSH_M=
SG_CONTINUATION)</span><br><span>     {</span><br><span>         c-&gt;opti=
ons.push_option_types_found |=3D option_types_found;</span><br><span> </spa=
n><br><span>         /* delay bringing tun/tap up until --push parms receiv=
ed from remote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (status =3D=3D PUSH_MSG_REPLY)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D=
 PUSH_MSG_UPDATE)</span><br><span>         {</span><br><span>             i=
f (!options_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es))</span><br><s=
pan>             {</span><br><span>                 goto error;</span><br><=
span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (!do_up(c, true, c-&gt;options.push_option_types_found))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (status =
=3D=3D PUSH_MSG_REPLY)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(D_PUSH_ERRORS, &quot;Fa=
iled to open tun/tap interface&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                goto error;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (!do_up(c, true, c-&gt;options.=
push_option_types_found))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    msg(D_PUSH_ERRORS, &quot;Failed to open tun/tap int=
erface&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               goto error;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      if (!option_types_found)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    msg(M_WARN, &quot;No option found&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span>=
<br><span>             }</span><br><span>         }</span><br><span>       =
  event_timeout_clear(&amp;c-&gt;c2.push_request_interval);</span><br><span=
>@@ -1048,11 +1056,13 @@</span><br><span>             md_ctx_init(c-&gt;c2.=
pulled_options_state, &quot;SHA256&quot;);</span><br><span>             c-&=
gt;c2.pulled_options_digest_init_done =3D true;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (apply_push=
_options(&amp;c-&gt;options,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (apply_push_options(c,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               &amp;c-&gt;options,</=
span><br><span>                                buf,</span><br><span>       =
                         permission_mask,</span><br><span>                 =
               option_types_found,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                               c-&gt;c2.es))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                               c-&gt;=
c2.es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                  false))</span><br><span>         {</span><br><span>      =
       push_update_digest(c-&gt;c2.pulled_options_state, &amp;buf_orig,</sp=
an><br><span>                                &amp;c-&gt;options);</span><br=
><span>@@ -1103,6 +1113,12 @@</span><br><span>         return process_incom=
ing_push_reply(c, permission_mask,</span><br><span>                        =
                    option_types_found, &amp;buf);</span><br><span>     }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (honor_re=
ceived_options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        &amp;&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return process_incoming_pus=
h_update(c, permission_mask,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                            option_types_found, &a=
mp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span>     else</span><br><span>     {</span><br><span>         return=
 PUSH_MSG_ERROR;</span><br><span>diff --git a/src/openvpn/push.h b/src/open=
vpn/push.h</span><br><span>index 4a13327..52ca715 100644</span><br><span>--=
- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br><=
span>@@ -33,9 +33,22 @@</span><br><span> #define PUSH_MSG_AUTH_FAILURE     =
4</span><br><span> #define PUSH_MSG_CONTINUATION     5</span><br><span> #de=
fine PUSH_MSG_ALREADY_REPLIED  6</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define PUSH_MSG_UPDATE           7</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define push_reply_cmd &quot;PUSH_REPLY&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define push_update_cmd &quot;PUSH_UPDA=
TE&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Push-update options flags *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUSH_OPT_T=
O_REMOVE (1&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define PUSH_OPT_OPTIONAL (1&lt;&lt;1)</span><br><span> </span><br><span>=
 int process_incoming_push_request(struct context *c);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int process_incoming_p=
ush_update(struct context *c,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                 unsigned int permission_mask,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
           unsigned int *option_types_found,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 struct buffer *bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> int process_incoming_push_msg(struct context *c,</span><br><span>        =
                       const struct buffer *buffer,</span><br><span>       =
                        bool honor_received_options,</span><br><span>diff -=
-git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000..b4d1e8b</span><br><span>-=
-- /dev/null</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>=
@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+process_incoming_push_update(struct context *c,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      unsigned int permission_mask,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                             unsigned int *option_types_fou=
nd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
             struct buffer *buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ret =3D PUSH_MSG_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint8_t ch =3D buf_read_u8(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (ch =3D=3D &#39;,&#39;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (apply_push_options(c,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                               &am=
p;c-&gt;options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            buf,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                               permission_mask,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                               opt=
ion_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            c-&gt;c2.es,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                               true))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            switch (c-&gt;options.push_continu=
ation)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cas=
e 0:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 case 1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         ret =3D PUSH_MSG_UPDATE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                case 2:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    ret =3D PUSH_MSG_CONTINUATION;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (ch =3D=3D &#39;\0&#39;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ret =3D PUSH_MSG_UPDATE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><sp=
an>index 8040e7b..b006917 100644</span><br><span>--- a/src/openvpn/ssl.c</s=
pan><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1947,6 +1947,9 @@=
</span><br><span>         /* support for exit notify via control channel */=
</span><br><span>         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* s=
upport push-updates */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>         if (session-&gt;opt-&g=
t;pull)</span><br><span>         {</span><br><span>             /* support =
for receiving push_reply before sending</span><br><span>diff --git a/src/op=
envpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index eea1323..53b7f2c 1006=
44</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvp=
n/ssl.h</span><br><span>@@ -110,6 +110,9 @@</span><br><span> /** Supports t=
he --dns option after all the incompatible changes */</span><br><span> #def=
ine IV_PROTO_DNS_OPTION_V2   (1&lt;&lt;11)</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** Supports push-update */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define IV_PROTO_PUSH_UPDA=
TE     (1&lt;&lt;12)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /* Default field in X509 to be username */</span><br><sp=
an> #define X509_USERNAME_FIELD_DEFAULT &quot;CN&quot;</span><br><span> </s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/uni=
t_tests/openvpn/Makefile.am</span><br><span>index a4e6235..1b2414c 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+=
++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -11,7 +11,7 @@=
</span><br><span> endif</span><br><span> </span><br><span> test_binaries +=
=3D crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdr=
iver misc_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	pkt_testdriver ssl_testdriver user_pass_testdriver</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	pkt_testdriver ssl_testdriver user_pass_=
testdriver push_update_msg_testdriver</span><br><span> </span><br><span> if=
 HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><br><span>@@ -307,3 =
+307,25 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span=
><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$(top=
_srcdir)/src/openvpn/list.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_update=
_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/tests/unit_=
tests/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-ff=
unction-sections \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
@TEST_CFLAGS@ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@CM=
OCKA_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+push_update_msg_testdriver=
_LDFLAGS =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TES=
T_LDFLAGS@ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@CMOCK=
A_LIBS@ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-L$(top_s=
rcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(OPTIONAL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_update_m=
sg_testdriver_SOURCES =3D test_push_update_msg.c \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	mock_msg.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	mock_get_random.c \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/plat=
form.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/push_util.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/openvpn/options_util.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c</span>=
<br><span>\ No newline at end of file</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_pus=
h_update_msg.c</span><br><span>new file mode 100644</span><br><span>index 0=
000000..8574855</span><br><span>--- /dev/null</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -0,0 +1,245 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;pu=
sh.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;options_util.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* mocks */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+pull_permission_mask(const struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        OPT_P_UP</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_ROUTE_EXTRAS</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SOCKBUF</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SOCKF=
LAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P=
_SETENV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OP=
T_P_SHAPER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        |=
 OPT_P_TIMER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 | OPT_P_COMP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  | OPT_P_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      | OPT_P_MESSAGES</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        | OPT_P_EXPLICIT_NOTIFY</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        | OPT_P_ECHO</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        | OPT_P_PULL_MODE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        | OPT_P_PEER_ID</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        | OPT_P_NCP</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        | OPT_P_PUSH_MTU</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        | OPT_P_ROUTE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_DHCPDNS;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return flags;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_opti=
ons(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   struct options *options,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   struct buffer *buf,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                   unsigned i=
nt permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   struct env_set *es,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                   boo=
l is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_PARM=
_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse(buf, &#39;=
,&#39;, line, sizeof(line)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   unsigned int push_update_option_flags =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!apply_pull_filter(options, line, is_update, &amp;push=
_update_option_flags))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_WARN, &quot;Offending option received from server&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * No need to test also the app=
lication part here</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * (add_option/remove_option/update_option)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+process_incoming_push_msg(struct context *c,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
    const struct buffer *buffer,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                          bool honor_received_options,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          u=
nsigned int permission_mask,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          unsigned int *option_types_found)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (buf_string_compare_advance(&amp;buf, &qu=
ot;PUSH_REQUEST&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn PUSH_MSG_REQUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (honor_received_options</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             &amp;&amp; buf_string_compare_advance(&amp;buf, push_repl=
y_cmd))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return PUSH_MSG_RE=
PLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (honor_received_o=
ptions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
&amp;&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return process_incoming_push_upda=
te(c, permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                            option_types_found, &amp;buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return PUSH_MSG_ERROR;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* tests */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_incoming_push_message_basic(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_=
buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *update_msg =3D &quot;PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route 0.0.0=
.0 0.0.0.0 10.10.10.1&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types=
_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(proc=
ess_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask=
(c), &amp;option_types_found), PUSH_MSG_UPDATE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message_erro=
r1(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c=
 =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATEerr,dhcp-opt=
ion DNS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_in=
coming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &=
amp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_incoming_push_message_error2(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_b=
uf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *update_msg =3D &quot;PUSH_UPDATE ,dhcp-option DNS 8.8.8.8&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, u=
pdate_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, &amp;buf,=
 c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_found), PUS=
H_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_incoming_push_message_1(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context *c =3D *state;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(256);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *update_=
msg =3D &quot;PUSH_UPDATE, ?-dns, route something, ?dhcp-option DNS 8.8.8.8=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_writ=
e(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg=
(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_type=
s_found), PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_bu=
f(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_incoming_push_message_bad_format(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *update_msg =3D &quot;PUSH_UPDATE, -dhcp-option, -?dns&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp=
;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, &a=
mp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_foun=
d), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_incoming_push_message_not_updatable_option(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *update_msg =3D &quot;PUSH_UPDATE, dev tun&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, updat=
e_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int option_types_found =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&=
gt;options.pull, pull_permission_mask(c), &amp;option_types_found), PUSH_MS=
G_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_incoming_push_message_mix(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context *c =3D *state;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(256);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *update_=
msg =3D &quot;PUSH_UPDATE,-dhcp-option, route 10.10.10.0, dhcp-option DNS 1=
.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.local, keepalive 10 60&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&=
amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c,=
 &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_f=
ound), PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_incoming_push_message_mix2(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_b=
uf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *update_msg =3D &quot;PUSH_UPDATE,-dhcp-option,dhcp-option DNS 8.8.8.8,=
redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, update_ms=
g, strlen(update_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int option_types_found =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;o=
ptions.pull, pull_permission_mask(c), &amp;option_types_found), PUSH_MSG_UP=
DATE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+setup(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct contex=
t *c =3D calloc(1, sizeof(struct context));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    c-&gt;options.pull =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options.route_nopull =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *state =3D c=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+teardown(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t context *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_message=
_basic, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_message_er=
ror1, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test_setup_teardown(test_incoming_push_message_erro=
r2, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test_setup_teardown(test_incoming_push_message_not_up=
datable_option, setup, teardown),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_me=
ssage_1, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_message_b=
ad_format, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_message=
_mix, setup, teardown),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2=
, setup, teardown)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests=
(tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--oLJduotlyEE=--

