From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 20 Sep 2025 21:34:18 +0000
In-Reply-To: <gerrit.1753792433000.I3334465738fb1fbf508dfd719b6a238b500cc0ae@...2715...>
References: <gerrit.1753792433000.I3334465738fb1fbf508dfd719b6a238b500cc0ae@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4d43418ae954b5044f0f14b020fca5a49f4ef15-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CgVNcgMfrck="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CgVNcgMfrck=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
19?usp=3Demail )

Change subject: list: Make types of hash elements consistent
......................................................................

list: Make types of hash elements consistent

Really no use in having the indices and limits in int.

Change-Id: I3334465738fb1fbf508dfd719b6a238b500cc0ae
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1119
Message-Id: <20250919173838.28092-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
108.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/integer.h
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options.h
M tests/unit_tests/openvpn/test_misc.c
8 files changed, 61 insertions(+), 48 deletions(-)




diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index b82379e..2a6f14a 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -135,6 +135,27 @@
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
index f30d540..1b90d82 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -34,22 +34,21 @@
 #include "memdbg.h"

 struct hash *
-hash_init(const int n_buckets, const uint32_t iv,
+hash_init(const uint32_t n_buckets, const uint32_t iv,
           uint32_t (*hash_function)(const void *key, uint32_t iv),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
-    int i;

     ASSERT(n_buckets > 0);
     ALLOC_OBJ_CLEAR(h, struct hash);
-    h->n_buckets =3D (int)adjust_power_of_2(n_buckets);
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
@@ -60,8 +59,7 @@
 void
 hash_free(struct hash *hash)
 {
-    int i;
-    for (i =3D 0; i < hash->n_buckets; ++i)
+    for (uint32_t i =3D 0; i < hash->n_buckets; ++i)
     {
         struct hash_bucket *b =3D &hash->buckets[i];
         struct hash_element *he =3D b->list;
@@ -212,15 +210,15 @@
 }

 void
-hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, int =
start_bucket,
-                         int end_bucket)
+hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, uint=
32_t start_bucket,
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
@@ -325,6 +323,9 @@
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
index fb3302d..5702b95 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -36,14 +36,11 @@
 #include "basic.h"
 #include "buffer.h"

-#define hashsize(n) ((uint32_t)1 << (n))
-#define hashmask(n) (hashsize(n) - 1)
-
 struct hash_element
 {
     void *value;
     const void *key;
-    unsigned int hash_value;
+    uint32_t hash_value;
     struct hash_element *next;
 };

@@ -54,16 +51,16 @@

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

-struct hash *hash_init(const int n_buckets, const uint32_t iv,
+struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
                        uint32_t (*hash_function)(const void *key, uint32_t=
 iv),
                        bool (*compare_function)(const void *key1, const vo=
id *key2));

@@ -81,17 +78,17 @@
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

-void hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi,=
 int start_bucket,
-                              int end_bucket);
+void hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi,=
 uint32_t start_bucket,
+                              uint32_t end_bucket);

 void hash_iterator_init(struct hash *hash, struct hash_iterator *iter);

@@ -109,13 +106,13 @@
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
index 8676a09..9256127 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -169,18 +169,12 @@
 }
=20
 static void
-multi_reap_range(const struct multi_context *m, int start_bucket, int end_=
bucket)
+multi_reap_range(const struct multi_context *m, uint32_t start_bucket, uin=
t32_t end_bucket)
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
@@ -201,11 +195,11 @@
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
@@ -237,10 +231,10 @@
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
index 087c0e6..b2b892b 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -51,8 +51,8 @@
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
index f1f66b9..151a016 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7956,8 +7956,8 @@
         {
             goto err;
         }
-        options->real_hash_size =3D real;
-        options->virtual_hash_size =3D virtual;
+        options->real_hash_size =3D (uint32_t)real;
+        options->virtual_hash_size =3D (uint32_t)virtual;
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a737711..b033068 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -499,8 +499,8 @@
     struct in6_addr ifconfig_ipv6_pool_base; /* IPv6 */
     int ifconfig_ipv6_pool_netbits;          /* IPv6 */

-    int real_hash_size;
-    int virtual_hash_size;
+    uint32_t real_hash_size;
+    uint32_t virtual_hash_size;
     const char *client_connect_script;
     const char *client_disconnect_script;
     const char *learn_address_script;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index dbfdd56..10bed1d 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -128,7 +128,7 @@
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str =3D (const char *)key;
-    const int len =3D strlen(str);
+    const uint32_t len =3D (uint32_t)strlen(str);
     return hash_func((const uint8_t *)str, len, iv);
 }

@@ -138,11 +138,11 @@
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
@@ -176,7 +176,7 @@
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
PL");
@@ -254,10 +254,10 @@

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
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--CgVNcgMfrck=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1119?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">list: Make types of hash elements consistent<=
br><br>Really no use in having the indices and limits in int.<br><br>Change=
-Id: I3334465738fb1fbf508dfd719b6a238b500cc0ae<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1119<br>Messa=
ge-Id: &lt;20250919173838.28092-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg33108.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/integ=
er.h<br>M src/openvpn/list.c<br>M src/openvpn/list.h<br>M src/openvpn/multi=
.c<br>M src/openvpn/multi.h<br>M src/openvpn/options.c<br>M src/openvpn/opt=
ions.h<br>M tests/unit_tests/openvpn/test_misc.c<br>8 files changed, 61 ins=
ertions(+), 48 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h</span><br><sp=
an>index b82379e..2a6f14a 100644</span><br><span>--- a/src/openvpn/integer.=
h</span><br><span>+++ b/src/openvpn/integer.h</span><br><span>@@ -135,6 +13=
5,27 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+constrain_uint(unsig=
ned int x, unsigned int min, unsigned int max)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (min &gt; max)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return min;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (x &lt; mi=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return min;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (x &gt; max)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return max;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return x;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Functions u=
sed for circular buffer index arithmetic.</span><br><span>  */</span><br><s=
pan>diff --git a/src/openvpn/list.c b/src/openvpn/list.c</span><br><span>in=
dex f30d540..1b90d82 100644</span><br><span>--- a/src/openvpn/list.c</span>=
<br><span>+++ b/src/openvpn/list.c</span><br><span>@@ -34,22 +34,21 @@</spa=
n><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><spa=
n> struct hash *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_=
init(const int n_buckets, const uint32_t iv,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+hash_init(const uint32_t n_buckets, const uint32_t=
 iv,</span><br><span>           uint32_t (*hash_function)(const void *key, =
uint32_t iv),</span><br><span>           bool (*compare_function)(const voi=
d *key1, const void *key2))</span><br><span> {</span><br><span>     struct =
hash *h;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</s=
pan><br><span> </span><br><span>     ASSERT(n_buckets &gt; 0);</span><br><s=
pan>     ALLOC_OBJ_CLEAR(h, struct hash);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    h-&gt;n_buckets =3D (int)adjust_power_of_2(n_bucket=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;n_buck=
ets =3D (uint32_t)adjust_power_of_2(n_buckets);</span><br><span>     h-&gt;=
mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D =
hash_function;</span><br><span>     h-&gt;compare_function =3D compare_func=
tion;</span><br><span>     h-&gt;iv =3D iv;</span><br><span>     ALLOC_ARRA=
Y(h-&gt;buckets, struct hash_bucket, h-&gt;n_buckets);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; h-&gt;n_buckets; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint32=
_t i =3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><=
span>         struct hash_bucket *b =3D &amp;h-&gt;buckets[i];</span><br><s=
pan>         b-&gt;list =3D NULL;</span><br><span>@@ -60,8 +59,7 @@</span><=
br><span> void</span><br><span> hash_free(struct hash *hash)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; has=
h-&gt;n_buckets; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (uint32_t i =3D 0; i &lt; hash-&gt;n_buckets; ++i)</span><br><spa=
n>     {</span><br><span>         struct hash_bucket *b =3D &amp;hash-&gt;b=
uckets[i];</span><br><span>         struct hash_element *he =3D b-&gt;list;=
</span><br><span>@@ -212,15 +210,15 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, int =
start_bucket,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                 int end_bucket)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+hash_iterator_init_range(struct hash *hash, struct hash_iterat=
or *hi, uint32_t start_bucket,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         uint32_t end_bucket)</span><br><span> {=
</span><br><span>     if (end_bucket &gt; hash-&gt;n_buckets)</span><br><sp=
an>     {</span><br><span>         end_bucket =3D hash-&gt;n_buckets;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(start_bucket &gt;=3D 0 &amp;&amp; start_bucket &lt=
;=3D end_bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(start_bucket &lt;=3D end_bucket);</span><br><span> </span><br><spa=
n>     hi-&gt;hash =3D hash;</span><br><span>     hi-&gt;elem =3D NULL;</sp=
an><br><span>@@ -325,6 +323,9 @@</span><br><span>  * the return value.  Eve=
ry 1-bit and 2-bit delta achieves avalanche.</span><br><span>  * About 36+6=
len instructions.</span><br><span>  *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * #define hashmask(n) (hashs=
ize(n)-1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span>  * The best hash table sizes are powers of 2.  There is no need t=
o do</span><br><span>  * mod a prime (mod is sooo slow!).  If you need less=
 than 32 bits,</span><br><span>  * use a bitmask.  For example, if you need=
 only 10 bits, do</span><br><span>diff --git a/src/openvpn/list.h b/src/ope=
nvpn/list.h</span><br><span>index fb3302d..5702b95 100644</span><br><span>-=
-- a/src/openvpn/list.h</span><br><span>+++ b/src/openvpn/list.h</span><br>=
<span>@@ -36,14 +36,11 @@</span><br><span> #include &quot;basic.h&quot;</sp=
an><br><span> #include &quot;buffer.h&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define hashsize(n) ((uint32_t)1 &l=
t;&lt; (n))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ha=
shmask(n) (hashsize(n) - 1)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> struct hash_element</span><br><span> {</span><br><s=
pan>     void *value;</span><br><span>     const void *key;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    unsigned int hash_value;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t hash_value;</sp=
an><br><span>     struct hash_element *next;</span><br><span> };</span><br>=
<span> </span><br><span>@@ -54,16 +51,16 @@</span><br><span> </span><br><sp=
an> struct hash</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int n_buckets;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int n_elements;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int mask;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint32_t n_buckets;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint32_t n_elements;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint32_t mask;</span><br><span>     uint32_t iv;</span><br><=
span>     uint32_t (*hash_function)(const void *key, uint32_t iv);</span><b=
r><span>     bool (*compare_function)(const void *key1, const void *key2); =
/* return true if equal */</span><br><span>     struct hash_bucket *buckets=
;</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-struct hash *hash_init(const int n_buckets, const uint32_=
t iv,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct hash *h=
ash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><span>     =
                   uint32_t (*hash_function)(const void *key, uint32_t iv),=
</span><br><span>                        bool (*compare_function)(const voi=
d *key1, const void *key2));</span><br><span> </span><br><span>@@ -81,17 +7=
8,17 @@</span><br><span> struct hash_iterator</span><br><span> {</span><br>=
<span>     struct hash *hash;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int bucket_index;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint32_t bucket_index;</span><br><span>     struct hash_bucke=
t *bucket;</span><br><span>     struct hash_element *elem;</span><br><span>=
     struct hash_element *last;</span><br><span>     bool bucket_marked;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int bucket_index_sta=
rt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int bucket_ind=
ex_end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t=
 bucket_index_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint32_t bucket_index_end;</span><br><span> };</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void hash_iterator_init_ran=
ge(struct hash *hash, struct hash_iterator *hi, int start_bucket,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                              i=
nt end_bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, uint=
32_t start_bucket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                             uint32_t end_bucket);</span><br><span> </span>=
<br><span> void hash_iterator_init(struct hash *hash, struct hash_iterator =
*iter);</span><br><span> </span><br><span>@@ -109,13 +106,13 @@</span><br><=
span>     return (*hash-&gt;hash_function)(key, hash-&gt;iv);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline uint32_t</span><br><span> hash_n_elements(const struct hash *=
hash)</span><br><span> {</span><br><span>     return hash-&gt;n_elements;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static inline uint32_t</span><br><span> hash_n_buckets(const st=
ruct hash *hash)</span><br><span> {</span><br><span>     return hash-&gt;n_=
buckets;</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mul=
ti.c</span><br><span>index 8676a09..9256127 100644</span><br><span>--- a/sr=
c/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span=
>@@ -169,18 +169,12 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_re=
ap_range(const struct multi_context *m, int start_bucket, int end_bucket)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_reap_range(cons=
t struct multi_context *m, uint32_t start_bucket, uint32_t end_bucket)</spa=
n><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span>     struct hash_iterator hi;</span><br><span>     struct hash_el=
ement *he;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (start_bucket &lt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      start_bucket =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        end_bucket =3D hash_n_buckets(m-&gt;vhash);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI: RE=
AP range %d -&gt; %d&quot;, start_bucket, end_bucket);</span><br><span>    =
 hash_iterator_init_range(m-&gt;vhash, &amp;hi, start_bucket, end_bucket);<=
/span><br><span>     while ((he =3D hash_iterator_next(&amp;hi)) !=3D NULL)=
</span><br><span>@@ -201,11 +195,11 @@</span><br><span> static void</span><=
br><span> multi_reap_all(const struct multi_context *m)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_reap_range(m=
, -1, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_=
reap_range(m, 0, hash_n_buckets(m-&gt;vhash));</span><br><span> }</span><br=
><span> </span><br><span> static struct multi_reap *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_reap_new(int buckets_per_pass)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+multi_reap_new(uint32_t bu=
ckets_per_pass)</span><br><span> {</span><br><span>     struct multi_reap *=
mr;</span><br><span>     ALLOC_OBJ(mr, struct multi_reap);</span><br><span>=
@@ -237,10 +231,10 @@</span><br><span> /*</span><br><span>  * How many buck=
ets in vhash to reap per pass.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-reap_buckets_per_pass(int n_buckets)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static uint32_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reap_buckets_per_pass(uint32_t n_buckets)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return constrain_int(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return constrain_uint=
(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);</span><br><span> }</span><b=
r><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --=
git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 087c0=
e6..b2b892b 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><spa=
n>+++ b/src/openvpn/multi.h</span><br><span>@@ -51,8 +51,8 @@</span><br><sp=
an>  */</span><br><span> struct multi_reap</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int bucket_base;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int buckets_per_pass;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t bucket_base;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t buckets_per=
_pass;</span><br><span>     time_t last_call;</span><br><span> };</span><br=
><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index f1f66b9..151a016 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -7956,8 +7956,8 @@</span><br><span>         {</span><br><span> =
            goto err;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;real_hash_size =3D real;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;virtu=
al_hash_size =3D virtual;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        options-&gt;real_hash_size =3D (uint32_t)real;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;virtual_hash_s=
ize =3D (uint32_t)virtual;</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] =
&amp;&amp; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpn/options.h b/src/openvpn/options.h</span><br><span>index a737711..b03=
3068 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++=
 b/src/openvpn/options.h</span><br><span>@@ -499,8 +499,8 @@</span><br><spa=
n>     struct in6_addr ifconfig_ipv6_pool_base; /* IPv6 */</span><br><span>=
     int ifconfig_ipv6_pool_netbits;          /* IPv6 */</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int real_hash_size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int virtual_hash=
_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t =
real_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint32_t virtual_hash_size;</span><br><span>     const char *client_connect=
_script;</span><br><span>     const char *client_disconnect_script;</span><=
br><span>     const char *learn_address_script;</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc=
.c</span><br><span>index dbfdd56..10bed1d 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_misc.c</span><br><span>@@ -128,7 +128,7 @@</span><br><span> word_=
hash_function(const void *key, uint32_t iv)</span><br><span> {</span><br><s=
pan>     const char *str =3D (const char *)key;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const int len =3D strlen(str);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t len =3D (uint32=
_t)strlen(str);</span><br><span>     return hash_func((const uint8_t *)str,=
 len, iv);</span><br><span> }</span><br><span> </span><br><span>@@ -138,11 =
+138,11 @@</span><br><span>     return strcmp((const char *)key1, (const ch=
ar *)key2) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static unsigned long</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static uint32_t</span><br><span> get_r=
andom(void)</span><br><span> {</span><br><span>     /* rand() is not very r=
andom, but it&#39;s C99 and this is just for testing */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return rand();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (uint32_t)rand();</span><br><s=
pan> }</span><br><span> </span><br><span> static struct hash_element *</spa=
n><br><span>@@ -176,7 +176,7 @@</span><br><span>     struct hash *hash =3D =
hash_init(10000, get_random(), word_hash_function, word_compare_function);<=
/span><br><span>     struct hash *nhash =3D hash_init(256, get_random(), wo=
rd_hash_function, word_compare_function);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;hash_init n_buckets=
=3D%d mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;hash_init n_b=
uckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</spa=
n><br><span> </span><br><span>     char wordfile[PATH_MAX] =3D { 0 };</span=
><br><span>     openvpn_test_get_srcdir_dir(wordfile, PATH_MAX, &quot;/../.=
./../COPYRIGHT.GPL&quot;);</span><br><span>@@ -254,10 +254,10 @@</span><br>=
<span> </span><br><span>     /* output contents of hash table */</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p=
tr_type inc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       uint32_t inc =3D 0;</span><br><span>         int count =3D 0;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fo=
r (ptr_type base =3D 0; base &lt; hash_n_buckets(hash); base +=3D inc)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (uint32_t ba=
se =3D 0; base &lt; hash_n_buckets(hash); base +=3D inc)</span><br><span>  =
       {</span><br><span>             struct hash_iterator hi;</span><br><s=
pan>             struct hash_element *he;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1119?usp=
=3Demail">change 1119</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1119?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3334465738fb1fbf508dfd719b6=
a238b500cc0ae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1119 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--CgVNcgMfrck=--

