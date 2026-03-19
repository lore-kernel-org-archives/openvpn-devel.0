From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Mar 2026 14:17:13 +0000
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@...2715...>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <057e429f99c42fa31e8a3099eb6db790cf24dc16-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V6z4+YmaitU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--V6z4+YmaitU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1570/4

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
index c03e821..01d7e9d 100644
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
@@ -246,19 +246,19 @@
 #endif

 #ifdef ENABLE_ASYNC_PUSH
-static uint32_t
+static uint64_t
 /*
  * inotify watcher descriptors are used as hash value
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-    return (uint32_t)(uintptr_t)key;
+    return (uintptr_t)key;
 }

 static bool
 int_compare_function(const void *key1, const void *key2)
 {
-    return (unsigned long)key1 =3D=3D (unsigned long)key2;
+    return (uintptr_t)key1 =3D=3D (uintptr_t)key2;
 }
 #endif

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
index a9ae33f..ccdfdee 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -124,7 +124,7 @@
 };


-static uint32_t
+static uint64_t
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str =3D (const char *)key;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Gerrit-Change-Number: 1570
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--V6z4+YmaitU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1570?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Change hash values in our ha=
sh map from uint32_t to uint64_t<br><br>32 bit architectures are playing a =
very small role today, so the difference<br>between 64 bit and 32 bit hash =
values is not expected to be large anymore.<br><br>This is also in preparat=
ion to replace our hash function with a more modern<br>replacement.<br><br>=
Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c<br>Signed-off-by: Arne=
 Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/list.c<br>M src/op=
envpn/list.h<br>M src/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/o=
penvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M tests/u=
nit_tests/openvpn/test_misc.c<br>8 files changed, 30 insertions(+), 30 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/70/1570/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/list.c b/s=
rc/openvpn/list.c</span><br><span>index f0e9908..50defb85 100644</span><br>=
<span>--- a/src/openvpn/list.c</span><br><span>+++ b/src/openvpn/list.c</sp=
an><br><span>@@ -34,8 +34,8 @@</span><br><span> #include &quot;memdbg.h&quo=
t;</span><br><span> </span><br><span> struct hash *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint32_t n_buckets, const u=
int32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
uint32_t (*hash_function)(const void *key, uint32_t iv),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint32_t n_buckets, ui=
nt32_t iv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br><span> =
          bool (*compare_function)(const void *key1, const void *key2))</sp=
an><br><span> {</span><br><span>     struct hash *h;</span><br><span>@@ -76=
,7 +76,7 @@</span><br><span> }</span><br><span> </span><br><span> struct ha=
sh_element *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_look=
up_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uin=
t32_t hv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_looku=
p_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint=
64_t hv)</span><br><span> {</span><br><span>     struct hash_element *he;</=
span><br><span>     struct hash_element *prev =3D NULL;</span><br><span>@@ =
-104,7 +104,7 @@</span><br><span> }</span><br><span> </span><br><span> bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove_fast(stru=
ct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_remove_fast(struc=
t hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv)</sp=
an><br><span> {</span><br><span>     struct hash_element *he;</span><br><sp=
an>     struct hash_element *prev =3D NULL;</span><br><span>@@ -136,7 +136,=
7 @@</span><br><span> bool</span><br><span> hash_add(struct hash *hash, con=
st void *key, void *value, bool replace)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hv;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t hv;</span><br><span>     st=
ruct hash_bucket *bucket;</span><br><span>     struct hash_element *he;</sp=
an><br><span>     bool ret =3D false;</span><br><span>@@ -412,7 +412,7 @@</=
span><br><span>         c ^=3D (b &gt;&gt; 15); \</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint32=
_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><b=
r><span> hash_func(const uint8_t *k, uint32_t length, uint32_t initval)</sp=
an><br><span> {</span><br><span>     uint32_t a, b, c, len;</span><br><span=
>diff --git a/src/openvpn/list.h b/src/openvpn/list.h</span><br><span>index=
 04cc3ab..06377c6 100644</span><br><span>--- a/src/openvpn/list.h</span><br=
><span>+++ b/src/openvpn/list.h</span><br><span>@@ -40,7 +40,7 @@</span><br=
><span> {</span><br><span>     void *value;</span><br><span>     const void=
 *key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t ha=
sh_value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64=
_t hash_value;</span><br><span>     struct hash_element *next;</span><br><s=
pan> };</span><br><span> </span><br><span>@@ -55,13 +55,13 @@</span><br><sp=
an>     uint32_t n_elements;</span><br><span>     uint32_t mask;</span><br>=
<span>     uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    uint32_t (*hash_function)(const void *key, uint32_t iv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(co=
nst void *key, uint32_t iv);</span><br><span>     bool (*compare_function)(=
const void *key1, const void *key2); /* return true if equal */</span><br><=
span>     struct hash_bucket *buckets;</span><br><span> };</span><br><span>=
 </span><br><span> struct hash *hash_init(const uint32_t n_buckets, const u=
int32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
             uint32_t (*hash_function)(const void *key, uint32_t iv),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       ui=
nt64_t (*hash_function)(const void *key, uint32_t iv),</span><br><span>    =
                    bool (*compare_function)(const void *key1, const void *=
key2));</span><br><span> </span><br><span> void hash_free(struct hash *hash=
);</span><br><span>@@ -69,9 +69,9 @@</span><br><span> bool hash_add(struct =
hash *hash, const void *key, void *value, bool replace);</span><br><span> <=
/span><br><span> struct hash_element *hash_lookup_fast(struct hash *hash, s=
truct hash_bucket *bucket,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                      const void *key, uint32_t hv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                 const void *key, uint64_t hv);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool hash_remove_fast(struct ha=
sh *hash, struct hash_bucket *bucket, const void *key, uint32_t hv);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool hash_remove_fast(stru=
ct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);</=
span><br><span> </span><br><span> void hash_remove_by_value(struct hash *ha=
sh, void *value);</span><br><span> </span><br><span>@@ -98,9 +98,9 @@</span=
><br><span> </span><br><span> void hash_iterator_free(struct hash_iterator =
*hi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t hash_func(c=
onst uint8_t *k, uint32_t length, uint32_t initval);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint32_t</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t<=
/span><br><span> hash_value(const struct hash *hash, const void *key)</span=
><br><span> {</span><br><span>     return (*hash-&gt;hash_function)(key, ha=
sh-&gt;iv);</span><br><span>@@ -119,7 +119,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static inline struct hash_bucket *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-hash_bucket(struct hash *hash, uint=
32_t hv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_bucket=
(struct hash *hash, uint64_t hv)</span><br><span> {</span><br><span>     re=
turn &amp;hash-&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> }</spa=
n><br><span>@@ -129,7 +129,7 @@</span><br><span> {</span><br><span>     voi=
d *ret =3D NULL;</span><br><span>     struct hash_element *he;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uint32_t hv =3D hash_value(has=
h, key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_=
t hv =3D hash_value(hash, key);</span><br><span>     struct hash_bucket *bu=
cket =3D &amp;hash-&gt;buckets[hv &amp; hash-&gt;mask];</span><br><span> </=
span><br><span>     he =3D hash_lookup_fast(hash, bucket, key, hv);</span><=
br><span>@@ -143,7 +143,7 @@</span><br><span> </span><br><span> /* NOTE: as=
sumes that key is not a duplicate */</span><br><span> static inline void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_add_fast(struct has=
h *hash, struct hash_bucket *bucket, const void *key, uint32_t hv,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+hash_add_fast(struct hash *h=
ash, struct hash_bucket *bucket, const void *key, uint64_t hv,</span><br><s=
pan>               void *value)</span><br><span> {</span><br><span>     str=
uct hash_element *he;</span><br><span>@@ -160,7 +160,7 @@</span><br><span> =
static inline bool</span><br><span> hash_remove(struct hash *hash, const vo=
id *key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uint32_t hv;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint64_t hv;</span><br><span>     struct hash_bucket *bucket;</span>=
<br><span>     bool ret;</span><br><span> </span><br><span>diff --git a/src=
/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index 6fa70a3..78c=
689e 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ =
b/src/openvpn/mroute.c</span><br><span>@@ -354,7 +354,7 @@</span><br><span>=
  * address type, number of bits in the network address,</span><br><span>  =
* and the actual address.</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-uint32_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+uint64_t</span><br><span> mroute_addr_hash_function(const voi=
d *key, uint32_t iv)</span><br><span> {</span><br><span>     return hash_fu=
nc(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span>d=
iff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>ind=
ex c8daa15..2f5d019 100644</span><br><span>--- a/src/openvpn/mroute.h</span=
><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -144,7 +144,7 @@</=
span><br><span> </span><br><span> bool mroute_learnable_address(const struc=
t mroute_addr *addr, struct gc_arena *gc);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-uint32_t mroute_addr_hash_function(c=
onst void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);=
</span><br><span> </span><br><span> bool mroute_addr_compare_function(const=
 void *key1, const void *key2);</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index b7bef46..=
5583d1c 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++=
 b/src/openvpn/mtcp.c</span><br><span>@@ -57,7 +57,7 @@</span><br><span>   =
  {</span><br><span>         mi-&gt;real.proto =3D sock-&gt;info.proto;</sp=
an><br><span>         struct hash_element *he;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const uint32_t hv =3D hash_value(hash, &am=
p;mi-&gt;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><sp=
an>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br=
><span> </span><br><span>         multi_assign_peer_id(m, mi);</span><br><s=
pan>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>in=
dex b359750..c272f79 100644</span><br><span>--- a/src/openvpn/mudp.c</span>=
<br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -204,7 +204,7 @@</spa=
n><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;=
top.c2.from.dest, true) &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><=
span>     {</span><br><span>         struct hash_element *he;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        const uint32_t hv =3D hash_=
value(hash, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const uint64_t hv =3D hash_value(hash, &amp;real);</span><br><s=
pan>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><b=
r><span>         uint8_t *ptr =3D BPTR(&amp;m-&gt;top.c2.buf);</span><br><s=
pan>         uint8_t op =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span=
>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>ind=
ex c03e821..01d7e9d 100644</span><br><span>--- a/src/openvpn/multi.c</span>=
<br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -228,11 +228,11 @@</=
span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><b=
r><span> cid_hash_function(const void *key, uint32_t iv)</span><br><span> {=
</span><br><span>     const unsigned long *k =3D (const unsigned long *)key=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t=
)*k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uin=
t64_t)*k;</span><br><span> }</span><br><span> </span><br><span> static bool=
</span><br><span>@@ -246,19 +246,19 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static uint64_t</span><br><span> /*</span><br><span> =
 * inotify watcher descriptors are used as hash value</span><br><span>  */<=
/span><br><span> int_hash_function(const void *key, uint32_t iv)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (u=
int32_t)(uintptr_t)key;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return (uintptr_t)key;</span><br><span> }</span><br><span> </span><=
br><span> static bool</span><br><span> int_compare_function(const void *key=
1, const void *key2)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return (unsigned long)key1 =3D=3D (unsigned long)key2=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uintpt=
r_t)key1 =3D=3D (uintptr_t)key2;</span><br><span> }</span><br><span> #endif=
</span><br><span> </span><br><span>@@ -1021,7 +1021,7 @@</span><br><span>  =
                const unsigned int flags)</span><br><span> {</span><br><spa=
n>     struct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const uint32_t hv =3D hash_value(m-&gt;vhash, addr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D ha=
sh_value(m-&gt;vhash, addr);</span><br><span>     struct hash_bucket *bucke=
t =3D hash_bucket(m-&gt;vhash, hv);</span><br><span>     struct multi_route=
 *oldroute =3D NULL;</span><br><span>     struct multi_instance *owner =3D =
NULL;</span><br><span>@@ -3103,7 +3103,7 @@</span><br><span>         goto d=
one;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const uint32_t hv =3D hash_value(hash, &amp;rea=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64=
_t hv =3D hash_value(hash, &amp;real);</span><br><span>     struct hash_buc=
ket *bucket =3D hash_bucket(hash, hv);</span><br><span> </span><br><span>  =
   /* make sure that we don&#39;t float to an address taken by another clie=
nt */</span><br><span>@@ -4247,7 +4247,7 @@</span><br><span> multi_unlearn_=
addr(struct multi_context *m, struct multi_instance *mi, const struct mrout=
e_addr *addr)</span><br><span> {</span><br><span>     struct hash_element *=
he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint32_t=
 hv =3D hash_value(m-&gt;vhash, addr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;vhash, addr);=
</span><br><span>     struct hash_bucket *bucket =3D hash_bucket(m-&gt;vhas=
h, hv);</span><br><span>     struct multi_route *r =3D NULL;</span><br><spa=
n> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tes=
ts/unit_tests/openvpn/test_misc.c</span><br><span>index a9ae33f..ccdfdee 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -124,7 +=
124,7 @@</span><br><span> };</span><br><span> </span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static uint64_t</span><br><span> wor=
d_hash_function(const void *key, uint32_t iv)</span><br><span> {</span><br>=
<span>     const char *str =3D (const char *)key;</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1570?usp=3Demail">change 1570</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/157=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8140107f98164d2a2e1768a6d8=
ac65016cd7f7c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1570 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--V6z4+YmaitU=--

