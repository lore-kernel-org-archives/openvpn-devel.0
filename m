From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:11:19 +0000
References: <gerrit.1700478678000.I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <36a59041b20ad2903c425b5510e0e273bffe33c9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="13/rpfhLk0A="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove dead list
 test code
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

--13/rpfhLk0A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail

to review the following change.


Change subject: Remove dead list test code
......................................................................

Remove dead list test code

Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
---
M src/openvpn/init.c
M src/openvpn/list.c
M src/openvpn/list.h
3 files changed, 0 insertions(+), 191 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/446/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8c707a4..5618c69 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -865,11 +865,6 @@
     return false;
 #endif

-#ifdef LIST_TEST
-    list_test();
-    return false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A010004, 0x0A0100FF);
     return false;
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 480f39d..dc4b1df 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -326,185 +326,6 @@
 }


-#ifdef LIST_TEST
-
-/*
- * Test the hash code by implementing a simple
- * word frequency algorithm.
- */
-
-struct word
-{
-    const char *word;
-    int n;
-};
-
-static uint32_t
-word_hash_function(const void *key, uint32_t iv)
-{
-    const char *str =3D (const char *) key;
-    const int len =3D strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
-}
-
-static bool
-word_compare_function(const void *key1, const void *key2)
-{
-    return strcmp((const char *)key1, (const char *)key2) =3D=3D 0;
-}
-
-static void
-print_nhash(struct hash *hash)
-{
-    struct hash_iterator hi;
-    struct hash_element *he;
-    int count =3D 0;
-
-    hash_iterator_init(hash, &hi, true);
-
-    while ((he =3D hash_iterator_next(&hi)))
-    {
-        printf("%d ", (int) he->value);
-        ++count;
-    }
-    printf("\n");
-
-    hash_iterator_free(&hi);
-    ASSERT(count =3D=3D hash_n_elements(hash));
-}
-
-static void
-rmhash(struct hash *hash, const char *word)
-{
-    hash_remove(hash, word);
-}
-
-void
-list_test(void)
-{
-    openvpn_thread_init();
-
-    {
-        struct gc_arena gc =3D gc_new();
-        struct hash *hash =3D hash_init(10000, get_random(), word_hash_fun=
ction, word_compare_function);
-        struct hash *nhash =3D hash_init(256, get_random(), word_hash_func=
tion, word_compare_function);
-
-        printf("hash_init n_buckets=3D%d mask=3D0x%08x\n", hash->n_buckets=
, hash->mask);
-
-        /* parse words from stdin */
-        while (true)
-        {
-            char buf[256];
-            char wordbuf[256];
-            int wbi;
-            int bi;
-            char c;
-
-            if (!fgets(buf, sizeof(buf), stdin))
-            {
-                break;
-            }
-
-            bi =3D wbi =3D 0;
-            do
-            {
-                c =3D buf[bi++];
-                if (isalnum(c) || c =3D=3D '_')
-                {
-                    ASSERT(wbi < (int) sizeof(wordbuf));
-                    wordbuf[wbi++] =3D c;
-                }
-                else
-                {
-                    if (wbi)
-                    {
-                        struct word *w;
-                        ASSERT(wbi < (int) sizeof(wordbuf));
-                        wordbuf[wbi++] =3D '\0';
-
-                        /* word is parsed from stdin */
-
-                        /* does it already exist in table? */
-                        w =3D (struct word *) hash_lookup(hash, wordbuf);
-
-                        if (w)
-                        {
-                            /* yes, increment count */
-                            ++w->n;
-                        }
-                        else
-                        {
-                            /* no, make a new object */
-                            ALLOC_OBJ_GC(w, struct word, &gc);
-                            w->word =3D string_alloc(wordbuf, &gc);
-                            w->n =3D 1;
-                            ASSERT(hash_add(hash, w->word, w, false));
-                            ASSERT(hash_add(nhash, w->word, (void *) ((ran=
dom() & 0x0F) + 1), false));
-                        }
-                    }
-                    wbi =3D 0;
-                }
-            } while (c);
-        }
-
-#if 1
-        /* remove some words from the table */
-        {
-            rmhash(hash, "true");
-            rmhash(hash, "false");
-        }
-#endif
-
-        /* output contents of hash table */
-        {
-            int base;
-            int inc =3D 0;
-            int count =3D 0;
-
-            for (base =3D 0; base < hash_n_buckets(hash); base +=3D inc)
-            {
-                struct hash_iterator hi;
-                struct hash_element *he;
-                inc =3D (get_random() % 3) + 1;
-                hash_iterator_init_range(hash, &hi, true, base, base + inc=
);
-
-                while ((he =3D hash_iterator_next(&hi)))
-                {
-                    struct word *w =3D (struct word *) he->value;
-                    printf("%6d '%s'\n", w->n, w->word);
-                    ++count;
-                }
-
-                hash_iterator_free(&hi);
-            }
-            ASSERT(count =3D=3D hash_n_elements(hash));
-        }
-
-#if 1
-        /* test hash_remove_by_value function */
-        {
-            int i;
-            for (i =3D 1; i <=3D 16; ++i)
-            {
-                printf("[%d] ***********************************\n", i);
-                print_nhash(nhash);
-                hash_remove_by_value(nhash, (void *) i, true);
-            }
-            printf("FINAL **************************\n");
-            print_nhash(nhash);
-        }
-#endif
-
-        hash_free(hash);
-        hash_free(nhash);
-        gc_free(&gc);
-    }
-
-    openvpn_thread_cleanup();
-}
-
-#endif /* ifdef LIST_TEST */
-
 /*
  * --------------------------------------------------------------------
  * hash() -- hash a variable-length key into a 32-bit value
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 94d14f2..18afc54 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -33,8 +33,6 @@
  * client instances over various key spaces.
  */

-/* define this to enable special list test mode */
-/*#define LIST_TEST*/

 #include "basic.h"
 #include "buffer.h"
@@ -114,11 +112,6 @@

 uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);

-#ifdef LIST_TEST
-void list_test(void);
-
-#endif
-
 static inline uint32_t
 hash_value(const struct hash *hash, const void *key)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d5822ab4a78d0d21
Gerrit-Change-Number: 446
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--13/rpfhLk0A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove dead list test code<br><br>Change-Id: I7511bc43cd6a0bc=
b89476f27d5822ab4a78d0d21<br>---<br>M src/openvpn/init.c<br>M src/openvpn/l=
ist.c<br>M src/openvpn/list.h<br>3 files changed, 0 insertions(+), 191 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/46/446/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c<=
/span><br><span>index 8c707a4..5618c69 100644</span><br><span>--- a/src/ope=
nvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -86=
5,11 +865,6 @@</span><br><span>     return false;</span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f LIST_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    list_t=
est();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return fals=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef IFCONFIG_=
POOL_TEST</span><br><span>     ifconfig_pool_test(0x0A010004, 0x0A0100FF);<=
/span><br><span>     return false;</span><br><span>diff --git a/src/openvpn=
/list.c b/src/openvpn/list.c</span><br><span>index 480f39d..dc4b1df 100644<=
/span><br><span>--- a/src/openvpn/list.c</span><br><span>+++ b/src/openvpn/=
list.c</span><br><span>@@ -326,185 +326,6 @@</span><br><span> }</span><br><=
span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef LIST_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Test the hash code by implementing a si=
mple</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * word frequency=
 algorithm.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-struct word</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *word;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-word_hash_function(const void *key, uint32_t iv)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *str =3D (const char *) key;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D strlen(str=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_fun=
c((const uint8_t *)str, len, iv);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-word_compare_function(const void *key1,=
 const void *key2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return strcmp((cons=
t char *)key1, (const char *)key2) =3D=3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-print_nhash(struct hash *has=
h)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct hash_iterator hi;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_element *he;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    hash_iterator_init(hash, &amp;hi, true);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while ((he =3D hash_iterator_next(&amp;=
hi)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%d &quot;, =
(int) he-&gt;value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ++count;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;\n&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    hash_iterator_free(&amp;hi);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(count =3D=3D ha=
sh_n_elements(hash));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-rmhash(struct hash *hash, const char *word)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    hash_remove(hash, word);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-list_test(void)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    openvpn_thread_init();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct hash *hash =3D hash_init(10000, get_random(), wor=
d_hash_function, word_compare_function);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct hash *nhash =3D hash_init(256, get_random=
(), word_hash_function, word_compare_function);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        printf(&quot;hash_init n_buckets=3D%d mask=3D0x%08x\n&quot;, h=
ash-&gt;n_buckets, hash-&gt;mask);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* parse words from stdin */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        while (true)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      char buf[256];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           char wordbuf[256];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            int wbi;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            int bi;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            char c;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!f=
gets(buf, sizeof(buf), stdin))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                break;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            bi =3D wbi =3D =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            do</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                c =3D buf[bi++];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (isa=
lnum(c) || c =3D=3D &#39;_&#39;)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    ASSERT(wbi &lt; (int) sizeof(wordbuf));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    wordbuf[wb=
i++] =3D c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 if (wbi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            struct word *w;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        ASSERT(wbi &lt; (int) sizeof(wordbuf));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        wor=
dbuf[wbi++] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           /* word is parsed from stdin */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        /* does it already exist in table? */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        w =3D (stru=
ct word *) hash_lookup(hash, wordbuf);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    if (w)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            /* yes, increment count */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                            ++w-&=
gt;n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                           /* no, make a new object */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            ALLOC_OBJ_GC(w=
, struct word, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            w-&gt;word =3D string_alloc(wordbuf, &amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         w-&gt;n =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                            ASSERT(hash_add(hash, w-&gt;word, w, false));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       ASSERT(hash_add(nhash, w-&gt;word, (void *) ((random() &amp; 0x0F) +=
 1), false));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                wbi =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            } while (c);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* remove some words from the table=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            rmhash(hash, &quot=
;true&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    rmhash(hash, &quot;false&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* output contents of has=
h table */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int base;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int inc =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int co=
unt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            for (base =3D 0; bas=
e &lt; hash_n_buckets(hash); base +=3D inc)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                struct hash_iterator hi;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                struct hash_element *he;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                inc =3D=
 (get_random() % 3) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                hash_iterator_init_range(hash, &amp;hi, true, base, base=
 + inc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                while ((he =3D has=
h_iterator_next(&amp;hi)))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    struct word *w =3D (struct word *) he-&gt;value;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    printf(=
&quot;%6d &#39;%s&#39;\n&quot;, w-&gt;n, w-&gt;word);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    ++count;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                hash_iterator_free(&amp;hi);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            ASSERT(count =3D=3D hash_n_element=
s(hash));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* test hash_remove_by_value function */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            int i;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            for (i =3D 1; i &lt;=3D 16; ++i)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                printf(&quot;[%=
d] ***********************************\n&quot;, i);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                print_nhash(nhash);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                hash_remove_b=
y_value(nhash, (void *) i, true);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            printf(&quot;FINAL **************************\n&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_nhash(n=
hash);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        hash_free(hash);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        hash_free(nhash);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_th=
read_cleanup();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef LIST_TEST */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *=
 --------------------------------------------------------------------</span=
><br><span>  * hash() -- hash a variable-length key into a 32-bit value</sp=
an><br><span>diff --git a/src/openvpn/list.h b/src/openvpn/list.h</span><br=
><span>index 94d14f2..18afc54 100644</span><br><span>--- a/src/openvpn/list=
.h</span><br><span>+++ b/src/openvpn/list.h</span><br><span>@@ -33,8 +33,6 =
@@</span><br><span>  * client instances over various key spaces.</span><br>=
<span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/* define this to enable special list test mode */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*#define LIST_TEST*/</span><br><span> =
</span><br><span> #include &quot;basic.h&quot;</span><br><span> #include &q=
uot;buffer.h&quot;</span><br><span>@@ -114,11 +112,6 @@</span><br><span> </=
span><br><span> uint32_t hash_func(const uint8_t *k, uint32_t length, uint3=
2_t initval);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef LIST_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void list_test(void);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline=
 uint32_t</span><br><span> hash_value(const struct hash *hash, const void *=
key)</span><br><span> {</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail">change 44=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/446?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7511bc43cd6a0bcb89476f27d58=
22ab4a78d0d21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 446 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--13/rpfhLk0A=--

