From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 13:14:13 +0000
References: <gerrit.1736860439000.I1146da697adb8a200df0507dc7ec931c36738ffa@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3dd4f4c4f8c718798acd83a4828c4db01ea68bd1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fnUNggnkaQU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various compiler
 warnings for intentionally unused parameters
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

--fnUNggnkaQU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/861?usp=3Demail

to review the following change.


Change subject: Fix various compiler warnings for intentionally unused para=
meters
......................................................................

Fix various compiler warnings for intentionally unused parameters

Change-Id: I1146da697adb8a200df0507dc7ec931c36738ffa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dco_win.h
M src/openvpn/event.h
M src/openvpn/multi.c
M src/openvpn/perf.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/ssl.c
M src/openvpn/tun.h
M src/openvpn/xkey_provider.c
M src/plugins/auth-pam/auth-pam.c
M src/plugins/down-root/down-root.c
11 files changed, 30 insertions(+), 30 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/861/1

diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 7688516..99c9252 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -54,7 +54,7 @@
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */

 static inline void
-dco_start_tun(struct tuntap *tt)
+dco_start_tun(struct tuntap *)
 {
     ASSERT(false);
 }
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index c212e07..d792145 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -214,7 +214,7 @@
 #else  /* ifdef _WIN32 */

 static inline void
-wait_signal(struct event_set *es, void *arg)
+wait_signal(struct event_set *, void *)
 {
 }

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f426b46..7fa3b43 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -252,7 +252,7 @@
 #ifdef ENABLE_MANAGEMENT

 static uint32_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_function(const void *key, uint32_t /*iv*/)
 {
     const unsigned long *k =3D (const unsigned long *)key;
     return (uint32_t) *k;
@@ -273,7 +273,7 @@
 /*
  * inotify watcher descriptors are used as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+int_hash_function(const void *key, uint32_t /*iv*/)
 {
     return (unsigned long)key;
 }
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 04abe89..d394347 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -75,7 +75,7 @@
 #else  /* ifdef ENABLE_PERFORMANCE_METRICS */

 static inline void
-perf_push(int type)
+perf_push(int)
 {
 }
 static inline void
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d17b285..2aa33d0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -4181,7 +4181,7 @@
 #else  /* if defined(_WIN32) */

 static void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)   =
/* PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *, const unsigned int)   /* PLATF=
ORM-SPECIFIC */
 {
 }

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..e605d8b 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -365,7 +365,7 @@

 #else  /* ifdef _WIN32 */
 static inline bool
-test_routes(const struct route_list *rl, const struct tuntap *tt)
+test_routes(const struct route_list *, const struct tuntap *)
 {
     return true;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4a7b57..631e547 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -257,7 +257,7 @@
 }

 int
-pem_password_callback(char *buf, int size, int rwflag, void *u)
+pem_password_callback(char *buf, int size, int /*rwflag*/, void */*u*/)
 {
     if (buf)
     {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ccba0bc..a5b9a48 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -698,37 +698,37 @@
 #else  /* ifdef _WIN32 */

 static inline bool
-tuntap_stop(int status)
+tuntap_stop(int)
 {
     return false;
 }

 static inline bool
-tuntap_abort(int status)
+tuntap_abort(int)
 {
     return false;
 }

 static inline void
-tun_standby_init(struct tuntap *tt)
+tun_standby_init(struct tuntap *)
 {
 }

 static inline bool
-tun_standby(struct tuntap *tt)
+tun_standby(struct tuntap *)
 {
     return true;
 }


 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(struct tuntap *)
 {
     return false;
 }

 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *, int)
 {
     return false;
 }
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 964d2eb..8efcd9e 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -204,7 +204,7 @@
 }

 static void *
-keymgmt_load(const void *reference, size_t reference_sz)
+keymgmt_load(const void */*reference*/, size_t /*reference_sz*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -416,7 +416,7 @@

 /* A minimal set of key params that we can return */
 static const OSSL_PARAM *
-keymgmt_gettable_params(void *provctx)
+keymgmt_gettable_params(void */*provctx*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -558,7 +558,7 @@
 }

 static const char *
-rsa_keymgmt_name(int id)
+rsa_keymgmt_name(int /*id*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -761,7 +761,7 @@
 }

 static const OSSL_PARAM *
-signature_settable_ctx_params(void *ctx, void *provctx)
+signature_settable_ctx_params(void */*ctx*/, void */*provctx*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -874,7 +874,7 @@
 }

 static const OSSL_PARAM *
-signature_gettable_ctx_params(void *ctx, void *provctx)
+signature_gettable_ctx_params(void */*ctx*/, void */*provctx*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -884,7 +884,7 @@
 }

 static int
-signature_get_ctx_params(void *ctx, OSSL_PARAM params[])
+signature_get_ctx_params(void */*ctx*/, OSSL_PARAM */*params[]*/)
 {
     xkey_dmsg(D_XKEY, "not implemented");
     return 0;
@@ -936,7 +936,7 @@
 }

 static int
-signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsi=
ze,
+signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t /*sig=
size*/,
                const unsigned char *tbs, size_t tbslen)
 {
     xkey_dmsg(D_XKEY, "entry with siglen =3D %zu\n", *siglen);
@@ -956,8 +956,8 @@
 }

 static int
-signature_digest_verify_init(void *ctx, const char *mdname, void *provkey,
-                             const OSSL_PARAM params[])
+signature_digest_verify_init(void */*ctx*/, const char *mdname, void */*pr=
ovkey*/,
+                             const OSSL_PARAM */*params[]*/)
 {
     xkey_dmsg(D_XKEY, "mdname <%s>", mdname);

@@ -970,8 +970,8 @@
  * for debugging purposes.
  */
 static int
-signature_digest_verify(void *ctx, const unsigned char *sig, size_t siglen,
-                        const unsigned char *tbs, size_t tbslen)
+signature_digest_verify(void */*ctx*/, const unsigned char */*sig*/, size_=
t /*siglen*/,
+                        const unsigned char */*tbs*/, size_t /*tbslen*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -1166,7 +1166,7 @@
 static OSSL_FUNC_provider_teardown_fn teardown;

 static const OSSL_ALGORITHM *
-query_operation(void *provctx, int op, int *no_store)
+query_operation(void */*provctx*/, int op, int *no_store)
 {
     xkey_dmsg(D_XKEY, "op =3D %d", op);

@@ -1188,7 +1188,7 @@
 }

 static const OSSL_PARAM *
-gettable_params(void *provctx)
+gettable_params(void */*provctx*/)
 {
     xkey_dmsg(D_XKEY, "entry");

@@ -1200,7 +1200,7 @@
     return param_types;
 }
 static int
-get_params(void *provctx, OSSL_PARAM params[])
+get_params(void */*provctx*/, OSSL_PARAM params[])
 {
     OSSL_PARAM *p;

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index 54cab33..7aa477c 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -520,7 +520,7 @@
 }

 OPENVPN_EXPORT int
-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char *argv[], const char *envp[])
+openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char **/*argv[]*/, const char *envp[])
 {
     struct auth_pam_context *context =3D (struct auth_pam_context *) handl=
e;

diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down=
-root.c
index 384bc81..3a152b1 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -344,7 +344,7 @@
 }

 OPENVPN_EXPORT int
-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char *argv[], const char *envp[])
+openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char **/*argv[]*/, const char *envp[])
 {
     struct down_root_context *context =3D (struct down_root_context *) han=
dle;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/861?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1146da697adb8a200df0507dc7ec931c36738ffa
Gerrit-Change-Number: 861
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--fnUNggnkaQU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/861?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix various compiler warnings for intentionally unused parame=
ters<br><br>Change-Id: I1146da697adb8a200df0507dc7ec931c36738ffa<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/=
dco_win.h<br>M src/openvpn/event.h<br>M src/openvpn/multi.c<br>M src/openvp=
n/perf.h<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/openvpn=
/ssl.c<br>M src/openvpn/tun.h<br>M src/openvpn/xkey_provider.c<br>M src/plu=
gins/auth-pam/auth-pam.c<br>M src/plugins/down-root/down-root.c<br>11 files=
 changed, 30 insertions(+), 30 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/61/861/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 7688516..99c=
9252 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++=
 b/src/openvpn/dco_win.h</span><br><span>@@ -54,7 +54,7 @@</span><br><span>=
 #else /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><br><s=
pan> </span><br><span> static inline void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-dco_start_tun(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_start_tun(struct tuntap *)</span><br>=
<span> {</span><br><span>     ASSERT(false);</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span=
>index c212e07..d792145 100644</span><br><span>--- a/src/openvpn/event.h</s=
pan><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -214,7 +214,7 @@=
</span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><sp=
an> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-wait_signal(struct event_set *es, void *arg)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+wait_signal(struct event_set *, void *)</span><br=
><span> {</span><br><span> }</span><br><span> </span><br><span>diff --git a=
/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index f426b46..7=
fa3b43 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++=
 b/src/openvpn/multi.c</span><br><span>@@ -252,7 +252,7 @@</span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> static uint32_=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_function(co=
nst void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+cid_hash_function(const void *key, uint32_t /*iv*/)</span><br><span=
> {</span><br><span>     const unsigned long *k =3D (const unsigned long *)=
key;</span><br><span>     return (uint32_t) *k;</span><br><span>@@ -273,7 +=
273,7 @@</span><br><span> /*</span><br><span>  * inotify watcher descriptor=
s are used as hash value</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-int_hash_function(const void *key, uint32_t iv)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int_hash_function(const=
 void *key, uint32_t /*iv*/)</span><br><span> {</span><br><span>     return=
 (unsigned long)key;</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/perf.h b/src/openvpn/perf.h</span><br><span>index 04abe89..d394347 10=
0644</span><br><span>--- a/src/openvpn/perf.h</span><br><span>+++ b/src/ope=
nvpn/perf.h</span><br><span>@@ -75,7 +75,7 @@</span><br><span> #else  /* if=
def ENABLE_PERFORMANCE_METRICS */</span><br><span> </span><br><span> static=
 inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_push=
(int type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+perf_push=
(int)</span><br><span> {</span><br><span> }</span><br><span> static inline =
void</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c=
</span><br><span>index d17b285..2aa33d0 100644</span><br><span>--- a/src/op=
envpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ =
-4181,7 +4181,7 @@</span><br><span> #else  /* if defined(_WIN32) */</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-get_bypass_addresses(struct route_bypass *rb, const unsig=
ned int flags)   /* PLATFORM-SPECIFIC */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+get_bypass_addresses(struct route_bypass *, const unsi=
gned int)   /* PLATFORM-SPECIFIC */</span><br><span> {</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/src/openvpn/route.h b/src/ope=
nvpn/route.h</span><br><span>index 421e7d2..e605d8b 100644</span><br><span>=
--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><=
br><span>@@ -365,7 +365,7 @@</span><br><span> </span><br><span> #else  /* i=
fdef _WIN32 */</span><br><span> static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-test_routes(const struct route_list *rl, const=
 struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_routes(const struct route_list *, const struct tuntap *)</span><br><sp=
an> {</span><br><span>     return true;</span><br><span> }</span><br><span>=
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index e4=
a7b57..631e547 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><sp=
an>+++ b/src/openvpn/ssl.c</span><br><span>@@ -257,7 +257,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-pem_password_callback(char *buf, int size, int rwfl=
ag, void *u)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pem_pas=
sword_callback(char *buf, int size, int /*rwflag*/, void */*u*/)</span><br>=
<span> {</span><br><span>     if (buf)</span><br><span>     {</span><br><sp=
an>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index=
 ccba0bc..a5b9a48 100644</span><br><span>--- a/src/openvpn/tun.h</span><br>=
<span>+++ b/src/openvpn/tun.h</span><br><span>@@ -698,37 +698,37 @@</span><=
br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span> stat=
ic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_=
stop(int status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun=
tap_stop(int)</span><br><span> {</span><br><span>     return false;</span><=
br><span> }</span><br><span> </span><br><span> static inline bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_abort(int status)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_abort(int)</span><b=
r><span> {</span><br><span>     return false;</span><br><span> }</span><br>=
<span> </span><br><span> static inline void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-tun_standby_init(struct tuntap *tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+tun_standby_init(struct tuntap *)</sp=
an><br><span> {</span><br><span> }</span><br><span> </span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_stan=
dby(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+tun_standby(struct tuntap *)</span><br><span> {</span><br><span>     ret=
urn true;</span><br><span> }</span><br><span> </span><br><span> </span><br>=
<span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+tuntap_is_dco_win(struct tuntap *)</span><br><span> {<=
/span><br><span>     return false;</span><br><span> }</span><br><span> </sp=
an><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(s=
truct tuntap *, int)</span><br><span> {</span><br><span>     return false;<=
/span><br><span> }</span><br><span>diff --git a/src/openvpn/xkey_provider.c=
 b/src/openvpn/xkey_provider.c</span><br><span>index 964d2eb..8efcd9e 10064=
4</span><br><span>--- a/src/openvpn/xkey_provider.c</span><br><span>+++ b/s=
rc/openvpn/xkey_provider.c</span><br><span>@@ -204,7 +204,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-keymgmt_load(const void *reference, size_=
t reference_sz)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+keym=
gmt_load(const void */*reference*/, size_t /*reference_sz*/)</span><br><spa=
n> {</span><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><br><=
span> </span><br><span>@@ -416,7 +416,7 @@</span><br><span> </span><br><spa=
n> /* A minimal set of key params that we can return */</span><br><span> st=
atic const OSSL_PARAM *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-keymgmt_gettable_params(void *provctx)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+keymgmt_gettable_params(void */*provctx*/)</span><br><=
span> {</span><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><b=
r><span> </span><br><span>@@ -558,7 +558,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> static const char *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-rsa_keymgmt_name(int id)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+rsa_keymgmt_name(int /*id*/)</span><br><span> {=
</span><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><br><span=
> </span><br><span>@@ -761,7 +761,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static const OSSL_PARAM *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-signature_settable_ctx_params(void *ctx, void *provct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+signature_settabl=
e_ctx_params(void */*ctx*/, void */*provctx*/)</span><br><span> {</span><br=
><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><br><span> </span><=
br><span>@@ -874,7 +874,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static const OSSL_PARAM *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-signature_gettable_ctx_params(void *ctx, void *provctx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+signature_gettable_ctx_para=
ms(void */*ctx*/, void */*provctx*/)</span><br><span> {</span><br><span>   =
  xkey_dmsg(D_XKEY, &quot;entry&quot;);</span><br><span> </span><br><span>@=
@ -884,7 +884,7 @@</span><br><span> }</span><br><span> </span><br><span> st=
atic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-signature_get=
_ctx_params(void *ctx, OSSL_PARAM params[])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+signature_get_ctx_params(void */*ctx*/, OSSL_PARAM =
*/*params[]*/)</span><br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &q=
uot;not implemented&quot;);</span><br><span>     return 0;</span><br><span>=
@@ -936,7 +936,7 @@</span><br><span> }</span><br><span> </span><br><span> s=
tatic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-signature_si=
gn(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+signature_sign(void *ctx, uns=
igned char *sig, size_t *siglen, size_t /*sigsize*/,</span><br><span>      =
          const unsigned char *tbs, size_t tbslen)</span><br><span> {</span=
><br><span>     xkey_dmsg(D_XKEY, &quot;entry with siglen =3D %zu\n&quot;, =
*siglen);</span><br><span>@@ -956,8 +956,8 @@</span><br><span> }</span><br>=
<span> </span><br><span> static int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-signature_digest_verify_init(void *ctx, const char *mdname, v=
oid *provkey,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                     const OSSL_PARAM params[])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+signature_digest_verify_init(void */*ctx*/, con=
st char *mdname, void */*provkey*/,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                             const OSSL_PARAM */*params[]*/=
)</span><br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &quot;mdname &l=
t;%s&gt;&quot;, mdname);</span><br><span> </span><br><span>@@ -970,8 +970,8=
 @@</span><br><span>  * for debugging purposes.</span><br><span>  */</span>=
<br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
signature_digest_verify(void *ctx, const unsigned char *sig, size_t siglen,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   const unsigned char *tbs, size_t tbslen)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+signature_digest_verify(void */*ctx*/, const unsign=
ed char */*sig*/, size_t /*siglen*/,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        const unsigned char */*tbs*/, size=
_t /*tbslen*/)</span><br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &q=
uot;entry&quot;);</span><br><span> </span><br><span>@@ -1166,7 +1166,7 @@</=
span><br><span> static OSSL_FUNC_provider_teardown_fn teardown;</span><br><=
span> </span><br><span> static const OSSL_ALGORITHM *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-query_operation(void *provctx, int op, int =
*no_store)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+query_ope=
ration(void */*provctx*/, int op, int *no_store)</span><br><span> {</span><=
br><span>     xkey_dmsg(D_XKEY, &quot;op =3D %d&quot;, op);</span><br><span=
> </span><br><span>@@ -1188,7 +1188,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static const OSSL_PARAM *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-gettable_params(void *provctx)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+gettable_params(void */*provctx*/)</span=
><br><span> {</span><br><span>     xkey_dmsg(D_XKEY, &quot;entry&quot;);</s=
pan><br><span> </span><br><span>@@ -1200,7 +1200,7 @@</span><br><span>     =
return param_types;</span><br><span> }</span><br><span> static int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-get_params(void *provctx, OSSL=
_PARAM params[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get=
_params(void */*provctx*/, OSSL_PARAM params[])</span><br><span> {</span><b=
r><span>     OSSL_PARAM *p;</span><br><span> </span><br><span>diff --git a/=
src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c</span><br=
><span>index 54cab33..7aa477c 100644</span><br><span>--- a/src/plugins/auth=
-pam/auth-pam.c</span><br><span>+++ b/src/plugins/auth-pam/auth-pam.c</span=
><br><span>@@ -520,7 +520,7 @@</span><br><span> }</span><br><span> </span><=
br><span> OPENVPN_EXPORT int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int typ=
e, const char *argv[], const char *envp[])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+openvpn_plugin_func_v1(openvpn_plugin_handle_t handl=
e, const int type, const char **/*argv[]*/, const char *envp[])</span><br><=
span> {</span><br><span>     struct auth_pam_context *context =3D (struct a=
uth_pam_context *) handle;</span><br><span> </span><br><span>diff --git a/s=
rc/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c</span>=
<br><span>index 384bc81..3a152b1 100644</span><br><span>--- a/src/plugins/d=
own-root/down-root.c</span><br><span>+++ b/src/plugins/down-root/down-root.=
c</span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> OPENVPN_EXPORT int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const =
int type, const char *argv[], const char *envp[])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+openvpn_plugin_func_v1(openvpn_plugin_handle_=
t handle, const int type, const char **/*argv[]*/, const char *envp[])</spa=
n><br><span> {</span><br><span>     struct down_root_context *context =3D (=
struct down_root_context *) handle;</span><br><span> </span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/861?usp=3Demail">change 861</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/861?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1146da697adb8a200df0507dc7e=
c931c36738ffa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 861 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--fnUNggnkaQU=--

