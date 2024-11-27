From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 27 Nov 2024 10:43:45 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c1c37481239651be0a0d5a5a8e3962597c141f34-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EdMZHmrOdJI="; charset=UTF-8
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

--EdMZHmrOdJI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail

to look at the new patch set (#4).

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
15 files changed, 619 insertions(+), 112 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..2077963 100644
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
@@ -612,6 +613,7 @@
         "test_provider"
         "test_ssl"
         "test_user_pass"
+        "test_push_update_msg"
         )

     if (WIN32)
@@ -807,6 +809,16 @@
         src/openvpn/env_set.c
         src/openvpn/run_command.c
         )
+
+    target_sources(test_push_update_msg PRIVATE
+        tests/unit_tests/openvpn/mock_msg.c
+        tests/unit_tests/openvpn/mock_get_random.c
+	    src/openvpn/buffer.c
+	    src/openvpn/platform.c
+	    src/openvpn/push_util.c
+	    src/openvpn/options_util.c
+	    src/openvpn/otime.c
+        )

     if (TARGET test_argv)
         target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)
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
index 043b240..6f97fcd 100644
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
-#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
-#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option =
*/
-#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option =
*/
-#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR=
1 */
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
index 6ab92e2..b4d486f 100644
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
index 1f8eb1e..4b621f1 100644
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
index a4e6235..ac2241e 100644
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
@@ -307,3 +307,21 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/list.c
+
+push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
+	-I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/tests/unit_tests/openvpn \
+	@TEST_CFLAGS@
+
+push_update_msg_testdriver_LDFLAGS =3D \
+	@TEST_LDFLAGS@ \
+	-L$(top_srcdir)/src/openvpn
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
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--EdMZHmrOdJI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
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
15 files changed, 619 insertions(+), 112 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 5db207d..207796=
3 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLi=
sts.txt</span><br><span>@@ -496,6 +496,7 @@</span><br><span>     src/openvp=
n/ps.c</span><br><span>     src/openvpn/ps.h</span><br><span>     src/openv=
pn/push.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/op=
envpn/push_util.c</span><br><span>     src/openvpn/push.h</span><br><span> =
    src/openvpn/pushlist.h</span><br><span>     src/openvpn/reflect_filter.=
c</span><br><span>@@ -612,6 +613,7 @@</span><br><span>         &quot;test_p=
rovider&quot;</span><br><span>         &quot;test_ssl&quot;</span><br><span=
>         &quot;test_user_pass&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &quot;test_push_update_msg&quot;</span><br><span> =
        )</span><br><span> </span><br><span>     if (WIN32)</span><br><span=
>@@ -807,6 +809,16 @@</span><br><span>         src/openvpn/env_set.c</span>=
<br><span>         src/openvpn/run_command.c</span><br><span>         )</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_push_update_ms=
g PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        te=
sts/unit_tests/openvpn/mock_msg.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	    src/openvpn/buffer.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	    src/openvpn/platfor=
m.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    src/openvpn=
/push_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    sr=
c/openvpn/options_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	    src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        )</span><br><span> </span><br><span>     if (TARGET test_=
argv)</span><br><span>         target_link_options(test_argv PRIVATE -Wl,--=
wrap=3Dparse_line)</span><br><span>diff --git a/src/openvpn/Makefile.am b/s=
rc/openvpn/Makefile.am</span><br><span>index ecb2bcf..55ec565 100644</span>=
<br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/M=
akefile.am</span><br><span>@@ -114,7 +114,7 @@</span><br><span> 	proto.c pr=
oto.h \</span><br><span> 	proxy.c proxy.h \</span><br><span> 	ps.c ps.h \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	push.c push.h \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	push.c push_util.c push.h=
 \</span><br><span> 	pushlist.h \</span><br><span> 	reflect_filter.c reflec=
t_filter.h \</span><br><span> 	reliable.c reliable.h \</span><br><span>diff=
 --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>inde=
x d50b24c..2c75953 100644</span><br><span>--- a/src/openvpn/forward.c</span=
><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2031,7 +2031,7 @=
@</span><br><span>     }</span><br><span> </span><br><span>     /* check fo=
r incoming control messages on the control channel like</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * push request/reply, or authenticat=
ion failure and 2FA messages */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * push request/reply/update, or authentication failure and=
 2FA messages */</span><br><span>     if (tls_test_payload_len(c-&gt;c2.tls=
_multi) &gt; 0)</span><br><span>     {</span><br><span>         check_incom=
ing_control_channel(c);</span><br><span>diff --git a/src/openvpn/init.c b/s=
rc/openvpn/init.c</span><br><span>index 9371024..f8d9d06 100644</span><br><=
span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</spa=
n><br><span>@@ -2030,8 +2030,8 @@</span><br><span>         /* possibly add =
routes */</span><br><span>         if ((route_order(c-&gt;c1.tuntap) =3D=3D=
 ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt;options.route_delay_defined))</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         int status =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c=
-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                  c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;=
c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            bool status =3D do_route(&amp;c-&gt;options, c-&gt;c1.r=
oute_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   c-&gt;c1.tuntap, c-&gt;=
plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>             *er=
ror_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);</span><br><span>         }<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/=
openvpn/options.c</span><br><span>index 043b240..6f97fcd 100644</span><br><=
span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.=
c</span><br><span>@@ -63,6 +63,7 @@</span><br><span> #include &lt;ctype.h&g=
t;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=
.h&quot;</span><br><span> </span><br><span> const char title_string[] =3D</=
span><br><span>     PACKAGE_STRING</span><br><span>@@ -927,24 +928,6 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-struct pull_filter</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define PUF_TYPE_UNDEF  0    /**&lt; undefined filter type */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_ACCEPT=
 1    /**&lt; filter type to accept a matching option */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_IGNORE 2    /**&lt; fil=
ter type to ignore a matching option */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define PUF_TYPE_REJECT 3    /**&lt; filter type to rejec=
t and trigger SIGUSR1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *pat=
tern;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_=
filter *next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-struct pull_filter_list</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct pull_filter *head;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct pull_filter *tail;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> #ifndef ENABLE_SMALL</span><br><span> </span><br><s=
pan> static const char *</span><br><span>@@ -5469,84 +5452,6 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Filter an option line by all pull filters.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * If a match is found, the line is modified depending on</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * the filter type, and r=
eturns true. If the filter type is</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * reject, SIGUSR1 is triggered and the return value is false.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In that case the c=
aller must end the push processing.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-apply_pull_fil=
ter(const struct options *o, char *line)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct pull_filter *f;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;pu=
ll_filter_list)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* skip leading spaces matching the behaviour of parse_l=
ine */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (issp=
ace(*line))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        line++;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D f-&gt;next)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (f-&gt;type =3D=3D PUF_TYPE=
_ACCEPT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quot;Pushed opt=
ion accepted by filter: &#39;%s&#39;&quot;, line);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            return true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else if (f-&gt;type =3D=3D PUF_TYPE_IGNORE &amp=
;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(D_PUSH, &quot;Pushed option removed=
 by filter: &#39;%s&#39;&quot;, line);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            *line =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        else if (f-&gt;type =3D=3D PUF_TYPE_REJECT &=
amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Pushed option reje=
cted by filter: &#39;%s&#39;. Restarting.&quot;, line);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            *line =3D &#39;\0&#39;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            throw_signal_so=
ft(SIGUSR1, &quot;Offending option received from server&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-apply_push_options(struct options *options,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   st=
ruct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
               unsigned int permission_mask,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   unsigned int *option_types_found,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   st=
ruct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    char line[OPTION_PAR=
M_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int line_=
num =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const c=
har *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    while (buf_parse(buf, &#39;,&#39;, line, si=
zeof(line)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *p[MAX_PARMS=
+1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(p);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++line_num;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!apply_pull=
_filter(options, line))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  return false; /* Cause push/pull error and stop push processing */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (parse_line(line, p, SIZE(p)-=
1, file, line_num, msglevel, &amp;options-&gt;gc))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            add_option(options, p, false, file, line_num, =
0, msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              permission_mask, option_types_found, es);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid</span><br><span> options_server_import(struct options *o,</span><br><sp=
an>                       const char *filename,</span><br><span>@@ -5680,6 =
+5585,44 @@</span><br><span>     return options-&gt;forward_compatible ? M_=
WARN : msglevel;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+apply_push_options(struct context *c,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                   struct options *opt=
ions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   unsigned int permission_mask,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   unsigned int *option_t=
ypes_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
           struct env_set *es,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                   bool is_update)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char line[OPTION_PARM_SIZE];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int line_num =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *file =3D &quot;[PUSH-OPTIONS]&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int msg=
level =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        char *p[MAX_PARMS+1];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        CLEAR(p);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ++line_num;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        unsigned int push_update_option_flags =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!apply_pull_filter(o=
ptions, line, is_update, &amp;push_update_option_flags))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            throw_signal_soft(SIGUSR1, &quot;Off=
ending option received from server&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return false; /* Cause push/pull error a=
nd stop push processing */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &amp;opti=
ons-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!=
is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 add_option(options, p, false, file, line_num, 0, msglevel,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                           permissi=
on_mask, option_types_found, es);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> set_user_script(struct options *options,</span><br><span>        =
         const char **script,</span><br><span>diff --git a/src/openvpn/opti=
ons.h b/src/openvpn/options.h</span><br><span>index 6ab92e2..b4d486f 100644=
</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/open=
vpn/options.h</span><br><span>@@ -777,6 +777,33 @@</span><br><span> #define=
 MAN_CLIENT_AUTH_ENABLED(opt) (false)</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * some PUSH_UPDATE options</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_ROUTE           (1&lt;&l=
t;0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U=
_ROUTE6          (1&lt;&lt;1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OPT_P_U_DNS             (1&lt;&lt;2)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_DHCP            (1&lt;&l=
t;3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U=
_REDIR_GATEWAY   (1&lt;&lt;4)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct pu=
ll_filter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_UNDEF  0   =
 /** undefined filter type */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define PUF_TYPE_ACCEPT 1    /** filter type to accept a matching=
 option */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P=
UF_TYPE_IGNORE 2    /** filter type to ignore a matching option */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_REJECT 3   =
 /** filter type to reject and trigger SIGUSR1 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int type;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int size;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    char *pattern;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct pull_filter *next;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct pu=
ll_filter_list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pull_filter =
*head;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pu=
ll_filter *tail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> vo=
id parse_argv(struct options *options,</span><br><span>                 con=
st int argc,</span><br><span>                 char *argv[],</span><br><span=
>@@ -845,11 +872,13 @@</span><br><span> </span><br><span> void pre_connect_=
restore(struct options *o, struct gc_arena *gc);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool apply_push_options(struct=
 options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool apply_push_options(struct context *c,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        struct options *options,</spa=
n><br><span>                         struct buffer *buf,</span><br><span>  =
                       unsigned int permission_mask,</span><br><span>      =
                   unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        struct env_set *es)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      struct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        bool is_update);</span><br><span> </span><br>=
<span> void options_detach(struct options *o);</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c<=
/span><br><span>index a9e020a..87282c3 100644</span><br><span>--- a/src/ope=
nvpn/options_util.c</span><br><span>+++ b/src/openvpn/options_util.c</span>=
<br><span>@@ -30,6 +30,8 @@</span><br><span> </span><br><span> #include &qu=
ot;options_util.h&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;push.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><spa=
n> parse_auth_failed_temp(struct options *o, const char *reason)</span><br>=
<span> {</span><br><span>@@ -98,3 +100,176 @@</span><br><span>     gc_free(=
&amp;gc);</span><br><span>     return message;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static const char *updatable_options[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;block-ipv6&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;block=
-outside-dns&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;dhcp-option&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;dns&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;ifconfig&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;ifconfig-ipv6&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;push-continuation&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;redirect-gateway&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;redirect-=
private&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;route&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;route-gateway&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;route-ipv6&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;route-metric&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;topology&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;tun-mtu&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;keepalive&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_push_update_option_flags(char **line, unsigned int *flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!line || !*line || !**line)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *flags =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool opt_is_updatable =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *str =3D *line;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char c =3D **line;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (c =3D=3D &#39;?&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *flags |=3D PUSH_OPT_OPTIONAL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (str[1])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            c =3D *(++str);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (c =3D=3D &#39;-&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 *flags |=3D PUSH_OPT_TO_REMOVE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (str[1])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            c =3D *(++str);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (c =3D=3D &#39;-&#39; &amp;&amp; !(*flags &amp=
; PUSH_OPT_TO_REMOVE))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *fl=
ags |=3D PUSH_OPT_TO_REMOVE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (str[1])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           c =3D *(++str);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Skip &#39;?&#39; and &#39;-&#39; if they are prese=
nt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len=
 =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  memmove(*line, str, len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    (*line)[len] =3D &#39;\0&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    str =3D *line;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int count =3D sizeof(updatable_options)/sizeof(char *);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; cou=
nt; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t opt_len =
=3D strlen(updatable_options[i]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (len &lt; opt_len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!strncmp(str, updatable_options[i], opt_len)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (!str[opt=
_len] || str[opt_len] =3D=3D &#39; &#39;))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            opt_is_updatable =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
opt_is_updatable)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*fla=
gs &amp; PUSH_OPT_OPTIONAL)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(D_PUSH, &quot;Pushed option is not updatable: &#39;%s&#39;&qu=
ot;, *line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot=
;Pushed option is not updatable: &#39;%s&#39;. Restarting.&quot;, *line);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Filter an option line by all pull fi=
lters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * If a match is found, the li=
ne is modified depending on</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * the filter type, and returns true. If the filter type is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * reject, SIGUSR1 is trigg=
ered and the return value is false.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * In that case the caller must end the push processing.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+apply_pull_filter(const struct options *o, char *line=
, bool is_update, unsigned int *push_update_option_flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct pull_filter *f;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!o-&gt;pull_filter_list &amp;&amp; !(is_update))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* skip leading spaces matching the behaviour of parse_line */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    while (isspace(*line))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        line++;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!check_push_update_option_flags(&amp;line, push_update_option_flags))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!o-&gt;pull_filter_list)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D f-&gt;next)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (f-&gt;type =3D=3D PUF_=
TYPE_ACCEPT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;Pu=
shed option accepted by filter: &#39;%s&#39;&quot;, line);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (f-&gt;type =3D=3D PUF_TY=
PE_IGNORE &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH, &quot;Pus=
hed option removed by filter: &#39;%s&#39;&quot;, line);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (f-&gt;type =3D=3D PUF_TY=
PE_REJECT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (is_update &amp;&a=
mp; (*push_update_option_flags &amp; PUSH_OPT_OPTIONAL))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(D_PUSH, &quot;Pushed opt=
ion removed by filter: &#39;%s&#39;&quot;, line);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                return true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;Pushed option re=
jected by filter: &#39;%s&#39;. Restarting.&quot;, line);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/options_util.h =
b/src/openvpn/options_util.h</span><br><span>index 29bc9dc..64ee0d6 100644<=
/span><br><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/=
openvpn/options_util.h</span><br><span>@@ -30,4 +30,10 @@</span><br><span> =
const char *</span><br><span> parse_auth_failed_temp(struct options *o, con=
st char *reason);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+apply_pull_filter(const struct options *o,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  char *line,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  bool is_update,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  unsigned =
int *push_update_option_flags);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif</span><br><span>diff --git a/src/openv=
pn/push.c b/src/openvpn/push.c</span><br><span>index 6c06374..71a0372 10064=
4</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvp=
n/push.c</span><br><span>@@ -39,8 +39,6 @@</span><br><span> #include &quot;=
ssl_util.h&quot;</span><br><span> #include &quot;options_util.h&quot;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static ch=
ar push_reply_cmd[] =3D &quot;PUSH_REPLY&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Auth use=
rname/password</span><br><span>  *</span><br><span>@@ -519,21 +517,31 @@</s=
pan><br><span>     {</span><br><span>         msg(D_PUSH_ERRORS, &quot;WARN=
ING: Received bad push/pull message: %s&quot;, sanitize_control_message(BST=
R(buffer), &amp;gc));</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (status =3D=3D PUSH_MSG_REPLY || status =
=3D=3D PUSH_MSG_CONTINUATION)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_M=
SG_UPDATE || status =3D=3D PUSH_MSG_CONTINUATION)</span><br><span>     {</s=
pan><br><span>         c-&gt;options.push_option_types_found |=3D option_ty=
pes_found;</span><br><span> </span><br><span>         /* delay bringing tun=
/tap up until --push parms received from remote */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (status =3D=3D PUSH_MSG_REPLY)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status =3D=
=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE)</span><br><span>      =
   {</span><br><span>             if (!options_postprocess_pull(&amp;c-&gt;=
options, c-&gt;c2.es))</span><br><span>             {</span><br><span>     =
            goto error;</span><br><span>             }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (!do_up(c, true, c-&gt;opti=
ons.push_option_types_found))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (status =3D=3D PUSH_MSG_REPLY)</span><br><span>   =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      msg(D_PUSH_ERRORS, &quot;Failed to open tun/tap interface&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto erro=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (!do_up(c, true, c-&gt;options.push_option_types_found))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    msg(D_PUSH_ERRORS,=
 &quot;Failed to open tun/tap interface&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    goto error;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (!option_types_found)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_WARN,=
 &quot;No option found&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                }</span><br><span>             }</span><br><span=
>         }</span><br><span>         event_timeout_clear(&amp;c-&gt;c2.push=
_request_interval);</span><br><span>@@ -1048,11 +1056,13 @@</span><br><span=
>             md_ctx_init(c-&gt;c2.pulled_options_state, &quot;SHA256&quot;=
);</span><br><span>             c-&gt;c2.pulled_options_digest_init_done =
=3D true;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (apply_push_options(&amp;c-&gt;options,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (apply_push_option=
s(c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                &amp;c-&gt;options,</span><br><span>                       =
         buf,</span><br><span>                                permission_ma=
sk,</span><br><span>                                option_types_found,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
      c-&gt;c2.es))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                               c-&gt;c2.es,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                               false))</span><br><s=
pan>         {</span><br><span>             push_update_digest(c-&gt;c2.pul=
led_options_state, &amp;buf_orig,</span><br><span>                         =
       &amp;c-&gt;options);</span><br><span>@@ -1103,6 +1113,12 @@</span><b=
r><span>         return process_incoming_push_reply(c, permission_mask,</sp=
an><br><span>                                            option_types_found=
, &amp;buf);</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (honor_received_options</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; buf_string_compar=
e_advance(&amp;buf, push_update_cmd))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return process_incoming_push_update(c, permission_mask,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                 option_types_found, &amp;buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span>     else</span><br><span=
>     {</span><br><span>         return PUSH_MSG_ERROR;</span><br><span>dif=
f --git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 4a1=
3327..52ca715 100644</span><br><span>--- a/src/openvpn/push.h</span><br><sp=
an>+++ b/src/openvpn/push.h</span><br><span>@@ -33,9 +33,22 @@</span><br><s=
pan> #define PUSH_MSG_AUTH_FAILURE     4</span><br><span> #define PUSH_MSG_=
CONTINUATION     5</span><br><span> #define PUSH_MSG_ALREADY_REPLIED  6</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUSH_MSG_UPDATE=
           7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define push_reply_cmd &qu=
ot;PUSH_REPLY&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define push_update_cmd &quot;PUSH_UPDATE&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Push-update options flags */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define PUSH_OPT_TO_REMOVE (1&lt;&lt;0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define PUSH_OPT_OPTIONAL (1&lt;&l=
t;1)</span><br><span> </span><br><span> int process_incoming_push_request(s=
truct context *c);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int process_incoming_push_update(struct context *c,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
       unsigned int permission_mask,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                 unsigned int *option_type=
s_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                      struct buffer *buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> int process_incoming_push_msg(stru=
ct context *c,</span><br><span>                               const struct =
buffer *buffer,</span><br><span>                               bool honor_r=
eceived_options,</span><br><span>diff --git a/src/openvpn/push_util.c b/src=
/openvpn/push_util.c</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000..b4d1e8b</span><br><span>--- /dev/null</span><br><span>+++ b/s=
rc/openvpn/push_util.c</span><br><span>@@ -0,0 +1,44 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;push.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_inco=
ming_push_update(struct context *c,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                             unsigned int permission_mask,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
         unsigned int *option_types_found,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                             struct buffer *buf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D PUSH_MSG_ERROR;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t ch =3D buf_=
read_u8(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ch =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (apply_push_options(c,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                               &amp;c-&gt;options,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                               buf,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
        permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                               option_types_found,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                               c-&gt;c2=
.es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                true))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     switch (c-&gt;options.push_continuation)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                case 0:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                case 1:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    ret =3D PUSH_MSG_UPDATE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                case 2:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    ret =3D PU=
SH_MSG_CONTINUATION;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (ch =3D=3D=
 &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D PUS=
H_MSG_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/ssl.c b/src/openvpn/ssl.c</span><br><span>index 1f8eb1e..4b621f1 100644</=
span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ss=
l.c</span><br><span>@@ -1947,6 +1947,9 @@</span><br><span>         /* suppo=
rt for exit notify via control channel */</span><br><span>         iv_proto=
 |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* support push-updates */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        iv_proto |=3D IV_PROTO_=
PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         if (session-&gt;opt-&gt;pull)</span><br><span>         {=
</span><br><span>             /* support for receiving push_reply before se=
nding</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</s=
pan><br><span>index eea1323..53b7f2c 100644</span><br><span>--- a/src/openv=
pn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -110,6 =
+110,9 @@</span><br><span> /** Supports the --dns option after all the inco=
mpatible changes */</span><br><span> #define IV_PROTO_DNS_OPTION_V2   (1&lt=
;&lt;11)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** Supports push-update */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define IV_PROTO_PUSH_UPDATE     (1&lt;&lt;12)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Default fiel=
d in X509 to be username */</span><br><span> #define X509_USERNAME_FIELD_DE=
FAULT &quot;CN&quot;</span><br><span> </span><br><span>diff --git a/tests/u=
nit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span>=
<br><span>index a4e6235..ac2241e 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file.am</span><br><span>@@ -11,7 +11,7 @@</span><br><span> endif</span><br>=
<span> </span><br><span> test_binaries +=3D crypto_testdriver packet_id_tes=
tdriver auth_token_testdriver ncp_testdriver misc_testdriver \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	pkt_testdriver ssl_testdriver use=
r_pass_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	p=
kt_testdriver ssl_testdriver user_pass_testdriver push_update_msg_testdrive=
r</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><spa=
n> if !WIN32</span><br><span>@@ -307,3 +307,21 @@</span><br><span> 	$(top_s=
rcdir)/src/openvpn/win32-util.c \</span><br><span> 	$(top_srcdir)/src/openv=
pn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/list.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+push_update_msg_testdriver_CFLAGS =3D -I$(top_s=
rcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	-I$(top_srcdir)/src/compat \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+push_update_msg_testdriver_LDFLAGS =3D \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	@TEST_LDFLAGS@ \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-L$(top_srcdir)/src/openvpn</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+push_update_msg_testdriver_SOURCES =3D test_push_up=
date_msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_m=
sg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_ran=
dom.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/push_util.c \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/o=
ptions_util.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/otime.c</span><br><span>\ No newline at end of file<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_msg.=
c b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000..8574855</span><br><span>--- /d=
ev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=
.c</span><br><span>@@ -0,0 +1,245 @@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;stdlib.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdarg.h&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;push.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;options_util.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* mocks */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+un=
signed int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pull_perm=
ission_mask(const struct context *c)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        OPT_P_UP</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        | OPT_P_ROUTE_EXTRAS</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        | OPT_P_SOCKBUF</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        | OPT_P_SOCKFLAGS</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        | OPT_P_SETENV</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        | OPT_P_SHAPER</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        | OPT_P_TIMER</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        | OPT_P_COMP</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        | OPT_P_PERSIST</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_MESSAGES</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_EXPLICIT_NOTIFY</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_ECHO</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_PULL_M=
ODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_=
PEER_ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OP=
T_P_NCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OP=
T_P_PUSH_MTU</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 | OPT_P_ROUTE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+apply_push_options(struct context *c,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   struct options *o=
ptions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   unsigned int permission_mask,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   unsigned int *option=
_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             struct env_set *es,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   bool is_update)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char line[OPTION_PARM_SIZE];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        unsigned int push_update_option_flags=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!apply_pull_filter(=
options, line, is_update, &amp;push_update_option_flags))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Offending option =
received from server&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * No need to test also the application part here</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * (add_option/remove_option/upda=
te_option)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_inco=
ming_push_msg(struct context *c,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                          const struct buffer *buffer,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          b=
ool honor_received_options,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                          unsigned int permission_mask,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          unsig=
ned int *option_types_found)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D *buffer;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_s=
tring_compare_advance(&amp;buf, &quot;PUSH_REQUEST&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return PUSH_MSG_REQUEST;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (honor_received_options</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; buf_string_=
compare_advance(&amp;buf, push_reply_cmd))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return PUSH_MSG_REPLY;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (honor_received_options</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             &amp;&amp; buf_string_compare_advance(&a=
mp;buf, push_update_cmd))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return process_incoming_push_update(c, permission_mask,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
     option_types_found, &amp;buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return PUSH_MSG=
_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* tests */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_mess=
age_basic(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE,dhcp=
-option DNS 8.8.8.8, route 0.0.0.0 0.0.0.0 10.10.10.1&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, update_msg=
, strlen(update_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    unsigned int option_types_found =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;op=
tions.pull, pull_permission_mask(c), &amp;option_types_found), PUSH_MSG_UPD=
ATE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_incoming_push_message_error1(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct context *c =3D *state;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(256);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *update_msg =
=3D &quot;PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, update_msg, str=
len(update_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int option_types_found =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options=
.pull, pull_permission_mask(c), &amp;option_types_found), PUSH_MSG_ERROR);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_messa=
ge_error2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct con=
text *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE ,dhc=
p-option DNS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_=
found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(proce=
ss_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(=
c), &amp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message_1(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *s=
tate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE, ?-dns, route some=
thing, ?dhcp-option DNS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int op=
tion_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permi=
ssion_mask(c), &amp;option_types_found), PUSH_MSG_UPDATE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_me=
ssage_bad_format(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct context *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDA=
TE, -dhcp-option, -?dns&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_typ=
es_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pr=
ocess_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_ma=
sk(c), &amp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message_not=
_updatable_option(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct context *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPD=
ATE, dev tun&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_inc=
oming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &a=
mp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message_mix(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *update_msg =3D &quot;PUSH_UPDATE,-dhcp-option, route 10=
.10.10.0, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN cor=
p.local, keepalive 10 60&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_ty=
pes_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(p=
rocess_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_m=
ask(c), &amp;option_types_found), PUSH_MSG_UPDATE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message=
_mix2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context=
 *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE,-dhcp-op=
tion,dhcp-option DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.2=
55.255.0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming=
_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;op=
tion_types_found), PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+setup(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct context *c =3D calloc(1, sizeof(struct context));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options.pul=
l =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;options.route_nopull =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    *state =3D c;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+teardown(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardo=
wn(test_incoming_push_message_basic, setup, teardown),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(=
test_incoming_push_message_error1, setup, teardown),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_incoming_push_message_error2, setup, teardown),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(t=
est_incoming_push_message_not_updatable_option, setup, teardown),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setu=
p_teardown(test_incoming_push_message_1, setup, teardown),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teard=
own(test_incoming_push_message_bad_format, setup, teardown),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_tea=
rdown(test_incoming_push_message_mix, setup, teardown),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown=
(test_incoming_push_message_mix2, setup, teardown)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return cmocka_run_group_tests(tests, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demai=
l">change 808</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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


--EdMZHmrOdJI=--

