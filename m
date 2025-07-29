From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 29 Jul 2025 12:33:55 +0000
References: <gerrit.1753792433000.I3334465738fb1fbf508dfd719b6a238b500cc0ae@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c0751dcbb3f3e67c761c603e43a6f09743cb08f6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KjQMGRRQDZA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: list: Make types of
 hash elements consistent
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

--KjQMGRRQDZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1119?usp=3Demail

to review the following change.


Change subject: list: Make types of hash elements consistent
......................................................................

list: Make types of hash elements consistent

Really no use in having the indices and limits in int.

Change-Id: I3334465738fb1fbf508dfd719b6a238b500cc0ae
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/integer.h
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options.h
M tests/unit_tests/openvpn/test_misc.c
8 files changed, 63 insertions(+), 50 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1119/1

diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index c568036..e6106c9 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -132,6 +132,27 @@
     }
 }

+static inline unsigned int
+constrain_uint(unsigned int x, unsigned int min, unsigned int max)
+{
+    if (min > max)
+    {
+        return min;
+    }
+    if (x < min)
+    {
+        return min;
+    }
+    else if (x > max)
+    {
+        return max;
+    }
+    else
+    {
+        return x;
+    }
+}
+
 /*
  * Functions used for circular buffer index arithmetic.
  */
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 1f33b5f..3971d62 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -35,23 +35,22 @@
 #include "memdbg.h"

 struct hash *
-hash_init(const int n_buckets,
+hash_init(const uint32_t n_buckets,
           const uint32_t iv,
           uint32_t (*hash_function)(const void *key, uint32_t iv),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
-    int i;

     ASSERT(n_buckets > 0);
     ALLOC_OBJ_CLEAR(h, struct hash);
-    h->n_buckets =3D (int) adjust_power_of_2(n_buckets);
+    h->n_buckets =3D (uint32_t)adjust_power_of_2(n_buckets);
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;
     h->compare_function =3D compare_function;
     h->iv =3D iv;
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
-    for (i =3D 0; i < h->n_buckets; ++i)
+    for (uint32_t i =3D 0; i < h->n_buckets; ++i)
     {
         struct hash_bucket *b =3D &h->buckets[i];
         b->list =3D NULL;
@@ -62,8 +61,7 @@
 void
 hash_free(struct hash *hash)
 {
-    int i;
-    for (i =3D 0; i < hash->n_buckets; ++i)
+    for (uint32_t i =3D 0; i < hash->n_buckets; ++i)
     {
         struct hash_bucket *b =3D &hash->buckets[i];
         struct hash_element *he =3D b->list;
@@ -222,15 +220,15 @@
 void
 hash_iterator_init_range(struct hash *hash,
                          struct hash_iterator *hi,
-                         int start_bucket,
-                         int end_bucket)
+                         uint32_t start_bucket,
+                         uint32_t end_bucket)
 {
     if (end_bucket > hash->n_buckets)
     {
         end_bucket =3D hash->n_buckets;
     }

-    ASSERT(start_bucket >=3D 0 && start_bucket <=3D end_bucket);
+    ASSERT(start_bucket <=3D end_bucket);

     hi->hash =3D hash;
     hi->elem =3D NULL;
@@ -336,6 +334,9 @@
  * the return value.  Every 1-bit and 2-bit delta achieves avalanche.
  * About 36+6len instructions.
  *
+ * #define hashsize(n) ((uint32_t)1<<(n))
+ * #define hashmask(n) (hashsize(n)-1)
+ *
  * The best hash table sizes are powers of 2.  There is no need to do
  * mod a prime (mod is sooo slow!).  If you need less than 32 bits,
  * use a bitmask.  For example, if you need only 10 bits, do
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 783570f..d2c5373 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -37,14 +37,11 @@
 #include "basic.h"
 #include "buffer.h"

-#define hashsize(n) ((uint32_t)1<<(n))
-#define hashmask(n) (hashsize(n)-1)
-
 struct hash_element
 {
     void *value;
     const void *key;
-    unsigned int hash_value;
+    uint32_t hash_value;
     struct hash_element *next;
 };

@@ -55,16 +52,16 @@

 struct hash
 {
-    int n_buckets;
-    int n_elements;
-    int mask;
+    uint32_t n_buckets;
+    uint32_t n_elements;
+    uint32_t mask;
     uint32_t iv;
     uint32_t (*hash_function)(const void *key, uint32_t iv);
     bool (*compare_function)(const void *key1, const void *key2); /* retur=
n true if equal */
     struct hash_bucket *buckets;
 };

-struct hash *hash_init(const int n_buckets,
+struct hash *hash_init(const uint32_t n_buckets,
                        const uint32_t iv,
                        uint32_t (*hash_function)(const void *key, uint32_t=
 iv),
                        bool (*compare_function)(const void *key1, const vo=
id *key2));
@@ -88,19 +85,19 @@
 struct hash_iterator
 {
     struct hash *hash;
-    int bucket_index;
+    uint32_t bucket_index;
     struct hash_bucket *bucket;
     struct hash_element *elem;
     struct hash_element *last;
     bool bucket_marked;
-    int bucket_index_start;
-    int bucket_index_end;
+    uint32_t bucket_index_start;
+    uint32_t bucket_index_end;
 };

 void hash_iterator_init_range(struct hash *hash,
                               struct hash_iterator *hi,
-                              int start_bucket,
-                              int end_bucket);
+                              uint32_t start_bucket,
+                              uint32_t end_bucket);

 void hash_iterator_init(struct hash *hash, struct hash_iterator *iter);

@@ -118,13 +115,13 @@
     return (*hash->hash_function)(key, hash->iv);
 }

-static inline int
+static inline uint32_t
 hash_n_elements(const struct hash *hash)
 {
     return hash->n_elements;
 }

-static inline int
+static inline uint32_t
 hash_n_buckets(const struct hash *hash)
 {
     return hash->n_buckets;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c0e8f9c..02157ac 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -175,19 +175,13 @@

 static void
 multi_reap_range(const struct multi_context *m,
-                 int start_bucket,
-                 int end_bucket)
+                 uint32_t start_bucket,
+                 uint32_t end_bucket)
 {
     struct gc_arena gc =3D gc_new();
     struct hash_iterator hi;
     struct hash_element *he;

-    if (start_bucket < 0)
-    {
-        start_bucket =3D 0;
-        end_bucket =3D hash_n_buckets(m->vhash);
-    }
-
     dmsg(D_MULTI_DEBUG, "MULTI: REAP range %d -> %d", start_bucket, end_bu=
cket);
     hash_iterator_init_range(m->vhash, &hi, start_bucket, end_bucket);
     while ((he =3D hash_iterator_next(&hi)) !=3D NULL)
@@ -209,11 +203,11 @@
 static void
 multi_reap_all(const struct multi_context *m)
 {
-    multi_reap_range(m, -1, 0);
+    multi_reap_range(m, 0, hash_n_buckets(m->vhash));
 }

 static struct multi_reap *
-multi_reap_new(int buckets_per_pass)
+multi_reap_new(uint32_t buckets_per_pass)
 {
     struct multi_reap *mr;
     ALLOC_OBJ(mr, struct multi_reap);
@@ -245,10 +239,10 @@
 /*
  * How many buckets in vhash to reap per pass.
  */
-static int
-reap_buckets_per_pass(int n_buckets)
+static uint32_t
+reap_buckets_per_pass(uint32_t n_buckets)
 {
-    return constrain_int(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);
+    return constrain_uint(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);
 }

 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3c821d7..a622e8c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -52,8 +52,8 @@
  */
 struct multi_reap
 {
-    int bucket_base;
-    int buckets_per_pass;
+    uint32_t bucket_base;
+    uint32_t buckets_per_pass;
     time_t last_call;
 };

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d3ca340..9ca2c4a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7588,11 +7588,11 @@
     }
     else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
     {
-        int real, virtual;
+        uint32_t real, virtual;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real =3D atoi_warn(p[1], msglevel);
-        virtual =3D atoi_warn(p[2], msglevel);
+        real =3D positive_atoi(p[1], msglevel);
+        virtual =3D positive_atoi(p[2], msglevel);
         if (real < 1 || virtual < 1)
         {
             msg(msglevel, "--hash-size sizes must be >=3D 1 (preferably a =
power of 2)");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 78b0d7c..9542d93 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -498,8 +498,8 @@
     struct in6_addr ifconfig_ipv6_pool_base;            /* IPv6 */
     int ifconfig_ipv6_pool_netbits;                     /* IPv6 */

-    int real_hash_size;
-    int virtual_hash_size;
+    uint32_t real_hash_size;
+    uint32_t virtual_hash_size;
     const char *client_connect_script;
     const char *client_disconnect_script;
     const char *learn_address_script;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 3272f6b..b1e0bef 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -123,7 +123,7 @@
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str =3D (const char *) key;
-    const int len =3D strlen(str);
+    const uint32_t len =3D (uint32_t)strlen(str);
     return hash_func((const uint8_t *)str, len, iv);
 }

@@ -133,11 +133,11 @@
     return strcmp((const char *)key1, (const char *)key2) =3D=3D 0;
 }

-static unsigned long
+static uint32_t
 get_random(void)
 {
     /* rand() is not very random, but it's C99 and this is just for testin=
g */
-    return rand();
+    return (uint32_t)rand();
 }

 static struct hash_element *
@@ -172,7 +172,7 @@
     struct hash *hash =3D hash_init(10000, get_random(), word_hash_functio=
n, word_compare_function);
     struct hash *nhash =3D hash_init(256, get_random(), word_hash_function=
, word_compare_function);

-    printf("hash_init n_buckets=3D%d mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);
+    printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, ha=
sh->mask);

     char wordfile[PATH_MAX] =3D { 0 };
     openvpn_test_get_srcdir_dir(wordfile, PATH_MAX, "/../../../COPYRIGHT.G=
PL" );
@@ -250,10 +250,10 @@

     /* output contents of hash table */
     {
-        ptr_type inc =3D 0;
+        uint32_t inc =3D 0;
         int count =3D 0;

-        for (ptr_type base =3D 0; base < hash_n_buckets(hash); base +=3D i=
nc)
+        for (uint32_t base =3D 0; base < hash_n_buckets(hash); base +=3D i=
nc)
         {
             struct hash_iterator hi;
             struct hash_element *he;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1119?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3334465738fb1fbf508dfd719b6a238b500cc0ae
Gerrit-Change-Number: 1119
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--KjQMGRRQDZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1119?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">list: Make types of hash elements consistent<br><br>Really n=
o use in having the indices and limits in int.<br><br>Change-Id: I333446573=
8fb1fbf508dfd719b6a238b500cc0ae<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M src/openvpn/integer.h<br>M src/openvpn/list.c=
<br>M src/openvpn/list.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<=
br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M tests/unit_tests=
/openvpn/test_misc.c<br>8 files changed, 63 insertions(+), 50 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1=
119/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h</s=
pan><br><span>index c568036..e6106c9 100644</span><br><span>--- a/src/openv=
pn/integer.h</span><br><span>+++ b/src/openvpn/integer.h</span><br><span>@@=
 -132,6 +132,27 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline un=
signed int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constrain=
_uint(unsigned int x, unsigned int min, unsigned int max)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (min &gt; max)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return min;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (x &lt; min)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return min;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (x &gt; max)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return max;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return x;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  =
* Functions used for circular buffer index arithmetic.</span><br><span>  */=
</span><br><span>diff --git a/src/openvpn/list.c b/src/openvpn/list.c</span=
><br><span>index 1f33b5f..3971d62 100644</span><br><span>--- a/src/openvpn/=
list.c</span><br><span>+++ b/src/openvpn/list.c</span><br><span>@@ -35,23 +=
35,22 @@</span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </=
span><br><span> struct hash *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-hash_init(const int n_buckets,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+hash_init(const uint32_t n_buckets,</span><br><span>    =
       const uint32_t iv,</span><br><span>           uint32_t (*hash_functi=
on)(const void *key, uint32_t iv),</span><br><span>           bool (*compar=
e_function)(const void *key1, const void *key2))</span><br><span> {</span><=
br><span>     struct hash *h;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i;</span><br><span> </span><br><span>     ASSERT(n_buckets =
&gt; 0);</span><br><span>     ALLOC_OBJ_CLEAR(h, struct hash);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;n_buckets =3D (int) adju=
st_power_of_2(n_buckets);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    h-&gt;n_buckets =3D (uint32_t)adjust_power_of_2(n_buckets);</span=
><br><span>     h-&gt;mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-=
&gt;hash_function =3D hash_function;</span><br><span>     h-&gt;compare_fun=
ction =3D compare_function;</span><br><span>     h-&gt;iv =3D iv;</span><br=
><span>     ALLOC_ARRAY(h-&gt;buckets, struct hash_bucket, h-&gt;n_buckets)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i =
&lt; h-&gt;n_buckets; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (uint32_t i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><s=
pan>     {</span><br><span>         struct hash_bucket *b =3D &amp;h-&gt;bu=
ckets[i];</span><br><span>         b-&gt;list =3D NULL;</span><br><span>@@ =
-62,8 +61,7 @@</span><br><span> void</span><br><span> hash_free(struct hash=
 *hash)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fo=
r (i =3D 0; i &lt; hash-&gt;n_buckets; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (uint32_t i =3D 0; i &lt; hash-&gt;n_bucket=
s; ++i)</span><br><span>     {</span><br><span>         struct hash_bucket =
*b =3D &amp;hash-&gt;buckets[i];</span><br><span>         struct hash_eleme=
nt *he =3D b-&gt;list;</span><br><span>@@ -222,15 +220,15 @@</span><br><spa=
n> void</span><br><span> hash_iterator_init_range(struct hash *hash,</span>=
<br><span>                          struct hash_iterator *hi,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                         int start_=
bucket,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
           int end_bucket)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         uint32_t start_bucket,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         uint32_t end_bu=
cket)</span><br><span> {</span><br><span>     if (end_bucket &gt; hash-&gt;=
n_buckets)</span><br><span>     {</span><br><span>         end_bucket =3D h=
ash-&gt;n_buckets;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(start_bucket &gt;=3D 0 &am=
p;&amp; start_bucket &lt;=3D end_bucket);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(start_bucket &lt;=3D end_bucket);</span><b=
r><span> </span><br><span>     hi-&gt;hash =3D hash;</span><br><span>     h=
i-&gt;elem =3D NULL;</span><br><span>@@ -336,6 +334,9 @@</span><br><span>  =
* the return value.  Every 1-bit and 2-bit delta achieves avalanche.</span>=
<br><span>  * About 36+6len instructions.</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * #define hashsize(n) ((uint32_t=
)1&lt;&lt;(n))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * #d=
efine hashmask(n) (hashsize(n)-1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span>  * The best hash table sizes are powers o=
f 2.  There is no need to do</span><br><span>  * mod a prime (mod is sooo s=
low!).  If you need less than 32 bits,</span><br><span>  * use a bitmask.  =
For example, if you need only 10 bits, do</span><br><span>diff --git a/src/=
openvpn/list.h b/src/openvpn/list.h</span><br><span>index 783570f..d2c5373 =
100644</span><br><span>--- a/src/openvpn/list.h</span><br><span>+++ b/src/o=
penvpn/list.h</span><br><span>@@ -37,14 +37,11 @@</span><br><span> #include=
 &quot;basic.h&quot;</span><br><span> #include &quot;buffer.h&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define has=
hsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define hashmask(n) (hashsize(n)-1)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> struct hash_element</span><br><=
span> {</span><br><span>     void *value;</span><br><span>     const void *=
key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int =
hash_value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
32_t hash_value;</span><br><span>     struct hash_element *next;</span><br>=
<span> };</span><br><span> </span><br><span>@@ -55,16 +52,16 @@</span><br><=
span> </span><br><span> struct hash</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int n_buckets;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int n_elements;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int mask;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint32_t n_buckets;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint32_t n_elements;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint32_t mask;</span><br><span>     =
uint32_t iv;</span><br><span>     uint32_t (*hash_function)(const void *key=
, uint32_t iv);</span><br><span>     bool (*compare_function)(const void *k=
ey1, const void *key2); /* return true if equal */</span><br><span>     str=
uct hash_bucket *buckets;</span><br><span> };</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-struct hash *hash_init(const int =
n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ha=
sh *hash_init(const uint32_t n_buckets,</span><br><span>                   =
     const uint32_t iv,</span><br><span>                        uint32_t (*=
hash_function)(const void *key, uint32_t iv),</span><br><span>             =
           bool (*compare_function)(const void *key1, const void *key2));</=
span><br><span>@@ -88,19 +85,19 @@</span><br><span> struct hash_iterator</s=
pan><br><span> {</span><br><span>     struct hash *hash;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int bucket_index;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint32_t bucket_index;</span><br><=
span>     struct hash_bucket *bucket;</span><br><span>     struct hash_elem=
ent *elem;</span><br><span>     struct hash_element *last;</span><br><span>=
     bool bucket_marked;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int bucket_index_start;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int bucket_index_end;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint32_t bucket_index_start;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint32_t bucket_index_end;</span><br><span>=
 };</span><br><span> </span><br><span> void hash_iterator_init_range(struct=
 hash *hash,</span><br><span>                               struct hash_ite=
rator *hi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                   int start_bucket,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                              int end_bucket);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                              uin=
t32_t start_bucket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                              uint32_t end_bucket);</span><br><span> </span=
><br><span> void hash_iterator_init(struct hash *hash, struct hash_iterator=
 *iter);</span><br><span> </span><br><span>@@ -118,13 +115,13 @@</span><br>=
<span>     return (*hash-&gt;hash_function)(key, hash-&gt;iv);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline uint32_t</span><br><span> hash_n_elements(const struct hash =
*hash)</span><br><span> {</span><br><span>     return hash-&gt;n_elements;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static inline uint32_t</span><br><span> hash_n_buckets(const s=
truct hash *hash)</span><br><span> {</span><br><span>     return hash-&gt;n=
_buckets;</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mu=
lti.c</span><br><span>index c0e8f9c..02157ac 100644</span><br><span>--- a/s=
rc/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><spa=
n>@@ -175,19 +175,13 @@</span><br><span> </span><br><span> static void</spa=
n><br><span> multi_reap_range(const struct multi_context *m,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                 int start_bucket,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 int en=
d_bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       uint32_t start_bucket,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 uint32_t end_bucket)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct h=
ash_iterator hi;</span><br><span>     struct hash_element *he;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (start_bu=
cket &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        start_bucket =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        end_bucket =
=3D hash_n_buckets(m-&gt;vhash);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %d -&gt; %d&qu=
ot;, start_bucket, end_bucket);</span><br><span>     hash_iterator_init_ran=
ge(m-&gt;vhash, &amp;hi, start_bucket, end_bucket);</span><br><span>     wh=
ile ((he =3D hash_iterator_next(&amp;hi)) !=3D NULL)</span><br><span>@@ -20=
9,11 +203,11 @@</span><br><span> static void</span><br><span> multi_reap_al=
l(const struct multi_context *m)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_reap_range(m, -1, 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_reap_range(m, 0, hash=
_n_buckets(m-&gt;vhash));</span><br><span> }</span><br><span> </span><br><s=
pan> static struct multi_reap *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_reap_new(int buckets_per_pass)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_reap_new(uint32_t buckets_per_pass)</span>=
<br><span> {</span><br><span>     struct multi_reap *mr;</span><br><span>  =
   ALLOC_OBJ(mr, struct multi_reap);</span><br><span>@@ -245,10 +239,10 @@<=
/span><br><span> /*</span><br><span>  * How many buckets in vhash to reap p=
er pass.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rea=
p_buckets_per_pass(int n_buckets)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static uint32_t</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+reap_buckets_per_pass(uint32_t n_buckets)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return constrain_int(n=
_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return constrain_uint(n_buckets / REAP_DIVISO=
R, REAP_MIN, REAP_MAX);</span><br><span> }</span><br><span> </span><br><spa=
n> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/src/openvpn/multi.=
h b/src/openvpn/multi.h</span><br><span>index 3c821d7..a622e8c 100644</span=
><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/mult=
i.h</span><br><span>@@ -52,8 +52,8 @@</span><br><span>  */</span><br><span>=
 struct multi_reap</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int bucket_base;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int buckets_per_pass;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint32_t bucket_base;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t buckets_per_pass;</span><br><span> =
    time_t last_call;</span><br><span> };</span><br><span> </span><br><span=
>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span=
>index d3ca340..9ca2c4a 100644</span><br><span>--- a/src/openvpn/options.c<=
/span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7588,11 +75=
88,11 @@</span><br><span>     }</span><br><span>     else if (streq(p[0], &=
quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      int real, virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        uint32_t real, virtual;</span><br><span> </span><br><span>    =
     VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        real =3D atoi_warn(p[1], msglevel);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        virtual =3D atoi_warn(p[2], =
msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eal =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        virtual =3D positive_atoi(p[2], msglevel);</span=
><br><span>         if (real &lt; 1 || virtual &lt; 1)</span><br><span>    =
     {</span><br><span>             msg(msglevel, &quot;--hash-size sizes m=
ust be &gt;=3D 1 (preferably a power of 2)&quot;);</span><br><span>diff --g=
it a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 78=
b0d7c..9542d93 100644</span><br><span>--- a/src/openvpn/options.h</span><br=
><span>+++ b/src/openvpn/options.h</span><br><span>@@ -498,8 +498,8 @@</spa=
n><br><span>     struct in6_addr ifconfig_ipv6_pool_base;            /* IPv=
6 */</span><br><span>     int ifconfig_ipv6_pool_netbits;                  =
   /* IPv6 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int real_hash_size;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int virtual_hash_size;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint32_t real_hash_size;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint32_t virtual_hash_size;</span><br><span=
>     const char *client_connect_script;</span><br><span>     const char *c=
lient_disconnect_script;</span><br><span>     const char *learn_address_scr=
ipt;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/te=
sts/unit_tests/openvpn/test_misc.c</span><br><span>index 3272f6b..b1e0bef 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -123,7 =
+123,7 @@</span><br><span> word_hash_function(const void *key, uint32_t iv)=
</span><br><span> {</span><br><span>     const char *str =3D (const char *)=
 key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int le=
n =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint32_t len =3D (uint32_t)strlen(str);</span><br><span>     retur=
n hash_func((const uint8_t *)str, len, iv);</span><br><span> }</span><br><s=
pan> </span><br><span>@@ -133,11 +133,11 @@</span><br><span>     return str=
cmp((const char *)key1, (const char *)key2) =3D=3D 0;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 unsigned long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c uint32_t</span><br><span> get_random(void)</span><br><span> {</span><br><=
span>     /* rand() is not very random, but it&#39;s C99 and this is just f=
or testing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn rand();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n (uint32_t)rand();</span><br><span> }</span><br><span> </span><br><span> s=
tatic struct hash_element *</span><br><span>@@ -172,7 +172,7 @@</span><br><=
span>     struct hash *hash =3D hash_init(10000, get_random(), word_hash_fu=
nction, word_compare_function);</span><br><span>     struct hash *nhash =3D=
 hash_init(256, get_random(), word_hash_function, word_compare_function);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
rintf(&quot;hash_init n_buckets=3D%d mask=3D0x%08x\n&quot;, hash-&gt;n_buck=
ets, hash-&gt;mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;=
n_buckets, hash-&gt;mask);</span><br><span> </span><br><span>     char word=
file[PATH_MAX] =3D { 0 };</span><br><span>     openvpn_test_get_srcdir_dir(=
wordfile, PATH_MAX, &quot;/../../../COPYRIGHT.GPL&quot; );</span><br><span>=
@@ -250,10 +250,10 @@</span><br><span> </span><br><span>     /* output cont=
ents of hash table */</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ptr_type inc =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uint32_t inc =3D 0;</span><br><span>=
         int count =3D 0;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        for (ptr_type base =3D 0; base &lt; hash_n_bu=
ckets(hash); base +=3D inc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (uint32_t base =3D 0; base &lt; hash_n_buckets(hash); b=
ase +=3D inc)</span><br><span>         {</span><br><span>             struc=
t hash_iterator hi;</span><br><span>             struct hash_element *he;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1119?usp=3Demail">change 1119</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1119?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3334465738fb1fbf508dfd719b6=
a238b500cc0ae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1119 </div>
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


--KjQMGRRQDZA=--

