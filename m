From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 17:48:48 +0000
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <e0c6487c698f011a2144fc46b98f15e071814ec9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t/diNqKSocc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash values
 in our hash map from uint32_t to uint64_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t/diNqKSocc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1570?usp=3Demail )


Change subject: Change hash values in our hash map from uint32_t to uint64_t
......................................................................

Change hash values in our hash map from uint32_t to uint64_t

32 bit architectures are playing a very small role today, so the difference
between 64 bit and 32 bit hash values is not expected to be large anymore.

This is also in preparation to replace our hash function with a more modern
replacement.

Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M tests/unit_tests/openvpn/test_misc.c
8 files changed, 30 insertions(+), 30 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1570/1

diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index f0e9908..50defb85 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -34,8 +34,8 @@
 #include "memdbg.h"

 struct hash *
-hash_init(const uint32_t n_buckets, const uint32_t iv,
-          uint32_t (*hash_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets, uint32_t iv,
+          uint64_t (*hash_function)(const void *key, uint32_t iv),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -76,7 +76,7 @@
 }

 struct hash_element *
-hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void=
 *key, uint32_t hv)
+hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void=
 *key, uint64_t hv)
 {
     struct hash_element *he;
     struct hash_element *prev =3D NULL;
@@ -104,7 +104,7 @@
 }

 bool
-hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void=
 *key, uint32_t hv)
+hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void=
 *key, uint64_t hv)
 {
     struct hash_element *he;
     struct hash_element *prev =3D NULL;
@@ -136,7 +136,7 @@
 bool
 hash_add(struct hash *hash, const void *key, void *value, bool replace)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     struct hash_element *he;
     bool ret =3D false;
@@ -412,7 +412,7 @@
         c ^=3D (b >> 15); \
     }

-uint32_t
+uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
 {
     uint32_t a, b, c, len;
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 04cc3ab..06377c6 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -40,7 +40,7 @@
 {
     void *value;
     const void *key;
-    uint32_t hash_value;
+    uint64_t hash_value;
     struct hash_element *next;
 };
=20
@@ -55,13 +55,13 @@
     uint32_t n_elements;
     uint32_t mask;
     uint32_t iv;
-    uint32_t (*hash_function)(const void *key, uint32_t iv);
+    uint64_t (*hash_function)(const void *key, uint32_t iv);
     bool (*compare_function)(const void *key1, const void *key2); /* retur=
n true if equal */
     struct hash_bucket *buckets;
 };

 struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-                       uint32_t (*hash_function)(const void *key, uint32_t=
 iv),
+                       uint64_t (*hash_function)(const void *key, uint32_t=
 iv),
                        bool (*compare_function)(const void *key1, const vo=
id *key2));

 void hash_free(struct hash *hash);
@@ -69,9 +69,9 @@
 bool hash_add(struct hash *hash, const void *key, void *value, bool replac=
e);

 struct hash_element *hash_lookup_fast(struct hash *hash, struct hash_bucke=
t *bucket,
-                                      const void *key, uint32_t hv);
+                                      const void *key, uint64_t hv);

-bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const=
 void *key, uint32_t hv);
+bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const=
 void *key, uint64_t hv);

 void hash_remove_by_value(struct hash *hash, void *value);

@@ -98,9 +98,9 @@

 void hash_iterator_free(struct hash_iterator *hi);

-uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
+uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);

-static inline uint32_t
+static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
     return (*hash->hash_function)(key, hash->iv);
@@ -119,7 +119,7 @@
 }

 static inline struct hash_bucket *
-hash_bucket(struct hash *hash, uint32_t hv)
+hash_bucket(struct hash *hash, uint64_t hv)
 {
     return &hash->buckets[hv & hash->mask];
 }
@@ -129,7 +129,7 @@
 {
     void *ret =3D NULL;
     struct hash_element *he;
-    uint32_t hv =3D hash_value(hash, key);
+    uint64_t hv =3D hash_value(hash, key);
     struct hash_bucket *bucket =3D &hash->buckets[hv & hash->mask];

     he =3D hash_lookup_fast(hash, bucket, key, hv);
@@ -143,7 +143,7 @@

 /* NOTE: assumes that key is not a duplicate */
 static inline void
-hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *k=
ey, uint32_t hv,
+hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *k=
ey, uint64_t hv,
               void *value)
 {
     struct hash_element *he;
@@ -160,7 +160,7 @@
 static inline bool
 hash_remove(struct hash *hash, const void *key)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     bool ret;

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 6fa70a3..78c689e 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -354,7 +354,7 @@
  * address type, number of bits in the network address,
  * and the actual address.
  */
-uint32_t
+uint64_t
 mroute_addr_hash_function(const void *key, uint32_t iv)
 {
     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c8daa15..2f5d019 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -144,7 +144,7 @@

 bool mroute_learnable_address(const struct mroute_addr *addr, struct gc_ar=
ena *gc);

-uint32_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);

 bool mroute_addr_compare_function(const void *key1, const void *key2);

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b7bef46..5583d1c 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -57,7 +57,7 @@
     {
         mi->real.proto =3D sock->info.proto;
         struct hash_element *he;
-        const uint32_t hv =3D hash_value(hash, &mi->real);
+        const uint64_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);

         multi_assign_peer_id(m, mi);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b359750..c272f79 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -204,7 +204,7 @@
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)=
 && m->top.c2.buf.len > 0)
     {
         struct hash_element *he;
-        const uint32_t hv =3D hash_value(hash, &real);
+        const uint64_t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
         uint8_t *ptr =3D BPTR(&m->top.c2.buf);
         uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c03e821..57ea3fb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -228,11 +228,11 @@

 #ifdef ENABLE_MANAGEMENT

-static uint32_t
+static uint64_t
 cid_hash_function(const void *key, uint32_t iv)
 {
     const unsigned long *k =3D (const unsigned long *)key;
-    return (uint32_t)*k;
+    return (uint64_t)*k;
 }

 static bool
@@ -246,7 +246,7 @@
 #endif

 #ifdef ENABLE_ASYNC_PUSH
-static uint32_t
+static uint64_t
 /*
  * inotify watcher descriptors are used as hash value
  */
@@ -1021,7 +1021,7 @@
                  const unsigned int flags)
 {
     struct hash_element *he;
-    const uint32_t hv =3D hash_value(m->vhash, addr);
+    const uint64_t hv =3D hash_value(m->vhash, addr);
     struct hash_bucket *bucket =3D hash_bucket(m->vhash, hv);
     struct multi_route *oldroute =3D NULL;
     struct multi_instance *owner =3D NULL;
@@ -3103,7 +3103,7 @@
         goto done;
     }

-    const uint32_t hv =3D hash_value(hash, &real);
+    const uint64_t hv =3D hash_value(hash, &real);
     struct hash_bucket *bucket =3D hash_bucket(hash, hv);

     /* make sure that we don't float to an address taken by another client=
 */
@@ -4247,7 +4247,7 @@
 multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, con=
st struct mroute_addr *addr)
 {
     struct hash_element *he;
-    const uint32_t hv =3D hash_value(m->vhash, addr);
+    const uint64_t hv =3D hash_value(m->vhash, addr);
     struct hash_bucket *bucket =3D hash_bucket(m->vhash, hv);
     struct multi_route *r =3D NULL;

diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index a9ae33f..a8383de 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -124,7 +124,7 @@
 };


-static uint32_t
+static uint64_t
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str =3D (const char *)key;
@@ -173,8 +173,8 @@
      */

     struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000, get_random(), word_hash_functio=
n, word_compare_function);
-    struct hash *nhash =3D hash_init(256, get_random(), word_hash_function=
, word_compare_function);
+    struct hash *hash =3D hash_init(10000, (uint32_t)get_random(), word_ha=
sh_function, word_compare_function);
+    struct hash *nhash =3D hash_init(256, (uint32_t)get_random(), word_has=
h_function, word_compare_function);

     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t/diNqKSocc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1570?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Change hash values in our hash map from uint32_t to uint64_t<br><br>32 =
bit architectures are playing a very small role today, so the difference<br=
>between 64 bit and 32 bit hash values is not expected to be large anymore.=
<br><br>This is also in preparation to replace our hash function with a mor=
e modern<br>replacement.<br><br>Change-Id: Ib8140107f98164d2a2e1768a6d8ac65=
016cd7f7c<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>=
M src/openvpn/list.c<br>M src/openvpn/list.h<br>M src/openvpn/mroute.c<br>M=
 src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M =
src/openvpn/multi.c<br>M tests/unit_tests/openvpn/test_misc.c<br>8 files ch=
anged, 30 insertions(+), 30 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1570/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>index f0e=
9908..50defb85 100644</span><br><span>--- a/src/openvpn/list.c</span><br><s=
pan>+++ b/src/openvpn/list.c</span><br><span>@@ -34,8 +34,8 @@</span><br><s=
pan> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span> struc=
t hash *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(con=
st uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          uint32_t (*hash_function)(const void *key, ui=
nt32_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_ini=
t(const uint32_t n_buckets, uint32_t iv,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          uint64_t (*hash_function)(const void *key, u=
int32_t iv),</span><br><span>           bool (*compare_function)(const void=
 *key1, const void *key2))</span><br><span> {</span><br><span>     struct h=
ash *h;</span><br><span>@@ -76,7 +76,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> struct hash_element *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-hash_lookup_fast(struct hash *hash, struct hash_bucket=
 *bucket, const void *key, uint32_t hv)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+hash_lookup_fast(struct hash *hash, struct hash_bucket =
*bucket, const void *key, uint64_t hv)</span><br><span> {</span><br><span> =
    struct hash_element *he;</span><br><span>     struct hash_element *prev=
 =3D NULL;</span><br><span>@@ -104,7 +104,7 @@</span><br><span> }</span><br=
><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, co=
nst void *key, uint32_t hv)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, con=
st void *key, uint64_t hv)</span><br><span> {</span><br><span>     struct h=
ash_element *he;</span><br><span>     struct hash_element *prev =3D NULL;</=
span><br><span>@@ -136,7 +136,7 @@</span><br><span> bool</span><br><span> h=
ash_add(struct hash *hash, const void *key, void *value, bool replace)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uin=
t32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64=
_t hv;</span><br><span>     struct hash_bucket *bucket;</span><br><span>   =
  struct hash_element *he;</span><br><span>     bool ret =3D false;</span><=
br><span>@@ -412,7 +412,7 @@</span><br><span>         c ^=3D (b &gt;&gt; 15=
); \</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+uint64_t</span><br><span> hash_func(const uint8_t *k, uint32_t=
 length, uint32_t initval)</span><br><span> {</span><br><span>     uint32_t=
 a, b, c, len;</span><br><span>diff --git a/src/openvpn/list.h b/src/openvp=
n/list.h</span><br><span>index 04cc3ab..06377c6 100644</span><br><span>--- =
a/src/openvpn/list.h</span><br><span>+++ b/src/openvpn/list.h</span><br><sp=
an>@@ -40,7 +40,7 @@</span><br><span> {</span><br><span>     void *value;</=
span><br><span>     const void *key;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint32_t hash_value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint64_t hash_value;</span><br><span>     struct ha=
sh_element *next;</span><br><span> };</span><br><span> </span><br><span>@@ =
-55,13 +55,13 @@</span><br><span>     uint32_t n_elements;</span><br><span>=
     uint32_t mask;</span><br><span>     uint32_t iv;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t (*hash_function)(const void *k=
ey, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint64_t (*hash_function)(const void *key, uint32_t iv);</span><br><span>=
     bool (*compare_function)(const void *key1, const void *key2); /* retur=
n true if equal */</span><br><span>     struct hash_bucket *buckets;</span>=
<br><span> };</span><br><span> </span><br><span> struct hash *hash_init(con=
st uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                       uint32_t (*hash_function)(const =
void *key, uint32_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       uint64_t (*hash_function)(const void *key, uint=
32_t iv),</span><br><span>                        bool (*compare_function)(=
const void *key1, const void *key2));</span><br><span> </span><br><span> vo=
id hash_free(struct hash *hash);</span><br><span>@@ -69,9 +69,9 @@</span><b=
r><span> bool hash_add(struct hash *hash, const void *key, void *value, boo=
l replace);</span><br><span> </span><br><span> struct hash_element *hash_lo=
okup_fast(struct hash *hash, struct hash_bucket *bucket,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                      co=
nst void *key, uint32_t hv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                      const void *key, uint64_t hv=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const v=
oid *key, uint32_t hv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, co=
nst void *key, uint64_t hv);</span><br><span> </span><br><span> void hash_r=
emove_by_value(struct hash *hash, void *value);</span><br><span> </span><br=
><span>@@ -98,9 +98,9 @@</span><br><span> </span><br><span> void hash_itera=
tor_free(struct hash_iterator *hi);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint32_t hash_func(const uint8_t *k, uint32=
_t length, uint32_t initval);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t in=
itval);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline uint32_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline uint64_t</span><br><span> hash_value(const struct hash=
 *hash, const void *key)</span><br><span> {</span><br><span>     return (*h=
ash-&gt;hash_function)(key, hash-&gt;iv);</span><br><span>@@ -119,7 +119,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static inline stru=
ct hash_bucket *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_=
bucket(struct hash *hash, uint32_t hv)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+hash_bucket(struct hash *hash, uint64_t hv)</span><br><s=
pan> {</span><br><span>     return &amp;hash-&gt;buckets[hv &amp; hash-&gt;=
mask];</span><br><span> }</span><br><span>@@ -129,7 +129,7 @@</span><br><sp=
an> {</span><br><span>     void *ret =3D NULL;</span><br><span>     struct =
hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint32_t hv =3D hash_value(hash, key);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint64_t hv =3D hash_value(hash, key);</span><br><sp=
an>     struct hash_bucket *bucket =3D &amp;hash-&gt;buckets[hv &amp; hash-=
&gt;mask];</span><br><span> </span><br><span>     he =3D hash_lookup_fast(h=
ash, bucket, key, hv);</span><br><span>@@ -143,7 +143,7 @@</span><br><span>=
 </span><br><span> /* NOTE: assumes that key is not a duplicate */</span><b=
r><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const vo=
id *key, uint32_t hv,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *=
key, uint64_t hv,</span><br><span>               void *value)</span><br><sp=
an> {</span><br><span>     struct hash_element *he;</span><br><span>@@ -160=
,7 +160,7 @@</span><br><span> static inline bool</span><br><span> hash_remo=
ve(struct hash *hash, const void *key)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    uint32_t hv;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t hv;</span><br><span>     str=
uct hash_bucket *bucket;</span><br><span>     bool ret;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</sp=
an><br><span>index 6fa70a3..78c689e 100644</span><br><span>--- a/src/openvp=
n/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -3=
54,7 +354,7 @@</span><br><span>  * address type, number of bits in the netw=
ork address,</span><br><span>  * and the actual address.</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32_t</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span> mrou=
te_addr_hash_function(const void *key, uint32_t iv)</span><br><span> {</spa=
n><br><span>     return hash_func(mroute_addr_hash_ptr((const struct mroute=
_addr *)key),</span><br><span>diff --git a/src/openvpn/mroute.h b/src/openv=
pn/mroute.h</span><br><span>index c8daa15..2f5d019 100644</span><br><span>-=
-- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span>=
<br><span>@@ -144,7 +144,7 @@</span><br><span> </span><br><span> bool mrout=
e_learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint3=
2_t mroute_addr_hash_function(const void *key, uint32_t iv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function=
(const void *key, uint32_t iv);</span><br><span> </span><br><span> bool mro=
ute_addr_compare_function(const void *key1, const void *key2);</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c<=
/span><br><span>index b7bef46..5583d1c 100644</span><br><span>--- a/src/ope=
nvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -57=
,7 +57,7 @@</span><br><span>     {</span><br><span>         mi-&gt;real.pro=
to =3D sock-&gt;info.proto;</span><br><span>         struct hash_element *h=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const uint3=
2_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const uint64_t hv =3D hash_value(hash, &=
amp;mi-&gt;real);</span><br><span>         struct hash_bucket *bucket =3D h=
ash_bucket(hash, hv);</span><br><span> </span><br><span>         multi_assi=
gn_peer_id(m, mi);</span><br><span>diff --git a/src/openvpn/mudp.c b/src/op=
envpn/mudp.c</span><br><span>index b359750..c272f79 100644</span><br><span>=
--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br=
><span>@@ -204,7 +204,7 @@</span><br><span>     if (mroute_extract_openvpn_=
sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true) &amp;&amp; m-&gt;top=
.c2.buf.len &gt; 0)</span><br><span>     {</span><br><span>         struct =
hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    const uint32_t hv =3D hash_value(hash, &amp;real);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const uint64_t hv =3D hash_value=
(hash, &amp;real);</span><br><span>         struct hash_bucket *bucket =3D =
hash_bucket(hash, hv);</span><br><span>         uint8_t *ptr =3D BPTR(&amp;=
m-&gt;top.c2.buf);</span><br><span>         uint8_t op =3D ptr[0] &gt;&gt; =
P_OPCODE_SHIFT;</span><br><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index c03e821..57ea3fb 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -228,11 +228,11 @@</span><br><span> </span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static uint32_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static uint64_t</span><br><span> cid_hash_function(const void *key, =
uint32_t iv)</span><br><span> {</span><br><span>     const unsigned long *k=
 =3D (const unsigned long *)key;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return (uint32_t)*k;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return (uint64_t)*k;</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span>@@ -246,7 +246,7 @@</span><=
br><span> #endif</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUS=
H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><b=
r><span> /*</span><br><span>  * inotify watcher descriptors are used as has=
h value</span><br><span>  */</span><br><span>@@ -1021,7 +1021,7 @@</span><b=
r><span>                  const unsigned int flags)</span><br><span> {</spa=
n><br><span>     struct hash_element *he;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(m-&gt;vhash, addr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t=
 hv =3D hash_value(m-&gt;vhash, addr);</span><br><span>     struct hash_buc=
ket *bucket =3D hash_bucket(m-&gt;vhash, hv);</span><br><span>     struct m=
ulti_route *oldroute =3D NULL;</span><br><span>     struct multi_instance *=
owner =3D NULL;</span><br><span>@@ -3103,7 +3103,7 @@</span><br><span>     =
    goto done;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(hash=
, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint64_t hv =3D hash_value(hash, &amp;real);</span><br><span>     struc=
t hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span> </span><b=
r><span>     /* make sure that we don&#39;t float to an address taken by an=
other client */</span><br><span>@@ -4247,7 +4247,7 @@</span><br><span> mult=
i_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const st=
ruct mroute_addr *addr)</span><br><span> {</span><br><span>     struct hash=
_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t uint32_t hv =3D hash_value(m-&gt;vhash, addr);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;vha=
sh, addr);</span><br><span>     struct hash_bucket *bucket =3D hash_bucket(=
m-&gt;vhash, hv);</span><br><span>     struct multi_route *r =3D NULL;</spa=
n><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_mi=
sc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index a9ae33f..=
a8383de 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@=
@ -124,7 +124,7 @@</span><br><span> };</span><br><span> </span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br>=
<span> word_hash_function(const void *key, uint32_t iv)</span><br><span> {<=
/span><br><span>     const char *str =3D (const char *)key;</span><br><span=
>@@ -173,8 +173,8 @@</span><br><span>      */</span><br><span> </span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, get_random(=
), word_hash_function, word_compare_function);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, get_rand=
om(), word_hash_function, word_compare_function);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, (u=
int32_t)get_random(), word_hash_function, word_compare_function);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D ha=
sh_init(256, (uint32_t)get_random(), word_hash_function, word_compare_funct=
ion);</span><br><span> </span><br><span>     printf(&quot;hash_init n_bucke=
ts=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><b=
r><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail">change 1570</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8=
ac65016cd7f7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--t/diNqKSocc=--

