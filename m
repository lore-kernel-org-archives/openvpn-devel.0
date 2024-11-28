From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 15:57:01 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <f030b95ab52f0158b5726115d61200e6cea5e897-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e8b2q1CntmI="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--e8b2q1CntmI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail

to look at the new patch set (#6).


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
15 files changed, 643 insertions(+), 112 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/808/6

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..cbce2a1 100644
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
=20
     if (WIN32)
@@ -808,6 +810,14 @@
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
index 6ab92e2..253ddc3 100644
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
index a9e020a..405f023 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -30,6 +30,8 @@

 #include "options_util.h"

+#include "push.h"
+
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {
@@ -98,3 +100,174 @@
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
+/**
+ * @brief Checks the formatting and validity of options inside push-update=
 messages.
+ *
+ * This function is used in `apply_pull_filter()` to validate and process =
options
+ * in push-update messages. It performs the following checks:
+ * - Determines if the options are updatable.
+ * - Checks for the presence of the `-` flag, which indicates that the opt=
ion
+ *   should be removed.
+ * - Checks for the `?` flag, which marks the option as optional and suppr=
esses
+ *   errors if the client cannot update it.
+ * - Modifies the original string (`*line`) by removing the `'-'` and `'?'=
` flags
+ *   after validating them and updating the appropriate flags in the `flag=
s` variable.
+ * - `-?option`, `-option`, `?option` are valid formats, `?-option` is not=
 a valid format.
+ *
+ * @param line A pointer to an option string. This string is the option be=
ing validated.
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
+    if (c =3D=3D '-')
+    {
+        if (!(str)[1])
+        {
+            return false;
+        }
+        *flags |=3D PUSH_OPT_TO_REMOVE;
+        c =3D *(++(str));
+    }
+    if (c =3D=3D '?')
+    {
+        if (!(str)[1] || (str)[1] =3D=3D '-')
+        {
+            return false;
+        }
+        *flags |=3D PUSH_OPT_OPTIONAL;
+        c =3D *(++(str));
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
index 29bc9dc..0825bfa 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -30,4 +30,18 @@
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason);

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
index 4a13327..b930c6c 100644
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
index 0000000..d0876bc
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
Gerrit-PatchSet: 6
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--e8b2q1CntmI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>mrbff <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">PUSH_UPDATE: Allow OpenVPN in client mode to receive and handle PUSH UPDA=
TE control messages to allow options updating at runtime.<br><br>* Added IV=
_PROTO_PUSH_UPDATE flag bit to support push-updates.<br>* Added process_inc=
oming_push_update(), in a separate file to create tests more easily.<br>* M=
odified incoming_push_message(), process_incoming_push_msg(), apply_push_op=
tions(),<br>  apply_pull_filter() to process also push-update messages.<br>=
* Added the check_push_update_option_flags() function used in apply_pull_fi=
lter() to<br>  check options formatting inside push-update messages, if the=
 options are updatables<br>  and to check for &#39;?&#39; and &#39;-&#39; f=
lags that may be present in front of the options.<br>  The &#39;-&#39; flag=
 is used to indicate that the option in question should be removed,<br>  wh=
ile the &#39;?&#39; indicates that the option is optional and to do not gen=
erate<br>  errors if the client cannot update that option.<br>  For more in=
fo you can read the RFC at https://github.com/OpenVPN/openvpn-rfc .<br>* Cr=
eated some unit tests for the push-update message handling in test_push_upd=
ate_msg.c.<br><br>Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a<br>S=
igned-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M CMakeLists.t=
xt<br>M src/openvpn/Makefile.am<br>M src/openvpn/forward.c<br>M src/openvpn=
/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/open=
vpn/options_util.c<br>M src/openvpn/options_util.h<br>M src/openvpn/push.c<=
br>M src/openvpn/push.h<br>A src/openvpn/push_util.c<br>M src/openvpn/ssl.c=
<br>M src/openvpn/ssl.h<br>M tests/unit_tests/openvpn/Makefile.am<br>A test=
s/unit_tests/openvpn/test_push_update_msg.c<br>15 files changed, 643 insert=
ions(+), 112 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/08/808/6</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeL=
ists.txt</span><br><span>index 5db207d..cbce2a1 100644</span><br><span>--- =
a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -4=
96,6 +496,7 @@</span><br><span>     src/openvpn/ps.c</span><br><span>     s=
rc/openvpn/ps.h</span><br><span>     src/openvpn/push.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/push_util.c</span><br><=
span>     src/openvpn/push.h</span><br><span>     src/openvpn/pushlist.h</s=
pan><br><span>     src/openvpn/reflect_filter.c</span><br><span>@@ -612,6 +=
613,7 @@</span><br><span>         &quot;test_provider&quot;</span><br><span=
>         &quot;test_ssl&quot;</span><br><span>         &quot;test_user_pas=
s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;test_push_update_msg&quot;</span><br><span>         )</span><br><span> </=
span><br><span>     if (WIN32)</span><br><span>@@ -808,6 +810,14 @@</span><=
br><span>         src/openvpn/run_command.c</span><br><span>         )</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ta=
rget_sources(test_push_update_msg PRIVATE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_msg.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/open=
vpn/mock_get_random.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	    src/openvpn/push_util.c</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	    src/openvpn/options_util.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	    src/openvpn/otime.c</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     if (TARGET test_argv)</span><br><sp=
an>         target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)<=
/span><br><span>         target_sources(test_argv PRIVATE</span><br><span>d=
iff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><sp=
an>index ecb2bcf..55ec565 100644</span><br><span>--- a/src/openvpn/Makefile=
.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -114,7=
 +114,7 @@</span><br><span> 	proto.c proto.h \</span><br><span> 	proxy.c pr=
oxy.h \</span><br><span> 	ps.c ps.h \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	push.c push.h \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	push.c push_util.c push.h \</span><br><span> 	pushlist.h \</s=
pan><br><span> 	reflect_filter.c reflect_filter.h \</span><br><span> 	relia=
ble.c reliable.h \</span><br><span>diff --git a/src/openvpn/forward.c b/src=
/openvpn/forward.c</span><br><span>index d50b24c..2c75953 100644</span><br>=
<span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward=
.c</span><br><span>@@ -2031,7 +2031,7 @@</span><br><span>     }</span><br><=
span> </span><br><span>     /* check for incoming control messages on the c=
ontrol channel like</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * push request/reply, or authentication failure and 2FA messages */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * push request/repl=
y/update, or authentication failure and 2FA messages */</span><br><span>   =
  if (tls_test_payload_len(c-&gt;c2.tls_multi) &gt; 0)</span><br><span>    =
 {</span><br><span>         check_incoming_control_channel(c);</span><br><s=
pan>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>in=
dex 9371024..f8d9d06 100644</span><br><span>--- a/src/openvpn/init.c</span>=
<br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2030,8 +2030,8 @@</s=
pan><br><span>         /* possibly add routes */</span><br><span>         i=
f ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt=
;options.route_delay_defined))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            int status =3D do_route(&am=
p;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
 c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            bool status =3D =
do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net=
_ctx);</span><br><span>             *error_flags |=3D (status ? 0 : ISC_ROU=
TE_ERRORS);</span><br><span>         }</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex 043b240..6f97fcd 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -63,6 +63,7 @@<=
/span><br><span> #include &lt;ctype.h&gt;</span><br><span> </span><br><span=
> #include &quot;memdbg.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;options_util.h&quot;</span><br><span> </span><br=
><span> const char title_string[] =3D</span><br><span>     PACKAGE_STRING</=
span><br><span>@@ -927,24 +928,6 @@</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
truct pull_filter</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_UNDEF  =
0    /**&lt; undefined filter type */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define PUF_TYPE_ACCEPT 1    /**&lt; filter type to accept =
a matching option */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define PUF_TYPE_IGNORE 2    /**&lt; filter type to ignore a matching option=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PUF_TYPE_R=
EJECT 3    /**&lt; filter type to reject and trigger SIGUSR1 */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int type;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    char *pattern;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct pull_filter *next;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct p=
ull_filter_list</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *he=
ad;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct pull_fi=
lter *tail;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifndef ENA=
BLE_SMALL</span><br><span> </span><br><span> static const char *</span><br>=
<span>@@ -5469,84 +5452,6 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Filter an option line b=
y all pull filters.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If a match is foun=
d, the line is modified depending on</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * the filter type, and returns true. If the filter type is<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * reject, SIGUSR1 is =
triggered and the return value is false.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * In that case the caller must end the push processing.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-apply_pull_filter(const struct options *o, char *=
line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct pull_filter *f;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!o-&gt;pull_filter_list)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* skip leading =
spaces matching the behaviour of parse_line */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    while (isspace(*line))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        line++;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (f =3D o-&gt;pull_f=
ilter_list-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (f-&gt;type =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strncmp(line, =
f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_LOW, &quot;Pushed option accepted by filter: &#39;%s&#=
39;&quot;, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else =
if (f-&gt;type =3D=3D PUF_TYPE_IGNORE &amp;&amp; strncmp(line, f-&gt;patter=
n, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(D_PUSH, &quot;Pushed option removed by filter: &#39;%s&#39;&quot;, l=
ine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *lin=
e =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e if (f-&gt;type =3D=3D PUF_TYPE_REJECT &amp;&amp; strncmp(line, f-&gt;patt=
ern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_WARN, &quot;Pushed option rejected by filter: &#39;%s&#39;. Rest=
arting.&quot;, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            *line =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            throw_signal_soft(SIGUSR1, &quot;Offending option=
 received from server&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return false;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-appl=
y_push_options(struct options *options,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                   struct buffer *buf,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                   unsigned int permissi=
on_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
      unsigned int *option_types_found,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                   struct env_set *es)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    char line[OPTION_PARM_SIZE];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int line_num =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    const char *file =3D &quot;[PUSH-OPTIONS]&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ms=
glevel =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whil=
e (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        char *p[MAX_PARMS+1];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        CLEAR(p);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        ++line_num;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!apply_pull_filter(options, line))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return false; /* Cause push/pul=
l error and stop push processing */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &amp=
;options-&gt;gc))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            add_=
option(options, p, false, file, line_num, 0, msglevel,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                       permission_mask, op=
tion_types_found, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> options_serv=
er_import(struct options *o,</span><br><span>                       const c=
har *filename,</span><br><span>@@ -5680,6 +5585,44 @@</span><br><span>     =
return options-&gt;forward_compatible ? M_WARN : msglevel;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_opt=
ions(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   struct options *options,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   struct buffer *buf,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                   unsigned =
int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   struct env_set *es,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                   boo=
l is_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_PARM=
_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int line=
_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse(buf, &#39;,&#39;,=
 line, sizeof(line)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char=
 *p[MAX_PARMS+1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ++line_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    unsigned int push_update_option_flags =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (!apply_pull_filter(options, line, is_update, &amp;pus=
h_update_option_flags))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      throw_signal_soft(SIGUSR1, &quot;Offending option received from serve=
r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return false; /* Cause push/pull error and stop push processing */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (parse_line(line, p, SIZE=
(p)-1, file, line_num, msglevel, &amp;options-&gt;gc))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!is_update)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                add_option(options, p, false, f=
ile, line_num, 0, msglevel,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           permission_mask, option_types_found, es)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static void</span><br><span> set_user_script(struct=
 options *options,</span><br><span>                 const char **script,</s=
pan><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</s=
pan><br><span>index 6ab92e2..253ddc3 100644</span><br><span>--- a/src/openv=
pn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@=
 -777,6 +777,33 @@</span><br><span> #define MAN_CLIENT_AUTH_ENABLED(opt) (f=
alse)</span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * some PUSH_UPDATE options</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OPT_P_U_ROUTE           (1&lt;&lt;0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define OPT_P_U_ROUTE6          (1&lt;&lt;1)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_U_DNS   =
          (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OPT_P_U_DHCP            (1&lt;&lt;3)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define OPT_P_U_REDIR_GATEWAY   (1&lt;&lt;4)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct pull_filter</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PUF_TYPE_UNDEF  0    /**&lt; undefined filter type =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_=
ACCEPT 1    /**&lt; filter type to accept a matching option */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define PUF_TYPE_IGNORE 2    /**=
&lt; filter type to ignore a matching option */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define PUF_TYPE_REJECT 3    /**&lt; filter typ=
e to reject and trigger SIGUSR1 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int type;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *pattern;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct pull_filter *next;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct pull_filter_list<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct pull_filter *head;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct pull_filter *tail=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void parse_argv(s=
truct options *options,</span><br><span>                 const int argc,</s=
pan><br><span>                 char *argv[],</span><br><span>@@ -845,11 +87=
2,13 @@</span><br><span> </span><br><span> void pre_connect_restore(struct =
options *o, struct gc_arena *gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool apply_push_options(struct options *opt=
ions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool apply_pus=
h_options(struct context *c,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        struct options *options,</span><br><span> =
                        struct buffer *buf,</span><br><span>               =
          unsigned int permission_mask,</span><br><span>                   =
      unsigned int *option_types_found,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        struct env_set *es);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        struct e=
nv_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                bool is_update);</span><br><span> </span><br><span> void op=
tions_detach(struct options *o);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/options_util.c b/src/openvpn/options_util.c</span><br><spa=
n>index a9e020a..405f023 100644</span><br><span>--- a/src/openvpn/options_u=
til.c</span><br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -=
30,6 +30,8 @@</span><br><span> </span><br><span> #include &quot;options_uti=
l.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;push.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> const char *</span><br><span> parse_auth_=
failed_temp(struct options *o, const char *reason)</span><br><span> {</span=
><br><span>@@ -98,3 +100,174 @@</span><br><span>     gc_free(&amp;gc);</spa=
n><br><span>     return message;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *updatable_options[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;block-ipv6&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;block-outside-dns=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dh=
cp-option&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;dns&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;ifconfig&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;ifconfig-ipv6&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;push-continuation&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;redirect-gateway&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;redirect-private&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;route&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;rout=
e-gateway&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;route-ipv6&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;route-metric&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;topology&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;tun-mtu&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;keepalive&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Checks t=
he formatting and validity of options inside push-update messages.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * This function is used in `apply_pull_filte=
r()` to validate and process options</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * in push-update messages. It performs the following chec=
ks:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - Determines =
if the options are updatable.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * - Checks for the presence of the `-` flag, which indicates tha=
t the option</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   sh=
ould be removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
- Checks for the `?` flag, which marks the option as optional and suppresse=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   errors if the=
 client cannot update it.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * - Modifies the original string (`*line`) by removing the `&#39;-&#=
39;` and `&#39;?&#39;` flags</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *   after validating them and updating the appropriate flags in t=
he `flags` variable.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * - `-?option`, `-option`, `?option` are valid formats, `?-option` is not=
 a valid format.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line A poi=
nter to an option string. This string is the option being validated.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags A pointer =
where flags will be stored:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *              - `PUSH_OPT_TO_REMOVE`: Set if the `-` flag is pres=
ent.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
 - `PUSH_OPT_OPTIONAL`: Set if the `?` flag is present.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return true if the flags and option combination are =
valid.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return fa=
lse if:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         -=
 The `-` and `?` flags are not formatted correctly.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         - The `line` parameter is empt=
y or `NULL`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
    - The `?` flag is absent and the option is not updatable.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+check_push_update_option_flags(char **line, unsigned int =
*flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!line || !*line || !**=
line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    *flags =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool opt_is_updatable =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *str =3D *line;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char c =3D **li=
ne;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (c =3D=3D &#39;-&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!(str)[1])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *flags |=3D PUSH_OPT_TO_REMOVE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        c =3D *(++(str));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (c =3D=3D &#39;?&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!(str)[1] || (str)[1] =3D=3D =
&#39;-&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *flags |=3D P=
USH_OPT_OPTIONAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      c =3D *(++(str));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip &#39;?&#39; and &=
#39;-&#39; if they are present */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t len =3D strlen(str);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    memmove(*line, str, len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    (*line)[len] =3D &#39;\0&#39;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    str =3D *line;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int count =3D sizeof(updatable_options)/=
sizeof(char *);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; count; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        size_t opt_len =3D strlen(updatable_options[i]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (len &lt; opt_len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(str, updatable_optio=
ns[i], opt_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &amp;&amp; (!str[opt_len] || str[opt_len] =3D=3D &#39; &#39;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            opt_is_updatable =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!opt_is_updatable)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (*flags &amp; PUSH_OPT_OPTIONAL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_PUSH, &quot;Pushed option is not =
updatable: &#39;%s&#39;&quot;, *line);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_WARN, &quot;Pushed option is not updatable: &#39;%s&#39;. Re=
starting.&quot;, *line);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_pull_f=
ilter(const struct options *o, char *line, bool is_update, unsigned int *pu=
sh_update_option_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pul=
l_filter *f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;pull_filter=
_list &amp;&amp; !(is_update))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* skip leading spaces matching=
 the behaviour of parse_line */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (isspace(*line))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        line++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (is_update)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!check_push_update_option_flags(&am=
p;line, push_update_option_flags))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!o-&gt;pull_filter_list)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (f =3D o-&gt;pull_filt=
er_list-&gt;head; f; f =3D f-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (f-&gt;type =3D=3D PUF_TYPE_ACCEPT &amp;&amp; strncmp(line,=
 f-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_LOW, &quot;Pushed option accepted by filter: &#39=
;%s&#39;&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else if (f-&gt;type =3D=3D PUF_TYPE_IGNORE &amp;&amp; strncmp(line, f=
-&gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_PUSH, &quot;Pushed option removed by filter: &#39;%=
s&#39;&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else if (f-&gt;type =3D=3D PUF_TYPE_REJECT &amp;&amp; strncmp(line, f-&=
gt;pattern, f-&gt;size) =3D=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (is_update &amp;&amp; (*push_update_option_flags &amp; P=
USH_OPT_OPTIONAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(D_PUSH, &quot;Pushed option removed by filter: &#39;%s&#39;&qu=
ot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  msg(M_WARN, &quot;Pushed option rejected by filter: &#39;%s&#39;. Restart=
ing.&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff -=
-git a/src/openvpn/options_util.h b/src/openvpn/options_util.h</span><br><s=
pan>index 29bc9dc..0825bfa 100644</span><br><span>--- a/src/openvpn/options=
_util.h</span><br><span>+++ b/src/openvpn/options_util.h</span><br><span>@@=
 -30,4 +30,18 @@</span><br><span> const char *</span><br><span> parse_auth_=
failed_temp(struct options *o, const char *reason);</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Filter an option line by all pull filt=
ers.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * If a match is found, the line=
 is modified depending on</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * the filter type, and returns true. If the filter type is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * reject, SIGUSR1 is trigger=
ed and the return value is false.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * In that case the caller must end the push processing.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+apply_pull_filter(const struct options *o,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                  char *line,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  bool=
 is_update,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
          unsigned int *push_update_option_flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #endif</span><br><span>dif=
f --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 6c0=
6374..71a0372 100644</span><br><span>--- a/src/openvpn/push.c</span><br><sp=
an>+++ b/src/openvpn/push.c</span><br><span>@@ -39,8 +39,6 @@</span><br><sp=
an> #include &quot;ssl_util.h&quot;</span><br><span> #include &quot;options=
_util.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static char push_reply_cmd[] =3D &quot;PUSH_REPLY&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br=
><span>  * Auth username/password</span><br><span>  *</span><br><span>@@ -5=
19,21 +517,31 @@</span><br><span>     {</span><br><span>         msg(D_PUSH=
_ERRORS, &quot;WARNING: Received bad push/pull message: %s&quot;, sanitize_=
control_message(BSTR(buffer), &amp;gc));</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (status =3D=3D PUSH_M=
SG_REPLY || status =3D=3D PUSH_MSG_CONTINUATION)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (status =3D=3D PUSH_MSG_REPLY || s=
tatus =3D=3D PUSH_MSG_UPDATE || status =3D=3D PUSH_MSG_CONTINUATION)</span>=
<br><span>     {</span><br><span>         c-&gt;options.push_option_types_f=
ound |=3D option_types_found;</span><br><span> </span><br><span>         /*=
 delay bringing tun/tap up until --push parms received from remote */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D P=
USH_MSG_REPLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE)</span=
><br><span>         {</span><br><span>             if (!options_postprocess=
_pull(&amp;c-&gt;options, c-&gt;c2.es))</span><br><span>             {</spa=
n><br><span>                 goto error;</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!do_up(c,=
 true, c-&gt;options.push_option_types_found))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (status =3D=3D PUSH_MSG_REPLY)</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msg(D_PUSH_ERRORS, &quot;Failed to open tun/tap inte=
rface&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (!do_up(c, true, c-&gt;options.push_option_types_found))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
sg(D_PUSH_ERRORS, &quot;Failed to open tun/tap interface&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    goto error=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (!option_types_f=
ound)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    msg(M_WARN, &quot;No option found&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span>             }<=
/span><br><span>         }</span><br><span>         event_timeout_clear(&am=
p;c-&gt;c2.push_request_interval);</span><br><span>@@ -1048,11 +1056,13 @@<=
/span><br><span>             md_ctx_init(c-&gt;c2.pulled_options_state, &qu=
ot;SHA256&quot;);</span><br><span>             c-&gt;c2.pulled_options_dige=
st_init_done =3D true;</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (apply_push_options(&amp;c-&gt;optio=
ns,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (appl=
y_push_options(c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                             &amp;c-&gt;options,</span><br><span>          =
                      buf,</span><br><span>                                =
permission_mask,</span><br><span>                                option_typ=
es_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                   c-&gt;c2.es))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                               c-&gt;c2.es,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                               false))=
</span><br><span>         {</span><br><span>             push_update_digest=
(c-&gt;c2.pulled_options_state, &amp;buf_orig,</span><br><span>            =
                    &amp;c-&gt;options);</span><br><span>@@ -1103,6 +1113,1=
2 @@</span><br><span>         return process_incoming_push_reply(c, permiss=
ion_mask,</span><br><span>                                            optio=
n_types_found, &amp;buf);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (honor_received_options</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; buf_st=
ring_compare_advance(&amp;buf, push_update_cmd))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return process_incoming_push_update(c, permission_ma=
sk,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                            option_types_found, &amp;buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else</spa=
n><br><span>     {</span><br><span>         return PUSH_MSG_ERROR;</span><b=
r><span>diff --git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><spa=
n>index 4a13327..b930c6c 100644</span><br><span>--- a/src/openvpn/push.h</s=
pan><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -33,9 +33,42 @@</=
span><br><span> #define PUSH_MSG_AUTH_FAILURE     4</span><br><span> #defin=
e PUSH_MSG_CONTINUATION     5</span><br><span> #define PUSH_MSG_ALREADY_REP=
LIED  6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUSH=
_MSG_UPDATE           7</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define push_re=
ply_cmd &quot;PUSH_REPLY&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define push_update_cmd &quot;PUSH_UPDATE&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Push-update options flags */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PUSH_OPT_TO_REMOVE (1&lt;&lt;0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PUSH_OPT_OPTI=
ONAL (1&lt;&lt;1)</span><br><span> </span><br><span> int process_incoming_p=
ush_request(struct context *c);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @brief Handles the receiving of a push-update message and =
applies updates to the specified options.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * This function processes a push-update message, validating its conte=
nt and applying updates</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * to the options specified in the message. It also handles split messa=
ges if the complete</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * message has not yet been received.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param c The context for the operation.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param permission_mask The permission mask speci=
fying which options are allowed to be pulled.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param option_types_found A pointer to a varia=
ble that will be filled with the types of options</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *                           found in the mes=
sage.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf =
A buffer containing the received message.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -=
 `PUSH_MSG_UPDATE`: The message was processed successfully, and the updates=
 were applied.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - =
`PUSH_MSG_CONTINUATION`: The message is a fragment of a larger message, and=
 the program is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
                          waiting for the final part.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * - `PUSH_MSG_ERROR`: An error occurred =
during message processing, or the message is invalid.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt process_incoming_push_update(struct context *c,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 unsigned in=
t permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                unsigned int *option_types_found,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
    struct buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> int process_incoming_push_msg(struct context *c,</sp=
an><br><span>                               const struct buffer *buffer,</s=
pan><br><span>                               bool honor_received_options,</=
span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util=
.c</span><br><span>new file mode 100644</span><br><span>index 0000000..b4d1=
e8b</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/push_ut=
il.c</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;push.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_push_update(s=
truct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                           unsigned int permission_mask,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                             unsigned =
int *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                             struct buffer *buf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int ret =3D PUSH_MSG_ERROR;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t ch =3D buf_read_u8(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ch =3D=3D &#39;,=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (apply_push_opti=
ons(c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                  &amp;c-&gt;options,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                               buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               permission=
_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                  option_types_found,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                               c-&gt;c2.es,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                               tr=
ue))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            switch (c-&gt=
;options.push_continuation)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                case 0:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                case 1:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    ret =3D PUSH_MSG_UPDATE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                case 2:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    ret =3D PUSH_MSG_CONTINUATIO=
N;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (ch =3D=3D &#39;\0&#39;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ret =3D PUSH_MSG_UPDATE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvp=
n/ssl.c</span><br><span>index 1f8eb1e..4b621f1 100644</span><br><span>--- a=
/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>=
@@ -1947,6 +1947,9 @@</span><br><span>         /* support for exit notify v=
ia control channel */</span><br><span>         iv_proto |=3D IV_PROTO_CC_EX=
IT_NOTIFY;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* support push-updates */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        iv_proto |=3D IV_PROTO_PUSH_UPDATE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         i=
f (session-&gt;opt-&gt;pull)</span><br><span>         {</span><br><span>   =
          /* support for receiving push_reply before sending</span><br><spa=
n>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index =
eea1323..53b7f2c 100644</span><br><span>--- a/src/openvpn/ssl.h</span><br><=
span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -110,6 +110,9 @@</span><br>=
<span> /** Supports the --dns option after all the incompatible changes */<=
/span><br><span> #define IV_PROTO_DNS_OPTION_V2   (1&lt;&lt;11)</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Supports =
push-update */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne IV_PROTO_PUSH_UPDATE     (1&lt;&lt;12)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /* Default field in X509 to be user=
name */</span><br><span> #define X509_USERNAME_FIELD_DEFAULT &quot;CN&quot;=
</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index a4e6=
235..ac2241e 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=
.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><s=
pan>@@ -11,7 +11,7 @@</span><br><span> endif</span><br><span> </span><br><s=
pan> test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_t=
estdriver ncp_testdriver misc_testdriver \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	pkt_testdriver ssl_testdriver user_pass_testdriver</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	pkt_testdriver ssl_te=
stdriver user_pass_testdriver push_update_msg_testdriver</span><br><span> <=
/span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><=
br><span>@@ -307,3 +307,21 @@</span><br><span> 	$(top_srcdir)/src/openvpn/w=
in32-util.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/list.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/sr=
c/compat \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_=
srcdir)/tests/unit_tests/openvpn \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_upda=
te_msg_testdriver_LDFLAGS =3D \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	@TEST_LDFLAGS@ \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	-L$(top_srcdir)/src/openvpn</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
push_update_msg_testdriver_SOURCES =3D test_push_update_msg.c \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src=
/openvpn/platform.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/push_util.c \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/options_util.c \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/o=
time.c</span><br><span>\ No newline at end of file</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/ope=
nvpn/test_push_update_msg.c</span><br><span>new file mode 100644</span><br>=
<span>index 0000000..d0876bc</span><br><span>--- /dev/null</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -0=
,0 +1,245 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;set=
jmp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;push.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;options_util.h&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* mocks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+pull_permission_mask(const struct=
 context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OPT_P_UP=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_ROU=
TE_EXTRAS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        | =
OPT_P_SOCKBUF</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        | OPT_P_SETENV</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        | OPT_P_SHAPER</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        | OPT_P_TIMER</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        | OPT_P_COMP</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        | OPT_P_PERSIST</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        | OPT_P_MESSAGES</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        | OPT_P_EXPLICIT_NOTIFY</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        | OPT_P_ECHO</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        | OPT_P_PULL_MODE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_PEER_ID</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_NCP</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_PUSH_MTU</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_ROUTE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        | OPT_P_DHCPDNS;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return flags;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
apply_push_options(struct context *c,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   struct options *options,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   struct buffer =
*buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     unsigned int permission_mask,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                   unsigned int *option_types_found,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                   struct e=
nv_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
           bool is_update)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char li=
ne[OPTION_PARM_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (buf_pa=
rse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        unsigned int push_update_option_flags =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!apply_pull_filter(options, line, is_upd=
ate, &amp;push_update_option_flags))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_WARN, &quot;Offending option received from server&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * No need to tes=
t also the application part here</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * (add_option/remove_option/update_option)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+process_incoming_push_msg(struct =
context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                  const struct buffer *buffer,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                          bool honor_received_op=
tions,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
             unsigned int permission_mask,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                          unsigned int *option_types=
_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *buf=
fer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (buf_string_compare_advance=
(&amp;buf, &quot;PUSH_REQUEST&quot;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return PUSH_MSG_REQUEST;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (honor_received_options</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             &amp;&amp; buf_string_compare_advance(&amp;=
buf, push_reply_cmd))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn PUSH_MSG_REPLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (ho=
nor_received_options</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             &amp;&amp; buf_string_compare_advance(&amp;buf, push_update_c=
md))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return process_incomi=
ng_push_update(c, permission_mask,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                            option_types_fou=
nd, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return PUSH_MSG_ERROR;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* tests =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_incoming_push_message_basic(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *update_msg =3D &quot;PUSH_UPDATE,dhcp-option DNS 8.8.8.8, =
route 0.0.0.0 0.0.0.0 10.10.10.1&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int o=
ption_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_perm=
ission_mask(c), &amp;option_types_found), PUSH_MSG_UPDATE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_m=
essage_error1(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 context *c =3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer buf =3D alloc_buf(256);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATEe=
rr,dhcp-option DNS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    buf_write(&amp;buf, update_msg, strlen(update_msg));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_=
types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission=
_mask(c), &amp;option_types_found), PUSH_MSG_ERROR);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_incoming_push_message_error2(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *update_msg =3D &quot;PUSH_UPDATE ,dhcp-option DNS 8.8.8.8&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write=
(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(=
c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types=
_found), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(=
&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_incoming_push_message_1(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *update_msg =3D &quot;PUSH_UPDATE, -?dns, route something, ?dhcp-option D=
NS 8.8.8.8&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_incomin=
g_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;o=
ption_types_found), PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_incoming_push_message_bad_format(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *=
state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE, -dhcp-option, ?-=
dns&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_w=
rite(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_pus=
h_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option=
_types_found), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fre=
e_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_incoming_push_message_not_updatable_option(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =
=3D *state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer buf =3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *update_msg =3D &quot;PUSH_UPDATE, dev tun&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&a=
mp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, =
&amp;buf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_fo=
und), PUSH_MSG_ERROR);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_incoming_push_message_mix(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(=
256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *update_msg =3D &quot;PUSH_UPDATE,-dhcp-option, route 10.10.10.0, dhcp-opt=
ion DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.local, keepalive=
 10 60&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
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
olor: hsl(120, 100%, 40%);">+test_incoming_push_message_mix2(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D *state;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *update_msg =3D &quot;PUSH_UPDATE,-dhcp-option,dhcp-option D=
NS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf=
, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(process_incoming_push_msg(c, &amp;b=
uf, c-&gt;options.pull, pull_permission_mask(c), &amp;option_types_found), =
PUSH_MSG_UPDATE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+setup(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct context *c =3D calloc(1, sizeof(struct context));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options.pull =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options.route_nop=
ull =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *=
state =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+teardown(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct context *c =3D *state;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free(c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_pu=
sh_message_basic, setup, teardown),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_=
message_error1, setup, teardown),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_me=
ssage_error2, setup, teardown),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_mess=
age_not_updatable_option, setup, teardown),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incomi=
ng_push_message_1, setup, teardown),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push=
_message_bad_format, setup, teardown),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_pu=
sh_message_mix, setup, teardown),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test_setup_teardown(test_incoming_push_me=
ssage_mix2, setup, teardown)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_g=
roup_tests(tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--e8b2q1CntmI=--

