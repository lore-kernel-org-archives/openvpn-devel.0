From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Mar 2026 17:50:05 +0000
In-Reply-To: <gerrit.1774014824000.I8ca07e2bbb5de229204191d61e90f084a58969af@...2715...>
References: <gerrit.1774014824000.I8ca07e2bbb5de229204191d61e90f084a58969af@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6f6d36c76a263094eb0b1d8d23fc2105c12bbf80-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="joOxmgrtPcg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--joOxmgrtPcg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
83?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1583
Message-Id: <20260325124338.123477-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
266.html
Signed-off-by: Gert Doering <gert@...1296...>
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
14 files changed, 77 insertions(+), 77 deletions(-)




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
index 24f2407..b4b19f2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4972,8 +4972,8 @@
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
@@ -5065,7 +5065,7 @@
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
@@ -5385,7 +5385,7 @@
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
@@ -5574,8 +5574,8 @@

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
=20
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
=20
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
=20
         if (is_update || options->pull_filter_list)
@@ -131,8 +131,8 @@
=20
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ca07e2bbb5de229204191d61e90f084a58969af
Gerrit-Change-Number: 1583
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--joOxmgrtPcg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1583?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change type of option flag from unsigned int to =
uint64_t<br><br>We currently use all 32 bits of the unsigned int for option=
 classes.<br>While we can probably can retire 2-3 of the existing options, =
at some<br>point we will hit the limit again.<br><br>Instead of fully rewri=
ting this logic to use a different approach or<br>structure, changing the t=
ype from unsigned int to uint64_t seem to be<br>a lot less intrusive approa=
ch.<br><br>Change-Id: I8ca07e2bbb5de229204191d61e90f084a58969af<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1583<br>Message-Id: &lt;20260325124338.123477-1-frank@...2641...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
6266.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/multi.c<br>M =
src/openvpn/multi.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<b=
r>M src/openvpn/options_parse.c<br>M src/openvpn/options_util.c<br>M src/op=
envpn/options_util.h<br>M src/openvpn/push.c<br>M src/openvpn/push.h<br>M s=
rc/openvpn/push_util.c<br>M tests/unit_tests/openvpn/test_options_parse.c<b=
r>M tests/unit_tests/openvpn/test_push_update_msg.c<br>14 files changed, 77=
 insertions(+), 77 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 34ed4eb..9b7bd42 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2339,7 +2339,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-do_up(struct context *c, bool pulled_opti=
ons, unsigned int option_types_found)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+do_up(struct context *c, bool pulled_options, uint64_t op=
tion_types_found)</span><br><span> {</span><br><span>     int error_flags =
=3D 0;</span><br><span>     if (!c-&gt;c2.do_up_ran)</span><br><span>@@ -24=
74,7 +2474,7 @@</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_update(struct conte=
xt *c, unsigned int option_types_found)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+do_update(struct context *c, uint64_t option_types_foun=
d)</span><br><span> {</span><br><span>     /* Not necessary since to receiv=
e the update the openvpn</span><br><span>      * instance must be up and ru=
nning but just in case</span><br><span>@@ -2588,7 +2588,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-do_deferred_options(struct context *c, const unsigne=
d int found, const bool is_update)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+do_deferred_options(struct context *c, const uint64_t found,=
 const bool is_update)</span><br><span> {</span><br><span>     if (found &a=
mp; OPT_P_MESSAGES)</span><br><span>     {</span><br><span>@@ -4209,7 +4209=
,7 @@</span><br><span>                 int i;</span><br><span>             =
    for (i =3D 0; i &lt; config.n; ++i)</span><br><span>                 {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    un=
signed int option_types_found =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    uint64_t option_types_found =3D 0;</sp=
an><br><span>                     if (config.list[i] &amp;&amp; config.list=
[i]-&gt;value)</span><br><span>                     {</span><br><span>     =
                    options_string_import(</span><br><span>diff --git a/src=
/openvpn/init.h b/src/openvpn/init.h</span><br><span>index 9c4cf71..9d5050d=
 100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/=
openvpn/init.h</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </span><b=
r><span> void context_gc_free(struct context *c);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-bool do_up(struct context *c,=
 bool pulled_options, unsigned int option_types_found);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool do_up(struct context *c, bool pull=
ed_options, uint64_t option_types_found);</span><br><span> </span><br><span=
> /**</span><br><span>  * @brief A simplified version of the do_up() functi=
on. This function is called</span><br><span>@@ -87,7 +87,7 @@</span><br><sp=
an>  * @return true on success.</span><br><span>  * @return false on error.=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool do_update(struct context *c, unsigned int option_types_found);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_update(struct conte=
xt *c, uint64_t option_types_found);</span><br><span> </span><br><span> uns=
igned int pull_permission_mask(const struct context *c);</span><br><span> <=
/span><br><span>@@ -99,7 +99,7 @@</span><br><span>  * Handle non-tun-relate=
d pulled options.</span><br><span>  * Set `is_update` param to true to skip=
 NCP check.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool do_deferred_options(struct context *c, const unsigned int f=
ound, const bool is_update);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool do_deferred_options(struct context *c, const uint64_t found, =
const bool is_update);</span><br><span> </span><br><span> void inherit_cont=
ext_child(struct context *dest, const struct context *src,</span><br><span>=
                            struct link_socket *sock);</span><br><span>diff=
 --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 16=
25fd0..22f8b54 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><=
span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1619,7 +1619,7 @@</span>=
<br><span>  */</span><br><span> static void</span><br><span> multi_client_c=
onnect_post(struct multi_context *m, struct multi_instance *mi, const char =
*dc_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
              unsigned int *option_types_found)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                          uint64_t *option_type=
s_found)</span><br><span> {</span><br><span>     /* Did script generate a d=
ynamic config file? */</span><br><span>     if (platform_test_file(dc_file)=
)</span><br><span>@@ -1645,7 +1645,7 @@</span><br><span>  */</span><br><spa=
n> static void</span><br><span> multi_client_connect_post_plugin(struct mul=
ti_context *m, struct multi_instance *mi,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                 const struct plugin_re=
turn *pr, unsigned int *option_types_found)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 const struct plugi=
n_return *pr, uint64_t *option_types_found)</span><br><span> {</span><br><s=
pan>     struct plugin_return config;</span><br><span> </span><br><span>@@ =
-1684,7 +1684,7 @@</span><br><span>  */</span><br><span> enum client_connec=
t_return</span><br><span> multi_client_connect_mda(struct multi_context *m,=
 struct multi_instance *mi, bool deferred,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                         unsigned int *option_types_fo=
und)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          uint64_t *option_types_found)</span><br><span> {</span><br><span>=
     /* We never return CC_RET_DEFERRED */</span><br><span>     ASSERT(!def=
erred);</span><br><span>@@ -2055,7 +2055,7 @@</span><br><span> </span><br><=
span> static enum client_connect_return</span><br><span> multi_client_conne=
ct_call_plugin_v1(struct multi_context *m, struct multi_instance *mi,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
         bool deferred, unsigned int *option_types_found)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                    b=
ool deferred, uint64_t *option_types_found)</span><br><span> {</span><br><s=
pan>     enum client_connect_return ret =3D CC_RET_SKIPPED;</span><br><span=
> #ifdef ENABLE_PLUGIN</span><br><span>@@ -2145,7 +2145,7 @@</span><br><spa=
n> </span><br><span> static enum client_connect_return</span><br><span> mul=
ti_client_connect_call_plugin_v2(struct multi_context *m, struct multi_inst=
ance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                        bool deferred, unsigned int *option_types_found)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
              bool deferred, uint64_t *option_types_found)</span><br><span>=
 {</span><br><span>     enum client_connect_return ret =3D CC_RET_SKIPPED;<=
/span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>@@ -2194,7 +2194,7 @@=
</span><br><span> </span><br><span> static enum client_connect_return</span=
><br><span> multi_client_connect_script_deferred(struct multi_context *m, s=
truct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                     unsigned int *option_types_found)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                 uint64_t *option_types_found)</span><br><span> {</span><br=
><span>     ASSERT(mi);</span><br><span>     ASSERT(option_types_found);</s=
pan><br><span>@@ -2235,7 +2235,7 @@</span><br><span>  */</span><br><span> s=
tatic enum client_connect_return</span><br><span> multi_client_connect_call=
_script(struct multi_context *m, struct multi_instance *mi, bool deferred,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
           unsigned int *option_types_found)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 uint64_t *option_=
types_found)</span><br><span> {</span><br><span>     if (deferred)</span><b=
r><span>     {</span><br><span>@@ -2339,7 +2339,7 @@</span><br><span> </spa=
n><br><span> static void</span><br><span> multi_client_connect_late_setup(s=
truct multi_context *m, struct multi_instance *mi,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                const unsigned=
 int option_types_found)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                const uint64_t option_types_found)</sp=
an><br><span> {</span><br><span>     ASSERT(m);</span><br><span>     ASSERT=
(mi);</span><br><span>@@ -2497,7 +2497,7 @@</span><br><span>  */</span><br>=
<span> static enum client_connect_return</span><br><span> multi_client_conn=
ect_compress_migrate(struct multi_context *m, struct multi_instance *mi,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
              bool deferred, unsigned int *option_types_found)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
      bool deferred, uint64_t *option_types_found)</span><br><span> {</span=
><br><span> #ifdef USE_COMP</span><br><span>     struct options *o =3D &amp=
;mi-&gt;context.options;</span><br><span>@@ -2529,7 +2529,7 @@</span><br><s=
pan>  */</span><br><span> static enum client_connect_return</span><br><span=
> multi_client_connect_source_ccd(struct multi_context *m, struct multi_ins=
tance *mi, bool deferred,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                unsigned int *option_types_found)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       uint64_t *option_types_found)</span><br><span> {</span><br><span>   =
  /* Since we never return a CC_RET_DEFERRED, this indicates a serious</spa=
n><br><span>      * problem */</span><br><span>@@ -2580,7 +2580,7 @@</span>=
<br><span> </span><br><span> typedef enum client_connect_return (*multi_cli=
ent_connect_handler)(</span><br><span>     struct multi_context *m, struct =
multi_instance *mi, bool from_deferred,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int *option_types_found);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint64_t *option_types_found);</sp=
an><br><span> </span><br><span> static const multi_client_connect_handler c=
lient_connect_handlers[] =3D {</span><br><span>     multi_client_connect_co=
mpress_migrate,</span><br><span>@@ -2678,7 +2678,7 @@</span><br><span>     =
bool from_deferred =3D (mi-&gt;context.c2.tls_multi-&gt;multi_state !=3D CA=
S_PENDING);</span><br><span> </span><br><span>     int *cur_handler_index =
=3D &amp;mi-&gt;client_connect_defer_state.cur_handler_index;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int *option_types_foun=
d =3D &amp;mi-&gt;client_connect_defer_state.option_types_found;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t *option_types_fou=
nd =3D &amp;mi-&gt;client_connect_defer_state.option_types_found;</span><br=
><span> </span><br><span>     /* We are called for the first time */</span>=
<br><span>     if (!from_deferred)</span><br><span>diff --git a/src/openvpn=
/multi.h b/src/openvpn/multi.h</span><br><span>index c686e47..7e2a77d 10064=
4</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openv=
pn/multi.h</span><br><span>@@ -73,7 +73,7 @@</span><br><span>     int cur_h=
andler_index;</span><br><span>     /* Remember which option classes where p=
rocessed for delayed option</span><br><span>      * handling. */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_types_fo=
und;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t op=
tion_types_found;</span><br><span> </span><br><span>     /**</span><br><spa=
n>      * The temporary file name that contains the return status of the</s=
pan><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</s=
pan><br><span>index 24f2407..b4b19f2 100644</span><br><span>--- a/src/openv=
pn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@=
 -4972,8 +4972,8 @@</span><br><span>     }</span><br><span> </span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_=
permission(const char *name, const char *file, int line, const unsigned int=
 type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   const unsigned int allowed, unsigned int *found, const msglvl_t msglevel=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+verify_permission(=
const char *name, const char *file, int line, const uint64_t type,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  const uint=
64_t allowed, uint64_t *found, const msglvl_t msglevel,</span><br><span>   =
                struct options *options, bool is_inline)</span><br><span> {=
</span><br><span>     if (!(type &amp; allowed))</span><br><span>@@ -5065,7=
 +5065,7 @@</span><br><span> void</span><br><span> remove_option(struct con=
text *c, struct options *options, char *p[], bool is_inline,</span><br><spa=
n>               const char *file, int line, const msglvl_t msglevel,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-              const unsigne=
d int permission_mask, unsigned int *option_types_found,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+              const uint64_t permissio=
n_mask, uint64_t *option_types_found,</span><br><span>               struct=
 env_set *es)</span><br><span> {</span><br><span>     msglvl_t msglevel_fc =
=3D msglevel_forward_compatible(options, msglevel);</span><br><span>@@ -538=
5,7 +5385,7 @@</span><br><span> void</span><br><span> update_option(struct =
context *c, struct options *options, char *p[], bool is_inline,</span><br><=
span>               const char *file, int line, const int level, const msgl=
vl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
       const unsigned int permission_mask, unsigned int *option_types_found=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              cons=
t uint64_t permission_mask, uint64_t *option_types_found,</span><br><span> =
              struct env_set *es)</span><br><span> {</span><br><span>     c=
onst bool pull_mode =3D BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE);</=
span><br><span>@@ -5574,8 +5574,8 @@</span><br><span> </span><br><span> voi=
d</span><br><span> add_option(struct options *options, char *p[], bool is_i=
nline, const char *file, int line,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-           const int level, const msglvl_t msglevel, const uns=
igned int permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-           unsigned int *option_types_found, struct env_set *es)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+           const int leve=
l, const msglvl_t msglevel, const uint64_t permission_mask,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           uint64_t *option_types_f=
ound, struct env_set *es)</span><br><span> {</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span>     const bool pull_mode =3D BOOL_=
CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><span>diff --git a/s=
rc/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 3d8b505.=
.ae3156a 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span=
>+++ b/src/openvpn/options.h</span><br><span>@@ -553,8 +553,8 @@</span><br>=
<span>     bool client;</span><br><span>     bool pull; /* client pull of c=
onfig options from server */</span><br><span>     int push_continuation;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int push_op=
tion_types_found;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
unsigned int push_update_options_found; /* tracks which option types have b=
een reset in current PUSH_UPDATE sequence */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint64_t push_option_types_found;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint64_t push_update_options=
_found; /* tracks which option types have been reset in current PUSH_UPDATE=
 sequence */</span><br><span>     const char *auth_user_pass_file;</span><b=
r><span>     bool auth_user_pass_file_inline;</span><br><span>     struct o=
ptions_pre_connect *pre_connect;</span><br><span>@@ -808,7 +808,7 @@</span>=
<br><span> </span><br><span> void add_option(struct options *options, char =
*p[], bool is_inline, const char *file,</span><br><span>                 in=
t line, const int level, const msglvl_t msglevel,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                const unsigned int permission_m=
ask, unsigned int *option_types_found,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                const uint64_t permission_mask, uint64_t=
 *option_types_found,</span><br><span>                 struct env_set *es);=
</span><br><span> </span><br><span> /**</span><br><span>@@ -833,7 +833,7 @@=
</span><br><span>  */</span><br><span> void remove_option(struct context *c=
, struct options *options, char *p[], bool is_inline,</span><br><span>     =
               const char *file, int line, const msglvl_t msglevel,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                   const unsi=
gned int permission_mask, unsigned int *option_types_found,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                   const uint64_t p=
ermission_mask, uint64_t *option_types_found,</span><br><span>             =
       struct env_set *es);</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -858,21 +858,21 @@</span><br><span>  */</span><br><span> void up=
date_option(struct context *c, struct options *options, char *p[], bool is_=
inline,</span><br><span>                    const char *file, int line, con=
st int level, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                   const unsigned int permission_mask, uns=
igned int *option_types_found,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                   const uint64_t permission_mask, uint64_t *opt=
ion_types_found,</span><br><span>                    struct env_set *es);</=
span><br><span> </span><br><span> void parse_argv(struct options *options, =
const int argc, char *argv[], const msglvl_t msglevel,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                const unsigned int permiss=
ion_mask, unsigned int *option_types_found,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                const uint64_t permission_mask, uin=
t64_t *option_types_found,</span><br><span>                 struct env_set =
*es);</span><br><span> </span><br><span> void read_config_file(struct optio=
ns *options, const char *file, int level, const char *top_file,</span><br><=
span>                       const int top_line, const msglvl_t msglevel,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      co=
nst unsigned int permission_mask, unsigned int *option_types_found,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      const=
 uint64_t permission_mask, uint64_t *option_types_found,</span><br><span>  =
                     struct env_set *es);</span><br><span> </span><br><span=
> void read_config_string(const char *prefix, struct options *options, cons=
t char *config,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  const msglvl_t msglevel, const unsigned int permission_ma=
sk,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      unsigned int *option_types_found, struct env_set *es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        const msgl=
vl_t msglevel, const uint64_t permission_mask,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        uint64_t *option_types_f=
ound, struct env_set *es);</span><br><span> </span><br><span> void notnull(=
const char *arg, const char *description);</span><br><span> </span><br><spa=
n>@@ -933,13 +933,13 @@</span><br><span> void pre_connect_restore(struct op=
tions *o, struct gc_arena *gc);</span><br><span> </span><br><span> bool app=
ly_push_options(struct context *c, struct options *options, struct buffer *=
buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       unsigned int permission_mask, unsigned int *option_types_found,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
uint64_t permission_mask, uint64_t *option_types_found,</span><br><span>   =
                      struct env_set *es, bool is_update);</span><br><span>=
 </span><br><span> void options_detach(struct options *o);</span><br><span>=
 </span><br><span> void options_server_import(struct options *o, const char=
 *filename, msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                           unsigned int permission_mask, unsigned =
int *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                           uint64_t permission_mask, uint64_t *option_=
types_found,</span><br><span>                            struct env_set *es=
);</span><br><span> </span><br><span> void pre_pull_default(struct options =
*o);</span><br><span>@@ -972,7 +972,7 @@</span><br><span> const char *auth_=
retry_print(void);</span><br><span> </span><br><span> void options_string_i=
mport(struct options *options, const char *config, const msglvl_t msglevel,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
      const unsigned int permission_mask, unsigned int *option_types_found,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
        const uint64_t permission_mask, uint64_t *option_types_found,</span=
><br><span>                            struct env_set *es);</span><br><span=
> </span><br><span> bool key_is_external(const struct options *options);</s=
pan><br><span>diff --git a/src/openvpn/options_parse.c b/src/openvpn/option=
s_parse.c</span><br><span>index cb51ad2..a8c4aee 100644</span><br><span>---=
 a/src/openvpn/options_parse.c</span><br><span>+++ b/src/openvpn/options_pa=
rse.c</span><br><span>@@ -346,7 +346,7 @@</span><br><span> void</span><br><=
span> read_config_file(struct options *options, const char *file, int level=
, const char *top_file,</span><br><span>                  const int top_lin=
e, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                 const unsigned int permission_mask, unsigned int *op=
tion_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               const uint64_t permission_mask, uint64_t *option_types_found=
,</span><br><span>                  struct env_set *es)</span><br><span> {<=
/span><br><span>     const int max_recursive_levels =3D 10;</span><br><span=
>@@ -419,8 +419,8 @@</span><br><span> </span><br><span> void</span><br><spa=
n> read_config_string(const char *prefix, struct options *options, const ch=
ar *config,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         const msglvl_t msglevel, const unsigned int permission_mask,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   unsigned=
 int *option_types_found, struct env_set *es)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                   const msglvl_t msglevel, const=
 uint64_t permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   uint64_t *option_types_found, struct env_set *es)=
</span><br><span> {</span><br><span>     char line[OPTION_LINE_SIZE];</span=
><br><span>     struct buffer multiline;</span><br><span>@@ -448,7 +448,7 @=
@</span><br><span> </span><br><span> void</span><br><span> parse_argv(struc=
t options *options, const int argc, char *argv[], const msglvl_t msglevel,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-           const unsig=
ned int permission_mask, unsigned int *option_types_found, struct env_set *=
es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           const=
 uint64_t permission_mask, uint64_t *option_types_found, struct env_set *es=
)</span><br><span> {</span><br><span>     /* usage message */</span><br><sp=
an>     if (argc &lt;=3D 1)</span><br><span>@@ -510,7 +510,7 @@</span><br><=
span> </span><br><span> bool</span><br><span> apply_push_options(struct con=
text *c, struct options *options, struct buffer *buf,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   unsigned int permission_=
mask, unsigned int *option_types_found,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   uint64_t permission_mask, uint64_t *=
option_types_found,</span><br><span>                    struct env_set *es,=
 bool is_update)</span><br><span> {</span><br><span>     char line[OPTION_P=
ARM_SIZE];</span><br><span>@@ -523,7 +523,7 @@</span><br><span>         cha=
r *p[MAX_PARMS + 1];</span><br><span>         CLEAR(p);</span><br><span>   =
      ++line_num;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    unsigned int push_update_option_flags =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uint64_t push_update_option_flags =3D =
0;</span><br><span>         int i =3D 0;</span><br><span> </span><br><span>=
         /* skip leading spaces matching the behaviour of parse_line */</sp=
an><br><span>@@ -578,7 +578,7 @@</span><br><span> </span><br><span> void</s=
pan><br><span> options_server_import(struct options *o, const char *filenam=
e, msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      unsigned int permission_mask, unsigned int *option_ty=
pes_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             const uint64_t permission_mask, uint64_t *option_types_found,<=
/span><br><span>                       struct env_set *es)</span><br><span>=
 {</span><br><span>     msg(D_PUSH, &quot;OPTIONS IMPORT: reading client sp=
ecific options from: %s&quot;, filename);</span><br><span>@@ -588,7 +588,7 =
@@</span><br><span> </span><br><span> void</span><br><span> options_string_=
import(struct options *options, const char *config, const msglvl_t msglevel=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
  const unsigned int permission_mask, unsigned int *option_types_found,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                      c=
onst uint64_t permission_mask, uint64_t *option_types_found,</span><br><spa=
n>                       struct env_set *es)</span><br><span> {</span><br><=
span>     read_config_string(&quot;[CONFIG-STRING]&quot;, options, config, =
msglevel, permission_mask,</span><br><span>diff --git a/src/openvpn/options=
_util.c b/src/openvpn/options_util.c</span><br><span>index 8d0a143..47fe0bc=
 100644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>++=
+ b/src/openvpn/options_util.c</span><br><span>@@ -203,7 +203,7 @@</span><b=
r><span>                                            &quot;tun-mtu&quot;, &q=
uot;keepalive&quot; };</span><br><span> </span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_push_update_option_flags(cha=
r *line, int *i, unsigned int *flags)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+check_push_update_option_flags(char *line, int *i, uint64=
_t *flags)</span><br><span> {</span><br><span>     *flags =3D 0;</span><br>=
<span>     bool opt_is_updatable =3D false;</span><br><span>diff --git a/sr=
c/openvpn/options_util.h b/src/openvpn/options_util.h</span><br><span>index=
 511d189..1d4ea9b 100644</span><br><span>--- a/src/openvpn/options_util.h</=
span><br><span>+++ b/src/openvpn/options_util.h</span><br><span>@@ -106,6 +=
106,6 @@</span><br><span>  *         - The `line` parameter is empty or `NU=
LL`.</span><br><span>  *         - The `?` flag is absent and the option is=
 not updatable.</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool check_push_update_option_flags(char *line, int *i, unsi=
gned int *flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol check_push_update_option_flags(char *line, int *i, uint64_t *flags);</sp=
an><br><span> </span><br><span> #endif /* ifndef OPTIONS_UTIL_H_ */</span><=
br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><sp=
an>index 93c5558..835c433 100644</span><br><span>--- a/src/openvpn/push.c</=
span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -505,7 +505,7 @@=
</span><br><span> incoming_push_message(struct context *c, const struct buf=
fer *buffer)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d int option_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint64_t option_types_found =3D 0;</span><br><span> </span>=
<br><span>     msg(D_PUSH, &quot;PUSH: Received control message: &#39;%s&#3=
9;&quot;,</span><br><span>         sanitize_control_message(BSTR(buffer), &=
amp;gc));</span><br><span>@@ -1060,8 +1060,8 @@</span><br><span> }</span><b=
r><span> </span><br><span> static int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-process_incoming_push_reply(struct context *c, unsigned int=
 permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                        unsigned int *option_types_found, struct buffer *bu=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_=
push_reply(struct context *c, uint64_t permission_mask,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            uint64_t *o=
ption_types_found, struct buffer *buf)</span><br><span> {</span><br><span> =
    int ret =3D PUSH_MSG_ERROR;</span><br><span>     const int ch =3D buf_r=
ead_u8(buf);</span><br><span>@@ -1110,8 +1110,8 @@</span><br><span> </span>=
<br><span> int</span><br><span> process_incoming_push_msg(struct context *c=
, const struct buffer *buffer,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                          bool honor_received_options, unsigned in=
t permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                       unsigned int *option_types_found)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                          bool honor_r=
eceived_options, uint64_t permission_mask,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                          uint64_t *option_types_fou=
nd)</span><br><span> {</span><br><span>     struct buffer buf =3D *buffer;<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/push.h b/src/ope=
nvpn/push.h</span><br><span>index d18d058..dff945f 100644</span><br><span>-=
-- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</span><br>=
<span>@@ -76,12 +76,12 @@</span><br><span>  * - `PUSH_MSG_ERROR`: An error =
occurred during message processing, or the message is invalid.</span><br><s=
pan>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int process_push_update(struct context *c, struct options *o, unsigned=
 int permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        unsigned int *option_types_found, struct buffer *bu=
f, bool msg_sender);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int process_push_update(struct context *c, struct options *o, uint64_t per=
mission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  uint64_t *option_types_found, struct buffer *buf, bool ms=
g_sender);</span><br><span> </span><br><span> int process_incoming_push_msg=
(struct context *c, const struct buffer *buffer,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                              bool honor_receive=
d_options, unsigned int permission_mask,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                              unsigned int *option_types=
_found);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   bool honor_received_options, uint64_t permission_mask,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
         uint64_t *option_types_found);</span><br><span> </span><br><span> =
bool send_push_request(struct context *c);</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br>=
<span>index 51c7b5f..e129403 100644</span><br><span>--- a/src/openvpn/push_=
util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -11=
,8 +11,8 @@</span><br><span> #endif</span><br><span> </span><br><span> int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-process_push_update(st=
ruct context *c, struct options *o, unsigned int permission_mask,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    unsigned in=
t *option_types_found, struct buffer *buf, bool msg_sender)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+process_push_update(struct context =
*c, struct options *o, uint64_t permission_mask,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    uint64_t *option_types_fou=
nd, struct buffer *buf, bool msg_sender)</span><br><span> {</span><br><span=
>     int ret =3D PUSH_MSG_ERROR;</span><br><span>     const int ch =3D buf=
_read_u8(buf);</span><br><span>@@ -146,7 +146,7 @@</span><br><span>        =
 return false;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t optio=
n_types_found =3D 0;</span><br><span>     struct context *c =3D &amp;mi-&gt=
;context;</span><br><span>     struct options o;</span><br><span>     CLEAR=
(o);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_options_par=
se.c b/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>index =
0b3d7fe..e67eae8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_options_parse.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_option=
s_parse.c</span><br><span>@@ -40,7 +40,7 @@</span><br><span> void</span><br=
><span> add_option(struct options *options, char *p[], bool is_inline, cons=
t char *file,</span><br><span>            int line, const int level, const =
msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
        const unsigned int permission_mask, unsigned int *option_types_foun=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           const =
uint64_t permission_mask, uint64_t *option_types_found,</span><br><span>   =
         struct env_set *es)</span><br><span> {</span><br><span>     functi=
on_called();</span><br><span>@@ -51,7 +51,7 @@</span><br><span> void</span>=
<br><span> remove_option(struct context *c, struct options *options, char *=
p[], bool is_inline,</span><br><span>               const char *file, int l=
ine, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-              const unsigned int permission_mask, unsigned int *opt=
ion_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
           const uint64_t permission_mask, uint64_t *option_types_found,</s=
pan><br><span>               struct env_set *es)</span><br><span> {</span><=
br><span> }</span><br><span>@@ -59,7 +59,7 @@</span><br><span> void</span><=
br><span> update_option(struct context *c, struct options *options, char *p=
[], bool is_inline,</span><br><span>               const char *file, int li=
ne, const int level, const msglvl_t msglevel,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-              const unsigned int permission_mask, u=
nsigned int *option_types_found,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+              const uint64_t permission_mask, uint64_t *option=
_types_found,</span><br><span>               struct env_set *es)</span><br>=
<span> {</span><br><span> }</span><br><span>@@ -191,7 +191,7 @@</span><br><=
span> static void</span><br><span> read_single_config(struct options *optio=
ns, const char *config)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found=
 =3D 0;</span><br><span>     struct env_set es;</span><br><span>     CLEAR(=
es);</span><br><span>     read_config_string(&quot;test_options_parse&quot;=
, options, config, M_INFO, OPT_P_DEFAULT,</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test=
_push_update_msg.c</span><br><span>index 9b7978e..219b476 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -=
70,7 +70,7 @@</span><br><span> </span><br><span> bool</span><br><span> appl=
y_push_options(struct context *c, struct options *options, struct buffer *b=
uf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
 unsigned int permission_mask, unsigned int *option_types_found,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   uint64_t pe=
rmission_mask, uint64_t *option_types_found,</span><br><span>              =
      struct env_set *es, bool is_update)</span><br><span> {</span><br><spa=
n>     char line[OPTION_PARM_SIZE];</span><br><span>@@ -83,7 +83,7 @@</span=
><br><span> </span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, =
sizeof(line)))</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        unsigned int push_update_option_flags =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        uint64_t push_upda=
te_option_flags =3D 0;</span><br><span>         int i =3D 0;</span><br><spa=
n> </span><br><span>         if (is_update || options-&gt;pull_filter_list)=
</span><br><span>@@ -131,8 +131,8 @@</span><br><span> </span><br><span> int=
</span><br><span> process_incoming_push_msg(struct context *c, const struct=
 buffer *buffer,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                     bool honor_received_options, unsigned int permission_m=
ask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
         unsigned int *option_types_found)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                          bool honor_received_option=
s, uint64_t permission_mask,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          uint64_t *option_types_found)</span><br>=
<span> {</span><br><span>     struct buffer buf =3D *buffer;</span><br><spa=
n> </span><br><span>@@ -206,7 +206,7 @@</span><br><span>     const char *up=
date_msg =3D</span><br><span>         &quot;PUSH_UPDATE,dhcp-option DNS 8.8=
.8.8, route 0.0.0.0 0.0.0.0 10.10.10.1&quot;;</span><br><span>     buf_writ=
e(&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_fou=
nd =3D 0;</span><br><span> </span><br><span>     assert_int_equal(process_i=
ncoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),<=
/span><br><span>                                                &amp;option=
_types_found),</span><br><span>@@ -222,7 +222,7 @@</span><br><span>     str=
uct buffer buf =3D alloc_buf(256);</span><br><span>     const char *update_=
msg =3D &quot;PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8&quot;;</span><br><span=
>     buf_write(&amp;buf, update_msg, strlen(update_msg));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_types_found =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t =
option_types_found =3D 0;</span><br><span> </span><br><span>     assert_int=
_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_perm=
ission_mask(c),</span><br><span>                                           =
     &amp;option_types_found),</span><br><span>@@ -238,7 +238,7 @@</span><b=
r><span>     struct buffer buf =3D alloc_buf(256);</span><br><span>     con=
st char *update_msg =3D &quot;PUSH_UPDATE ,dhcp-option DNS 8.8.8.8&quot;;</=
span><br><span>     buf_write(&amp;buf, update_msg, strlen(update_msg));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int option_=
types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint64_t option_types_found =3D 0;</span><br><span> </span><br><span>   =
  assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;options.pul=
l, pull_permission_mask(c),</span><br><span>                               =
                 &amp;option_types_found),</span><br><span>@@ -254,7 +254,7=
 @@</span><br><span>     struct buffer buf =3D alloc_buf(256);</span><br><s=
pan>     const char *update_msg =3D &quot;PUSH_UPDATE, -?dns, route somethi=
ng, ?dhcp-option DNS 8.8.8.8&quot;;</span><br><span>     buf_write(&amp;buf=
, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D 0;<=
/span><br><span> </span><br><span>     assert_int_equal(process_incoming_pu=
sh_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span><br>=
<span>                                                &amp;option_types_fou=
nd),</span><br><span>@@ -270,7 +270,7 @@</span><br><span>     struct buffer=
 buf =3D alloc_buf(256);</span><br><span>     const char *update_msg =3D &q=
uot;PUSH_UPDATE, -dhcp-option, ?-dns&quot;;</span><br><span>     buf_write(=
&amp;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found=
 =3D 0;</span><br><span> </span><br><span>     assert_int_equal(process_inc=
oming_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</s=
pan><br><span>                                                &amp;option_t=
ypes_found),</span><br><span>@@ -286,7 +286,7 @@</span><br><span>     struc=
t buffer buf =3D alloc_buf(256);</span><br><span>     const char *update_ms=
g =3D &quot;PUSH_UPDATE, dev tun&quot;;</span><br><span>     buf_write(&amp=
;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D=
 0;</span><br><span> </span><br><span>     assert_int_equal(process_incomin=
g_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span>=
<br><span>                                                &amp;option_types=
_found),</span><br><span>@@ -303,7 +303,7 @@</span><br><span>     const cha=
r *update_msg =3D</span><br><span>         &quot;PUSH_UPDATE,-dhcp-option, =
route 10.10.10.0, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DO=
MAIN corp.local, keepalive 10 60&quot;;</span><br><span>     buf_write(&amp=
;buf, update_msg, strlen(update_msg));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int option_types_found =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint64_t option_types_found =3D=
 0;</span><br><span> </span><br><span>     assert_int_equal(process_incomin=
g_push_msg(c, &amp;buf, c-&gt;options.pull, pull_permission_mask(c),</span>=
<br><span>                                                &amp;option_types=
_found),</span><br><span>@@ -320,7 +320,7 @@</span><br><span>     const cha=
r *update_msg =3D</span><br><span>         &quot;PUSH_UPDATE,-dhcp-option,d=
hcp-option DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255=
.0&quot;;</span><br><span>     buf_write(&amp;buf, update_msg, strlen(updat=
e_msg));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
int option_types_found =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint64_t option_types_found =3D 0;</span><br><span> </span><b=
r><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf, c-&gt;=
options.pull, pull_permission_mask(c),</span><br><span>                    =
                            &amp;option_types_found),</span><br><span>@@ -3=
44,7 +344,7 @@</span><br><span> test_incoming_push_continuation_route_accum=
ulation(void **state)</span><br><span> {</span><br><span>     struct contex=
t *c =3D *state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned int option_types_found =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint64_t option_types_found =3D 0;</span><br><span> <=
/span><br><span>     reset_route_counters();</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1583?usp=3Demail">change 1583</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1583?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ca07e2bbb5de229204191d61e9=
0f084a58969af </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1583 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--joOxmgrtPcg=--

