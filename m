From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 23:02:29 +0000
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5684d11f71fd3ef95b64b490c815d4f86d80a174-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FPwb6eEOU6E="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FPwb6eEOU6E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1610?usp=3Demail

to review the following change.


Change subject: Remove various unused functions
......................................................................

Remove various unused functions

Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.h
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_openssl.c
M src/openvpn/dco_win.h
M src/openvpn/env_set.c
M src/openvpn/env_set.h
M src/openvpn/event.h
M src/openvpn/interval.h
M src/openvpn/manage.h
M src/openvpn/mroute.h
M src/openvpn/multi_io.c
M src/openvpn/openvpn.c
M src/openvpn/plugin.c
M src/openvpn/plugin.h
M src/openvpn/route.c
M src/openvpn/route.h
18 files changed, 0 insertions(+), 271 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1610/1

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index fcc923b..aef29de 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -805,28 +805,6 @@
     return ntohs(ret);
 }

-static inline uint32_t
-buf_read_u32(struct buffer *buf, bool *good)
-{
-    uint32_t ret;
-    if (!buf_read(buf, &ret, sizeof(uint32_t)))
-    {
-        if (good)
-        {
-            *good =3D false;
-        }
-        return 0;
-    }
-    else
-    {
-        if (good)
-        {
-            *good =3D true;
-        }
-        return ntohl(ret);
-    }
-}
-
 /** Return true if buffer contents are equal */
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer *b)
@@ -1018,12 +996,6 @@

 void x_gc_freespecial(struct gc_arena *a);

-static inline bool
-gc_defined(struct gc_arena *a)
-{
-    return a->list !=3D NULL;
-}
-
 static inline void
 gc_init(struct gc_arena *a)
 {
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 0bfa8b4..4e9283d 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -591,15 +591,6 @@
 void md_ctx_cleanup(md_ctx_t *ctx);

 /*
- * Returns the size of the message digest output by the given context
- *
- * @param ctx           Message digest context.
- *
- * @return              Size of the message digest, or \0 if ctx is NULL.
- */
-int md_ctx_size(const md_ctx_t *ctx);
-
-/*
  * Process the given data for use in the message digest.
  *
  * @param ctx           Message digest context. May not be NULL.
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c41daef..b0d0820 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -740,16 +740,6 @@
     ASSERT(psa_hash_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
 }

-int
-md_ctx_size(const md_ctx_t *ctx)
-{
-    if (ctx =3D=3D NULL)
-    {
-        return 0;
-    }
-    return (int)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
-}
-
 void
 md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index 087d94c..3f04a3e 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -863,16 +863,6 @@
     mbedtls_md_free(ctx);
 }

-int
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-    {
-        return 0;
-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
 void
 md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_le=
n)
 {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 9900d06..e49f654 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1152,12 +1152,6 @@
     EVP_MD_CTX_reset(ctx);
 }

-int
-md_ctx_size(const EVP_MD_CTX *ctx)
-{
-    return EVP_MD_CTX_size(ctx);
-}
-
 void
 md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index ac3ce33..a92e5ad 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *s=
ock,
                       struct signal_info *sig_info);

-void dco_start_tun(struct tuntap *tt);
-
 bool dco_win_supports_multipeer(void);

 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned i=
nt netbits,
@@ -79,13 +77,5 @@

 void dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsi=
gned int netbits);

-#else  /* if defined(ENABLE_DCO) && defined(_WIN32) */
-
-static inline void
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* defined(_WIN32) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index d992097..e147913 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -209,32 +209,6 @@
 }

 void
-env_set_print(msglvl_t msglevel, const struct env_set *es)
-{
-    if (check_debug_level(msglevel))
-    {
-        const struct env_item *e;
-        int i;
-
-        if (es)
-        {
-            e =3D es->list;
-            i =3D 0;
-
-            while (e)
-            {
-                if (env_safe_to_print(e->string))
-                {
-                    msg(msglevel, "ENV [%d] '%s'", i, e->string);
-                }
-                ++i;
-                e =3D e->next;
-            }
-        }
-    }
-}
-
-void
 env_set_write_file(const char *path, const struct env_set *es)
 {
     FILE *fp =3D platform_fopen(path, "w");
@@ -411,15 +385,6 @@
 }

 void
-setenv_int_i(struct env_set *es, const char *name, const int value, const =
int i)
-{
-    struct gc_arena gc =3D gc_new();
-    const char *name_str =3D setenv_format_indexed_name(name, i, &gc);
-    setenv_int(es, name_str, value);
-    gc_free(&gc);
-}
-
-void
 setenv_str_i(struct env_set *es, const char *name, const char *value, cons=
t int i)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index fcfc3ca..9b4a1e7 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -69,8 +69,6 @@
  */
 void setenv_str_incr(struct env_set *es, const char *name, const char *val=
ue);

-void setenv_int_i(struct env_set *es, const char *name, const int value, c=
onst int i);
-
 void setenv_str_i(struct env_set *es, const char *name, const char *value,=
 const int i);

 /* struct env_set functions */
@@ -85,8 +83,6 @@

 const char *env_set_get(const struct env_set *es, const char *name);

-void env_set_print(msglvl_t msglevel, const struct env_set *es);
-
 /**
  * Write a struct env_set to a file. Each item on one line.
  *
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 40ed161..b784dfe 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -190,13 +190,6 @@
     return ret;
 }

-static inline void
-event_set_return_init(struct event_set_return *esr)
-{
-    esr->rwflags =3D 0;
-    esr->arg =3D NULL;
-}
-
 #ifdef _WIN32

 static inline void
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index f6d3503..59051bd 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -255,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_timeout *et, struct timeval *tv, i=
nt et_const_retry);

-/*
- * Measure time intervals in microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-struct usec_timer
-{
-    struct timeval start;
-    struct timeval end;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer_start(struct usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj->start, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec_timer *obj)
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_GETTIMEOFDAY */
-
-static inline bool
-usec_timer_interval_defined(struct usec_timer *obj)
-{
-    return obj->start.tv_sec && obj->end.tv_sec;
-}
-
-static inline int
-usec_timer_interval(struct usec_timer *obj)
-{
-    return tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* INTERVAL_H */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e5ad23f..06eb572 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -158,12 +158,6 @@
     return h->size;
 }

-static inline int
-log_history_capacity(const struct log_history *h)
-{
-    return h->capacity;
-}
-
 /*
  * Callbacks for 'status' and 'kill' commands.
  * Also for management-based deferred authentication and packet filter.
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c8daa15..041d7e2 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -249,24 +249,4 @@
     dest->v4.addr =3D htonl(src);
 }

-static inline in_addr_t
-in_addr_t_from_mroute_addr(const struct mroute_addr *addr)
-{
-    if ((addr->type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 && addr->netbits =
=3D=3D 0 && addr->len =3D=3D 4)
-    {
-        return ntohl(addr->v4.addr);
-    }
-    else
-    {
-        return 0;
-    }
-}
-
-static inline void
-mroute_addr_reset(struct mroute_addr *ma)
-{
-    ma->len =3D 0;
-    ma->type =3D MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H */
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..dec3208 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -617,12 +617,3 @@

     } while (action !=3D TA_UNDEF);
 }
-
-void
-multi_io_delete_event(struct multi_io *multi_io, event_t event)
-{
-    if (multi_io && multi_io->es)
-    {
-        event_del(multi_io->es, event);
-    }
-}
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index f38660f..5e1f680 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -31,7 +31,6 @@
 #include "multi.h"
 #include "win32.h"
 #include "platform.h"
-#include "string.h"

 #include "memdbg.h"

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index f8adde5..29f9327 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -993,24 +993,4 @@
     pr->n =3D 0;
 }

-#ifdef ENABLE_DEBUG
-void
-plugin_return_print(const msglvl_t msglevel, const char *prefix, const str=
uct plugin_return *pr)
-{
-    int i;
-    msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);
-    for (i =3D 0; i < pr->n; ++i)
-    {
-        struct openvpn_plugin_string_list *l =3D pr->list[i];
-        int count =3D 0;
-
-        msg(msglevel, "PLUGIN #%d (%s)", i, prefix);
-        while (l)
-        {
-            msg(msglevel, "[%d] '%s' -> '%s'", ++count, l->name, l->value);
-            l =3D l->next;
-        }
-    }
-}
-#endif /* ifdef ENABLE_DEBUG */
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 7e9faf3..b5fb916 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -135,10 +135,6 @@

 void plugin_return_free(struct plugin_return *pr);

-#ifdef ENABLE_DEBUG
-void plugin_return_print(const msglvl_t msglevel, const char *prefix, cons=
t struct plugin_return *pr);
-
-#endif

 static inline int
 plugin_n(const struct plugin_list *pl)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3b18f74..93e856b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -185,19 +185,6 @@
     dest->gc =3D a;
 }

-static const char *
-route_string(const struct route_ipv4 *r, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE network %s netmask %s gateway %s", print_in_ad=
dr_t(r->network, 0, gc),
-               print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r->gate=
way, 0, gc));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        buf_printf(&out, " metric %d", r->metric);
-    }
-    return BSTR(&out);
-}
-
 static bool
 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1312,6 @@
 #endif /* ifndef ENABLE_SMALL */

 static void
-print_route(const struct route_ipv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc =3D gc_new();
-    if (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s", route_string(r, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes(const struct route_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 *r;
-    for (r =3D rl->routes; r; r =3D r->next)
-    {
-        print_route(r, msglevel);
-    }
-}
-
-static void
 setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 88107e9..0d33d36 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -377,8 +377,6 @@

 #endif

-void print_routes(const struct route_list *rl, msglvl_t msglevel);
-
 #ifdef _WIN32

 void show_routes(msglvl_t msglevel);
@@ -409,19 +407,6 @@
     return mask;
 }

-static inline bool
-route_list_vpn_gateway_needed(const struct route_list *rl)
-{
-    if (!rl)
-    {
-        return false;
-    }
-    else
-    {
-        return !(rl->spec.flags & RTSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inline int
 route_did_redirect_default_gateway(const struct route_list *rl)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-Change-Number: 1610
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--FPwb6eEOU6E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1610?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove various unused functions<br><br>Chan=
ge-Id: I82a4e82ff876fab715e052de1903c65b835360b5<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.h<br>M sr=
c/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mbedtls.c<br>M src/openv=
pn/crypto_mbedtls_legacy.c<br>M src/openvpn/crypto_openssl.c<br>M src/openv=
pn/dco_win.h<br>M src/openvpn/env_set.c<br>M src/openvpn/env_set.h<br>M src=
/openvpn/event.h<br>M src/openvpn/interval.h<br>M src/openvpn/manage.h<br>M=
 src/openvpn/mroute.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/openvpn.=
c<br>M src/openvpn/plugin.c<br>M src/openvpn/plugin.h<br>M src/openvpn/rout=
e.c<br>M src/openvpn/route.h<br>18 files changed, 0 insertions(+), 271 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/10/1610/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.h b=
/src/openvpn/buffer.h</span><br><span>index fcc923b..aef29de 100644</span><=
br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffe=
r.h</span><br><span>@@ -805,28 +805,6 @@</span><br><span>     return ntohs(=
ret);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline uint32_t</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-buf_read_u32(struct buffer *buf, bool *good)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint32_t ret;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!buf_read(buf, &amp;ret, sizeof(uint32_t)))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (good)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            *good =3D false;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (good)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            *good =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return ntohl(ret);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /** Return true if buffer contents are equal */</span><br><span> sta=
tic inline bool</span><br><span> buf_equal(const struct buffer *a, const st=
ruct buffer *b)</span><br><span>@@ -1018,12 +996,6 @@</span><br><span> </sp=
an><br><span> void x_gc_freespecial(struct gc_arena *a);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_aren=
a *a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return a-&gt;list !=3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline void</span>=
<br><span> gc_init(struct gc_arena *a)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h</sp=
an><br><span>index 0bfa8b4..4e9283d 100644</span><br><span>--- a/src/openvp=
n/crypto_backend.h</span><br><span>+++ b/src/openvpn/crypto_backend.h</span=
><br><span>@@ -591,15 +591,6 @@</span><br><span> void md_ctx_cleanup(md_ctx=
_t *ctx);</span><br><span> </span><br><span> /*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Returns the size of the message digest output =
by the given context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx       =
    Message digest context.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return   =
           Size of the message digest, or \0 if ctx is NULL.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int md_ctx_size(const md_ctx_t *ctx);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/*</span><br><span>  * Process the given data for use in th=
e message digest.</span><br><span>  *</span><br><span>  * @param ctx       =
    Message digest context. May not be NULL.</span><br><span>diff --git a/s=
rc/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>=
index c41daef..b0d0820 100644</span><br><span>--- a/src/openvpn/crypto_mbed=
tls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@=
 -740,16 +740,6 @@</span><br><span>     ASSERT(psa_hash_abort(&amp;ctx-&gt;=
operation) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-md_ctx_size(const md_ctx_t *ctx)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (ctx =3D=3D NULL)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (i=
nt)PSA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> void</span><br><span> md_ctx_update(md_ctx_t *ctx,=
 const uint8_t *src, size_t src_len)</span><br><span> {</span><br><span>dif=
f --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_=
legacy.c</span><br><span>index 087d94c..3f04a3e 100644</span><br><span>--- =
a/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>+++ b/src/openvpn/cry=
pto_mbedtls_legacy.c</span><br><span>@@ -863,16 +863,6 @@</span><br><span> =
    mbedtls_md_free(ctx);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-md_ctx_size(const mbedtls_md_context_t *ctx)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_update(mb=
edtls_md_context_t *ctx, const uint8_t *src, size_t src_len)</span><br><spa=
n> {</span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvp=
n/crypto_openssl.c</span><br><span>index 9900d06..e49f654 100644</span><br>=
<span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/=
crypto_openssl.c</span><br><span>@@ -1152,12 +1152,6 @@</span><br><span>   =
  EVP_MD_CTX_reset(ctx);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-md_ctx_size(const EVP_MD_CTX *ctx)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return EVP_MD_CTX_size(ctx);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> void</span><br><span> md_ctx_update(EVP_MD_CTX *ctx=
, const uint8_t *src, size_t src_len)</span><br><span> {</span><br><span>di=
ff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>in=
dex ac3ce33..a92e5ad 100644</span><br><span>--- a/src/openvpn/dco_win.h</sp=
an><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -65,8 +65,6 @@<=
/span><br><span> void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struc=
t link_socket *sock,</span><br><span>                       struct signal_i=
nfo *sig_info);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void dco_start_tun(struct tuntap *tt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> bool dco_win_supports_multip=
eer(void);</span><br><span> </span><br><span> void dco_win_add_iroute_ipv4(=
dco_context_t *dco, in_addr_t dst, unsigned int netbits,</span><br><span>@@=
 -79,13 +77,5 @@</span><br><span> </span><br><span> void dco_win_del_iroute=
_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /*=
 if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-dco_start_tun(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ASSERT(false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif=
 /* defined(_WIN32) */</span><br><span> #endif /* ifndef DCO_H */</span><br=
><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br=
><span>index d992097..e147913 100644</span><br><span>--- a/src/openvpn/env_=
set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -209,3=
2 +209,6 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-env_set_print(msglvl_t msg=
level, const struct env_set *es)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c=
heck_debug_level(msglevel))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        co=
nst struct env_item *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (es)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            e =3D es-&gt;list;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            i =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            while (e)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                if (env_safe_to_print(e-&gt;string))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    msg(msglevel, &qu=
ot;ENV [%d] &#39;%s&#39;&quot;, i, e-&gt;string);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                ++i;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                e =3D e-&gt;next;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void</span><br><span> env_set_write_file(c=
onst char *path, const struct env_set *es)</span><br><span> {</span><br><sp=
an>     FILE *fp =3D platform_fopen(path, &quot;w&quot;);</span><br><span>@=
@ -411,15 +385,6 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_int_i(struc=
t env_set *es, const char *name, const int value, const int i)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *name_str =3D setenv_for=
mat_indexed_name(name, i, &amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    setenv_int(es, name_str, value);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span> setenv_str_i(struct env_set *es, const char *name, const char *va=
lue, const int i)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>diff --git a/src/openvpn/env_set.h b/src/op=
envpn/env_set.h</span><br><span>index fcfc3ca..9b4a1e7 100644</span><br><sp=
an>--- a/src/openvpn/env_set.h</span><br><span>+++ b/src/openvpn/env_set.h<=
/span><br><span>@@ -69,8 +69,6 @@</span><br><span>  */</span><br><span> voi=
d setenv_str_incr(struct env_set *es, const char *name, const char *value);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d setenv_int_i(struct env_set *es, const char *name, const int value, const=
 int i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> void setenv_str_i(struct env_set *es, const char *name, const char *va=
lue, const int i);</span><br><span> </span><br><span> /* struct env_set fun=
ctions */</span><br><span>@@ -85,8 +83,6 @@</span><br><span> </span><br><sp=
an> const char *env_set_get(const struct env_set *es, const char *name);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void e=
nv_set_print(msglvl_t msglevel, const struct env_set *es);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>=
  * Write a struct env_set to a file. Each item on one line.</span><br><spa=
n>  *</span><br><span>diff --git a/src/openvpn/event.h b/src/openvpn/event.=
h</span><br><span>index 40ed161..b784dfe 100644</span><br><span>--- a/src/o=
penvpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><span>@@=
 -190,13 +190,6 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_set_r=
eturn_init(struct event_set_return *esr)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   esr-&gt;rwflags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    esr-&gt;arg =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef _WIN32</span><br><span> </span><br><span> static inline void</=
span><br><span>diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h=
</span><br><span>index f6d3503..59051bd 100644</span><br><span>--- a/src/op=
envpn/interval.h</span><br><span>+++ b/src/openvpn/interval.h</span><br><sp=
an>@@ -255,47 +255,4 @@</span><br><span>  */</span><br><span> bool event_ti=
meout_trigger(struct event_timeout *et, struct timeval *tv, int et_const_re=
try);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Measure time i=
ntervals in microseconds</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX 60 /* maximum=
 interval size in seconds */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define USEC_T=
IMER_MAX_USEC (USEC_TIMER_MAX * 1000000)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct usec_timer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval start;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval end=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef HAVE_GETTIMEOFDAY</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_t=
imer_start(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLE=
AR(*obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_=
gettimeofday(&amp;obj-&gt;start, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_end(struct usec=
_timer *obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp=
;obj-&gt;end, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_GETTIMEOFDAY */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-usec_timer_interval_defined(struct usec_timer *obj)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return obj-&gt;start.tv_sec &amp;&amp; obj-=
&gt;end.tv_sec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-usec_timer_interval(struct usec_timer *obj)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return tv_subtract(&amp;obj-&gt;end, &amp;obj=
-&gt;start, USEC_TIMER_MAX);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #endif /* INTERVAL_H */</span><br><span>diff --git a/src/openvpn/manag=
e.h b/src/openvpn/manage.h</span><br><span>index e5ad23f..06eb572 100644</s=
pan><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/=
manage.h</span><br><span>@@ -158,12 +158,6 @@</span><br><span>     return h=
-&gt;size;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-log_history_capacity(const struct log_history *h)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return h-&gt;capacity;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Callbacks for &#3=
9;status&#39; and &#39;kill&#39; commands.</span><br><span>  * Also for man=
agement-based deferred authentication and packet filter.</span><br><span>di=
ff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>inde=
x c8daa15..041d7e2 100644</span><br><span>--- a/src/openvpn/mroute.h</span>=
<br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -249,24 +249,4 @@</=
span><br><span>     dest-&gt;v4.addr =3D htonl(src);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_ad=
dr_t_from_mroute_addr(const struct mroute_addr *addr)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if ((addr-&gt;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 =
&amp;&amp; addr-&gt;netbits =3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return ntohl(addr-&gt;v4.addr);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-mroute_addr_reset(struct mroute_addr *ma)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ma-&gt;len =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ma-&gt;type =3D MR_ADDR_NONE;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> #endif /* MROUTE_H */</span><br><span>diff --git=
 a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index e6=
f4e9c..dec3208 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><b=
r><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -617,12 +617,3 @@</=
span><br><span> </span><br><span>     } while (action !=3D TA_UNDEF);</span=
><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-multi_io_delete_event(struct multi_io *multi_i=
o, event_t event)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi_io &amp;&a=
mp; multi_io-&gt;es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_del=
(multi_io-&gt;es, event);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br>=
<span>index f38660f..5e1f680 100644</span><br><span>--- a/src/openvpn/openv=
pn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -31,7 +=
31,6 @@</span><br><span> #include &quot;multi.h&quot;</span><br><span> #inc=
lude &quot;win32.h&quot;</span><br><span> #include &quot;platform.h&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string.h=
&quot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/plugin.c b/src/open=
vpn/plugin.c</span><br><span>index f8adde5..29f9327 100644</span><br><span>=
--- a/src/openvpn/plugin.c</span><br><span>+++ b/src/openvpn/plugin.c</span=
><br><span>@@ -993,24 +993,4 @@</span><br><span>     pr-&gt;n =3D 0;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_ret=
urn_print(const msglvl_t msglevel, const char *prefix, const struct plugin_=
return *pr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    msg(msglevel, &quot;PLUGIN_RETURN_PRI=
NT %s&quot;, prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (i =3D 0; i &lt; pr-&gt;n; ++i)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct openvpn_plugin_string_list *l =3D pr-&gt;list[i];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        int count =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;PLUGIN #%d (%s)&quot=
;, i, prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 while (l)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msgleve=
l, &quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count, l-&gt;name, l=
-&gt;value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   l =3D l-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span> =
#endif /* ENABLE_PLUGIN */</span><br><span>diff --git a/src/openvpn/plugin.=
h b/src/openvpn/plugin.h</span><br><span>index 7e9faf3..b5fb916 100644</spa=
n><br><span>--- a/src/openvpn/plugin.h</span><br><span>+++ b/src/openvpn/pl=
ugin.h</span><br><span>@@ -135,10 +135,6 @@</span><br><span> </span><br><sp=
an> void plugin_return_free(struct plugin_return *pr);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(c=
onst msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span>=
 static inline int</span><br><span> plugin_n(const struct plugin_list *pl)<=
/span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</spa=
n><br><span>index 3b18f74..93e856b 100644</span><br><span>--- a/src/openvpn=
/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -185,=
19 +185,6 @@</span><br><span>     dest-&gt;gc =3D a;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_str=
ing(const struct route_ipv4 *r, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct buffer out =3D alloc_buf_gc(256, gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;ROUTE=
 network %s netmask %s gateway %s&quot;, print_in_addr_t(r-&gt;network, 0, =
gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               pr=
int_in_addr_t(r-&gt;netmask, 0, gc), print_in_addr_t(r-&gt;gateway, 0, gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags =
&amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p=
rintf(&amp;out, &quot; metric %d&quot;, r-&gt;metric);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static bool</span><br><span> is_route_parm_defined(cons=
t char *parm)</span><br><span> {</span><br><span>@@ -1325,27 +1312,6 @@</sp=
an><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> </span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pri=
nt_route(const struct route_ipv4 *r, msglvl_t msglevel)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_DEFINED)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%s&quot;, route_st=
ring(r, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pr=
int_routes(const struct route_list *rl, msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        print_route(r, msglevel);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span> setenv_route(struct env_set *es, const struct route_ipv=
4 *r, int i)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/r=
oute.h</span><br><span>index 88107e9..0d33d36 100644</span><br><span>--- a/=
src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><sp=
an>@@ -377,8 +377,6 @@</span><br><span> </span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void print_rou=
tes(const struct route_list *rl, msglvl_t msglevel);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><=
span> </span><br><span> void show_routes(msglvl_t msglevel);</span><br><spa=
n>@@ -409,19 +407,6 @@</span><br><span>     return mask;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_=
list_vpn_gateway_needed(const struct route_list *rl)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!rl)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return !(rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPO=
INT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> static inline int</span><br><span>=
 route_did_redirect_default_gateway(const struct route_list *rl)</span><br>=
<span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1610?usp=3Demail">change 1610</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de190=
3c65b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--FPwb6eEOU6E=--

