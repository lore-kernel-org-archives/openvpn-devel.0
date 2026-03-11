From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 18:51:06 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@...2715...>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <5d4cdedf801622149738d35c852e73a8bbc378c0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="71eMa0cLcX8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--71eMa0cLcX8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2). ( http://gerrit.openvpn.net/c/=
openvpn/+/1571?usp=3Demail )


Change subject: Change hash iv to a dynamically allocated ctx
......................................................................

Change hash iv to a dynamically allocated ctx

While for our own hash function, always using an uint32_t works well, it do=
es
not work very well if we move to another hash function. Move the context of
a hardcoded uint32_t iv to a void pointer to a real ctx.

Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/multi.c
M tests/unit_tests/openvpn/test_misc.c
6 files changed, 42 insertions(+), 23 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/1571/2

diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 50defb85..36d8ede 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -29,13 +29,16 @@

 #include "integer.h"
 #include "list.h"
+
+#include "crypto.h"
 #include "misc.h"

 #include "memdbg.h"

 struct hash *
-hash_init(const uint32_t n_buckets, uint32_t iv,
-          uint64_t (*hash_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets, void *ctx,
+          void (*free_hash_ctx)(void *ctx),
+          uint64_t (*hash_function)(const void *key, void *ctx),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -46,7 +49,8 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;
     h->compare_function =3D compare_function;
-    h->iv =3D iv;
+    h->free_ctx =3D free_hash_ctx;
+    h->ctx =3D ctx;
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32_t i =3D 0; i < h->n_buckets; ++i)
     {
@@ -71,6 +75,7 @@
             he =3D next;
         }
     }
+    hash->free_ctx(hash->ctx);
     free(hash->buckets);
     free(hash);
 }
@@ -412,6 +417,14 @@
         c ^=3D (b >> 15); \
     }

+void *
+hash_func_new_ctx(void)
+{
+    uint32_t *ctx =3D malloc(sizeof(uint32_t));
+    *ctx =3D (uint32_t)get_random();
+    return ctx;
+}
+
 uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
 {
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 06377c6..ea6f47a 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -54,14 +54,17 @@
     uint32_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);
+    void *ctx;
+    uint64_t (*hash_function)(const void *key, void *ctx);
     bool (*compare_function)(const void *key1, const void *key2); /* retur=
n true if equal */
+    void (*free_ctx)(void *ctx);
+    void *free_ctx_arg;
     struct hash_bucket *buckets;
 };

-struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-                       uint64_t (*hash_function)(const void *key, uint32_t=
 iv),
+struct hash *hash_init(const uint32_t n_buckets, void *ctx,
+                       void (*free_hash_ctx)(void *ctx),
+                       uint64_t (*hash_function)(const void *key, void *ct=
x),
                        bool (*compare_function)(const void *key1, const vo=
id *key2));

 void hash_free(struct hash *hash);
@@ -100,10 +103,12 @@

 uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);

+void *hash_func_new_ctx(void);
+
 static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
-    return (*hash->hash_function)(key, hash->iv);
+    return (*hash->hash_function)(key, hash->ctx);
 }

 static inline uint32_t
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 78c689e..89b3ecc 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -355,10 +355,11 @@
  * and the actual address.
  */
 uint64_t
-mroute_addr_hash_function(const void *key, uint32_t iv)
+mroute_addr_hash_function(const void *key, void *ctx)
 {
+    uint32_t *iv =3D ctx;
     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-                     mroute_addr_hash_len((const struct mroute_addr *)key)=
, iv);
+                     mroute_addr_hash_len((const struct mroute_addr *)key)=
, *iv);
 }

 bool
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 2f5d019..51b62d2 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -144,7 +144,7 @@

 bool mroute_learnable_address(const struct mroute_addr *addr, struct gc_ar=
ena *gc);

-uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, void *ctx);

 bool mroute_addr_compare_function(const void *key1, const void *key2);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 57ea3fb..200e1e7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT

 static uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_function(const void *key, void *ctx)
 {
     const unsigned long *k =3D (const unsigned long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are used as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+int_hash_function(const void *key, void *ctx)
 {
     return (uint32_t)(uintptr_t)key;
 }
@@ -290,18 +290,18 @@
      * to determine which client sent an incoming packet
      * which is seen on the TCP/UDP socket.
      */
-    m->hash =3D hash_init(t->options.real_hash_size, (uint32_t)get_random(=
),
+    m->hash =3D hash_init(t->options.real_hash_size, hash_func_new_ctx(), =
free,
                         mroute_addr_hash_function, mroute_addr_compare_fun=
ction);

     /*
      * Virtual address hash table.  Used to determine
      * which client to route a packet to.
      */
-    m->vhash =3D hash_init(t->options.virtual_hash_size, (uint32_t)get_ran=
dom(),
+    m->vhash =3D hash_init(t->options.virtual_hash_size, hash_func_new_ctx=
(), free,
                          mroute_addr_hash_function, mroute_addr_compare_fu=
nction);

 #ifdef ENABLE_MANAGEMENT
-    m->cid_hash =3D hash_init(t->options.real_hash_size, 0, cid_hash_funct=
ion, cid_compare_function);
+    m->cid_hash =3D hash_init(t->options.real_hash_size, NULL, free, cid_h=
ash_function, cid_compare_function);
 #endif

 #ifdef ENABLE_ASYNC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between inotify watch descriptors and
      * multi_instances.
      */
-    m->inotify_watchers =3D hash_init(t->options.real_hash_size, (uint32_t=
)get_random(),
-                                    int_hash_function, int_compare_functio=
n);
+    m->inotify_watchers =3D
+        hash_init(t->options.real_hash_size, NULL, free, int_hash_function=
, int_compare_function);
 #endif

     /*
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index a8383de..24bf22d 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -125,11 +125,12 @@


 static uint64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_function(const void *key, void *ctx)
 {
+    uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
+    return hash_func((const uint8_t *)str, len, *iv);
 }

 static bool
@@ -171,10 +172,9 @@
      * Test the hash code by implementing a simple
      * word frequency algorithm.
      */
-
     struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000, (uint32_t)get_random(), word_ha=
sh_function, word_compare_function);
-    struct hash *nhash =3D hash_init(256, (uint32_t)get_random(), word_has=
h_function, word_compare_function);
+    struct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word=
_hash_function, word_compare_function);
+    struct hash *nhash =3D hash_init(256, hash_func_new_ctx(), free, word_=
hash_function, word_compare_function);

     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);


--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--71eMa0cLcX8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1571?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Change hash iv to a dynamically allocated ctx<br><br>While for our own =
hash function, always using an uint32_t works well, it does<br>not work ver=
y well if we move to another hash function. Move the context of<br>a hardco=
ded uint32_t iv to a void pointer to a real ctx.<br><br>Change-Id: If47c7d9=
20b2fa4047b7db03fcde821899839324d<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M src/openvpn/list.c<br>M src/openvpn/list.h<br>M s=
rc/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/multi.c<br>M=
 tests/unit_tests/openvpn/test_misc.c<br>6 files changed, 42 insertions(+),=
 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/71/1571/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/li=
st.c b/src/openvpn/list.c</span><br><span>index 50defb85..36d8ede 100644</s=
pan><br><span>--- a/src/openvpn/list.c</span><br><span>+++ b/src/openvpn/li=
st.c</span><br><span>@@ -29,13 +29,16 @@</span><br><span> </span><br><span>=
 #include &quot;integer.h&quot;</span><br><span> #include &quot;list.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto.h&quot;</span><=
br><span> #include &quot;misc.h&quot;</span><br><span> </span><br><span> #i=
nclude &quot;memdbg.h&quot;</span><br><span> </span><br><span> struct hash =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint=
32_t n_buckets, uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          uint64_t (*hash_function)(const void *key, uint32_t iv),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint3=
2_t n_buckets, void *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          void (*free_hash_ctx)(void *ctx),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+          uint64_t (*hash_function)(const voi=
d *key, void *ctx),</span><br><span>           bool (*compare_function)(con=
st void *key1, const void *key2))</span><br><span> {</span><br><span>     s=
truct hash *h;</span><br><span>@@ -46,7 +49,8 @@</span><br><span>     h-&gt=
;mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D=
 hash_function;</span><br><span>     h-&gt;compare_function =3D compare_fun=
ction;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =
=3D iv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;fr=
ee_ctx =3D free_hash_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    h-&gt;ctx =3D ctx;</span><br><span>     ALLOC_ARRAY(h-&gt;buckets=
, struct hash_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t =
i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><spa=
n>@@ -71,6 +75,7 @@</span><br><span>             he =3D next;</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    hash-&gt;free_ctx(hash-&gt;ctx);</span><br><span>     =
free(hash-&gt;buckets);</span><br><span>     free(hash);</span><br><span> }=
</span><br><span>@@ -412,6 +417,14 @@</span><br><span>         c ^=3D (b &g=
t;&gt; 15); \</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+hash_func_new_ctx(void)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint32_t *ctx =3D malloc(sizeof(uint32_t));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    *ctx =3D (uint32_t)get_random();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> uint64_t</span><br><span> =
hash_func(const uint8_t *k, uint32_t length, uint32_t initval)</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/list.h b/src/openvpn/list.h=
</span><br><span>index 06377c6..ea6f47a 100644</span><br><span>--- a/src/op=
envpn/list.h</span><br><span>+++ b/src/openvpn/list.h</span><br><span>@@ -5=
4,14 +54,17 @@</span><br><span>     uint32_t n_buckets;</span><br><span>   =
  uint32_t n_elements;</span><br><span>     uint32_t mask;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(const void *k=
ey, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  void *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t64_t (*hash_function)(const void *key, void *ctx);</span><br><span>     bo=
ol (*compare_function)(const void *key1, const void *key2); /* return true =
if equal */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void=
 (*free_ctx)(void *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    void *free_ctx_arg;</span><br><span>     struct hash_bucket *bucke=
ts;</span><br><span> };</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct hash *hash_init(const uint32_t n_buckets, const =
uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              uint64_t (*hash_function)(const void *key, uint32_t iv),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct hash *hash_init(c=
onst uint32_t n_buckets, void *ctx,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       void (*free_hash_ctx)(void *ctx),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
 uint64_t (*hash_function)(const void *key, void *ctx),</span><br><span>   =
                     bool (*compare_function)(const void *key1, const void =
*key2));</span><br><span> </span><br><span> void hash_free(struct hash *has=
h);</span><br><span>@@ -100,10 +103,12 @@</span><br><span> </span><br><span=
> uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id *hash_func_new_ctx(void);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static inline uint64_t</span><br><span> hash_val=
ue(const struct hash *hash, const void *key)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return (*hash-&gt;hash_functi=
on)(key, hash-&gt;iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return (*hash-&gt;hash_function)(key, hash-&gt;ctx);</span><br><span=
> }</span><br><span> </span><br><span> static inline uint32_t</span><br><sp=
an>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span=
>index 78c689e..89b3ecc 100644</span><br><span>--- a/src/openvpn/mroute.c</=
span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -355,10 +355,1=
1 @@</span><br><span>  * and the actual address.</span><br><span>  */</span=
><br><span> uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
route_addr_hash_function(const void *key, uint32_t iv)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(const void *ke=
y, void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint32_t *iv =3D ctx;</span><br><span>     return hash_fun=
c(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                     mroute_addr_hash_le=
n((const struct mroute_addr *)key), iv);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     mroute_addr_hash_len((const struc=
t mroute_addr *)key), *iv);</span><br><span> }</span><br><span> </span><br>=
<span> bool</span><br><span>diff --git a/src/openvpn/mroute.h b/src/openvpn=
/mroute.h</span><br><span>index 2f5d019..51b62d2 100644</span><br><span>---=
 a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span><b=
r><span>@@ -144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_=
learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_=
t mroute_addr_hash_function(const void *key, uint32_t iv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(c=
onst void *key, void *ctx);</span><br><span> </span><br><span> bool mroute_=
addr_compare_function(const void *key1, const void *key2);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</s=
pan><br><span>index 57ea3fb..200e1e7 100644</span><br><span>--- a/src/openv=
pn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -22=
9,7 +229,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> </=
span><br><span> static uint64_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-cid_hash_function(const void *key, uint32_t iv)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+cid_hash_function(const void *key, vo=
id *ctx)</span><br><span> {</span><br><span>     const unsigned long *k =3D=
 (const unsigned long *)key;</span><br><span>     return (uint64_t)*k;</spa=
n><br><span>@@ -250,7 +250,7 @@</span><br><span> /*</span><br><span>  * ino=
tify watcher descriptors are used as hash value</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-int_hash_function(const void=
 *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int_hash_function(const void *key, void *ctx)</span><br><span> {</span><br>=
<span>     return (uint32_t)(uintptr_t)key;</span><br><span> }</span><br><s=
pan>@@ -290,18 +290,18 @@</span><br><span>      * to determine which client=
 sent an incoming packet</span><br><span>      * which is seen on the TCP/U=
DP socket.</span><br><span>      */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options.real_hash_size, (u=
int32_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    m-&gt;hash =3D hash_init(t-&gt;options.real_hash_size, hash_func_new_=
ctx(), free,</span><br><span>                         mroute_addr_hash_func=
tion, mroute_addr_compare_function);</span><br><span> </span><br><span>    =
 /*</span><br><span>      * Virtual address hash table.  Used to determine<=
/span><br><span>      * which client to route a packet to.</span><br><span>=
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vha=
sh =3D hash_init(t-&gt;options.virtual_hash_size, (uint32_t)get_random(),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D h=
ash_init(t-&gt;options.virtual_hash_size, hash_func_new_ctx(), free,</span>=
<br><span>                          mroute_addr_hash_function, mroute_addr_=
compare_function);</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;cid_hash=
 =3D hash_init(t-&gt;options.real_hash_size, 0, cid_hash_function, cid_comp=
are_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
-&gt;cid_hash =3D hash_init(t-&gt;options.real_hash_size, NULL, free, cid_h=
ash_function, cid_compare_function);</span><br><span> #endif</span><br><spa=
n> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>@@ -309,8 +30=
9,8 @@</span><br><span>      * Mapping between inotify watch descriptors an=
d</span><br><span>      * multi_instances.</span><br><span>      */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =
=3D hash_init(t-&gt;options.real_hash_size, (uint32_t)get_random(),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
       int_hash_function, int_compare_function);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m-&gt;inotify_watchers =3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        hash_init(t-&gt;options.rea=
l_hash_size, NULL, free, int_hash_function, int_compare_function);</span><b=
r><span> #endif</span><br><span> </span><br><span>     /*</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn=
/test_misc.c</span><br><span>index a8383de..24bf22d 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_misc.c</span><br><span>@@ -125,11 +125,12 @@</span><br>=
<span> </span><br><span> </span><br><span> static uint64_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-word_hash_function(const void *key, ui=
nt32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash=
_function(const void *key, void *ctx)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint32_t *iv =3D (uint32_t *)ctx;<=
/span><br><span>     const char *str =3D (const char *)key;</span><br><span=
>     const uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, =
len, iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 hash_func((const uint8_t *)str, len, *iv);</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span>@@ -171,10 +172,9 @@</sp=
an><br><span>      * Test the hash code by implementing a simple</span><br>=
<span>      * word frequency algorithm.</span><br><span>      */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct hash *hash =3D hash_init(10000, (uint32_t)get_random(), word_ha=
sh_function, word_compare_function);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct hash *nhash =3D hash_init(256, (uint32_t)get_rand=
om(), word_hash_function, word_compare_function);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, ha=
sh_func_new_ctx(), free, word_hash_function, word_compare_function);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D=
 hash_init(256, hash_func_new_ctx(), free, word_hash_function, word_compare=
_function);</span><br><span> </span><br><span>     printf(&quot;hash_init n=
_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1571?usp=3Demail">change 1571</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde=
821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--71eMa0cLcX8=--

