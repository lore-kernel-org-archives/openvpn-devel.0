From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 29 Jul 2025 12:23:37 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <bc4c7c983950a72a7de3692ae2d4c6e1a2af20a9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VzoBluhBblc="; charset=UTF-8
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
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VzoBluhBblc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#23) to the change originally created b=
y mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250729104045.27582-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
406.html
Signed-off-by: Gert Doering <gert@...1296...>
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
15 files changed, 625 insertions(+), 88 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/23

diff --git a/CMakeLists.txt b/CMakeLists.txt
index efb2d2d..3866e21 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -534,6 +534,7 @@
     src/openvpn/ps.c
     src/openvpn/ps.h
     src/openvpn/push.c
+    src/openvpn/push_util.c
     src/openvpn/push.h
     src/openvpn/pushlist.h
     src/openvpn/reflect_filter.c
@@ -652,6 +653,7 @@
         "test_provider"
         "test_ssl"
         "test_user_pass"
+        "test_push_update_msg"
         )

     if (WIN32)
@@ -854,6 +856,14 @@
         src/openvpn/run_command.c
         )

+    target_sources(test_push_update_msg PRIVATE
+        tests/unit_tests/openvpn/mock_msg.c
+        tests/unit_tests/openvpn/mock_get_random.c
+	    src/openvpn/push_util.c
+	    src/openvpn/options_util.c
+	    src/openvpn/otime.c
+        )
+
     if (TARGET test_argv)
         target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)
         target_sources(test_argv PRIVATE
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a5d4cdc..1e17c3f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -117,7 +117,7 @@
 	proto.c proto.h \
 	proxy.c proxy.h \
 	ps.c ps.h \
-	push.c push.h \
+	push.c push_util.c push.h \
 	pushlist.h \
 	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index dfc6708..475d142 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2064,7 +2064,7 @@
     }

     /* check for incoming control messages on the control channel like
-     * push request/reply, or authentication failure and 2FA messages */
+     * push request/reply/update, or authentication failure and 2FA messag=
es */
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel(c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aac8a6a..ba1dda4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2051,8 +2051,8 @@
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
index d44c102..eb53a60 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -66,6 +66,7 @@
 #include <ctype.h>

 #include "memdbg.h"
+#include "options_util.h"

 const char title_string[] =3D
     PACKAGE_STRING
@@ -948,24 +949,6 @@
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
@@ -5503,60 +5486,14 @@
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
 bool
-apply_push_options(struct options *options,
+apply_push_options(struct context *c,
+                   struct options *options,
                    struct buffer *buf,
                    unsigned int permission_mask,
                    unsigned int *option_types_found,
-                   struct env_set *es)
+                   struct env_set *es,
+                   bool is_update)
 {
     char line[OPTION_PARM_SIZE];
     int line_num =3D 0;
@@ -5568,14 +5505,40 @@
         char *p[MAX_PARMS+1];
         CLEAR(p);
         ++line_num;
-        if (!apply_pull_filter(options, line))
+        unsigned int push_update_option_flags =3D 0;
+        int i =3D 0;
+
+        /* skip leading spaces matching the behaviour of parse_line */
+        while (isspace(line[i]))
         {
+            i++;
+        }
+
+        /* If we are not in a 'PUSH_UPDATE' we just check `apply_pull_filt=
er()`
+         * otherwise we must call `check_push_update_option_flags()` first
+         */
+        if ((is_update && !check_push_update_option_flags(line, &i, &push_=
update_option_flags))
+            || !apply_pull_filter(options, &line[i]))
+        {
+            /* In case we are in a `PUSH_UPDATE` and `check_push_update_op=
tion_flags()`
+             * or `apply_pull_filter()` fail but the option is flagged by =
`PUSH_OPT_OPTIONAL`,
+             * instead of restarting, we just ignore the option and we pro=
cess the next one
+             */
+            if (push_update_option_flags & PUSH_OPT_OPTIONAL)
+            {
+                continue; /* Ignoring this option */
+            }
+            throw_signal_soft(SIGUSR1, "Offending option received from ser=
ver");
             return false; /* Cause push/pull error and stop push processin=
g */
         }
-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &opti=
ons->gc))
+
+        if (parse_line(&line[i], p, SIZE(p)-1, file, line_num, msglevel, &=
options->gc))
         {
-            add_option(options, p, false, file, line_num, 0, msglevel,
-                       permission_mask, option_types_found, es);
+            if (!is_update)
+            {
+                add_option(options, p, false, file, line_num, 0, msglevel,
+                           permission_mask, option_types_found, es);
+            }
         }
     }
     return true;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 56e85d7..0544ca9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -794,6 +794,33 @@
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
+#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
+#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option =
*/
+#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option =
*/
+#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR=
1 */
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
@@ -862,11 +889,13 @@

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
index 80d0c08..d317c1a 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -30,6 +30,8 @@

 #include "options_util.h"

+#include "push.h"
+
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {
@@ -145,3 +147,116 @@

     return (int) i;
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
+bool
+check_push_update_option_flags(char *line, int *i, unsigned int *flags)
+{
+    *flags =3D 0;
+    bool opt_is_updatable =3D false;
+    char c =3D line[*i];
+
+    /* We check for '?' and '-' and
+     * if they are present we skip them.
+     */
+    if (c =3D=3D '-')
+    {
+        if (!(line)[*i + 1])
+        {
+            return false;
+        }
+        *flags |=3D PUSH_OPT_TO_REMOVE;
+        c =3D (line)[++(*i)];
+    }
+    if (c =3D=3D '?')
+    {
+        if (!(line)[*i + 1] || (line)[*i + 1] =3D=3D '-')
+        {
+            return false;
+        }
+        *flags |=3D PUSH_OPT_OPTIONAL;
+        c =3D (line)[++(*i)];
+    }
+
+    size_t len =3D strlen(&line[*i]);
+    int count =3D sizeof(updatable_options)/sizeof(char *);
+    for (int j =3D 0; j < count; ++j)
+    {
+        size_t opt_len =3D strlen(updatable_options[j]);
+        if (len < opt_len)
+        {
+            continue;
+        }
+        if (!strncmp(&line[*i], updatable_options[j], opt_len)
+            && (!line[*i + opt_len] || line[*i + opt_len] =3D=3D ' '))
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
+            msg(D_PUSH, "Pushed option is not updatable: '%s'. Ignoring.",=
 line);
+        }
+        else
+        {
+            msg(M_WARN, "Pushed option is not updatable: '%s'. Restarting.=
", line);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+bool
+apply_pull_filter(const struct options *o, char *line)
+{
+    if (!o->pull_filter_list)
+    {
+        return true;
+    }
+
+    struct pull_filter *f;
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
+            *line =3D '\0';
+            return true;
+        }
+        else if (f->type =3D=3D PUF_TYPE_REJECT && strncmp(line, f->patter=
n, f->size) =3D=3D 0)
+        {
+            msg(M_WARN, "Pushed option rejected by filter: '%s'.", line);
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 2474e7f..71d51d6 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -50,4 +50,47 @@
 int
 atoi_warn(const char *str, int msglevel);

+/**
+ * Filter an option line by all pull filters.
+ *
+ * If a match is found, the line is modified depending on
+ * the filter type, and returns true. If the filter type is
+ * reject, SIGUSR1 is triggered and the return value is false.
+ * In that case the caller must end the push processing.
+ */
+bool
+apply_pull_filter(const struct options *o,
+                  char *line);
+
+/**
+ * @brief Checks the formatting and validity of options inside push-update=
 messages.
+ *
+ * This function is used to validate and process options
+ * in push-update messages. It performs the following checks:
+ * - Determines if the options are updatable.
+ * - Checks for the presence of the `-` flag, which indicates that the opt=
ion
+ *   should be removed.
+ * - Checks for the `?` flag, which marks the option as optional and suppr=
esses
+ *   errors if the client cannot update it.
+ * - Increase the value pointed by 'i' when we encounter the `'-'` and `'?=
'` flags
+ *   after validating them and updating the appropriate flags in the `flag=
s` variable.
+ * - `-?option`, `-option`, `?option` are valid formats, `?-option` is not=
 a valid format.
+ * - If the flags and the option are not consecutive, the option is invali=
d:
+ *   `- ?option`, `-? option`, `- option` are invalid formats.
+ *
+ * @param line A pointer to an option string. This string is the option be=
ing validated.
+ * @param i A pointer to an integer that represents the current index in t=
he `line` string.
+ * @param flags A pointer where flags will be stored:
+ *              - `PUSH_OPT_TO_REMOVE`: Set if the `-` flag is present.
+ *              - `PUSH_OPT_OPTIONAL`: Set if the `?` flag is present.
+ *
+ * @return true if the flags and option combination are valid.
+ * @return false if:
+ *         - The `-` and `?` flags are not formatted correctly.
+ *         - The `line` parameter is empty or `NULL`.
+ *         - The `?` flag is absent and the option is not updatable.
+ */
+bool
+check_push_update_option_flags(char *line, int *i, unsigned int *flags);
+
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ad8fa3d7..858b821 100644
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
+                    msg(M_WARN, "No updatable options found in incoming PU=
SH_UPDATE message");
+                }
             }
         }
         event_timeout_clear(&c->c2.push_request_interval);
@@ -1056,11 +1064,13 @@
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
@@ -1111,6 +1121,12 @@
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
index 048b4c4..18dfcd8 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -33,9 +33,42 @@
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

+/**
+ * @brief Handles the receiving of a push-update message and applies updat=
es to the specified options.
+ *
+ * This function processes a push-update message, validating its content a=
nd applying updates
+ * to the options specified in the message. It also handles split messages=
 if the complete
+ * message has not yet been received.
+ *
+ * @param c The context for the operation.
+ * @param permission_mask The permission mask specifying which options are=
 allowed to be pulled.
+ * @param option_types_found A pointer to a variable that will be filled w=
ith the types of options
+ *                           found in the message.
+ * @param buf A buffer containing the received message.
+ *
+ * @return
+ * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the up=
dates were applied.
+ * - `PUSH_MSG_CONTINUATION`: The message is a fragment of a larger messag=
e, and the program is
+ *                            waiting for the final part.
+ * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the=
 message is invalid.
+ */
+
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
index 9c6616a..a7658dd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1993,6 +1993,9 @@
         /* support for exit notify via control channel */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;

+        /* support push-updates */
+        iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+
         if (session->opt->pull)
         {
             /* support for receiving push_reply before sending
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 000992d..0a43ea1 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -114,6 +114,9 @@
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)

+/** Supports push-update */
+#define IV_PROTO_PUSH_UPDATE     (1<<12)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index b47b495..b24e03c 100644
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
@@ -326,3 +326,21 @@
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
index 0000000..d47286a
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -0,0 +1,260 @@
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
+        int i =3D 0;
+
+        if (is_update || options->pull_filter_list)
+        {
+            /* skip leading spaces matching the behaviour of parse_line */
+            while (isspace(line[i]))
+            {
+                i++;
+            }
+
+            if ((is_update && !check_push_update_option_flags(line, &i, &p=
ush_update_option_flags))
+                || (options->pull_filter_list && !apply_pull_filter(option=
s, &line[i])))
+            {
+                if (push_update_option_flags & PUSH_OPT_OPTIONAL)
+                {
+                    continue; /* Ignoring this option */
+                }
+                msg(M_WARN, "Offending option received from server");
+                return false; /* Cause push/pull error and stop push proce=
ssing */
+            }
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
+    const char *update_msg =3D "PUSH_UPDATE, -?dns, route something, ?dhcp=
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
+    const char *update_msg =3D "PUSH_UPDATE, -dhcp-option, ?-dns";
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
Gerrit-PatchSet: 23
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--VzoBluhBblc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #23</strong> to the change originally c=
reated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">PUSH_UPDATE: Allow OpenVPN in client mode to receive=
 and handle PUSH UPDATE control messages to allow options updating at runti=
me.<br><br>* Added IV_PROTO_PUSH_UPDATE flag bit to support push-updates.<b=
r>* Added process_incoming_push_update(), in a separate file to create test=
s more easily.<br>* Modified incoming_push_message(), process_incoming_push=
_msg(), apply_push_options(),<br>  apply_pull_filter() to process also push=
-update messages.<br>* Added the check_push_update_option_flags() function =
used in apply_pull_filter() to<br>  check options formatting inside push-up=
date messages, if the options are updatables<br>  and to check for &#39;?&#=
39; and &#39;-&#39; flags that may be present in front of the options.<br> =
 The &#39;-&#39; flag is used to indicate that the option in question shoul=
d be removed,<br>  while the &#39;?&#39; indicates that the option is optio=
nal and to do not generate<br>  errors if the client cannot update that opt=
ion.<br>  For more info you can read the RFC at https://github.com/OpenVPN/=
openvpn-rfc .<br>* Created some unit tests for the push-update message hand=
ling in test_push_update_msg.c.<br><br>Change-Id: I6ecd4cb47571cc8c20e46de8=
595c742aeec6064a<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202507291=
04045.27582-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg32406.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makef=
ile.am<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br>M src/openvpn/=
options.c<br>M src/openvpn/options.h<br>M src/openvpn/options_util.c<br>M s=
rc/openvpn/options_util.h<br>M src/openvpn/push.c<br>M src/openvpn/push.h<b=
r>A src/openvpn/push_util.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<b=
r>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/test=
_push_update_msg.c<br>15 files changed, 625 insertions(+), 88 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/8=
08/23</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>=
index efb2d2d..3866e21 100644</span><br><span>--- a/CMakeLists.txt</span><b=
r><span>+++ b/CMakeLists.txt</span><br><span>@@ -534,6 +534,7 @@</span><br>=
<span>     src/openvpn/ps.c</span><br><span>     src/openvpn/ps.h</span><br=
><span>     src/openvpn/push.c</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    src/openvpn/push_util.c</span><br><span>     src/openvpn/pus=
h.h</span><br><span>     src/openvpn/pushlist.h</span><br><span>     src/op=
envpn/reflect_filter.c</span><br><span>@@ -652,6 +653,7 @@</span><br><span>=
         &quot;test_provider&quot;</span><br><span>         &quot;test_ssl&=
quot;</span><br><span>         &quot;test_user_pass&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &quot;test_push_update_msg&qu=
ot;</span><br><span>         )</span><br><span> </span><br><span>     if (W=
IN32)</span><br><span>@@ -854,6 +856,14 @@</span><br><span>         src/ope=
nvpn/run_command.c</span><br><span>         )</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_push_up=
date_msg PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tests/unit_tests/openvpn/mock_msg.c</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	    src/openvpn/push_u=
til.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    src/openv=
pn/options_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 =
   src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (TARGET test_argv)</span><br><span>         target_link_o=
ptions(test_argv PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span>         =
target_sources(test_argv PRIVATE</span><br><span>diff --git a/src/openvpn/M=
akefile.am b/src/openvpn/Makefile.am</span><br><span>index a5d4cdc..1e17c3f=
 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b=
/src/openvpn/Makefile.am</span><br><span>@@ -117,7 +117,7 @@</span><br><spa=
n> 	proto.c proto.h \</span><br><span> 	proxy.c proxy.h \</span><br><span> =
	ps.c ps.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	push.c p=
ush.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push.c push=
_util.c push.h \</span><br><span> 	pushlist.h \</span><br><span> 	reflect_f=
ilter.c reflect_filter.h \</span><br><span> 	reliable.c reliable.h \</span>=
<br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span>=
<br><span>index dfc6708..475d142 100644</span><br><span>--- a/src/openvpn/f=
orward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -20=
64,7 +2064,7 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   /* check for incoming control messages on the control channel like</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * push request/reply, =
or authentication failure and 2FA messages */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * push request/reply/update, or authenticati=
on failure and 2FA messages */</span><br><span>     if (tls_test_payload_le=
n(c-&gt;c2.tls_multi) &gt; 0)</span><br><span>     {</span><br><span>      =
   check_incoming_control_channel(c);</span><br><span>diff --git a/src/open=
vpn/init.c b/src/openvpn/init.c</span><br><span>index aac8a6a..ba1dda4 1006=
44</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openv=
pn/init.c</span><br><span>@@ -2051,8 +2051,8 @@</span><br><span>         /*=
 possibly add routes */</span><br><span>         if ((route_order(c-&gt;c1.=
tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt;options.route_delay_defi=
ned))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            int status =3D do_route(&amp;c-&gt;options, c-&gt;c1=
.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                  c-&gt;c1.tuntap, c-&gt;p=
lugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            bool status =3D do_route(&amp;c-&gt;optio=
ns, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                   c-&gt;c1.=
tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>  =
           *error_flags |=3D (status ? 0 : ISC_ROUTE_ERRORS);</span><br><sp=
an>         }</span><br><span> </span><br><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index d44c102..eb53a60 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -66,6 +66,7 @@</span><br><span> #include=
 &lt;ctype.h&gt;</span><br><span> </span><br><span> #include &quot;memdbg.h=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;options_util.h&quot;</span><br><span> </span><br><span> const char title_=
string[] =3D</span><br><span>     PACKAGE_STRING</span><br><span>@@ -948,24=
 +949,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-struct pull_filter</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define PUF_TYPE_UNDEF  0    /**&lt; undefined fi=
lter type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define P=
UF_TYPE_ACCEPT 1    /**&lt; filter type to accept a matching option */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_IGNORE 2 =
   /**&lt; filter type to ignore a matching option */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_REJECT 3    /**&lt; filter=
 type to reject and trigger SIGUSR1 */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int type;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    char *pattern;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct pull_filter *next;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-struct pull_filter_list</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct pull_filter *head;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *tail;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> #ifndef ENABLE_SMALL</span><br><span=
> </span><br><span> static const char *</span><br><span>@@ -5503,60 +5486,1=
4 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Filter an option line by all pull filters.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * If a match is found, the line is modifie=
d depending on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the =
filter type, and returns true. If the filter type is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * reject, SIGUSR1 is triggered and the ret=
urn value is false.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 In that case the caller must end the push processing.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-apply_pull_filter(const struct options *o, char *line)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct pull_filter *f;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!o-&gt;pull_filter_list)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* skip leading spaces matching the b=
ehaviour of parse_line */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    while (isspace(*line))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 line++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (f =3D o-&gt;pull_filter_list-&gt;head; f;=
 f =3D f-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (f-&gt;t=
ype =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;si=
ze) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LO=
W, &quot;Pushed option accepted by filter: &#39;%s&#39;&quot;, line);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return true;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        else if (f-&gt;type =3D=3D P=
UF_TYPE_IGNORE &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D 0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_PUSH, &quot;Pu=
shed option removed by filter: &#39;%s&#39;&quot;, line);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            *line =3D &#39;\0&#39;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            return true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        else if (f-&gt;type =3D=3D=
 PUF_TYPE_REJECT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =3D=3D=
 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
Pushed option rejected by filter: &#39;%s&#39;. Restarting.&quot;, line);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *line =3D &=
#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   throw_signal_soft(SIGUSR1, &quot;Offending option received from server&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-apply_push_options(struct options *options,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct context *c,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   s=
truct options *options,</span><br><span>                    struct buffer *=
buf,</span><br><span>                    unsigned int permission_mask,</spa=
n><br><span>                    unsigned int *option_types_found,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                   struct env_s=
et *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       struct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   bool is_update)</span><br><span> {</span><br><spa=
n>     char line[OPTION_PARM_SIZE];</span><br><span>     int line_num =3D 0=
;</span><br><span>@@ -5568,14 +5505,40 @@</span><br><span>         char *p[=
MAX_PARMS+1];</span><br><span>         CLEAR(p);</span><br><span>         +=
+line_num;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!apply_pull_filter(options, line))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        unsigned int push_update_option_flags =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int i =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* skip leading spaces matching the =
behaviour of parse_line */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        while (isspace(line[i]))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            i++;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* If we are not in a &#39;PUSH_UPDATE&#39; we just =
check `apply_pull_filter()`</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * otherwise we must call `check_push_update_option_flags()=
` first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((is_upda=
te &amp;&amp; !check_push_update_option_flags(line, &amp;i, &amp;push_updat=
e_option_flags))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         || !apply_pull_filter(options, &amp;line[i]))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* In case we are in a `PUSH_UPDATE` a=
nd `check_push_update_option_flags()`</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * or `apply_pull_filter()` fail but the opti=
on is flagged by `PUSH_OPT_OPTIONAL`,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * instead of restarting, we just ignore the =
option and we process the next one</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (push_update_option_flags &amp; PUSH_OPT_OPTIONAL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                continue=
; /* Ignoring this option */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            throw_signal_soft(SIGUSR1, &quot;Offending option received f=
rom server&quot;);</span><br><span>             return false; /* Cause push=
/pull error and stop push processing */</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (parse_line(line, p=
, SIZE(p)-1, file, line_num, msglevel, &amp;options-&gt;gc))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (parse_line(&amp;line[i], p, SIZE(p)-1, fi=
le, line_num, msglevel, &amp;options-&gt;gc))</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            add_option(o=
ptions, p, false, file, line_num, 0, msglevel,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       permission_mask, option_typ=
es_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (!is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             add_option(options, p, false, file, line_num, 0, msglevel,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    permission_mask, option_types_found, es);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><b=
r><span>     }</span><br><span>     return true;</span><br><span>diff --git=
 a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 56e8=
5d7..0544ca9 100644</span><br><span>--- a/src/openvpn/options.h</span><br><=
span>+++ b/src/openvpn/options.h</span><br><span>@@ -794,6 +794,33 @@</span=
><br><span> #define MAN_CLIENT_AUTH_ENABLED(opt) (false)</span><br><span> #=
endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * some PUSH_=
UPDATE options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_ROUTE=
           (1&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPT_P_U_ROUTE6          (1&lt;&lt;1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define OPT_P_U_DNS             (1&lt;&lt;2)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_DHCP =
           (1&lt;&lt;3)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPT_P_U_REDIR_GATEWAY   (1&lt;&lt;4)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+struct pull_filter</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P=
UF_TYPE_UNDEF  0    /**&lt; undefined filter type */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_ACCEPT 1    /**&lt; filt=
er type to accept a matching option */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define PUF_TYPE_IGNORE 2    /**&lt; filter type to igno=
re a matching option */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PUF_TYPE_REJECT 3    /**&lt; filter type to reject and trigger =
SIGUSR1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int t=
ype;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int size;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *pattern;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pull_filter=
 *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct pull_filter_list</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct pull_filter *head;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct pull_filter *tail;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> void parse_argv(struct options *options,=
</span><br><span>                 const int argc,</span><br><span>         =
        char *argv[],</span><br><span>@@ -862,11 +889,13 @@</span><br><span=
> </span><br><span> void pre_connect_restore(struct options *o, struct gc_a=
rena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool apply_push_options(struct options *options,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool apply_push_options(struct context =
*c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        struct options *options,</span><br><span>                         s=
truct buffer *buf,</span><br><span>                         unsigned int pe=
rmission_mask,</span><br><span>                         unsigned int *optio=
n_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 struct env_set *es);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        struct env_set *es,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        bool is_u=
pdate);</span><br><span> </span><br><span> void options_detach(struct optio=
ns *o);</span><br><span> </span><br><span>diff --git a/src/openvpn/options_=
util.c b/src/openvpn/options_util.c</span><br><span>index 80d0c08..d317c1a =
100644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++=
 b/src/openvpn/options_util.c</span><br><span>@@ -30,6 +30,8 @@</span><br><=
span> </span><br><span> #include &quot;options_util.h&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;pu=
sh.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> const char *</span><br><span> parse_auth_failed_temp(struct option=
s *o, const char *reason)</span><br><span> {</span><br><span>@@ -145,3 +147=
,116 @@</span><br><span> </span><br><span>     return (int) i;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static const char *updatable_opt=
ions[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;block-ipv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;block-outside-dns&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;dhcp-option&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;dns&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;ifconfig&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;ifconfig-ipv6&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;push-continuation&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;redir=
ect-gateway&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;redirect-private&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;route&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;route-gateway&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;route-ipv6&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;route-metric&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;topology&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;tun-mtu&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;keepalive=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_push_update_option_flags(char *line, int *i, unsigned int =
*flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    *flags =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    bool opt_is_updatable =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char c =3D =
line[*i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* We check for &#39;?&#3=
9; and &#39;-&#39; and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * if they are present we skip them.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (c =3D=3D &#39;-&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!(line)[*i + 1])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *flags |=3D PUSH_OPT_TO_REMOVE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        c =3D (line)[++(*i)];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (c =3D=3D &#39;?&#39;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!(line)[*i + 1] || (line)[*i + 1] =3D=3D &#39;-=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *flags |=3D PUSH_OP=
T_OPTIONAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
c =3D (line)[++(*i)];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(&amp;=
line[*i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int c=
ount =3D sizeof(updatable_options)/sizeof(char *);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int j =3D 0; j &lt; count; ++j)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        size_t opt_len =3D strlen(upd=
atable_options[j]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (len &lt; opt_len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!strncmp(&amp;line[*i], updatable_options[j], opt_len)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (!line[*i + o=
pt_len] || line[*i + opt_len] =3D=3D &#39; &#39;))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            opt_is_updatable =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!opt_is_updatable)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(*flags &amp; PUSH_OPT_OPTIONAL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_PUSH, &quot;Pushed option is not updatable: &#39;%s&#3=
9;. Ignoring.&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_W=
ARN, &quot;Pushed option is not updatable: &#39;%s&#39;. Restarting.&quot;,=
 line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+apply_pull_filter(const struc=
t options *o, char *line)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&=
gt;pull_filter_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct pull_filter *f;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D =
f-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (f-&gt;type=
 =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_L=
OW, &quot;Pushed option accepted by filter: &#39;%s&#39;&quot;, line);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (f-&gt;type =
=3D=3D PUF_TYPE_IGNORE &amp;&amp; strncmp(line, f-&gt;pattern, f-&gt;size) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PU=
SH, &quot;Pushed option removed by filter: &#39;%s&#39;&quot;, line);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *line =3D &#3=
9;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else i=
f (f-&gt;type =3D=3D PUF_TYPE_REJECT &amp;&amp; strncmp(line, f-&gt;pattern=
, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_WARN, &quot;Pushed option rejected by filter: &#39;%s&#39;.&quo=
t;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a=
/src/openvpn/options_util.h b/src/openvpn/options_util.h</span><br><span>in=
dex 2474e7f..71d51d6 100644</span><br><span>--- a/src/openvpn/options_util.=
h</span><br><span>+++ b/src/openvpn/options_util.h</span><br><span>@@ -50,4=
 +50,47 @@</span><br><span> int</span><br><span> atoi_warn(const char *str,=
 int msglevel);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Filter an option line by all pull filters.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * If a match is found, the line is modified depending on</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the filter type, and return=
s true. If the filter type is</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * reject, SIGUSR1 is triggered and the return value is false.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In that case the ca=
ller must end the push processing.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_pull_filte=
r(const struct options *o,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                  char *line);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Checks =
the formatting and validity of options inside push-update messages.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * This function is used to validate and pro=
cess options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in p=
ush-update messages. It performs the following checks:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * - Determines if the options are updat=
able.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - Checks fo=
r the presence of the `-` flag, which indicates that the option</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *   should be removed.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * - Checks for the `?` fla=
g, which marks the option as optional and suppresses</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   errors if the client cannot update i=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - Increase the=
 value pointed by &#39;i&#39; when we encounter the `&#39;-&#39;` and `&#39=
;?&#39;` flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
after validating them and updating the appropriate flags in the `flags` var=
iable.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - `-?optio=
n`, `-option`, `?option` are valid formats, `?-option` is not a valid forma=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - If the flags=
 and the option are not consecutive, the option is invalid:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *   `- ?option`, `-? option`, `- o=
ption` are invalid formats.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 line A pointer to an option string. This string is the option being valida=
ted.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param i A p=
ointer to an integer that represents the current index in the `line` string=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags A =
pointer where flags will be stored:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *              - `PUSH_OPT_TO_REMOVE`: Set if the `-` flag=
 is present.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
         - `PUSH_OPT_OPTIONAL`: Set if the `?` flag is present.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true if the flags and option combinat=
ion are valid.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn false if:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
       - The `-` and `?` flags are not formatted correctly.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *         - The `line` parameter i=
s empty or `NULL`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*         - The `?` flag is absent and the option is not updatable.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_push_update_option_flags(char *line, int *i, unsig=
ned int *flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #endif /* ifndef OPTIONS_UTIL_H_ */</span><br><span>diff --g=
it a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index ad8fa3d7=
..858b821 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+=
++ b/src/openvpn/push.c</span><br><span>@@ -39,8 +39,6 @@</span><br><span> =
#include &quot;ssl_util.h&quot;</span><br><span> #include &quot;options_uti=
l.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static char push_reply_cmd[] =3D &quot;PUSH_REPLY&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><sp=
an>  * Auth username/password</span><br><span>  *</span><br><span>@@ -519,2=
1 +517,31 @@</span><br><span>     {</span><br><span>         msg(D_PUSH_ERR=
ORS, &quot;WARNING: Received bad push/pull message: %s&quot;, sanitize_cont=
rol_message(BSTR(buffer), &amp;gc));</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else if (status =3D=3D PUSH_MSG_R=
EPLY || status =3D=3D PUSH_MSG_CONTINUATION)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (status =3D=3D PUSH_MSG_REPLY || statu=
s =3D=3D PUSH_MSG_UPDATE || status =3D=3D PUSH_MSG_CONTINUATION)</span><br>=
<span>     {</span><br><span>         c-&gt;options.push_option_types_found=
 |=3D option_types_found;</span><br><span> </span><br><span>         /* del=
ay bringing tun/tap up until --push parms received from remote */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D PUSH_=
MSG_REPLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE)</span><br=
><span>         {</span><br><span>             if (!options_postprocess_pul=
l(&amp;c-&gt;options, c-&gt;c2.es))</span><br><span>             {</span><b=
r><span>                 goto error;</span><br><span>             }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!do_up(c, tru=
e, c-&gt;options.push_option_types_found))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (status =3D=3D PUSH_MSG_REPLY)</span>=
<br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                msg(D_PUSH_ERRORS, &quot;Failed to open tun/tap interfac=
e&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (!do_up(c, true, c-&gt;options.push_option_types_found))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(D=
_PUSH_ERRORS, &quot;Failed to open tun/tap interface&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    goto error;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                if (!option_types_found=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
msg(M_WARN, &quot;No updatable options found in incoming PUSH_UPDATE messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span>             }</span><br><span>         }</span><br=
><span>         event_timeout_clear(&amp;c-&gt;c2.push_request_interval);</=
span><br><span>@@ -1056,11 +1064,13 @@</span><br><span>             md_ctx_=
init(c-&gt;c2.pulled_options_state, &quot;SHA256&quot;);</span><br><span>  =
           c-&gt;c2.pulled_options_digest_init_done =3D true;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (apply_push_options(&amp;c-&gt;options,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (apply_push_options(c,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               &amp;c-=
&gt;options,</span><br><span>                                buf,</span><br=
><span>                                permission_mask,</span><br><span>   =
                             option_types_found,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                               c-&gt;c2.es))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
        c-&gt;c2.es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                               false))</span><br><span>         {</span><b=
r><span>             push_update_digest(c-&gt;c2.pulled_options_state, &amp=
;buf_orig,</span><br><span>                                &amp;c-&gt;optio=
ns);</span><br><span>@@ -1111,6 +1121,12 @@</span><br><span>         return=
 process_incoming_push_reply(c, permission_mask,</span><br><span>          =
                                  option_types_found, &amp;buf);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (honor_received_options</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             &amp;&amp; buf_string_compare_advance(&amp;buf, push_=
update_cmd))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return proces=
s_incoming_push_update(c, permission_mask,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                            option_t=
ypes_found, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span>     else</span><br><span>     {</span><br><span> =
        return PUSH_MSG_ERROR;</span><br><span>diff --git a/src/openvpn/pus=
h.h b/src/openvpn/push.h</span><br><span>index 048b4c4..18dfcd8 100644</spa=
n><br><span>--- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push=
.h</span><br><span>@@ -33,9 +33,42 @@</span><br><span> #define PUSH_MSG_AUT=
H_FAILURE     4</span><br><span> #define PUSH_MSG_CONTINUATION     5</span>=
<br><span> #define PUSH_MSG_ALREADY_REPLIED  6</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define PUSH_MSG_UPDATE           7</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define push_reply_cmd &quot;PUSH_REPLY&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define push_update_cmd &=
quot;PUSH_UPDATE&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Push-update o=
ptions flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine PUSH_OPT_TO_REMOVE (1&lt;&lt;0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PUSH_OPT_OPTIONAL (1&lt;&lt;1)</span><br><span> </s=
pan><br><span> int process_incoming_push_request(struct context *c);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Handles the re=
ceiving of a push-update message and applies updates to the specified optio=
ns.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This function processes a push=
-update message, validating its content and applying updates</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * to the options specified in the=
 message. It also handles split messages if the complete</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * message has not yet been received.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param c The context for the opera=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param perm=
ission_mask The permission mask specifying which options are allowed to be =
pulled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param op=
tion_types_found A pointer to a variable that will be filled with the types=
 of options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
                     found in the message.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param buf A buffer containing the received messa=
ge.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * - `PUSH_MSG_UPDATE`: The message was p=
rocessed successfully, and the updates were applied.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * - `PUSH_MSG_CONTINUATION`: The message=
 is a fragment of a larger message, and the program is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *                            waiting fo=
r the final part.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 - `PUSH_MSG_ERROR`: An error occurred during message processing, or the me=
ssage is invalid.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int process_incoming_push_update(stru=
ct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                            unsigned int permission_mask,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                 unsi=
gned int *option_types_found,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                 struct buffer *buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int process_i=
ncoming_push_msg(struct context *c,</span><br><span>                       =
        const struct buffer *buffer,</span><br><span>                      =
         bool honor_received_options,</span><br><span>diff --git a/src/open=
vpn/push_util.c b/src/openvpn/push_util.c</span><br><span>new file mode 100=
644</span><br><span>index 0000000..b4d1e8b</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -0,0 +1,44 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;co=
nfig.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;push.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+process_incoming_push_update(struct context *c,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                             unsigned =
int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                             unsigned int *option_types_found,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                             st=
ruct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D PUSH=
_MSG_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t ch =3D buf_read_u8(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ch =3D=3D &#39;,&#39;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (apply_push_options(c,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                               &amp;c-&gt;options=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
             buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             permission_mask,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                               option_types_found=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
             c-&gt;c2.es,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                               true))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            switch (c-&gt;options.push_continuation)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                case 0:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                case 1:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    ret =
=3D PUSH_MSG_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     case 2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             ret =3D PUSH_MSG_CONTINUATION;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    break;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else if (ch =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ret =3D PUSH_MSG_UPDATE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>di=
ff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 9c66=
16a..a7658dd 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span=
>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1993,6 +1993,9 @@</span><br><s=
pan>         /* support for exit notify via control channel */</span><br><s=
pan>         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* support push-u=
pdates */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        iv=
_proto |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>         if (session-&gt;opt-&gt;pull)</span=
><br><span>         {</span><br><span>             /* support for receiving=
 push_reply before sending</span><br><span>diff --git a/src/openvpn/ssl.h b=
/src/openvpn/ssl.h</span><br><span>index 000992d..0a43ea1 100644</span><br>=
<span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span=
><br><span>@@ -114,6 +114,9 @@</span><br><span> /** Supports the --dns opti=
on after all the incompatible changes */</span><br><span> #define IV_PROTO_=
DNS_OPTION_V2   (1&lt;&lt;11)</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/** Supports push-update */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define IV_PROTO_PUSH_UPDATE     (1&lt;=
&lt;12)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /* Default field in X509 to be username */</span><br><span> #define X=
509_USERNAME_FIELD_DEFAULT &quot;CN&quot;</span><br><span> </span><br><span=
>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openv=
pn/Makefile.am</span><br><span>index b47b495..b24e03c 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/un=
it_tests/openvpn/Makefile.am</span><br><span>@@ -11,7 +11,7 @@</span><br><s=
pan> endif</span><br><span> </span><br><span> test_binaries +=3D crypto_tes=
tdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_test=
driver \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	pkt_testdriv=
er ssl_testdriver user_pass_testdriver</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	pkt_testdriver ssl_testdriver user_pass_testdriver push=
_update_msg_testdriver</span><br><span> </span><br><span> if HAVE_LD_WRAP_S=
UPPORT</span><br><span> if !WIN32</span><br><span>@@ -326,3 +326,21 @@</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span> 	$(=
top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/list.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+push_update_msg_testdriver=
_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/tests/unit_tests/openvpn=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+push_update_msg_testdriver_LDFLAGS =3D \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_LDFLAGS@ \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	-L$(top_srcdir)/src/o=
penvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+push_update_msg_testdriver_SOURC=
ES =3D test_push_update_msg.c \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	mock_get_random.c \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/pus=
h_util.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/options_util.c \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c</span><br><span>\ No newl=
ine at end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000..d47286a</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_push_update_msg.c</span><br><span>@@ -0,0 +1,260 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* mocks */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+pull_permission_mask(const struct context *c)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int flags =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        OPT_P_UP</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        | OPT_P_ROUTE_EXTRAS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SOCKBUF</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SOCKFLAGS</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SETENV</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_SHAPER</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_TIMER</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_COMP</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_PERSIS=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_ME=
SSAGES</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT=
_P_EXPLICIT_NOTIFY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       | OPT_P_ECHO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        | OPT_P_PEER_ID</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        | OPT_P_NCP</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        | OPT_P_PUSH_MTU</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        | OPT_P_ROUTE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        | OPT_P_DHCPDNS;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return flags;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+apply_push_options(struct contex=
t *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     struct options *options,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   struct buffer *buf,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   unsigned int permission_mas=
k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
  unsigned int *option_types_found,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                   struct env_set *es,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   bool is_update)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_PARM_SIZE];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (buf_parse(buf, &#39;,&#39;, line, si=
zeof(line)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int =
push_update_option_flags =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int i =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (is_update || options-&gt;pull_filter_list)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            /* skip leading spaces matching the behaviou=
r of parse_line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           while (isspace(line[i]))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                i++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 ((is_update &amp;&amp; !check_push_update_option_flags(line, &amp;i, &amp;=
push_update_option_flags))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                || (options-&gt;pull_filter_list &amp;&amp; !apply_p=
ull_filter(options, &amp;line[i])))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (push_update_option_flags &amp; PUSH_OPT_OPTIO=
NAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   continue; /* Ignoring this option */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(M_WARN, &quot;Offending option receiv=
ed from server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                return false; /* Cause push/pull error and stop push pro=
cessing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * No need to test also th=
e application part here</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * (add_option/remove_option/update_option)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+process_incoming_push_msg(struct context =
*c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          const struct buffer *buffer,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                          bool honor_received_options,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
     unsigned int permission_mask,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          unsigned int *option_types_found)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buffer;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (buf_string_compare_advance(&amp;b=
uf, &quot;PUSH_REQUEST&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return PUSH_MSG_REQUEST;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (honor_received_options</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             &amp;&amp; buf_string_compare_advance(&amp;buf, pu=
sh_reply_cmd))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return PUSH=
_MSG_REPLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (honor_rec=
eived_options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       &amp;&amp; buf_string_compare_advance(&amp;buf, push_update_cmd))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return process_incoming_push=
_update(c, permission_mask,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                            option_types_found, &am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return PUSH_MSG_ERROR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* tests */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_incoming_push_message_basic(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D =
alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *update_msg =3D &quot;PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route=
 0.0.0.0 0.0.0.0 10.10.10.1&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option=
_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permissio=
n_mask(c), &amp;option_types_found), PUSH_MSG_UPDATE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_messag=
e_error1(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cont=
ext *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATEerr,dh=
cp-option DNS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types=
_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(proc=
ess_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask=
(c), &amp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_incoming_push_message_error2(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D=
 alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *update_msg =3D &quot;PUSH_UPDATE ,dhcp-option DNS 8.8.8.8&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&am=
p;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, &=
amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_fou=
nd), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp=
;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_incoming_push_message_1(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(256=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *u=
pdate_msg =3D &quot;PUSH_UPDATE, -?dns, route something, ?dhcp-option DNS 8=
.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_pu=
sh_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;optio=
n_types_found), PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_incoming_push_message_bad_format(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *update_msg =3D &quot;PUSH_UPDATE, -dhcp-option, ?-dns&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(=
&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c=
, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_=
found), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_incoming_push_message_not_updatable_option(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *stat=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *update_msg =3D &quot;PUSH_UPDATE, dev tun&quot;;</span=
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
 40%);">+test_incoming_push_message_mix(void **state)</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VzoBluhBblc=--

