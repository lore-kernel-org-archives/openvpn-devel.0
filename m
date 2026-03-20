From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 20 Mar 2026 13:53:48 +0000
References: <gerrit.1774014824000.I8ca07e2bbb5de229204191d61e90f084a58969af@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <c94264b603046f3642b32cbdc9a05d4086719079-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gduuYDCuyjg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change type of
 option flag from unsigned int to uint64_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gduuYDCuyjg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1583?usp=3Demail )


Change subject: Change type of option flag from unsigned int to uint64_t
......................................................................

Change type of option flag from unsigned int to uint64_t

We currently use all 32 bits of the unsigned int for option classes.
While we can probably can retire 2-3 of the existing options, at some
point we will hit the limit again.

Instead of fully rewriting this logic to use a different approach or
structure, changing the type from unsigned int to uint64_t seem to be
a lot less intrusive approach.

Change-Id: I8ca07e2bbb5de229204191d61e90f084a58969af
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_parse.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/push_util.c
M tests/unit_tests/openvpn/test_options_parse.c
M tests/unit_tests/openvpn/test_push_update_msg.c
14 files changed, 78 insertions(+), 78 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1583/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 34ed4eb..9b7bd42 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2339,7 +2339,7 @@
 }

 bool
-do_up(struct context *c, bool pulled_options, unsigned int option_types_fo=
und)
+do_up(struct context *c, bool pulled_options, uint64_t option_types_found)
 {
     int error_flags =3D 0;
     if (!c->c2.do_up_ran)
@@ -2474,7 +2474,7 @@
 }

 bool
-do_update(struct context *c, unsigned int option_types_found)
+do_update(struct context *c, uint64_t option_types_found)
 {
     /* Not necessary since to receive the update the openvpn
      * instance must be up and running but just in case
@@ -2588,7 +2588,7 @@
 }

 bool
-do_deferred_options(struct context *c, const unsigned int found, const boo=
l is_update)
+do_deferred_options(struct context *c, const uint64_t found, const bool is=
_update)
 {
     if (found & OPT_P_MESSAGES)
     {
@@ -4209,7 +4209,7 @@
                 int i;
                 for (i =3D 0; i < config.n; ++i)
                 {
-                    unsigned int option_types_found =3D 0;
+                    uint64_t option_types_found =3D 0;
                     if (config.list[i] && config.list[i]->value)
                     {
                         options_string_import(
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 9c4cf71..9d5050d 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -75,7 +75,7 @@

 void context_gc_free(struct context *c);

-bool do_up(struct context *c, bool pulled_options, unsigned int option_typ=
es_found);
+bool do_up(struct context *c, bool pulled_options, uint64_t option_types_f=
ound);

 /**
  * @brief A simplified version of the do_up() function. This function is c=
alled
@@ -87,7 +87,7 @@
  * @return true on success.
  * @return false on error.
  */
-bool do_update(struct context *c, unsigned int option_types_found);
+bool do_update(struct context *c, uint64_t option_types_found);
=20
 unsigned int pull_permission_mask(const struct context *c);

@@ -99,7 +99,7 @@
  * Handle non-tun-related pulled options.
  * Set `is_update` param to true to skip NCP check.
  */
-bool do_deferred_options(struct context *c, const unsigned int found, cons=
t bool is_update);
+bool do_deferred_options(struct context *c, const uint64_t found, const bo=
ol is_update);

 void inherit_context_child(struct context *dest, const struct context *src,
                            struct link_socket *sock);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1625fd0..22f8b54 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1619,7 +1619,7 @@
  */
 static void
 multi_client_connect_post(struct multi_context *m, struct multi_instance *=
mi, const char *dc_file,
-                          unsigned int *option_types_found)
+                          uint64_t *option_types_found)
 {
     /* Did script generate a dynamic config file? */
     if (platform_test_file(dc_file))
@@ -1645,7 +1645,7 @@
  */
 static void
 multi_client_connect_post_plugin(struct multi_context *m, struct multi_ins=
tance *mi,
-                                 const struct plugin_return *pr, unsigned =
int *option_types_found)
+                                 const struct plugin_return *pr, uint64_t =
*option_types_found)
 {
     struct plugin_return config;

@@ -1684,7 +1684,7 @@
  */
 enum client_connect_return
 multi_client_connect_mda(struct multi_context *m, struct multi_instance *m=
i, bool deferred,
-                         unsigned int *option_types_found)
+                         uint64_t *option_types_found)
 {
     /* We never return CC_RET_DEFERRED */
     ASSERT(!deferred);
@@ -2055,7 +2055,7 @@
=20
 static enum client_connect_return
 multi_client_connect_call_plugin_v1(struct multi_context *m, struct multi_=
instance *mi,
-                                    bool deferred, unsigned int *option_ty=
pes_found)
+                                    bool deferred, uint64_t *option_types_=
found)
 {
     enum client_connect_return ret =3D CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
@@ -2145,7 +2145,7 @@

 static enum client_connect_return
 multi_client_connect_call_plugin_v2(struct multi_context *m, struct multi_=
instance *mi,
-                                    bool deferred, unsigned int *option_ty=
pes_found)
+                                    bool deferred, uint64_t *option_types_=
found)
 {
     enum client_connect_return ret =3D CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
@@ -2194,7 +2194,7 @@

 static enum client_connect_return
 multi_client_connect_script_deferred(struct multi_context *m, struct multi=
_instance *mi,
-                                     unsigned int *option_types_found)
+                                     uint64_t *option_types_found)
 {
     ASSERT(mi);
     ASSERT(option_types_found);
@@ -2235,7 +2235,7 @@
  */
 static enum client_connect_return
 multi_client_connect_call_script(struct multi_context *m, struct multi_ins=
tance *mi, bool deferred,
-                                 unsigned int *option_types_found)
+                                 uint64_t *option_types_found)
 {
     if (deferred)
     {
@@ -2339,7 +2339,7 @@

 static void
 multi_client_connect_late_setup(struct multi_context *m, struct multi_inst=
ance *mi,
-                                const unsigned int option_types_found)
+                                const uint64_t option_types_found)
 {
     ASSERT(m);
     ASSERT(mi);
@@ -2497,7 +2497,7 @@
  */
 static enum client_connect_return
 multi_client_connect_compress_migrate(struct multi_context *m, struct mult=
i_instance *mi,
-                                      bool deferred, unsigned int *option_=
types_found)
+                                      bool deferred, uint64_t *option_type=
s_found)
 {
 #ifdef USE_COMP
     struct options *o =3D &mi->context.options;
@@ -2529,7 +2529,7 @@
  */
 static enum client_connect_return
 multi_client_connect_source_ccd(struct multi_context *m, struct multi_inst=
ance *mi, bool deferred,
-                                unsigned int *option_types_found)
+                                uint64_t *option_types_found)
 {
     /* Since we never return a CC_RET_DEFERRED, this indicates a serious
      * problem */
@@ -2580,7 +2580,7 @@

 typedef enum client_connect_return (*multi_client_connect_handler)(
     struct multi_context *m, struct multi_instance *mi, bool from_deferred,
-    unsigned int *option_types_found);
+    uint64_t *option_types_found);

 static const multi_client_connect_handler client_connect_handlers[] =3D {
     multi_client_connect_compress_migrate,
@@ -2678,7 +2678,7 @@
     bool from_deferred =3D (mi->context.c2.tls_multi->multi_state !=3D CAS=
_PENDING);

     int *cur_handler_index =3D &mi->client_connect_defer_state.cur_handler=
_index;
-    unsigned int *option_types_found =3D &mi->client_connect_defer_state.o=
ption_types_found;
+    uint64_t *option_types_found =3D &mi->client_connect_defer_state.optio=
n_types_found;

     /* We are called for the first time */
     if (!from_deferred)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c686e47..7e2a77d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -73,7 +73,7 @@
     int cur_handler_index;
     /* Remember which option classes where processed for delayed option
      * handling. */
-    unsigned int option_types_found;
+    uint64_t option_types_found;

     /**
      * The temporary file name that contains the return status of the
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1db781d..4f0025b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4953,8 +4953,8 @@
     }

 static bool
-verify_permission(const char *name, const char *file, int line, const unsi=
gned int type,
-                  const unsigned int allowed, unsigned int *found, const m=
sglvl_t msglevel,
+verify_permission(const char *name, const char *file, int line, const uint=
64_t type,
+                  const uint64_t allowed, uint64_t *found, const msglvl_t =
msglevel,
                   struct options *options, bool is_inline)
 {
     if (!(type & allowed))
@@ -5046,7 +5046,7 @@
 void
 remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
     msglvl_t msglevel_fc =3D msglevel_forward_compatible(options, msglevel=
);
@@ -5366,7 +5366,7 @@
 void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const int level, const msglvl_t =
msglevel,
-              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
@@ -5555,8 +5555,8 @@

 void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file, int line,
-           const int level, const msglvl_t msglevel, const unsigned int pe=
rmission_mask,
-           unsigned int *option_types_found, struct env_set *es)
+           const int level, const msglvl_t msglevel, const uint64_t permis=
sion_mask,
+           uint64_t *option_types_found, struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
@@ -5988,7 +5988,7 @@

             init_options(&sub);
             sub.ce =3D options->ce;
-            read_config_string("[CONNECTION-OPTIONS]", &sub, p[1], msgleve=
l, OPT_P_CONNECTION,
+            read_config_string("[PEER-OPTIONS]", &sub, p[1], msglevel, OPT=
_P_CONNECTION,
                                option_types_found, es);
             if (!sub.ce.remote)
             {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b505..ae3156a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -553,8 +553,8 @@
     bool client;
     bool pull; /* client pull of config options from server */
     int push_continuation;
-    unsigned int push_option_types_found;
-    unsigned int push_update_options_found; /* tracks which option types h=
ave been reset in current PUSH_UPDATE sequence */
+    uint64_t push_option_types_found;
+    uint64_t push_update_options_found; /* tracks which option types have =
been reset in current PUSH_UPDATE sequence */
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
     struct options_pre_connect *pre_connect;
@@ -808,7 +808,7 @@

 void add_option(struct options *options, char *p[], bool is_inline, const =
char *file,
                 int line, const int level, const msglvl_t msglevel,
-                const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
+                const uint64_t permission_mask, uint64_t *option_types_fou=
nd,
                 struct env_set *es);
=20
 /**
@@ -833,7 +833,7 @@
  */
 void remove_option(struct context *c, struct options *options, char *p[], =
bool is_inline,
                    const char *file, int line, const msglvl_t msglevel,
-                   const unsigned int permission_mask, unsigned int *optio=
n_types_found,
+                   const uint64_t permission_mask, uint64_t *option_types_=
found,
                    struct env_set *es);

 /**
@@ -858,21 +858,21 @@
  */
 void update_option(struct context *c, struct options *options, char *p[], =
bool is_inline,
                    const char *file, int line, const int level, const msgl=
vl_t msglevel,
-                   const unsigned int permission_mask, unsigned int *optio=
n_types_found,
+                   const uint64_t permission_mask, uint64_t *option_types_=
found,
                    struct env_set *es);

 void parse_argv(struct options *options, const int argc, char *argv[], con=
st msglvl_t msglevel,
-                const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
+                const uint64_t permission_mask, uint64_t *option_types_fou=
nd,
                 struct env_set *es);

 void read_config_file(struct options *options, const char *file, int level=
, const char *top_file,
                       const int top_line, const msglvl_t msglevel,
-                      const unsigned int permission_mask, unsigned int *op=
tion_types_found,
+                      const uint64_t permission_mask, uint64_t *option_typ=
es_found,
                       struct env_set *es);

 void read_config_string(const char *prefix, struct options *options, const=
 char *config,
-                        const msglvl_t msglevel, const unsigned int permis=
sion_mask,
-                        unsigned int *option_types_found, struct env_set *=
es);
+                        const msglvl_t msglevel, const uint64_t permission=
_mask,
+                        uint64_t *option_types_found, struct env_set *es);

 void notnull(const char *arg, const char *description);

@@ -933,13 +933,13 @@
 void pre_connect_restore(struct options *o, struct gc_arena *gc);

 bool apply_push_options(struct context *c, struct options *options, struct=
 buffer *buf,
-                        unsigned int permission_mask, unsigned int *option=
_types_found,
+                        uint64_t permission_mask, uint64_t *option_types_f=
ound,
                         struct env_set *es, bool is_update);

 void options_detach(struct options *o);

 void options_server_import(struct options *o, const char *filename, msglvl=
_t msglevel,
-                           unsigned int permission_mask, unsigned int *opt=
ion_types_found,
+                           uint64_t permission_mask, uint64_t *option_type=
s_found,
                            struct env_set *es);

 void pre_pull_default(struct options *o);
@@ -972,7 +972,7 @@
 const char *auth_retry_print(void);

 void options_string_import(struct options *options, const char *config, co=
nst msglvl_t msglevel,
-                           const unsigned int permission_mask, unsigned in=
t *option_types_found,
+                           const uint64_t permission_mask, uint64_t *optio=
n_types_found,
                            struct env_set *es);

 bool key_is_external(const struct options *options);
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index cb51ad2..a8c4aee 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -346,7 +346,7 @@
 void
 read_config_file(struct options *options, const char *file, int level, con=
st char *top_file,
                  const int top_line, const msglvl_t msglevel,
-                 const unsigned int permission_mask, unsigned int *option_=
types_found,
+                 const uint64_t permission_mask, uint64_t *option_types_fo=
und,
                  struct env_set *es)
 {
     const int max_recursive_levels =3D 10;
@@ -419,8 +419,8 @@

 void
 read_config_string(const char *prefix, struct options *options, const char=
 *config,
-                   const msglvl_t msglevel, const unsigned int permission_=
mask,
-                   unsigned int *option_types_found, struct env_set *es)
+                   const msglvl_t msglevel, const uint64_t permission_mask,
+                   uint64_t *option_types_found, struct env_set *es)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer multiline;
@@ -448,7 +448,7 @@

 void
 parse_argv(struct options *options, const int argc, char *argv[], const ms=
glvl_t msglevel,
-           const unsigned int permission_mask, unsigned int *option_types_=
found, struct env_set *es)
+           const uint64_t permission_mask, uint64_t *option_types_found, s=
truct env_set *es)
 {
     /* usage message */
     if (argc <=3D 1)
@@ -510,7 +510,7 @@

 bool
 apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
-                   unsigned int permission_mask, unsigned int *option_type=
s_found,
+                   uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es, bool is_update)
 {
     char line[OPTION_PARM_SIZE];
@@ -523,7 +523,7 @@
         char *p[MAX_PARMS + 1];
         CLEAR(p);
         ++line_num;
-        unsigned int push_update_option_flags =3D 0;
+        uint64_t push_update_option_flags =3D 0;
         int i =3D 0;

         /* skip leading spaces matching the behaviour of parse_line */
@@ -578,7 +578,7 @@

 void
 options_server_import(struct options *o, const char *filename, msglvl_t ms=
glevel,
-                      unsigned int permission_mask, unsigned int *option_t=
ypes_found,
+                      const uint64_t permission_mask, uint64_t *option_typ=
es_found,
                       struct env_set *es)
 {
     msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s"=
, filename);
@@ -588,7 +588,7 @@

 void
 options_string_import(struct options *options, const char *config, const m=
sglvl_t msglevel,
-                      const unsigned int permission_mask, unsigned int *op=
tion_types_found,
+                      const uint64_t permission_mask, uint64_t *option_typ=
es_found,
                       struct env_set *es)
 {
     read_config_string("[CONFIG-STRING]", options, config, msglevel, permi=
ssion_mask,
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 8d0a143..47fe0bc 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -203,7 +203,7 @@
                                            "tun-mtu", "keepalive" };

 bool
-check_push_update_option_flags(char *line, int *i, unsigned int *flags)
+check_push_update_option_flags(char *line, int *i, uint64_t *flags)
 {
     *flags =3D 0;
     bool opt_is_updatable =3D false;
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 511d189..1d4ea9b 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -106,6 +106,6 @@
  *         - The `line` parameter is empty or `NULL`.
  *         - The `?` flag is absent and the option is not updatable.
  */
-bool check_push_update_option_flags(char *line, int *i, unsigned int *flag=
s);
+bool check_push_update_option_flags(char *line, int *i, uint64_t *flags);

 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 93c5558..835c433 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -505,7 +505,7 @@
 incoming_push_message(struct context *c, const struct buffer *buffer)
 {
     struct gc_arena gc =3D gc_new();
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     msg(D_PUSH, "PUSH: Received control message: '%s'",
         sanitize_control_message(BSTR(buffer), &gc));
@@ -1060,8 +1060,8 @@
 }

 static int
-process_incoming_push_reply(struct context *c, unsigned int permission_mas=
k,
-                            unsigned int *option_types_found, struct buffe=
r *buf)
+process_incoming_push_reply(struct context *c, uint64_t permission_mask,
+                            uint64_t *option_types_found, struct buffer *b=
uf)
 {
     int ret =3D PUSH_MSG_ERROR;
     const int ch =3D buf_read_u8(buf);
@@ -1110,8 +1110,8 @@

 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
-                          bool honor_received_options, unsigned int permis=
sion_mask,
-                          unsigned int *option_types_found)
+                          bool honor_received_options, uint64_t permission=
_mask,
+                          uint64_t *option_types_found)
 {
     struct buffer buf =3D *buffer;

diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index d18d058..dff945f 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -76,12 +76,12 @@
  * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the=
 message is invalid.
  */

-int process_push_update(struct context *c, struct options *o, unsigned int=
 permission_mask,
-                        unsigned int *option_types_found, struct buffer *b=
uf, bool msg_sender);
+int process_push_update(struct context *c, struct options *o, uint64_t per=
mission_mask,
+                        uint64_t *option_types_found, struct buffer *buf, =
bool msg_sender);

 int process_incoming_push_msg(struct context *c, const struct buffer *buff=
er,
-                              bool honor_received_options, unsigned int pe=
rmission_mask,
-                              unsigned int *option_types_found);
+                              bool honor_received_options, uint64_t permis=
sion_mask,
+                              uint64_t *option_types_found);

 bool send_push_request(struct context *c);

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..e129403 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -11,8 +11,8 @@
 #endif

 int
-process_push_update(struct context *c, struct options *o, unsigned int per=
mission_mask,
-                    unsigned int *option_types_found, struct buffer *buf, =
bool msg_sender)
+process_push_update(struct context *c, struct options *o, uint64_t permiss=
ion_mask,
+                    uint64_t *option_types_found, struct buffer *buf, bool=
 msg_sender)
 {
     int ret =3D PUSH_MSG_ERROR;
     const int ch =3D buf_read_u8(buf);
@@ -146,7 +146,7 @@
         return false;
     }

-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;
     struct context *c =3D &mi->context;
     struct options o;
     CLEAR(o);
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 0b3d7fe..e67eae8 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -40,7 +40,7 @@
 void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file,
            int line, const int level, const msglvl_t msglevel,
-           const unsigned int permission_mask, unsigned int *option_types_=
found,
+           const uint64_t permission_mask, uint64_t *option_types_found,
            struct env_set *es)
 {
     function_called();
@@ -51,7 +51,7 @@
 void
 remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
 }
@@ -59,7 +59,7 @@
 void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const int level, const msglvl_t =
msglevel,
-              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
 }
@@ -191,7 +191,7 @@
 static void
 read_single_config(struct options *options, const char *config)
 {
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;
     struct env_set es;
     CLEAR(es);
     read_config_string("test_options_parse", options, config, M_INFO, OPT_=
P_DEFAULT,
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 9b7978e..219b476 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -70,7 +70,7 @@

 bool
 apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
-                   unsigned int permission_mask, unsigned int *option_type=
s_found,
+                   uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es, bool is_update)
 {
     char line[OPTION_PARM_SIZE];
@@ -83,7 +83,7 @@

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        unsigned int push_update_option_flags =3D 0;
+        uint64_t push_update_option_flags =3D 0;
         int i =3D 0;

         if (is_update || options->pull_filter_list)
@@ -131,8 +131,8 @@

 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
-                          bool honor_received_options, unsigned int permis=
sion_mask,
-                          unsigned int *option_types_found)
+                          bool honor_received_options, uint64_t permission=
_mask,
+                          uint64_t *option_types_found)
 {
     struct buffer buf =3D *buffer;

@@ -206,7 +206,7 @@
     const char *update_msg =3D
         "PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route 0.0.0.0 0.0.0.0 10.10.=
10.1";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -222,7 +222,7 @@
     struct buffer buf =3D alloc_buf(256);
     const char *update_msg =3D "PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -238,7 +238,7 @@
     struct buffer buf =3D alloc_buf(256);
     const char *update_msg =3D "PUSH_UPDATE ,dhcp-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -254,7 +254,7 @@
     struct buffer buf =3D alloc_buf(256);
     const char *update_msg =3D "PUSH_UPDATE, -?dns, route something, ?dhcp=
-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;
=20
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -270,7 +270,7 @@
     struct buffer buf =3D alloc_buf(256);
     const char *update_msg =3D "PUSH_UPDATE, -dhcp-option, ?-dns";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -286,7 +286,7 @@
     struct buffer buf =3D alloc_buf(256);
     const char *update_msg =3D "PUSH_UPDATE, dev tun";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -303,7 +303,7 @@
     const char *update_msg =3D
         "PUSH_UPDATE,-dhcp-option, route 10.10.10.0, dhcp-option DNS 1.1.1=
.1, route 10.11.12.0, dhcp-option DOMAIN corp.local, keepalive 10 60";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -320,7 +320,7 @@
     const char *update_msg =3D
         "PUSH_UPDATE,-dhcp-option,dhcp-option DNS 8.8.8.8,redirect-gateway=
 local,route 192.168.1.0 255.255.255.0";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, p=
ull_permission_mask(c),
                                                &option_types_found),
@@ -344,7 +344,7 @@
 test_incoming_push_continuation_route_accumulation(void **state)
 {
     struct context *c =3D *state;
-    unsigned int option_types_found =3D 0;
+    uint64_t option_types_found =3D 0;

     reset_route_counters();


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1583?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ca07e2bbb5de229204191d61e90f084a58969af
Gerrit-Change-Number: 1583
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gduuYDCuyjg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1583?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Change type of option flag from unsigned int to uint64_t<br><br>We curr=
ently use all 32 bits of the unsigned int for option classes.<br>While we c=
an probably can retire 2-3 of the existing options, at some<br>point we wil=
l hit the limit again.<br><br>Instead of fully rewriting this logic to use =
a different approach or<br>structure, changing the type from unsigned int t=
o uint64_t seem to be<br>a lot less intrusive approach.<br><br>Change-Id: I=
8ca07e2bbb5de229204191d61e90f084a58969af<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvpn/init.h=
<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/options=
.c<br>M src/openvpn/options.h<br>M src/openvpn/options_parse.c<br>M src/ope=
nvpn/options_util.c<br>M src/openvpn/options_util.h<br>M src/openvpn/push.c=
<br>M src/openvpn/push.h<br>M src/openvpn/push_util.c<br>M tests/unit_tests=
/openvpn/test_options_parse.c<br>M tests/unit_tests/openvpn/test_push_updat=
e_msg.c<br>14 files changed, 78 insertions(+), 78 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/83/1583/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</sp=
an><br><span>index 34ed4eb..9b7bd42 100644</span><br><span>--- a/src/openvp=
n/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2339,=
7 +2339,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-do_up(struct context *c, =
bool pulled_options, unsigned int option_types_found)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do_up(struct context *c, bool pulled_opti=
ons, uint64_t option_types_found)</span><br><span> {</span><br><span>     i=
nt error_flags =3D 0;</span><br><span>     if (!c-&gt;c2.do_up_ran)</span><=
br><span>@@ -2474,7 +2474,7 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_upda=
te(struct context *c, unsigned int option_types_found)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+do_update(struct context *c, uint64_t op=
tion_types_found)</span><br><span> {</span><br><span>     /* Not necessary =
since to receive the update the openvpn</span><br><span>      * instance mu=
st be up and running but just in case</span><br><span>@@ -2588,7 +2588,7 @@=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-do_deferred_options(struct context *c=
, const unsigned int found, const bool is_update)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+do_deferred_options(struct context *c, const =
uint64_t found, const bool is_update)</span><br><span> {</span><br><span>  =
   if (found &amp; OPT_P_MESSAGES)</span><br><span>     {</span><br><span>@=
@ -4209,7 +4209,7 @@</span><br><span>                 int i;</span><br><spa=
n>                 for (i =3D 0; i &lt; config.n; ++i)</span><br><span>    =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             unsigned int option_types_found =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    uint64_t option_types=
_found =3D 0;</span><br><span>                     if (config.list[i] &amp;=
&amp; config.list[i]-&gt;value)</span><br><span>                     {</spa=
n><br><span>                         options_string_import(</span><br><span=
>diff --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>index=
 9c4cf71..9d5050d 100644</span><br><span>--- a/src/openvpn/init.h</span><br=
><span>+++ b/src/openvpn/init.h</span><br><span>@@ -75,7 +75,7 @@</span><br=
><span> </span><br><span> void context_gc_free(struct context *c);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool do_up(s=
truct context *c, bool pulled_options, unsigned int option_types_found);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_up(struct cont=
ext *c, bool pulled_options, uint64_t option_types_found);</span><br><span>=
 </span><br><span> /**</span><br><span>  * @brief A simplified version of t=
he do_up() function. This function is called</span><br><span>@@ -87,7 +87,7=
 @@</span><br><span>  * @return true on success.</span><br><span>  * @retur=
n false on error.</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool do_update(struct context *c, unsigned int option_type=
s_found);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_up=
date(struct context *c, uint64_t option_types_found);</span><br><span> </sp=
an><br><span> unsigned int pull_permission_mask(const struct context *c);</=
span><br><span> </span><br><span>@@ -99,7 +99,7 @@</span><br><span>  * Hand=
le non-tun-related pulled options.</span><br><span>  * Set `is_update` para=
m to true to skip NCP check.</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool do_deferred_options(struct context *c, con=
st unsigned int found, const bool is_update);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool do_deferred_options(struct context *c, const=
 uint64_t found, const bool is_update);</span><br><span> </span><br><span> =
void inherit_context_child(struct context *dest, const struct context *src,=
</span><br><span>                            struct link_socket *sock);</sp=
an><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><=
br><span>index 1625fd0..22f8b54 100644</span><br><span>--- a/src/openvpn/mu=
lti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1619,7 =
+1619,7 @@</span><br><span>  */</span><br><span> static void</span><br><spa=
n> multi_client_connect_post(struct multi_context *m, struct multi_instance=
 *mi, const char *dc_file,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                          unsigned int *option_types_found)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          uint=
64_t *option_types_found)</span><br><span> {</span><br><span>     /* Did sc=
ript generate a dynamic config file? */</span><br><span>     if (platform_t=
est_file(dc_file))</span><br><span>@@ -1645,7 +1645,7 @@</span><br><span>  =
*/</span><br><span> static void</span><br><span> multi_client_connect_post_=
plugin(struct multi_context *m, struct multi_instance *mi,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                 const=
 struct plugin_return *pr, unsigned int *option_types_found)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                 c=
onst struct plugin_return *pr, uint64_t *option_types_found)</span><br><spa=
n> {</span><br><span>     struct plugin_return config;</span><br><span> </s=
pan><br><span>@@ -1684,7 +1684,7 @@</span><br><span>  */</span><br><span> e=
num client_connect_return</span><br><span> multi_client_connect_mda(struct =
multi_context *m, struct multi_instance *mi, bool deferred,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         unsigned int=
 *option_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         uint64_t *option_types_found)</span><br><span> {=
</span><br><span>     /* We never return CC_RET_DEFERRED */</span><br><span=
>     ASSERT(!deferred);</span><br><span>@@ -2055,7 +2055,7 @@</span><br><s=
pan> </span><br><span> static enum client_connect_return</span><br><span> m=
ulti_client_connect_call_plugin_v1(struct multi_context *m, struct multi_in=
stance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                          bool deferred, unsigned int *option_types_found)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                bool deferred, uint64_t *option_types_found)</span><br><spa=
n> {</span><br><span>     enum client_connect_return ret =3D CC_RET_SKIPPED=
;</span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>@@ -2145,7 +2145,7 =
@@</span><br><span> </span><br><span> static enum client_connect_return</sp=
an><br><span> multi_client_connect_call_plugin_v2(struct multi_context *m, =
struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                    bool deferred, unsigned int *optio=
n_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                               bool deferred, uint64_t *option_types_found)=
</span><br><span> {</span><br><span>     enum client_connect_return ret =3D=
 CC_RET_SKIPPED;</span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>@@ -=
2194,7 +2194,7 @@</span><br><span> </span><br><span> static enum client_con=
nect_return</span><br><span> multi_client_connect_script_deferred(struct mu=
lti_context *m, struct multi_instance *mi,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                     unsigned int *opt=
ion_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                  uint64_t *option_types_found)</span><br><=
span> {</span><br><span>     ASSERT(mi);</span><br><span>     ASSERT(option=
_types_found);</span><br><span>@@ -2235,7 +2235,7 @@</span><br><span>  */</=
span><br><span> static enum client_connect_return</span><br><span> multi_cl=
ient_connect_call_script(struct multi_context *m, struct multi_instance *mi=
, bool deferred,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                            unsigned int *option_types_found)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
uint64_t *option_types_found)</span><br><span> {</span><br><span>     if (d=
eferred)</span><br><span>     {</span><br><span>@@ -2339,7 +2339,7 @@</span=
><br><span> </span><br><span> static void</span><br><span> multi_client_con=
nect_late_setup(struct multi_context *m, struct multi_instance *mi,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
   const unsigned int option_types_found)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                const uint64_t option=
_types_found)</span><br><span> {</span><br><span>     ASSERT(m);</span><br>=
<span>     ASSERT(mi);</span><br><span>@@ -2497,7 +2497,7 @@</span><br><spa=
n>  */</span><br><span> static enum client_connect_return</span><br><span> =
multi_client_connect_compress_migrate(struct multi_context *m, struct multi=
_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                               bool deferred, unsigned int *option_types_fo=
und)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                       bool deferred, uint64_t *option_types_found)</span><=
br><span> {</span><br><span> #ifdef USE_COMP</span><br><span>     struct op=
tions *o =3D &amp;mi-&gt;context.options;</span><br><span>@@ -2529,7 +2529,=
7 @@</span><br><span>  */</span><br><span> static enum client_connect_retur=
n</span><br><span> multi_client_connect_source_ccd(struct multi_context *m,=
 struct multi_instance *mi, bool deferred,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                unsigned int *option_t=
ypes_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                        uint64_t *option_types_found)</span><br><span> {</s=
pan><br><span>     /* Since we never return a CC_RET_DEFERRED, this indicat=
es a serious</span><br><span>      * problem */</span><br><span>@@ -2580,7 =
+2580,7 @@</span><br><span> </span><br><span> typedef enum client_connect_r=
eturn (*multi_client_connect_handler)(</span><br><span>     struct multi_co=
ntext *m, struct multi_instance *mi, bool from_deferred,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    unsigned int *option_types_found);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t *option_=
types_found);</span><br><span> </span><br><span> static const multi_client_=
connect_handler client_connect_handlers[] =3D {</span><br><span>     multi_=
client_connect_compress_migrate,</span><br><span>@@ -2678,7 +2678,7 @@</spa=
n><br><span>     bool from_deferred =3D (mi-&gt;context.c2.tls_multi-&gt;mu=
lti_state !=3D CAS_PENDING);</span><br><span> </span><br><span>     int *cu=
r_handler_index =3D &amp;mi-&gt;client_connect_defer_state.cur_handler_inde=
x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int *o=
ption_types_found =3D &amp;mi-&gt;client_connect_defer_state.option_types_f=
ound;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t *=
option_types_found =3D &amp;mi-&gt;client_connect_defer_state.option_types_=
found;</span><br><span> </span><br><span>     /* We are called for the firs=
t time */</span><br><span>     if (!from_deferred)</span><br><span>diff --g=
it a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index c686e4=
7..7e2a77d 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><span=
>+++ b/src/openvpn/multi.h</span><br><span>@@ -73,7 +73,7 @@</span><br><spa=
n>     int cur_handler_index;</span><br><span>     /* Remember which option=
 classes where processed for delayed option</span><br><span>      * handlin=
g. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int=
 option_types_found;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint64_t option_types_found;</span><br><span> </span><br><span>     /*=
*</span><br><span>      * The temporary file name that contains the return =
status of the</span><br><span>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c</span><br><span>index 1db781d..4f0025b 100644</span><br><span=
>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</s=
pan><br><span>@@ -4953,8 +4953,8 @@</span><br><span>     }</span><br><span>=
 </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-verify_permission(const char *name, const char *file, int line, co=
nst unsigned int type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                  const unsigned int allowed, unsigned int *found, const m=
sglvl_t msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ve=
rify_permission(const char *name, const char *file, int line, const uint64_=
t type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,</sp=
an><br><span>                   struct options *options, bool is_inline)</s=
pan><br><span> {</span><br><span>     if (!(type &amp; allowed))</span><br>=
<span>@@ -5046,7 +5046,7 @@</span><br><span> void</span><br><span> remove_o=
ption(struct context *c, struct options *options, char *p[], bool is_inline=
,</span><br><span>               const char *file, int line, const msglvl_t=
 msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
   const unsigned int permission_mask, unsigned int *option_types_found,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+              const ui=
nt64_t permission_mask, uint64_t *option_types_found,</span><br><span>     =
          struct env_set *es)</span><br><span> {</span><br><span>     msglv=
l_t msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</span><=
br><span>@@ -5366,7 +5366,7 @@</span><br><span> void</span><br><span> updat=
e_option(struct context *c, struct options *options, char *p[], bool is_inl=
ine,</span><br><span>               const char *file, int line, const int l=
evel, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-              const unsigned int permission_mask, unsigned int *op=
tion_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
            const uint64_t permission_mask, uint64_t *option_types_found,</=
span><br><span>               struct env_set *es)</span><br><span> {</span>=
<br><span>     const bool pull_mode =3D BOOL_CAST(permission_mask &amp; OPT=
_P_PULL_MODE);</span><br><span>@@ -5555,8 +5555,8 @@</span><br><span> </spa=
n><br><span> void</span><br><span> add_option(struct options *options, char=
 *p[], bool is_inline, const char *file, int line,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-           const int level, const msglvl_t msg=
level, const unsigned int permission_mask,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-           unsigned int *option_types_found, struct en=
v_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
  const int level, const msglvl_t msglevel, const uint64_t permission_mask,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           uint64_t=
 *option_types_found, struct env_set *es)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span>     const bool pul=
l_mode =3D BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><spa=
n>@@ -5988,7 +5988,7 @@</span><br><span> </span><br><span>             init=
_options(&amp;sub);</span><br><span>             sub.ce =3D options-&gt;ce;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_conf=
ig_string(&quot;[CONNECTION-OPTIONS]&quot;, &amp;sub, p[1], msglevel, OPT_P=
_CONNECTION,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     read_config_string(&quot;[PEER-OPTIONS]&quot;, &amp;sub, p[1], msgleve=
l, OPT_P_CONNECTION,</span><br><span>                                option=
_types_found, es);</span><br><span>             if (!sub.ce.remote)</span><=
br><span>             {</span><br><span>diff --git a/src/openvpn/options.h =
b/src/openvpn/options.h</span><br><span>index 3d8b505..ae3156a 100644</span=
><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/op=
tions.h</span><br><span>@@ -553,8 +553,8 @@</span><br><span>     bool clien=
t;</span><br><span>     bool pull; /* client pull of config options from se=
rver */</span><br><span>     int push_continuation;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int push_option_types_found;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int push_u=
pdate_options_found; /* tracks which option types have been reset in curren=
t PUSH_UPDATE sequence */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint64_t push_option_types_found;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint64_t push_update_options_found; /* tracks w=
hich option types have been reset in current PUSH_UPDATE sequence */</span>=
<br><span>     const char *auth_user_pass_file;</span><br><span>     bool a=
uth_user_pass_file_inline;</span><br><span>     struct options_pre_connect =
*pre_connect;</span><br><span>@@ -808,7 +808,7 @@</span><br><span> </span><=
br><span> void add_option(struct options *options, char *p[], bool is_inlin=
e, const char *file,</span><br><span>                 int line, const int l=
evel, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                const unsigned int permission_mask, unsigned int *=
option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                const uint64_t permission_mask, uint64_t *option_types_foun=
d,</span><br><span>                 struct env_set *es);</span><br><span> <=
/span><br><span> /**</span><br><span>@@ -833,7 +833,7 @@</span><br><span>  =
*/</span><br><span> void remove_option(struct context *c, struct options *o=
ptions, char *p[], bool is_inline,</span><br><span>                    cons=
t char *file, int line, const msglvl_t msglevel,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                   const unsigned int permission=
_mask, unsigned int *option_types_found,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   const uint64_t permission_mask, uin=
t64_t *option_types_found,</span><br><span>                    struct env_s=
et *es);</span><br><span> </span><br><span> /**</span><br><span>@@ -858,21 =
+858,21 @@</span><br><span>  */</span><br><span> void update_option(struct =
context *c, struct options *options, char *p[], bool is_inline,</span><br><=
span>                    const char *file, int line, const int level, const=
 msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                 const unsigned int permission_mask, unsigned int *option_t=
ypes_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
           const uint64_t permission_mask, uint64_t *option_types_found,</s=
pan><br><span>                    struct env_set *es);</span><br><span> </s=
pan><br><span> void parse_argv(struct options *options, const int argc, cha=
r *argv[], const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                const unsigned int permission_mask, unsigned =
int *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                const uint64_t permission_mask, uint64_t *option_types=
_found,</span><br><span>                 struct env_set *es);</span><br><sp=
an> </span><br><span> void read_config_file(struct options *options, const =
char *file, int level, const char *top_file,</span><br><span>              =
         const int top_line, const msglvl_t msglevel,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      const unsigned int pe=
rmission_mask, unsigned int *option_types_found,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                      const uint64_t permissio=
n_mask, uint64_t *option_types_found,</span><br><span>                     =
  struct env_set *es);</span><br><span> </span><br><span> void read_config_=
string(const char *prefix, struct options *options, const char *config,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        c=
onst msglvl_t msglevel, const unsigned int permission_mask,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        unsigned int =
*option_types_found, struct env_set *es);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        const msglvl_t msglevel, cons=
t uint64_t permission_mask,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        uint64_t *option_types_found, struct env_se=
t *es);</span><br><span> </span><br><span> void notnull(const char *arg, co=
nst char *description);</span><br><span> </span><br><span>@@ -933,13 +933,1=
3 @@</span><br><span> void pre_connect_restore(struct options *o, struct gc=
_arena *gc);</span><br><span> </span><br><span> bool apply_push_options(str=
uct context *c, struct options *options, struct buffer *buf,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        unsigned int=
 permission_mask, unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        uint64_t permissi=
on_mask, uint64_t *option_types_found,</span><br><span>                    =
     struct env_set *es, bool is_update);</span><br><span> </span><br><span=
> void options_detach(struct options *o);</span><br><span> </span><br><span=
> void options_server_import(struct options *o, const char *filename, msglv=
l_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                   unsigned int permission_mask, unsigned int *option_types=
_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
               uint64_t permission_mask, uint64_t *option_types_found,</spa=
n><br><span>                            struct env_set *es);</span><br><spa=
n> </span><br><span> void pre_pull_default(struct options *o);</span><br><s=
pan>@@ -972,7 +972,7 @@</span><br><span> const char *auth_retry_print(void)=
;</span><br><span> </span><br><span> void options_string_import(struct opti=
ons *options, const char *config, const msglvl_t msglevel,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                           const unsig=
ned int permission_mask, unsigned int *option_types_found,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           const uin=
t64_t permission_mask, uint64_t *option_types_found,</span><br><span>      =
                      struct env_set *es);</span><br><span> </span><br><spa=
n> bool key_is_external(const struct options *options);</span><br><span>dif=
f --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c</span><=
br><span>index cb51ad2..a8c4aee 100644</span><br><span>--- a/src/openvpn/op=
tions_parse.c</span><br><span>+++ b/src/openvpn/options_parse.c</span><br><=
span>@@ -346,7 +346,7 @@</span><br><span> void</span><br><span> read_config=
_file(struct options *options, const char *file, int level, const char *top=
_file,</span><br><span>                  const int top_line, const msglvl_t=
 msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      const unsigned int permission_mask, unsigned int *option_types_found,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 co=
nst uint64_t permission_mask, uint64_t *option_types_found,</span><br><span=
>                  struct env_set *es)</span><br><span> {</span><br><span> =
    const int max_recursive_levels =3D 10;</span><br><span>@@ -419,8 +419,8=
 @@</span><br><span> </span><br><span> void</span><br><span> read_config_st=
ring(const char *prefix, struct options *options, const char *config,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   const ms=
glvl_t msglevel, const unsigned int permission_mask,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   unsigned int *option_typ=
es_found, struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   const msglvl_t msglevel, const uint64_t permis=
sion_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          uint64_t *option_types_found, struct env_set *es)</span><br><span=
> {</span><br><span>     char line[OPTION_LINE_SIZE];</span><br><span>     =
struct buffer multiline;</span><br><span>@@ -448,7 +448,7 @@</span><br><spa=
n> </span><br><span> void</span><br><span> parse_argv(struct options *optio=
ns, const int argc, char *argv[], const msglvl_t msglevel,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           const unsigned int permissi=
on_mask, unsigned int *option_types_found, struct env_set *es)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+           const uint64_t permis=
sion_mask, uint64_t *option_types_found, struct env_set *es)</span><br><spa=
n> {</span><br><span>     /* usage message */</span><br><span>     if (argc=
 &lt;=3D 1)</span><br><span>@@ -510,7 +510,7 @@</span><br><span> </span><br=
><span> bool</span><br><span> apply_push_options(struct context *c, struct =
options *options, struct buffer *buf,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                   unsigned int permission_mask, unsigned i=
nt *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   uint64_t permission_mask, uint64_t *option_types_fou=
nd,</span><br><span>                    struct env_set *es, bool is_update)=
</span><br><span> {</span><br><span>     char line[OPTION_PARM_SIZE];</span=
><br><span>@@ -523,7 +523,7 @@</span><br><span>         char *p[MAX_PARMS +=
 1];</span><br><span>         CLEAR(p);</span><br><span>         ++line_num=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int=
 push_update_option_flags =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        uint64_t push_update_option_flags =3D 0;</span><br><sp=
an>         int i =3D 0;</span><br><span> </span><br><span>         /* skip=
 leading spaces matching the behaviour of parse_line */</span><br><span>@@ =
-578,7 +578,7 @@</span><br><span> </span><br><span> void</span><br><span> o=
ptions_server_import(struct options *o, const char *filename, msglvl_t msgl=
evel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
      unsigned int permission_mask, unsigned int *option_types_found,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      con=
st uint64_t permission_mask, uint64_t *option_types_found,</span><br><span>=
                       struct env_set *es)</span><br><span> {</span><br><sp=
an>     msg(D_PUSH, &quot;OPTIONS IMPORT: reading client specific options f=
rom: %s&quot;, filename);</span><br><span>@@ -588,7 +588,7 @@</span><br><sp=
an> </span><br><span> void</span><br><span> options_string_import(struct op=
tions *options, const char *config, const msglvl_t msglevel,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                      const unsigned=
 int permission_mask, unsigned int *option_types_found,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                      const uint64_t pe=
rmission_mask, uint64_t *option_types_found,</span><br><span>              =
         struct env_set *es)</span><br><span> {</span><br><span>     read_c=
onfig_string(&quot;[CONFIG-STRING]&quot;, options, config, msglevel, permis=
sion_mask,</span><br><span>diff --git a/src/openvpn/options_util.c b/src/op=
envpn/options_util.c</span><br><span>index 8d0a143..47fe0bc 100644</span><b=
r><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/openvpn/=
options_util.c</span><br><span>@@ -203,7 +203,7 @@</span><br><span>        =
                                    &quot;tun-mtu&quot;, &quot;keepalive&qu=
ot; };</span><br><span> </span><br><span> bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-check_push_update_option_flags(char *line, int *i,=
 unsigned int *flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_push_update_option_flags(char *line, int *i, uint64_t *flags)</span=
><br><span> {</span><br><span>     *flags =3D 0;</span><br><span>     bool =
opt_is_updatable =3D false;</span><br><span>diff --git a/src/openvpn/option=
s_util.h b/src/openvpn/options_util.h</span><br><span>index 511d189..1d4ea9=
b 100644</span><br><span>--- a/src/openvpn/options_util.h</span><br><span>+=
++ b/src/openvpn/options_util.h</span><br><span>@@ -106,6 +106,6 @@</span><=
br><span>  *         - The `line` parameter is empty or `NULL`.</span><br><=
span>  *         - The `?` flag is absent and the option is not updatable.<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool check_push_update_option_flags(char *line, int *i, unsigned int *flags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_push_up=
date_option_flags(char *line, int *i, uint64_t *flags);</span><br><span> </=
span><br><span> #endif /* ifndef OPTIONS_UTIL_H_ */</span><br><span>diff --=
git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 93c5558=
..835c433 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+=
++ b/src/openvpn/push.c</span><br><span>@@ -505,7 +505,7 @@</span><br><span=
> incoming_push_message(struct context *c, const struct buffer *buffer)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_typ=
es_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint64_t option_types_found =3D 0;</span><br><span> </span><br><span>     m=
sg(D_PUSH, &quot;PUSH: Received control message: &#39;%s&#39;&quot;,</span>=
<br><span>         sanitize_control_message(BSTR(buffer), &amp;gc));</span>=
<br><span>@@ -1060,8 +1060,8 @@</span><br><span> }</span><br><span> </span>=
<br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
process_incoming_push_reply(struct context *c, unsigned int permission_mask=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
        unsigned int *option_types_found, struct buffer *buf)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+process_incoming_push_reply(struc=
t context *c, uint64_t permission_mask,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                            uint64_t *option_types_foun=
d, struct buffer *buf)</span><br><span> {</span><br><span>     int ret =3D =
PUSH_MSG_ERROR;</span><br><span>     const int ch =3D buf_read_u8(buf);</sp=
an><br><span>@@ -1110,8 +1110,8 @@</span><br><span> </span><br><span> int</=
span><br><span> process_incoming_push_msg(struct context *c, const struct b=
uffer *buffer,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                   bool honor_received_options, unsigned int permission_mas=
k,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
       unsigned int *option_types_found)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                          bool honor_received_options,=
 uint64_t permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                          uint64_t *option_types_found)</span><br><s=
pan> {</span><br><span>     struct buffer buf =3D *buffer;</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/push.h b/src/openvpn/push.h</spa=
n><br><span>index d18d058..dff945f 100644</span><br><span>--- a/src/openvpn=
/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br><span>@@ -76,12 =
+76,12 @@</span><br><span>  * - `PUSH_MSG_ERROR`: An error occurred during =
message processing, or the message is invalid.</span><br><span>  */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int process=
_push_update(struct context *c, struct options *o, unsigned int permission_=
mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        unsigned int *option_types_found, struct buffer *buf, bool msg_send=
er);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int process_pus=
h_update(struct context *c, struct options *o, uint64_t permission_mask,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  uint64_t *option_types_found, struct buffer *buf, bool msg_sender);</span=
><br><span> </span><br><span> int process_incoming_push_msg(struct context =
*c, const struct buffer *buffer,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                              bool honor_received_options, unsig=
ned int permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                              unsigned int *option_types_found);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   bool honor_received_options, uint64_t permission_mask,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                              uint64_=
t *option_types_found);</span><br><span> </span><br><span> bool send_push_r=
equest(struct context *c);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>index 51c7=
b5f..e129403 100644</span><br><span>--- a/src/openvpn/push_util.c</span><br=
><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -11,8 +11,8 @@</spa=
n><br><span> #endif</span><br><span> </span><br><span> int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-process_push_update(struct context *c,=
 struct options *o, unsigned int permission_mask,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    unsigned int *option_types_=
found, struct buffer *buf, bool msg_sender)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+process_push_update(struct context *c, struct optio=
ns *o, uint64_t permission_mask,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    uint64_t *option_types_found, struct buffe=
r *buf, bool msg_sender)</span><br><span> {</span><br><span>     int ret =
=3D PUSH_MSG_ERROR;</span><br><span>     const int ch =3D buf_read_u8(buf);=
</span><br><span>@@ -146,7 +146,7 @@</span><br><span>         return false;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =
=3D 0;</span><br><span>     struct context *c =3D &amp;mi-&gt;context;</spa=
n><br><span>     struct options o;</span><br><span>     CLEAR(o);</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/u=
nit_tests/openvpn/test_options_parse.c</span><br><span>index 0b3d7fe..e67ea=
e8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_options_parse=
.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</spa=
n><br><span>@@ -40,7 +40,7 @@</span><br><span> void</span><br><span> add_op=
tion(struct options *options, char *p[], bool is_inline, const char *file,<=
/span><br><span>            int line, const int level, const msglvl_t msgle=
vel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           const =
unsigned int permission_mask, unsigned int *option_types_found,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+           const uint64_t permi=
ssion_mask, uint64_t *option_types_found,</span><br><span>            struc=
t env_set *es)</span><br><span> {</span><br><span>     function_called();</=
span><br><span>@@ -51,7 +51,7 @@</span><br><span> void</span><br><span> rem=
ove_option(struct context *c, struct options *options, char *p[], bool is_i=
nline,</span><br><span>               const char *file, int line, const msg=
lvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
        const unsigned int permission_mask, unsigned int *option_types_foun=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              con=
st uint64_t permission_mask, uint64_t *option_types_found,</span><br><span>=
               struct env_set *es)</span><br><span> {</span><br><span> }</s=
pan><br><span>@@ -59,7 +59,7 @@</span><br><span> void</span><br><span> upda=
te_option(struct context *c, struct options *options, char *p[], bool is_in=
line,</span><br><span>               const char *file, int line, const int =
level, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-              const unsigned int permission_mask, unsigned int *o=
ption_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
             const uint64_t permission_mask, uint64_t *option_types_found,<=
/span><br><span>               struct env_set *es)</span><br><span> {</span=
><br><span> }</span><br><span>@@ -191,7 +191,7 @@</span><br><span> static v=
oid</span><br><span> read_single_config(struct options *options, const char=
 *config)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    unsigned int option_types_found =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</span>=
<br><span>     struct env_set es;</span><br><span>     CLEAR(es);</span><br=
><span>     read_config_string(&quot;test_options_parse&quot;, options, con=
fig, M_INFO, OPT_P_DEFAULT,</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_m=
sg.c</span><br><span>index 9b7978e..219b476 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -70,7 +70,7 @@<=
/span><br><span> </span><br><span> bool</span><br><span> apply_push_options=
(struct context *c, struct options *options, struct buffer *buf,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                   unsigned int =
permission_mask, unsigned int *option_types_found,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   uint64_t permission_mask,=
 uint64_t *option_types_found,</span><br><span>                    struct e=
nv_set *es, bool is_update)</span><br><span> {</span><br><span>     char li=
ne[OPTION_PARM_SIZE];</span><br><span>@@ -83,7 +83,7 @@</span><br><span> </=
span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        unsigned int push_update_option_flags =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uint64_t push_update_option_flag=
s =3D 0;</span><br><span>         int i =3D 0;</span><br><span> </span><br>=
<span>         if (is_update || options-&gt;pull_filter_list)</span><br><sp=
an>@@ -131,8 +131,8 @@</span><br><span> </span><br><span> int</span><br><sp=
an> process_incoming_push_msg(struct context *c, const struct buffer *buffe=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
       bool honor_received_options, unsigned int permission_mask,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                          unsig=
ned int *option_types_found)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          bool honor_received_options, uint64_t pe=
rmission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                     uint64_t *option_types_found)</span><br><span> {</span=
><br><span>     struct buffer buf =3D *buffer;</span><br><span> </span><br>=
<span>@@ -206,7 +206,7 @@</span><br><span>     const char *update_msg =3D</=
span><br><span>         &quot;PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route 0.=
0.0.0 0.0.0.0 10.10.10.1&quot;;</span><br><span>     buf_write(&amp;buf, up=
date_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    unsigned int option_types_found =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</s=
pan><br><span> </span><br><span>     assert_int_equal(process_incoming_push=
_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br><s=
pan>                                                &amp;option_types_found=
),</span><br><span>@@ -222,7 +222,7 @@</span><br><span>     struct buffer b=
uf =3D alloc_buf(256);</span><br><span>     const char *update_msg =3D &quo=
t;PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8&quot;;</span><br><span>     buf_wr=
ite(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_f=
ound =3D 0;</span><br><span> </span><br><span>     assert_int_equal(process=
_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c)=
,</span><br><span>                                                &amp;opti=
on_types_found),</span><br><span>@@ -238,7 +238,7 @@</span><br><span>     s=
truct buffer buf =3D alloc_buf(256);</span><br><span>     const char *updat=
e_msg =3D &quot;PUSH_UPDATE ,dhcp-option DNS 8.8.8.8&quot;;</span><br><span=
>     buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_types_found =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t =
option_types_found =3D 0;</span><br><span> </span><br><span>     assert_int=
_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_perm=
ission_mask(c),</span><br><span>                                           =
     &amp;option_types_found),</span><br><span>@@ -254,7 +254,7 @@</span><b=
r><span>     struct buffer buf =3D alloc_buf(256);</span><br><span>     con=
st char *update_msg =3D &quot;PUSH_UPDATE, -?dns, route something, ?dhcp-op=
tion DNS 8.8.8.8&quot;;</span><br><span>     buf_write(&amp;buf, update_msg=
, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int option_types_found =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</span><br><s=
pan> </span><br><span>     assert_int_equal(process_incoming_push_msg(c, &a=
mp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br><span>      =
                                          &amp;option_types_found),</span><=
br><span>@@ -270,7 +270,7 @@</span><br><span>     struct buffer buf =3D all=
oc_buf(256);</span><br><span>     const char *update_msg =3D &quot;PUSH_UPD=
ATE, -dhcp-option, ?-dns&quot;;</span><br><span>     buf_write(&amp;buf, up=
date_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    unsigned int option_types_found =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</s=
pan><br><span> </span><br><span>     assert_int_equal(process_incoming_push=
_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br><s=
pan>                                                &amp;option_types_found=
),</span><br><span>@@ -286,7 +286,7 @@</span><br><span>     struct buffer b=
uf =3D alloc_buf(256);</span><br><span>     const char *update_msg =3D &quo=
t;PUSH_UPDATE, dev tun&quot;;</span><br><span>     buf_write(&amp;buf, upda=
te_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    unsigned int option_types_found =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</span>=
<br><span> </span><br><span>     assert_int_equal(process_incoming_push_msg=
(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br><span>=
                                                &amp;option_types_found),</=
span><br><span>@@ -303,7 +303,7 @@</span><br><span>     const char *update_=
msg =3D</span><br><span>         &quot;PUSH_UPDATE,-dhcp-option, route 10.1=
0.10.0, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.=
local, keepalive 10 60&quot;;</span><br><span>     buf_write(&amp;buf, upda=
te_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    unsigned int option_types_found =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;</span>=
<br><span> </span><br><span>     assert_int_equal(process_incoming_push_msg=
(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br><span>=
                                                &amp;option_types_found),</=
span><br><span>@@ -320,7 +320,7 @@</span><br><span>     const char *update_=
msg =3D</span><br><span>         &quot;PUSH_UPDATE,-dhcp-option,dhcp-option=
 DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0&quot;;<=
/span><br><span>     buf_write(&amp;buf, update_msg, strlen(update_msg));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option=
_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t option_types_found =3D 0;</span><br><span> </span><br><span>  =
   assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pu=
ll, pull_permission_mask(c),</span><br><span>                              =
                  &amp;option_types_found),</span><br><span>@@ -344,7 +344,=
7 @@</span><br><span> test_incoming_push_continuation_route_accumulation(vo=
id **state)</span><br><span> {</span><br><span>     struct context *c =3D *=
state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned in=
t option_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint64_t option_types_found =3D 0;</span><br><span> </span><br>=
<span>     reset_route_counters();</span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1583?usp=3Demail">change 1583</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1583?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ca07e2bbb5de229204191d61e9=
0f084a58969af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1583 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gduuYDCuyjg=--

